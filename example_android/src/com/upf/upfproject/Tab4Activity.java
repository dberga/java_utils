package com.upf.upfproject;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class Tab4Activity extends Activity{
	
		Button add;
		EditText sitename, username, password;
		TextView aux;
		
		String site, user, pass;
	
        @Override
        public void onCreate(Bundle savedInstanceState)
        {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.tab4layout);
            
            add = (Button)findViewById(R.id.buttonAdd);
            
            sitename = (EditText)findViewById(R.id.EditTextSitename);
            username = (EditText)findViewById(R.id.EditTextUsername);
            password = (EditText)findViewById(R.id.EditTextPassword);
            
            aux = (TextView)findViewById(R.id.textViewAux);
        }
        
        public void addSite(View v){ 	
        	site = sitename.getText().toString();
        	user = username.getText().toString();
        	pass = password.getText().toString();
        	
        	if(site.matches("")||user.matches("")||pass.matches("")){
        		aux.setText("Error: hay algun campo vacio.");
        	}else{
        		if(check(site,user,pass))	add(site,user,pass);
        	}   	
        }
        
        
        public boolean check(String checkSite, String checkUser, String checkPassword){
        	return true;
        }
        
        public void add(String addSite, String addUser, String addPassword){
        	
        }
}