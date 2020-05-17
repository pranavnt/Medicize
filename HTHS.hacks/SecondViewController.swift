//
//  SecondViewController.swift
//  HTHS.hacks
//
//  Created by Pranav Teegavarapu on 5/16/20.
//  Copyright © 2020 Pranav Teegavarapu. All rights reserved.
//

import Foundation
import UIKit
import CoreML
import Vision


class covid19ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraView: UIImageView!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
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
    
    
    @IBAction func cameraActivation(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: covid19_classifer_1().model) else {
            fatalError("loading model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model Failed to Process Image")
            }
            if let firstResult = results.first {
                if firstResult.identifier.contains("Not"){
                    self.navigationItem.title = "Negative Test"
                } else {
                    self.navigationItem.title = "Positive Test"
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

