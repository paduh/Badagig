//
//  PostBadaGigVC.swift
//  badagig
//
//  Created by Perfect Aduh on 11/30/17.
//  Copyright © 2017 Perfect Aduh. All rights reserved.
//

import UIKit

class PostBadaGigVC: UIViewController {

    
    //Outlets
    @IBOutlet weak var addDescriptionTextView: UITextView!
    @IBOutlet weak var postRequestActivity: UIActivityIndicatorView!
    @IBOutlet weak var textViewPlaceHolderLbl: UILabel!
    @IBOutlet weak var subCategoryTxt: UITextField!
    @IBOutlet weak var deliveryTimeTxt: UITextField!
    @IBOutlet weak var budgetTxt: UITextField!
    @IBOutlet weak var categoryTxt: UITextField!
    
    //Variables
    var categoryPicker = UIPickerView()
    var subCategoryPicker = UIPickerView()
    var deliveryTimePicker = UIPickerView()
    var categories = [Category]()
    var subCategories = [SubCategory]()
    var toolBar = UIToolbar()
    var selectedCategory = Category()
    var selectedSubCategory = SubCategory()
    var subCategory = SubCategory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryPicker.delegate = self
        categoryPicker.dataSource  = self
        
        subCategoryPicker.delegate = self
        subCategoryPicker.dataSource = self
        
        deliveryTimePicker.delegate = self
        deliveryTimePicker.dataSource = self
        
        addDescriptionTextView.delegate = self
        postRequestActivity.isHidden = true
        
        deliveryTimeTxt.delegate = self
        budgetTxt.delegate = self
        
        toolBar.barStyle = UIBarStyle.default
        
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(donePicking))
        doneButton.tintColor = #colorLiteral(red: 0.253228128, green: 0.4500418901, blue: 0.7301566601, alpha: 1)
        
        toolBar.setItems([flexibleButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
    }
    
    @objc func donePicking(textField: UITextField) {
        self.view.endEditing(true)
        switch textField {
        case categoryTxt:
            categoryTxt.resignFirstResponder()
        case subCategoryTxt:
            subCategoryTxt.resignFirstResponder()
        case deliveryTimeTxt:
            deliveryTimeTxt.resignFirstResponder()
        default:
            break
        }
    }
    
    func showAlert(title: String, message: String) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    @IBAction func categorButtonyPressed(_ sender: Any) {
        BadaGigService.instance.categories.removeAll()
        BadaGigService.instance.getAllCategories { (success) in
            if success {
                self.categoryTxt.inputView = self.categoryPicker
                self.categoryTxt.inputAccessoryView = self.toolBar
                self.categoryTxt.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func subCategoryButtonPressed(_ sender: Any) {
        BadaGigService.instance.subCategories.removeAll()
        BadaGigService.instance.getAllSubCategoryByCategory(categoryId: selectedCategory.id) { (success) in
            if success {
                self.subCategoryTxt.inputView = self.subCategoryPicker
                self.subCategoryTxt.inputAccessoryView = self.toolBar
                self.subCategoryTxt.becomeFirstResponder()
            }
        }
    }
    
    
    @IBAction func deliveryTimeButtonPressed(_ sender: Any) {
        BadaGigService.instance.deliveryDays.removeAll()
        BadaGigService.instance.getDeliveryDays()
        deliveryTimeTxt.inputView = deliveryTimePicker
        deliveryTimeTxt.inputAccessoryView = self.toolBar
        deliveryTimeTxt.becomeFirstResponder()
    }
    
    @IBAction func submiteRequestButtonPressed(_ sender: Any) {
        guard let description = addDescriptionTextView.text, description != ""  else { return }
        guard let category = categoryTxt.text, category != ""  else { return }
        guard let subCategory = subCategoryTxt.text, subCategory != ""  else { return }
        guard let deliveryTime = deliveryTimeTxt.text, deliveryTime != ""  else { return }
        guard let budget = budgetTxt.text, budget != ""  else { return }
        guard let budgetToDouble = Double(budget) else { return }
        
        BadaGigService.instance.addNewRequest(description: description, badaGigerId: AuthService.instance.loggedInUserId!, budget: budgetToDouble, deliveryDays: deliveryTime, subCategoryId: self.selectedSubCategory.id) { (success) in
            if success {
                
            } else {
                
            }
        }
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PostBadaGigVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case budgetTxt:
            view.bindToKeyboardWillChange()
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case budgetTxt:
            view.bindToKeyboardDidChange()
        default:
            break
        }
    }
}

extension PostBadaGigVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text != "" {
            textViewPlaceHolderLbl.isHidden = false
        } else {
            textViewPlaceHolderLbl.isHidden = true
        }
    }
}


extension PostBadaGigVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView{
        case categoryPicker:
            return BadaGigService.instance.categories.count
        case subCategoryPicker:
            return BadaGigService.instance.subCategories.count
        case deliveryTimePicker:
            return BadaGigService.instance.deliveryDays.count
        default:
            break
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case categoryPicker:
            let category = BadaGigService.instance.categories[row]
            return category.CategoryTItle
        case subCategoryPicker:
            let subCategory = BadaGigService.instance.subCategories[row]
            return subCategory.subCategoryTItle
        case deliveryTimePicker:
            let deliveryDays = BadaGigService.instance.deliveryDays[row]
            return deliveryDays
        default:
            break
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case categoryPicker:
            selectedCategory = BadaGigService.instance.categories[row]
            categoryTxt.text = selectedCategory.CategoryTItle
        case subCategoryPicker:
            let selectedSubcategory = BadaGigService.instance.subCategories[row]
            subCategoryTxt.text = selectedSubcategory.subCategoryTItle
            self.selectedSubCategory = selectedSubcategory
        case deliveryTimePicker:
            let deliveryTime = BadaGigService.instance.deliveryDays[row]
            deliveryTimeTxt.text = deliveryTime
        default:
            break
        }
    }
}
