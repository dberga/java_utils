package com.upf.upfproject;

import android.app.TabActivity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TabHost;
import android.widget.TabHost.TabSpec;

public class MainActivity extends TabActivity 
{
            /** Called when the activity is first created. */
            @Override
            public void onCreate(Bundle savedInstanceState)
            {
                    super.onCreate(savedInstanceState);
                    setContentView(R.layout.main);

             
                    // create the TabHost that will contain the Tabs
                    TabHost tabHost = (TabHost)findViewById(android.R.id.tabhost);


                    TabSpec tab1 = tabHost.newTabSpec("First Tab");
                    TabSpec tab2 = tabHost.newTabSpec("Second Tab");
                    TabSpec tab3 = tabHost.newTabSpec("Third tab");
                    TabSpec tab4 = tabHost.newTabSpec("Forth tab");

                   // Set the Tab name and Activity
                   // that will be opened when particular Tab will be selected
                    /*tab1.setIndicator("Menu");
                    tab2.setIndicator("Buscar");
                    tab3.setIndicator("Update");
                    tab4.setIndicator("Añadir");   */              
                    
                    /*tab1.setIndicator(null, getResources().getDrawable(R.drawable.menu_1));
                    tab2.setIndicator(null, getResources().getDrawable(R.drawable.lupa_1));
                    tab3.setIndicator(null, getResources().getDrawable(R.drawable.arrows_1));
                    tab4.setIndicator(null, getResources().getDrawable(R.drawable.add_1));*/
                    
                    tab1.setIndicator(null, getResources().getDrawable(R.drawable.tab1selector));
                    tab2.setIndicator(null, getResources().getDrawable(R.drawable.tab2selector));
                    tab3.setIndicator(null, getResources().getDrawable(R.drawable.tab3selector));
                    tab4.setIndicator(null, getResources().getDrawable(R.drawable.tab4selector));
                    
                    tab1.setContent(new Intent(this,Tab1Activity.class));
                    tab2.setContent(new Intent(this,Tab2Activity.class));
                    tab3.setContent(new Intent(this,Tab3Activity.class));
                    tab4.setContent(new Intent(this,Tab4Activity.class));
                    
                    /** Add the tabs  to the TabHost to display. */
                    tabHost.addTab(tab1);
                    tabHost.addTab(tab2);
                    tabHost.addTab(tab3);
                    tabHost.addTab(tab4);

            }
} 