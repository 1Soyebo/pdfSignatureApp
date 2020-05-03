//
//  ViewController.swift
//  SigningPractice
//
//  Created by Ibukunoluwa Soyebo on 28/04/2020.
//  Copyright © 2020 Ibukunoluwa Soyebo. All rights reserved.
//

import UIKit
import PDFKit
import EPSignature
import IGColorPicker


//MARK: - PDF ANNOTATION
class ImageStampAnnotation: PDFAnnotation {
    
    var image: UIImage!
    
    
    
    // A custom init that sets the type to Stamp on default and assigns our Image variable
    init(with image: UIImage!, forBounds bounds: CGRect, withProperties properties: [AnyHashable : Any]?) {
        super.init(bounds: bounds, forType: PDFAnnotationSubtype.stamp, withProperties: properties)
        
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(with box: PDFDisplayBox, in context: CGContext) {
        
        // Get the CGImage of our image
        guard let cgImage = self.image.cgImage else { return }
        
        // Draw our CGImage in the context of our PDFAnnotation bounds
        context.draw(cgImage, in: self.bounds)
        
    }
}

//MARK: - VIEW CONTROLLER
class SignVC: UIViewController, EPSignatureDelegate, PDFDocumentDelegate, ColorPickerViewDelegate {
    
   
    @IBOutlet weak var pdfSignatureView: EPSignatureView!
    
    @IBOutlet var pdfSignatureTapGesRecog: UITapGestureRecognizer!
    @IBOutlet weak var btnCancelSignatureView: UIBarButtonItem!
    @IBOutlet weak var btnDoneSignatureView: UIBarButtonItem!
    @IBOutlet weak var signatureViewNavBar: UINavigationBar!
    
    
    
    var hasColorBeenPicked: Bool = false
   
    @IBOutlet var colorVC: ColorPickerView!
       
    var pickedColor = UIColor()
    
    
    var signaturePosition: CGPoint!
    var signatureColor = UIColor()
    //var hasColorBeenPicked: Bool = false
    
    @IBOutlet var PositionSignature: UITapGestureRecognizer!
    
    
    var Pdfurl:URL!
    
    @IBOutlet weak var pdfContainerView: PDFView!
   
    var currentlySelectedAnnotation: PDFAnnotation?
    var PDFsignatureImage: UIImage?
    
    @IBOutlet weak var toolbarColorVc: UIToolbar!
    
    var originalViewTitle: String = "sksksksks"
    
//MARK: - viewDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        colorVC.delegate = self
        self.title = "skskssk"
        //pdfContainerView.autoScales = true
        //setupView()
        
        let signbarbutton = UIBarButtonItem(title: "Sign", style: .plain, target: self, action: #selector(btnSignature))
        let shareBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(savePDF))
        
        
        self.navigationItem.rightBarButtonItems = [shareBarButton, signbarbutton]
        setupView()
        if hasColorBeenPicked{
            showSignaturePage()
        }

        colorVC.isHidden = true
        toolbarColorVc.isHidden = true
        pdfSignatureView.isHidden = true
        pdfSignatureTapGesRecog.isEnabled = false
        PositionSignature.isEnabled = false
        //self.view.bringSubviewToFront(oluwa)
        //pdfContainerView.isHidden = true
        
    }

    
    
//    func showSavedPdf(url:String, fileName:String) {
//            if #available(iOS 10.0, *) {
//                do {
//                    let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                    let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
//                    for url in contents {
//                        if url.description.contains("\(fileName).pdf") {
//                           // its your file! do what you want with it!
//
//                    }
//                }
//            } catch {
//                print("could not locate pdf file !!!!!!!")
//            }
//        }
//    }
    
    
    // MARK: - SETUP VIEW
    func setupView(){
        if let path = Bundle.main.path(forResource: "sample", ofType: "pdf") {
            DispatchQueue.main.async {
                if let pdfDocument = PDFDocument(url: self.Pdfurl) {
                    self.pdfContainerView.displayMode = .singlePageContinuous
                    self.pdfContainerView.autoScales = true
                    self.pdfContainerView.displayDirection = .vertical
                    self.pdfContainerView.document = pdfDocument
                }
            }
            
        }
    }
    
    // MARK: - SAVE PDF
    @objc func savePDF(){
        
        let doc = pdfContainerView.document
        let dataPDF = doc?.dataRepresentation()
        let base64Data = dataPDF?.base64EncodedString()
        let vc = UIActivityViewController(activityItems: [dataPDF!], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    
    
    //MARK: - ALERT TO SIGN
    @objc func btnSignature() {
        
        let alertToSign = UIAlertController(title: "Signature", message: "Tap The PDF To Position Signature", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: ({Void in self.PositionSignature.isEnabled = true
            self.title = "Tap Position"
            
            
            }
        ))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: ({Void in }))
        
        alertToSign.addAction(okAction)
        alertToSign.addAction(cancelAction)
        self.present(alertToSign, animated: true, completion: nil)
        
    }
    
    
    //MARK: - SHOW SIGNATURE VIEW
    @objc func showSignaturePage(){
        
        signatureViewNavBar.isHidden = false
        pdfSignatureView.clear()
        pdfSignatureView.layer.borderWidth = 5
        pdfSignatureView.layer.borderColor = CGColor(srgbRed: 2/255, green: 2/255, blue: 2/255, alpha: 0.1)
        pdfSignatureView.layer.cornerRadius = 5
    
        pdfSignatureView.isHidden = false
        //pdfSignatureView.strokeColor = pickedColor
        pdfSignatureView.backgroundColor = UIColor.white
        pdfSignatureTapGesRecog.isEnabled = true
        
        self.view.bringSubviewToFront(pdfSignatureView)
        

    }
    
    @IBAction func handleSIgnatureTapGesRecog(_ sender: Any) {
        print("tapped")
        if pdfSignatureView.isSigned{
            btnDoneSignatureView.isEnabled = true
        }
        title = originalViewTitle
    }
    
    @IBAction func btnCancelSignaturePage(_ sender: Any) {
        pdfSignatureView.isHidden = true
        title = originalViewTitle
    }
    
    
    @IBAction func btnHandleDoneSignaturePAge(_ sender: Any) {
        pdfSignatureView.layer.borderWidth = 0
        signatureViewNavBar.isHidden = true
        PDFsignatureImage = pdfSignatureView.getSignatureAsImage()
        guard let unwrappedSignatureImage = PDFsignatureImage, let page = pdfContainerView.currentPage else { return }
        //let pageBounds = page.bounds(for: .cropBox)
        let imageBounds = CGRect(x: signaturePosition.x, y: signaturePosition.y, width: 200, height: 100)
        let imageStamp = ImageStampAnnotation(with: unwrappedSignatureImage, forBounds: imageBounds, withProperties: nil)
        page.addAnnotation(imageStamp)
        pdfSignatureView.isHidden = true
    }
    
    
    
    
   //MARK: - GESTURE RECOGNIZER
    @IBAction func handleTapSignaturePosition(_ sender: Any) {
        print("Tapped")
        
        let touchLocation = (sender as AnyObject).location(in: pdfContainerView)
        guard let page = pdfContainerView.page(for: touchLocation, nearest: true)
            else {
                return
        }
        let locationOnPage = pdfContainerView.convert(touchLocation, to: page)

        
        signaturePosition = locationOnPage
        PositionSignature.isEnabled = false
        self.title = "Pick A Color"
        colorVC.isHidden = false
        toolbarColorVc.isHidden = false
        self.view.bringSubviewToFront(colorVC)
        self.view.bringSubviewToFront(toolbarColorVc)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "ColorVC") as! TesTColorVc
//
//        controller.modalPresentationStyle = .overFullScreen
//
//
//        present(controller, animated: true)
        
        
    }
    
    //MARK: - COLOR PICKER DELEGATE
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped")
        
        
        let tappedcolor = colorVC.colors[indexPath.row]
        pdfSignatureView.strokeColor = tappedcolor
        //hasColorBeenPicked = true
        print("HMm")
        
    }


    // This is an optional method
    func colorPickerView(_ colorPickerView: ColorPickerView, didDeselectItemAt indexPath: IndexPath) {
        
        print("tapped")
      
    }
    
    //MARK: - NAVBAR BUTTONS
    
   @IBAction func btnDoneToolbar(_ sender: Any) {
    colorVC.isHidden = true
    toolbarColorVc.isHidden = true
    
    
    showSignaturePage()
   
   }

    @IBAction func btnCloseToolbar(_ sender: Any) {
        colorVC.isHidden = true
        toolbarColorVc.isHidden = true
        
    }
    
    
}

