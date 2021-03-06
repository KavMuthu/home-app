package org.ctagroup.homeapp.questions;

import android.content.Context;
import android.view.View;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.TextView;

/**
 * @author David Horton
 */
public class MultiSelect extends Question {
    @Override
    public View createView(Context context) {
        //Add question with selections
        LinearLayout qLayout = new LinearLayout(context);
        qLayout.setOrientation(LinearLayout.VERTICAL);

        TextView textView = new TextView(context);
        textView.setText(getText());
        textView.setTextSize(getTextSize());
        qLayout.addView(textView);

        //Add potential answers
        String[] arrAnswers = getOptions().split("\\|");
        for (String answer : arrAnswers) {
            CheckBox checkBox = new CheckBox(context);
            checkBox.setText(answer);
            qLayout.addView(checkBox);
        }

        setView(qLayout);
        return getView();
    }

    @Override
    public String getAnswer() {
        String answer = "";
        LinearLayout layout = (LinearLayout)myView;

        for (int i = 0; i < layout.getChildCount(); i++)
        {
            View childView = layout.getChildAt(i);
            if (childView instanceof CheckBox)
            {
                CheckBox checkbox = (CheckBox) childView;
                if (checkbox.isChecked())
                {
                    answer = answer.isEmpty() ? checkbox.getText().toString() : answer + "|" + checkbox.getText().toString();
                }
            }
        }

        return answer;
    }

    @Override
    public void setAnswer(String answer) {
        clearAnswer();

        if (answer != null)
        {
            LinearLayout layout = (LinearLayout)myView;

            String[] answers = answer.split("|");

            for (String single : answers)
            {
                for (int i = 0; i < layout.getChildCount(); i++)
                {
                    View childView = layout.getChildAt(i);
                    if (childView instanceof CheckBox)
                    {
                        CheckBox checkbox = (CheckBox) childView;
                        if (checkbox.getText().equals(single))
                        {
                            checkbox.setChecked(true);
                            break;
                        }
                    }
                }
            }
        }
    }

    @Override
    public void clearAnswer() {
        LinearLayout layout = (LinearLayout)myView;

        for (int i = 0; i < layout.getChildCount(); i++)
        {
            View childView = layout.getChildAt(i);
            if (childView instanceof CheckBox)
            {
                CheckBox checkbox = (CheckBox) childView;
                checkbox.setChecked(false);
            }
        }
    }


}
