//
//  skinCancerViewController.swift
//  HTHS.hacks
//
//  Created by Pranav Teegavarapu on 5/17/20.
//  Copyright © 2020 Pranav Teegavarapu. All rights reserved.
//

import Foundation
import UIKit
import CoreML
import Vision

class skinCancerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    @IBAction func cameraActivation(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            cameraView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("could not convert to CIImage")
            }
            detect(image: ciimage)
        }
    }
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: skin_cancer_classifier_1().model) else {
            fatalError("loading model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model Failed to Process Image")
            }
            if let firstResult = results.first {
                if firstResult.identifier.contains("Positive Test"){
                    self.navigationItem.title = "Positive Test"
                } else {
                    self.navigationItem.title = "Negative Test"
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try! handler.perform([request])
        }
        catch {
            print(error)
        }
        
    }
    
}
