//
//  LoadPDfVc.swift
//  SigningPractice
//
//  Created by Ibukunoluwa Soyebo on 29/04/2020.
//  Copyright © 2020 Ibukunoluwa Soyebo. All rights reserved.
//

import UIKit
import PKHUD
import PDFKit

class LoadPDfVc: UIViewController {
    
    
    @IBOutlet weak var pdfURL: UITextField!
    var pathGenerated: String = ""
    
    
    var fileName: String = "LoadedPDF"
    var didPdfLoad: Bool = false
    
    @IBOutlet weak var outBtnLoadPDF: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fileName =
        navigationController?.navigationBar.prefersLargeTitles = false
        curveUIElements(element: pdfURL.layer)
        title = "Load URL"
        outBtnLoadPDF.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    func curveUIElements(element: CALayer){
        element.cornerRadius = 5
        element.borderWidth = 2
        element.borderColor = CGColor(srgbRed: 234/255, green: 91/255, blue: 12/255, alpha: 1)
    }

    func showSavedPdf(url:String) {
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if let pdfDocument = PDFDocument(url: url) {
                        let nextVc = SignVC(nibName: "SignatureVC", bundle: nil)
                        //nextVc.Pdfurl = url
                        self.navigationController?.pushViewController(nextVc, animated: true)
                    }
            }
        } catch {
            print("could not locate pdf file !!!!!!!")
        }
        }
        
    }
    
    @IBAction func goTOPDF(_ sender: Any) {
     
        if pdfURL.text != "" {
            
            let validurl = pdfURL.text
            print(self.pdfURL.text)
            let url = URL(string: validurl!)
            self.didPdfLoad = true

//            FileDownloader.loadFileAsync(url: url!) { (path, error) in
//                print("PDF File downloaded to : \(path!)")
//                self.pathGenerated = path!
//                            }
            
            
            
            if self.didPdfLoad{
                
                let nextVc = SignVC(nibName: "SignatureVC", bundle: nil)
                nextVc.Pdfurl = url
                self.navigationController?.pushViewController(nextVc, animated: true)
                    //showSavedPdf(url: pathGenerated)
 
            }
            
        }
        else{
//            let nextVc = SignVC(nibName: "SignatureVC", bundle: nil)
//            self.navigationController?.pushViewController(nextVc, animated: true)
//            HUD.flash(.labeledSuccess(title: "Let's Go", subtitle: nil))

//                let nextVc = SignVC(nibName: "SignatureVC", bundle: nil)
//            self.navigationController?.pushViewController(nextVc, animated: true)
                HUD.flash(.labeledError(title: "Error", subtitle: "Please Put in a URL"))
                        print("Empty")
            
                                        }
                }
        
    }
    
    
       
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



