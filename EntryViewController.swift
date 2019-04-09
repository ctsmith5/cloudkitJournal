//
//  EntryViewController.swift
//  JournalCloud2
//
//  Created by Colin Smith on 4/8/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    func updateViews(){
        DispatchQueue.main.async {
            guard let entry = self.entry else {return}
            self.titleTextField.text = entry.title
            self.bodyTextView.text = entry.bodyText
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text,
            !title.isEmpty,
            let bodyText = bodyTextView.text else {return}
        EntryController.shared.save(title: title, bodyText: bodyText) { (entry) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
