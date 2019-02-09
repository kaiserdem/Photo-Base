//
//  AddViewController.swift
//  photoBase
//
//  Created by Kaiserdem on 08.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var titleField: UITextField!
  @IBOutlet weak var descriptionField: UITextField!
  @IBOutlet weak var imageView: UIImageView!
  
  var item : Entity? = nil
  
  var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    if item == nil {
      self.navigationItem.title = "Add new Data"
    } else {
      self.navigationItem.title = item?.titleText
      titleField.text = item?.titleText
      descriptionField.text = item?.descriptionText
      
      imageView.image = UIImage(data: (item?.image)! as Data)
    }

  }
    
  @IBAction func dismissKeyboard(_ sender: Any) {
    self.resignFirstResponder()
  }
  @IBAction func camera(_ sender: Any) {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = UIImagePickerController.SourceType.camera
    pickerController.allowsEditing = true
    
    self.present(pickerController, animated: true, completion: nil)
  }
  @IBAction func library(_ sender: Any) {
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
    pickerController.allowsEditing = true
    
    self.present(pickerController, animated: true, completion: nil)
    
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      imageView.image = image
    }
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func save(_ sender: Any) {
    
    if item == nil { // если не сущестует - создаем
    
    let entityDescription = NSEntityDescription.entity(forEntityName: "Entity", in: pc)
    
    let item = Entity(entity: entityDescription!, insertInto: pc)
    
    item.titleText = titleField.text
    item.descriptionText = descriptionField.text
    item.image = imageView.image!.pngData() as NSData?
      
    } else { // перезаписываем
    
      item?.titleText = titleField.text
      item?.descriptionText = descriptionField.text
      item?.image = imageView.image!.pngData() as NSData?
    }
    do {
      try pc.save()
    }
    catch {
      print(error)
      return
    }
    navigationController!.popViewController(animated: true)
  }
}
