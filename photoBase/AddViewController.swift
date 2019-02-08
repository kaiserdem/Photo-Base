//
//  AddViewController.swift
//  photoBase
//
//  Created by Kaiserdem on 08.02.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

  @IBOutlet weak var titleField: UITextField!
  @IBOutlet weak var descriptionField: UITextField!
  
  @IBOutlet weak var imageView: UIImageView!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  @IBAction func dismissKeyboard(_ sender: Any) {
  }
  @IBAction func camera(_ sender: Any) {
  }
  
    
  @IBAction func library(_ sender: Any) {
  }
  
  @IBAction func save(_ sender: Any) {
  }
}
