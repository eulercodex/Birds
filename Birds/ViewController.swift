//
//  ViewController.swift
//  Birds
//
//  Created by Jesse Mihigo on 2/26/17.
//  Copyright © 2017 Jesse Nkingi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var aTableView: UITableView!
    var dictionary: Trie = Trie()
    var suggestions: [String] = [String]();
    @IBAction func editingDidChangeOnText(_ sender: UITextField) {
        if let string = sender.text {
            suggestions = dictionary.returnArrayOfValidWordsUsing(prefix: string , withLimit: 5);
            if suggestions.count > 0 {
                aTableView.reloadData()
                aTableView.isHidden = false
            }
            else {
                aTableView.isHidden = true
            }
        }
        
    }
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.isHidden = true
        
        if let path = Bundle.main.path(forResource: "birds", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers);
                for bird in jsonObj as! [String]{
                    dictionary.addWord(aWord: bird)
                }
                
            } catch{
                print("JSON processing failed")
            }
        } else {
            print("Invalid filename/path.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = suggestions[indexPath.row]
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        textField.text = suggestions[indexPath.row];
        if let string = textField.text {
            suggestions = dictionary.returnArrayOfValidWordsUsing(prefix: string , withLimit: 5);
            if suggestions.count > 0 {
                aTableView.reloadData()
                aTableView.isHidden = false
            }
            else {
                aTableView.isHidden = true
            }
        }
    }

}

