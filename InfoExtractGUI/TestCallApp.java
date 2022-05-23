/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package infoextractgui;

import gate.*;
import gate.creole.ResourceInstantiationException;
import gate.persist.PersistenceException;
import gate.util.GateException;
import gate.util.persistence.PersistenceManager;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author UPF
 */
public class TestCallApp {
    
    
    
    public static void main(String[] args) {
        // set the gap file
        String gappFile=args[0];
        // the application (corpus pipeline)
        gate.creole.SerialAnalyserController application;
        // the file to process
        String file=args[1];
        try {
            // initialize GATE
            Gate.init();
            // load the application from file
            application =
                (gate.creole.SerialAnalyserController)
                                PersistenceManager.loadObjectFromFile(new File(gappFile));            
            // create a GATE document
            Document doc=Factory.newDocument(new URL("file:///"+file));
            
            System.out.println(doc.getContent());
            
            // create a corpus
           Corpus c=Factory.newCorpus("MyCorpus");
            
            // put document in corpus 
           c.add(doc);
           
            // set application  corpus parameter 
           application.setCorpus(c);
            
            
            
            // execute the application
            application.execute();
            
            // show information from document
            System.out.println(doc.getAnnotations());
            
            
        } catch (GateException ex) {
            Logger.getLogger(TestCallApp.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ExtractInformation.class.getName()).log(Level.SEVERE, null, ex);
        } 
        
    }
    
   /** TO IMPLEMENT **/ 
    public static void showAnnotations(Document doc) {
       
        
    }
    
    
}
