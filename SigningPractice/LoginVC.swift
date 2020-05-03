//
//  LoginVC.swift
//  SigningPractice
//
//  Created by Ibukunoluwa Soyebo on 30/04/2020.
//  Copyright © 2020 Ibukunoluwa Soyebo. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var outBtnLogin: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Login"
        navigationController?.navigationBar.prefersLargeTitles = true
        curveUIElements(element: txtPassword.layer)
        curveUIElements(element: txtUsername.layer)
        outBtnLogin.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    
    public func curveUIElements(element: CALayer){
        element.cornerRadius = 5
        element.borderWidth = 2
        element.borderColor = CGColor(srgbRed: 234/255, green: 91/255, blue: 12/255, alpha: 1)
    }

    @IBAction func btnLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoadPDFVc")
        //tabBarController!.selectedViewController = controller
        self.show(controller, sender: nil)
        
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "ColorVC")
//
//        //tabBarController!.selectedViewController = controller
//        //controller.isModalInPresentation = true
//        controller.modalPresentationStyle = .overFullScreen
//        //controller.modalTransitionStyle = .partialCurl
//        //controller.preferredContentSize = CGSize(width: 100, height: 100)
//        //controller.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        //controller.view.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
//        //controller.view.center = self.view.center
//        present(controller, animated: true)
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
