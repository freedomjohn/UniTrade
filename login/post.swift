//
//  post.swift
//  login
//
//  Created by Ellis on 11/12/15.
//  Copyright © 2015 Sheng Zhang. All rights reserved.
//

import UIKit
import Parse

class post: UIViewController ,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate  {

    var i = 0;
    
    var post = PFObject(className: "Post")
    
    @IBOutlet weak var itemName: UITextField!
    
    @IBOutlet weak var Price: UITextField!
    
    @IBOutlet weak var currentImage: UIImageView!
    
    @IBOutlet weak var itemDescription: UITextField!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var postBtn: UITabBarItem!
    
    @IBAction func takePicture(sender: AnyObject) {
        var imageFromSource = UIImagePickerController()
        imageFromSource.delegate = self
        imageFromSource.allowsEditing = false
        //create alert controller
        let myAlert = UIAlertController(title: "take photo", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet )
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        myAlert.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { action -> Void in
            //Code for launching the camera
            if
                UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                    imageFromSource.sourceType = UIImagePickerControllerSourceType.Camera
            }
            else{
                imageFromSource.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            }
            self.presentViewController(imageFromSource, animated: true, completion: nil)
            
        }
        myAlert.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            //Code for picking from camera roll
            imageFromSource.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
             self.presentViewController(imageFromSource, animated: true, completion: nil)
        }
        myAlert.addAction(choosePictureAction)
        
        //show the alert
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        //imageFromSource.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
       
        
        

    }
    

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var temp : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        currentImage.image = temp
        let imageData = UIImageJPEGRepresentation(temp, 0.2)
        let imageFile = PFFile(name:"image.jpeg", data:imageData!)
        
        var userPhoto = PFObject(className:"UserPhoto")
        userPhoto["imageName"] = "\(i)"
        userPhoto["imageFile"] = imageFile
        userPhoto.saveInBackground()
        post["image"] = imageFile
        self.dismissViewControllerAnimated( true , completion: {})
    }

    
    @IBAction func addPost(sender: AnyObject) {
        if (itemName.text == nil || Price.text == nil || itemDescription.text == nil) {
            print("hikkk")
            let myAlert = UIAlertController(title: "Please complete all of the required fields before continuing.", message: nil, preferredStyle: UIAlertControllerStyle.Alert )
            
            //add an "ok" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(myAlert, animated: true, completion: nil)

        } else {
            print("hi")
        post["name"] = itemName.text
        post["price"] = Price.text
        post["description"] = itemDescription.text
        post["category"] = "none"
        post["user"] = PFUser.currentUser()?.objectId
        post.saveInBackground()
        }
       self.view.endEditing(true)
    }


}
