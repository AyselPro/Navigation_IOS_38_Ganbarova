//
//  ViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit
import StorageService

public class ViewController: UIViewController {
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        StorageService.cropPhoto()
        #if DEBUG
        view.backgroundColor = .green
        #else
        view.backgroundColor = .red
        #endif
       
       
    }
    
    private func tapBurButtonItamAction() {
        
    }
        
    private func buttonAction() {
        
    }
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
