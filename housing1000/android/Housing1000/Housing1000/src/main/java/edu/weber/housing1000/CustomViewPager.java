package edu.weber.housing1000;

import android.content.Context;
import android.support.v4.view.ViewPager;
import android.util.AttributeSet;
import android.view.MotionEvent;

/**
 * Created by Blake on 2/20/14.
 */
public class CustomViewPager extends ViewPager {
    private SurveyFlowActivity myActivity;

    public CustomViewPager(Context context) {
        super(context);
        try {
            if (!isInEditMode())
                myActivity = (SurveyFlowActivity) context;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public CustomViewPager(Context context, AttributeSet attrs) {
        super(context, attrs);
        try
        {
            if (!isInEditMode())
                myActivity = (SurveyFlowActivity) context;
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    @Override
    public boolean onInterceptTouchEvent(MotionEvent arg0) {
        return myActivity.getIsSignatureCaptured() && super.onInterceptTouchEvent(arg0);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        if (myActivity.getIsSignatureCaptured())
            return super.onTouchEvent(event);

        return false;
    }
}
