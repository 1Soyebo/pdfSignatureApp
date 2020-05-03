//
//  TesTColorVc.swift
//  SigningPractice
//
//  Created by Ibukunoluwa Soyebo on 01/05/2020.
//  Copyright © 2020 Ibukunoluwa Soyebo. All rights reserved.
//

import UIKit
import IGColorPicker
import SwiftSignatureView
import EPSignature




class TesTColorVc: UIViewController, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout, EPSignatureDelegate{
    
    @IBOutlet var mainView: UIView!
    var hasColorBeenPicked: Bool = false
    

    @IBOutlet weak var sigh: EPSignatureView!
    @IBOutlet var signTapGestRecog: UITapGestureRecognizer!
    
    @IBOutlet weak var btnSignDone: UIBarButtonItem!
    
    
    @IBOutlet var colorVC: ColorPickerView!
    
    var pickedColor = UIColor()
    
    //@IBOutlet var colorView: ColorPickerCell!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        sigh.strokeColor = UIColor.red
        sigh.backgroundColor = UIColor.white
        sigh.layer.borderWidth = 5
        sigh.layer.borderColor = CGColor(srgbRed: 2/255, green: 2/255, blue: 2/255, alpha: 0.1)
        
        
        //mainView.alpha = 0.1
        //formView.alpha = 1
//        colorVC.style = .square
//        colorVC.delegate = self
//        colorVC.layoutDelegate = self
        //self.preferredContentSize = CGSize(width: 100, height: 100)
        // Do any additional setup after loading the view.
        //let toolSample = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
            
        //self.view.addSubview(toolSample)
        navigationController?.setToolbarHidden(false, animated: false)
        
    }
    
    
//    required init?(coder aDecoder: NSCoder) {
//       super.init(coder: aDecoder)
//    }

    
    
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped")
        
        
        let tappedcolor = colorVC.colors[indexPath.row]
        pickedColor = tappedcolor
        hasColorBeenPicked = true
        
    }



    // This is an optional method
    func colorPickerView(_ colorPickerView: ColorPickerView, didDeselectItemAt indexPath: IndexPath) {
        
        print("tapped")
      
    }
    
    
    
    
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    @IBAction func btnDismiss(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        let signCV = SignVC(nibName: "SignatureVC", bundle: nil)
        signCV.hasColorBeenPicked = hasColorBeenPicked
        //signCV.showSignaturePage()
        signCV.signatureColor = pickedColor
        
        self.dismiss(animated: true, completion: nil)
     
    }
    
    func skeleton(){
        
    }
    
    
    @IBAction func handleSignTapGesture(_ sender: Any) {
        print("tapped")
        if sigh.isSigned{
            btnSignDone.isEnabled = sigh.isSigned
        }
        
    }
    
    
    
    
    
//    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      // The size for each cell
//        
//    
//      // 👉🏻 WIDTH AND HEIGHT MUST BE EQUALS!
//    }
//
//    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//      // Space between cells
//    }
//
//    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//      // Space between rows
//    }
//
//    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
//      // Inset used aroud the view
//    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



