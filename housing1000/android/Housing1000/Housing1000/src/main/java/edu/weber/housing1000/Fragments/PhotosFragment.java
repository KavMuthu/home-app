package edu.weber.housing1000.Fragments;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.ByteArrayOutputStream;

import edu.weber.housing1000.Helpers.EncryptionHelper;
import edu.weber.housing1000.Helpers.FileHelper;
import edu.weber.housing1000.Helpers.ImageHelper;
import edu.weber.housing1000.ImageAdapter;
import edu.weber.housing1000.R;
import edu.weber.housing1000.SurveyFlowActivity;
import edu.weber.housing1000.Utils;

/**
 * Created by Blake on 2/11/14.
 */
public class PhotosFragment extends SurveyAppFragment {
    private static final int TAKE_PICTURE = 1111;   // Activity result for taking a picture

    SurveyFlowActivity myActivity;  // Parent activity

    GridView photosGridView;    // Holds the photos
    TextView noPhotosTextView; // Text that is shown when no photos are present

    ImageAdapter imageAdapter; // Adapter that keeps track of saved photos

    public PhotosFragment() {} // Default constructor - Needed to restore state

    public PhotosFragment(String name, String actionBarTitle) {
        super(name, actionBarTitle);

    }

    @Override
    public void onResume() {
        super.onResume();

        final InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(getActivity().INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(getView().getWindowToken(), 0);
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);

        myActivity = (SurveyFlowActivity) activity;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setHasOptionsMenu(true);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_photos, container, false);

        photosGridView = (GridView) rootView.findViewById(R.id.photosGridView);
        noPhotosTextView = (TextView) rootView.findViewById(R.id.noPhotosTextView);

        // Pull the images list from the saved state
        if (savedInstanceState != null)
            imageAdapter = new ImageAdapter(myActivity, savedInstanceState.getStringArrayList("images"));
        else
            imageAdapter = new ImageAdapter(myActivity);
        photosGridView.setAdapter(imageAdapter);

        if (imageAdapter.getCount() > 0)
            noPhotosTextView.setVisibility(View.GONE);

        photosGridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> parent, View v, int position, long id) {
                Toast.makeText(myActivity, "" + position, Toast.LENGTH_SHORT).show();
            }
        });

        return rootView;
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        inflater.inflate(R.menu.menu_fragment_photos, menu);

        super.onCreateOptionsMenu(menu, inflater);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId())
        {
            case R.id.action_camera:
                dispatchTakePictureIntent(TAKE_PICTURE);
                return true;
            default:
                break;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);

        outState.putStringArrayList("images", imageAdapter.getImages());
    }

    /**
     * Opens up the camera to take a picture
     * @param actionCode Activity result to return
     */
    private void dispatchTakePictureIntent(int actionCode) {
        if(Utils.isIntentAvailable(getActivity().getApplicationContext(), MediaStore.ACTION_IMAGE_CAPTURE)){
            Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
            startActivityForResult(takePictureIntent, actionCode);
        }
    }

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == TAKE_PICTURE) {
            Bitmap photo = (Bitmap) data.getExtras().get("data");
            Bitmap sPhoto = ImageHelper.ScaleImage(photo);
            try {
                // Set up the file names
                String imageName = "photo_" + String.valueOf(imageAdapter.getCount()) + ".jpg";
                String encryptedName = "photo_" + String.valueOf(imageAdapter.getCount()) + ".secure";

                ByteArrayOutputStream byteArray = new ByteArrayOutputStream();
                sPhoto.compress(Bitmap.CompressFormat.JPEG, 100, byteArray);
                byte[] byteImage = byteArray.toByteArray();

                byte[] encryptedImage = EncryptionHelper.encrypt(byteImage);

                FileHelper.writeFileToExternalStorage(encryptedImage, myActivity.getFolderHash(), encryptedName);

                byte[] encryptedFileBytes = FileHelper.readFileFromExternalStorage(myActivity.getFolderHash(), encryptedName);

                // Decrypt the photo - for testing
                //byte[] decryptedImageBytes = EncryptionHelper.decrypt(encryptedFileBytes);
                //FileHelper.writeFileToExternalStorage(decryptedImageBytes, myActivity.getFolderHash(), imageName);

                // Add the file path to the imageAdapter
                imageAdapter.addImagePath(FileHelper.getAbsoluteFilePath(myActivity.getFolderHash(), encryptedName));

                Log.d("PHOTO ADDED", (String)imageAdapter.getItem(imageAdapter.getCount() - 1));
                Log.d("PHOTO COUNT", String.valueOf(imageAdapter.getCount()));

                imageAdapter.notifyDataSetChanged();
                if (imageAdapter.getCount() > 0)
                    noPhotosTextView.setVisibility(View.GONE);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}