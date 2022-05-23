/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package infoextractgui;

import gate.Gate;
import java.io.File;

/**
 *
 * @author UPF
 */
public class InfoExtractGUI {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        IEForm form;
        
        try {
            Gate.setGateHome(new File("C:\\work\\programs\\GATE-7.0"));
            Gate.init();
            ExtractInformation extractor=new ExtractInformation(args[0]);
            extractor.setIsIEApplication(new Boolean(args[1]).booleanValue());
            
            form=new IEForm(extractor);
            form.setVisible(true);
            
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
