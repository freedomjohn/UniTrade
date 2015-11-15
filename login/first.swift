//
//  first.swift
//  login
//
//  Created by Ellis on 11/12/15.
//  Copyright © 2015 Sheng Zhang. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class first: UIViewController, UITableViewDelegate, PFLogInViewControllerDelegate,PFSignUpViewControllerDelegate, UITableViewDataSource {
  
    // Parse setup
    var logInController = PFLogInViewController()
    var signUpViewController = PFSignUpViewController()
    
    // To show search bar on navigation bar
    lazy   var searchBars:UISearchBar = UISearchBar(frame: CGRectMake(30, 0, 250, 20))
    
    // Table View Setup
    @IBOutlet weak var tableView: UITableView!
    var dataArray: NSMutableArray! = NSMutableArray() // Array of data (each cell)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // To show search bar on navigation bar
        let leftNavBarButton = UIBarButtonItem(customView: searchBars)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        // Testing if it shows the items in table view
        for (var i: Int = 0; i < 50; i++){
            self.dataArray.addObject("Post")
        }
        self.tableView.reloadData()
        
        // Hide the navigation bar on swipe
        self.navigationController?.hidesBarsOnSwipe = true

    }
    // Setup for table view
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = self.dataArray[indexPath.row] as? String
        return cell
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.logInController.fields = [PFLogInFields.UsernameAndPassword
            , PFLogInFields.LogInButton
            , PFLogInFields.SignUpButton
            , PFLogInFields.PasswordForgotten
            //, PFLogInFields.DismissButton
        ]
        let logInlogoTitle = UILabel()
        logInlogoTitle.text = "UniTride"
        self.logInController.logInView?.logo = logInlogoTitle
        self.logInController.delegate = self
        
        let signUplogoTitle = UILabel()
        signUplogoTitle.text = "UniTride"
        self.signUpViewController.signUpView?.logo = signUplogoTitle
        self.signUpViewController.delegate = self
        
        self.logInController.signUpController = self.signUpViewController
        
        if(PFUser.currentUser() == nil){
            self.presentViewController(self.logInController, animated:true, completion: nil)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //log in
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if(!username.isEmpty || !password.isEmpty){
            return true
        }else{
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        //        let firstViewController:first = first()
        //        self.presentViewController(firstViewController, animated: true, completion: nil)
        
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Failed to Login")
    }
    
    //sign up
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        return true
    }
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("fail to sign up")
    }
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        print("User dismissed sign up")
    }
    @IBAction func act(sender: AnyObject) {
        self.presentViewController(self.logInController, animated:true, completion: nil)
        if(PFUser.currentUser() != nil){
            user.text = PFUser.currentUser()?.username // print the user name to label
        }
    }
    
    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        if(PFUser.currentUser() == nil){
            user.text = "nobody"
        }
    }
    
    @IBOutlet weak var user: UILabel!
    
    
}
