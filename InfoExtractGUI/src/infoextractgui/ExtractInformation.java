/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package infoextractgui;

import gate.*;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.persist.PersistenceException;
import gate.util.OffsetComparator;
import gate.util.persistence.PersistenceManager;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.TreeSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import sun.security.krb5.internal.KDCOptions;

/**
 *
 * @author UPF
 */
public class ExtractInformation {
    
    Document document;
    public Document getDocument() {
        return document;
    }
    public void setDocument(Document d) {
        document=d;
    }
    public void createDocument(File f) {
        try {
          
                document=Factory.newDocument(new URL("file:///"+f.getAbsolutePath()));
           
        
        } catch (ResourceInstantiationException ex) {
            Logger.getLogger(ExtractInformation.class.getName()).log(Level.SEVERE, null, ex);
        } catch(MalformedURLException murle) {
            murle.printStackTrace();
        }
    }
    
    gate.creole.SerialAnalyserController application;
    public Corpus corpus;
    public Corpus getCorpus() {
        return corpus;
    }
    
    public boolean isIEApplication;
    public void setIsIEApplication(boolean b) {
        isIEApplication=b;
    }
    
    public ExtractInformation(String gappFile) {
        try {
            application =
                (gate.creole.SerialAnalyserController)
                                PersistenceManager.loadObjectFromFile(new File(gappFile));
            
        } catch (PersistenceException ex) {
            Logger.getLogger(ExtractInformation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ExtractInformation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ResourceInstantiationException ex) {
            Logger.getLogger(ExtractInformation.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public String getSentences() {
        String txt="TO BE IMPLEMENTED";
       
        
        
        
        return txt;
    }
    
    
    public String getSummary() {
        String summary="TO BE IMPLEMENTED";
      
        
        return summary;
    }
    
    
    public String extractEntities(String type) {
        String list="TO BE IMPLEMENTED";
        
   
        return list;
        
    }
    
    /** 
     Extract all entities specified in "types"
     **/ 
    public String extractEntitiesByType(String[] types) {
        String list="";
        
        return list;
    }
    
    /**
     * Gives the text of the annotation
     * @param ann
     * @return 
     */
    public String getAnnotationString(Annotation ann) {
        String name="";
        Long start, end;
        String dc=document.getContent().toString();
        start=ann.getStartNode().getOffset();
        end  =ann.getEndNode().getOffset();
        name=dc.substring(start.intValue(), end.intValue());        
        return name;
    }
    
    public void processDocument() {
        try {
          
            corpus=Factory.newCorpus("");
            corpus.add(document);
            application.setCorpus(corpus);
            application.execute();
        } catch (ExecutionException ex) {
            Logger.getLogger(ExtractInformation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ResourceInstantiationException ex) {
            Logger.getLogger(ExtractInformation.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    
}
