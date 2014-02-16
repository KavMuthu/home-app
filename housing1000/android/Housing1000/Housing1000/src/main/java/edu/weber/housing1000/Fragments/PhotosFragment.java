package edu.weber.housing1000.Fragments;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.ListView;
import android.widget.TextView;

import edu.weber.housing1000.R;

/**
 * Created by Blake on 2/11/14.
 */
public class PhotosFragment extends SurveyAppFragment {

    ListView photoListView;
    TextView noPhotosTextView;

    public PhotosFragment(String name) {
        super(name);

        setActionBarTitle("Client Photo(s)");
    }

    @Override
    public void onResume() {
        super.onResume();

        final InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(getActivity().INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(getView().getWindowToken(), 0);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_photos, container, false);

        photoListView = (ListView) rootView.findViewById(R.id.photoListView);
        noPhotosTextView = (TextView) rootView.findViewById(R.id.noPhotosTextView);

        return rootView;
    }
}
