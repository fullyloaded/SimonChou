//
//  MealViewController.swift
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
/*
此值通過 MealTableViewController 傳入 PrepareForSeque(_Sender) 或添加一個 new meal.
*/
    var meal: Meal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 當程序將要退出是被調用，通常是用來保存數據和一些退出前的清理工作。

        nameTextField.delegate = self
        
        // 編輯現有的meal所設置的顯示。
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text   = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        // 文本字段具有效的MealName,啟用保存按鈕。
        checkValidMealName()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text

    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
         // 如果用戶取消,關閉該選擇器。
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func camera(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // 使用原始的信息字典包含圖像的多種表示，。
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // 設置photoImageView以顯示所選擇的圖像。
        photoImageView.image = selectedImage
        
        // 關閉該選擇器
        dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    // 此方法可以先配置一個視圖控制器
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            //unwind segue後,讓the meal 傳遞給MealTableViewController

            meal = Meal(name: name, photo: photo, rating: rating)
            
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    func checkValidMealName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController視圖控制器，它允許用戶從他們的照片庫選擇媒體。
        let imagePickerController = UIImagePickerController()
        
        //讓照片可以挑，不能取。
         imagePickerController.sourceType = .PhotoLibrary
        
        // 當用戶選擇一個圖像,通知ViewController。
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

}

