package org.ctagroup.homeapp.activities;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.pm.ActivityInfo;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.ActionBar;
import android.support.v7.app.ActionBarActivity;
import android.view.MenuItem;
import android.view.View;

import com.astuetz.PagerSlidingTabStrip;
import com.google.common.hash.HashCode;
import com.google.common.hash.HashFunction;
import com.google.common.hash.Hashing;

import java.io.File;
import java.io.IOException;

import org.ctagroup.homeapp.CustomViewPager;
import org.ctagroup.homeapp.R;
import org.ctagroup.homeapp.Utils;
import org.ctagroup.homeapp.data.SurveyListing;
import org.ctagroup.homeapp.fragments.PhotosFragment;
import org.ctagroup.homeapp.fragments.ProgressDialogFragment;
import org.ctagroup.homeapp.fragments.SignatureFragment;
import org.ctagroup.homeapp.fragments.SurveyAppFragment;
import org.ctagroup.homeapp.fragments.SurveyFragment;
import org.ctagroup.homeapp.helpers.ErrorHelper;
import org.ctagroup.homeapp.helpers.FileHelper;
import org.ctagroup.homeapp.helpers.Logger;
import org.ctagroup.homeapp.helpers.RESTHelper;
import retrofit.client.Response;

public class SurveyFlowActivity extends ActionBarActivity {
    public static final String EXTRA_SURVEY = "survey";
    private static Double latitude;
    private static Double longitude;
    private static Location currentLocation;
    private LocationManager locationmanager;
    private LocationListener locationlistener;
    private boolean isDisclaimerFinished;

    private PagerSlidingTabStrip mTabs;                         //Tabs of the view
    private SectionsPagerAdapter mSectionsPagerAdapter;         //Keeps track of the fragments
    private CustomViewPager mViewPager;                         //View object that holds the fragments

    private SurveyListing surveyListing;
    private String folderHash;                          //The name of the survey folder (for files)
    private String clientSurveyId;                      //Client survey id for image submission

    private ProgressDialogFragment progressDialogFragment;

    public static Location getLocation() {
        return currentLocation;
    }

    public String getFolderHash() {
        return folderHash;
    }

    public String getClientSurveyId() {
        return clientSurveyId;
    }

    public void setSubmittingResponse(boolean value) {
        try {
            if (value) {
                Utils.lockScreenOrientation(this);
            } else {
                setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            ErrorHelper.showError(this, ex.getMessage());
        }
    }

    public boolean getIsDisclaimerFinished() {

        if(surveyListing.hasDisclaimer()) {
            if (isDisclaimerFinished && mTabs.getVisibility() != View.VISIBLE) {
                mTabs.setVisibility(View.VISIBLE);
            } else if (!isDisclaimerFinished) {
                mTabs.setVisibility(View.GONE);
                mViewPager.setCurrentItem(0);
            }

            return isDisclaimerFinished;
        }
        else {
            mTabs.setVisibility(View.GONE);
            mViewPager.setCurrentItem(2);
            return false;
        }
    }

    public void setIsDisclaimerFinished(boolean value) {
        isDisclaimerFinished = value;
        mViewPager.setCurrentItem(1);
        getIsDisclaimerFinished();
    }

    public SurveyListing getSurveyListing() {
        return surveyListing;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_survey_flow);
        Utils.setActionBarColorToDefault(this);

        // Restore state after being recreated
        if (savedInstanceState != null) {
            surveyListing = (SurveyListing) savedInstanceState.getSerializable("surveyListing");
            folderHash = savedInstanceState.getString("folderHash");
            //currentLocation = savedInstanceState.getParcelable("currentLocation");
            isDisclaimerFinished = savedInstanceState.getBoolean("isSignatureCaptured");
            clientSurveyId = savedInstanceState.getString("clientSurveyId");
        } else {
            // Grab the survey listing from the extras
            surveyListing = (SurveyListing) getIntent().getSerializableExtra(EXTRA_SURVEY);
            generateFolderHash();

            progressDialogFragment = (ProgressDialogFragment) getSupportFragmentManager().findFragmentByTag("Dialog");
        }

        // Create the adapter that will return a fragment for each of the three
        // primary sections of the activity.
        mSectionsPagerAdapter = new SectionsPagerAdapter(getSupportFragmentManager());

        // Set up the ViewPager with the sections adapter.
        mViewPager = (CustomViewPager) findViewById(R.id.pager);
        mViewPager.setAdapter(mSectionsPagerAdapter);
        mViewPager.setOffscreenPageLimit(3);

        ViewPager.OnPageChangeListener mPageChangeListener = new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int i, float v, int i2) {

            }

            @Override
            public void onPageSelected(int i) {
                final ActionBar actionBar = getSupportActionBar();

                String actionBarTitle = ((SurveyAppFragment) mSectionsPagerAdapter.getItem(i)).getActionBarTitle();

                actionBar.setTitle(actionBarTitle != null ? actionBarTitle : getResources().getString(R.string.app_name));
            }

            @Override
            public void onPageScrollStateChanged(int i) {

            }
        };
        // Set the page change listener
        mViewPager.setOnPageChangeListener(mPageChangeListener);

        // Bind the tabs to the ViewPager
        mTabs = (PagerSlidingTabStrip) findViewById(R.id.tabs);
        mTabs.setShouldExpand(true);
        mTabs.setViewPager(mViewPager);
        mTabs.setIndicatorColorResource(R.color.tab_selected);

        // Set the page change listener for the tabs
        mTabs.setOnPageChangeListener(mPageChangeListener);

        if (savedInstanceState == null || mViewPager.getCurrentItem() == 0) {
            // Force a page change update
            mViewPager.setCurrentItem(1);
            mViewPager.setCurrentItem(0);
        }

        getIsDisclaimerFinished();

        //Start Location Listener
        locationmanager = (LocationManager) this.getSystemService(Context.LOCATION_SERVICE);
        locationlistener = new LocationListener() {
            @Override
            public void onLocationChanged(Location location) {
                latitude = location.getLatitude();
                longitude = location.getLongitude();
                currentLocation = location;

                Logger.d("GPS Location:", latitude + "," + longitude);
            }

            @Override
            public void onStatusChanged(String provider, int status, Bundle extras) {
            }

            @Override
            public void onProviderEnabled(String provider) {
            }

            @Override
            public void onProviderDisabled(String provider) {
            }
        };

        // Get updates within no less than 15 minutes and 100 meters
        locationmanager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 15 * 60 * 1000, 100, locationlistener);
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);

        try {
            // Store the survey listing and folder hash
            outState.putSerializable("surveyListing", surveyListing);
            outState.putString("folderHash", folderHash);
            if (currentLocation != null)
                outState.putParcelable("currentLocation", currentLocation);
            outState.putBoolean("isSignatureCaptured", isDisclaimerFinished);
            outState.putString("clientSurveyId", clientSurveyId);
        } catch (Exception ex) {
            ex.printStackTrace();
            ErrorHelper.showError(this, ex.getMessage());
        }
    }

    @Override
    protected void onPause() {
        super.onPause();

        // Dismiss any dialogs to prevent WindowLeaked exceptions
        dismissDialog();
        locationmanager.removeUpdates(locationlistener);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        return id == R.id.action_settings || super.onOptionsItemSelected(item);
    }

    public void onPostSurveyResponsesTaskCompleted(Response response) {
        dismissDialog();

        if (response != null && response.getStatus() == 201) {
            String result = "";

            try {
                result = RESTHelper.convertStreamToString(response.getBody().in());
            } catch (IOException e) {
                e.printStackTrace();
            }

            Logger.d("SURVEY RESPONSE", result);

            String[] split = result.split("=");
            clientSurveyId = split[split.length - 1];
            clientSurveyId = clientSurveyId.replace("\n", "");

            Logger.d("clientSurveyId", clientSurveyId);

            // Submit the photos
            Fragment f = this.getSupportFragmentManager().findFragmentByTag(getFragmentTag(1));

            mViewPager.setCurrentItem(1, true);

            ((PhotosFragment) f).submitPhotos();
        } else if (response != null) {
            setSubmittingResponse(false);

            ErrorHelper.showError(this, getString(R.string.error_problem_submitting_survey));
        } else // survey response has already been submitted, move on to photos
        {
            // Submit the photos
            Fragment f = this.getSupportFragmentManager().findFragmentByTag(getFragmentTag(1));

            mViewPager.setCurrentItem(1, true);

            ((PhotosFragment) f).submitPhotos();
        }
    }

    public void onSaveSurveyResponsesToDatabase(long surveyDataId) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this)
                .setTitle(getString(R.string.success))
                .setMessage(getString(R.string.message_when_survey_saved_to_database))
                .setOnCancelListener(new DialogInterface.OnCancelListener() {
                    @Override
                    public void onCancel(DialogInterface dialog) {
                        setSubmittingResponse(false);
                        finish();
                    }
                })
                .setPositiveButton(getString(R.string.okay), new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        setSubmittingResponse(false);
                        finish();
                    }
                });

        Utils.centerDialogMessageAndShow(builder);

        if(surveyListing.hasDisclaimer()) {
            // Save the photo paths to the database
            Fragment photoFragment = this.getSupportFragmentManager().findFragmentByTag(getFragmentTag(1));
            ((PhotosFragment) photoFragment).savePhotoPathsToDatabase(surveyDataId);

            // Save the signature and initial paths to the database
            Fragment signatureFragment = this.getSupportFragmentManager().findFragmentByTag(getFragmentTag(0));
            ((SignatureFragment) signatureFragment).saveSignatureAndInitialPathsToDatabase(surveyDataId);
        }
    }

    public void onPostPhotoTaskCompleted(Response response) {
        dismissDialog();

        if (response != null && response.getStatus() == 200) {
            try {
                if (response.getBody() != null)
                    Logger.d("PHOTOS RESPONSE", RESTHelper.convertStreamToString(response.getBody().in()));
            } catch (IOException e) {
                e.printStackTrace();
            }

            if(surveyListing.hasDisclaimer()) {
                // Submit signature
                Fragment f = this.getSupportFragmentManager().findFragmentByTag(getFragmentTag(0));
                mViewPager.setCurrentItem(0, true);

                ((SignatureFragment) f).submitDisclaimerInfo();
            }
            else {
                showSendSuccessMessage();
            }
        } else {
            setSubmittingResponse(false);

            ErrorHelper.showError(this, getString(R.string.error_problem_submitting_photos));
        }
    }

    public void onPostSignatureTaskCompleted(Response response) {
        dismissDialog();

        if (response != null && response.getStatus() == 200) {
            try {
                if (response.getBody() != null)
                    Logger.d("SIGNATURE RESPONSE", RESTHelper.convertStreamToString(response.getBody().in()));
            } catch (IOException e) {
                e.printStackTrace();
            }

            showSendSuccessMessage();
        } else {
            setSubmittingResponse(false);

            ErrorHelper.showError(this, getString(R.string.error_problem_submitting_signature));
        }
    }

    private void showSendSuccessMessage() {

        final String successMessage = surveyListing.hasDisclaimer() ? getString(R.string.success_survey_response) : getString(R.string.success_pit_response);

        AlertDialog.Builder builder = new AlertDialog.Builder(this)
                .setTitle(getString(R.string.success))
                .setMessage(successMessage)
                .setOnCancelListener(new DialogInterface.OnCancelListener() {
                    @Override
                    public void onCancel(DialogInterface dialog) {
                        // Delete the folder containing any related files
                        deleteAllFolderFilesAndFinish();
                    }
                })
                .setPositiveButton(getString(R.string.okay), new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // Delete the folder containing any related files
                        deleteAllFolderFilesAndFinish();
                    }
                });

        Utils.centerDialogMessageAndShow(builder);
    }

    @Override
    public void onBackPressed() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage(getString(R.string.cancel_this_survey));
        builder.setPositiveButton(getString(R.string.yes), new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                // Delete the folder containing any related files
                deleteAllFolderFilesAndFinish();
            }
        });
        builder.setNegativeButton(getString(R.string.no), new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        Utils.centerDialogMessageAndShow(builder);
    }

    private void deleteAllFolderFilesAndFinish() {
        setSubmittingResponse(false);

        File surveyDir = new File(FileHelper.getAbsoluteFilePath(getFolderHash(), "", this));
        if (surveyDir.exists()) {
            Logger.d("DELETING SURVEY DIR", surveyDir.getAbsolutePath());
            FileHelper.deleteAllFiles(surveyDir);
        }

        finish();
    }

    private void generateFolderHash() {
        HashFunction hf = Hashing.md5();
        HashCode hc = hf.newHasher().putLong(System.currentTimeMillis()).hash();

        folderHash = hc.toString();

        Logger.d("FOLDER HASH", folderHash);
    }

    public void showProgressDialog(String title, String message, String tag) {
        progressDialogFragment = ProgressDialogFragment.newInstance(title, message);
        progressDialogFragment.show(getSupportFragmentManager(), tag);
    }

    private void dismissDialog() {
        if (progressDialogFragment != null && progressDialogFragment.isAdded()) {
            progressDialogFragment.dismiss();
            progressDialogFragment = null;
        }
    }

    private String getFragmentTag(int pos) {
        return "android:switcher:" + R.id.pager + ":" + pos;
    }

    /**
     * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
     * one of the sections/tabs/pages.
     */
    public class SectionsPagerAdapter extends FragmentPagerAdapter {
        SignatureFragment signatureFragment;
        PhotosFragment photosFragment;
        SurveyFragment surveyFragment;

        public SectionsPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            // getItem is called to instantiate the fragment for the given page.
            switch (position) {
                case 0:
                    if (signatureFragment == null)
                        signatureFragment = SignatureFragment.newInstance(getBaseContext());

                    return signatureFragment;
                case 1:
                    if (photosFragment == null)
                        photosFragment = PhotosFragment.newInstance(getBaseContext());

                    return photosFragment;
                case 2:
                    if (surveyFragment == null)
                        surveyFragment = SurveyFragment.newInstance(getBaseContext(), SurveyFlowActivity.this.surveyListing.getTitle());

                    return surveyFragment;
                default:
                    return null;
            }
        }

        @Override
        public int getCount() {
            return 3;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            switch (position) {
                case 0:
                    return getString(R.string.fragment_signature_name);
                case 1:
                    return getString(R.string.fragment_photos_name);
                case 2:
                    return getString(R.string.fragment_survey_name);
                default:
                    return "";
            }
        }


    }

}
