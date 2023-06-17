//
//  CreateEventViewController.swift
//  SociaCampus
//
//  Created by Cumali Atalan on 26.05.2023.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class CreateEventViewController: UIViewController, UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadPhoto: UIImageView!
    @IBOutlet weak var eventTypeTextField: UITextField!
    @IBOutlet weak var eventLocationTextField: UITextField!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var eventDesc: UITextField!
    var eventDate : String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let firestore = Firestore.firestore()
        
        uploadPhoto.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectedImage))
        uploadPhoto.addGestureRecognizer(gestureRecognizer)
        
        let calendar = Calendar.current
        let currentDate = Date()
        let minimumDate = calendar.date(byAdding: .day, value: 0, to: currentDate)
        let maximumDate = calendar.date(byAdding: .year, value: 1, to: currentDate)
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        
        datePicker.date = currentDate
        
    }
        
    @objc func selectedImage() {
        let pickerController =  UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadPhoto.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func datePickerAct(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        let selectedDate = datePicker.date
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        self.eventDate = formattedDate
        
    }
    
    
    @IBAction func createEventButtonAction(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = uploadPhoto.image?.jpegData(compressionQuality: 1)
        {
            
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data) { storagemetadata, error in
                if error != nil
                {
                    self.errorMessage(title: "Error", message: error?.localizedDescription ?? "Try Again!")
                } else
                {
                    imageReference.downloadURL { url, error in
                        if error == nil
                        {
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl
                            {
                                let firestoreDatabase = Firestore.firestore()
                                let firestoreEvent = ["eventPhotoURL": imageUrl,
                                                      "eventType": self.eventTypeTextField.text!,
                                                      "eventName": self.eventNameTextField.text!,
                                                      "eventLocation": self.eventLocationTextField.text!,
                                                      "eventDesc": self.eventDesc.text!,
                                                      "eventDate" : self.eventDate,
                                                      "date" : FieldValue.serverTimestamp()] as [String:Any]
                                if imageUrl != "" && self.eventTypeTextField.text != "" && self.eventNameTextField.text != "" && self.eventLocationTextField.text != "" && self.eventDesc.text != "" {
                                    firestoreDatabase.collection("Event").addDocument(data: firestoreEvent) {
                                        (error) in
                                        if error != nil
                                        {
                                            self.errorMessage(title: "İnternet Erişimi Problemi!", message: error?.localizedDescription ?? "Error, Try Again")
                                        }
                                        else
                                        {
                                            self.errorMessage(title: "Tebrikler!", message: "Etkinlik Oluşturuldu.")
                                            self.uploadPhoto.image = UIImage(named: "choose")
                                            self.eventTypeTextField.text = ""
                                            self.eventNameTextField.text = ""
                                            self.eventLocationTextField.text = ""
                                            self.eventDesc.text = ""
                                            self.tabBarController?.selectedIndex = 0
                                        }
                                    }
                                } else {
                                    self.errorMessage(title: "Tüm boşlukları doldurunuz!", message: error?.localizedDescription ?? "Error! Try Again")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func errorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
