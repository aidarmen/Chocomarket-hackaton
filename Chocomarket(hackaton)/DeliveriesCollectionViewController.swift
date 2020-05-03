//
//  DeliveriesCollectionViewController.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 01.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DeliveriesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UINavigationBarDelegate {

    var ref: DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = (view.frame.size.width - 50)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width-200)
        
        // Do any additional setup after loading the view.
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    @IBAction func logoutButton(_ sender: Any) {
    do {
        try Auth.auth().signOut()
    } catch {
        print("User creation failed with error:")
    }
        let secondViewController = (self.storyboard?.instantiateViewController(withIdentifier: "initial"))! as! InitialViewController
        self.navigationController!.pushViewController(secondViewController, animated: true)
    }
    
    
        override func viewWillAppear(_ animated: Bool) {
            
            
            
//            if(Auth.auth().currentUser != nil){
//            let userID : String = (Auth.auth().currentUser?.uid)!
//             print("Current user ID is" + userID)
//            ref = Database.database().reference()
//            self.ref?.child("first_name").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
//                print("qqqqqqqqqq")
//                let db = Firestore.firestore()
//                db.collection("users").getDocuments { (query, error) in
//                    let document = query?.documents.first?.data()["phone"]
//                    print(document!)
//                }
//
//
//             })
//    }
            
            if(Auth.auth().currentUser == nil){
                let secondViewController = (self.storyboard?.instantiateViewController(withIdentifier: "initial"))! as! InitialViewController
                self.navigationController!.pushViewController(secondViewController, animated: true)
            }
            
            print("logout")
    }
        override func viewWillDisappear(_ animated: Bool) {
            
        }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deliveryCell", for: indexPath) as! DeliveriesCollectionViewCell
        
        cell.update(deliveryNumber: "Delivery #\(1)", deliveryDescr: "you should embed each of the view controllers attached to the Tab Bar Controller inside Navigation Control", statusImage: UIImage(systemName: "flag")!, statusName: "Not Taken")
        cell.layer.cornerRadius = 10
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
