package com.example.lab1;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;

public class MainActivity extends Activity {
	
	AlertDialog alertDialog;
	EditText firstname;
	EditText lastname;
	RadioGroup gender;
	Spinner age;
	TextView nias;
	Button next;
	RadioButton rButton;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		firstname = (EditText) findViewById(R.id.EditText01);
		lastname = (EditText) findViewById(R.id.editText1);
		gender = (RadioGroup) findViewById(R.id.radioGroup1);
		age = (Spinner) findViewById(R.id.spinner1);
		nias = (TextView) findViewById(R.id.textView5);
		next = (Button) findViewById(R.id.button1);
		
		alertDialog = new AlertDialog.Builder(this).create();
		alertDialog.setTitle("Fields");
		alertDialog.setMessage("You must fill all fields");
		alertDialog.setButton("OK", new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface dialog, int which) {
			// here you can add functions
			}
			});
		

		next.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if(firstname.getText().toString().matches("") || lastname.getText().toString().matches("")){
					alertDialog.show();
				}else{
					
				int selected = gender.getCheckedRadioButtonId();
				rButton = (RadioButton) findViewById(selected);
				
				Intent intent = new Intent(getApplicationContext(),
						Interface.class);
				intent.putExtra("result_firstname", firstname.getText()
						.toString());
				intent.putExtra("result_lastname", lastname.getText()
						.toString());
				intent.putExtra("result_gender",
						rButton.getText());
				intent.putExtra("result_age", age.getSelectedItem().toString());
				intent.putExtra("result_nias", nias.getText().toString());
				
					startActivity(intent);
				}
			}
		});
	}

}
