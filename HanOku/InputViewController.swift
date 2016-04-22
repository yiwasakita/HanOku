//
//  InputViewController.swift
//  HanOku
//
//  Created by tlsmooth89 on 4/21/16.
//  Copyright © 2016 yusuke.iwasaki. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    // @IBOutlet weak var datePicker: UIDatePicker!
    
    let realm = try! Realm()
    var item:Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Calling the dismissKeyboard method when the background is tapped.
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = item.title
        detailTextView.text = item.detail
        // datePicker.date = item.time
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        try! realm.write {
            self.item.title = self.titleTextField.text!
            self.item.detail = self.detailTextView.text
            // self.item.time = self.datePicker.date
            self.realm.add(self.item, update: true)
        }
        
        // setNotification(item)
        
        super.viewWillDisappear(animated)
    }
    
    func dismissKeyboard() {    
        view.endEditing(true)
    }
}
