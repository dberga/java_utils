package com.example.lab1;


import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class Interface extends Activity {

	Bundle results;
	TextView r_firstname;
	TextView r_lastname;
	TextView r_gender;
	TextView r_age;
	TextView r_nias;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main2);

		r_firstname = (TextView) findViewById(R.id.textView6);
		r_lastname = (TextView) findViewById(R.id.textView7);
		r_gender = (TextView) findViewById(R.id.textView8);
		r_age = (TextView) findViewById(R.id.textView9);
		r_nias = (TextView) findViewById(R.id.textView5);

		results = getIntent().getExtras();
		if (results != null) {
			String result_firstname = results.getString("result_firstname");
			String result_lastname = results.getString("result_lastname");
			String result_gender = results.getString("result_gender");
			String result_age = results.getString("result_age");
			String result_nias = results.getString("result_nias");

			r_firstname.setText(result_firstname);
			r_lastname.setText(result_lastname);
			r_gender.setText(result_gender);
			r_age.setText(result_age);
			r_nias.setText(result_nias);
		}

	}

}
