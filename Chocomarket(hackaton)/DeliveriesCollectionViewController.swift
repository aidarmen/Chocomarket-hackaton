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

class DeliveriesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UINavigationBarDelegate, DeliveryCellDelegate {
    
    var indexOfProduct = 35
    var ref: DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    var deliveries: [Deliveries] = []
    
    func MoreButtonTapped(sender: DeliveriesCollectionViewCell) {
        print("tuta")
        if let indexPath = collectionView.indexPath(for: sender){
            var items = deliveries[indexPath.row]
            indexOfProduct = indexPath.row
            print("tuta")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexOfProduct = indexPath.row
        performSegue(withIdentifier: "showDeliveryProducts", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDeliveryProducts"{
            let destin = segue.destination as? deliveryProductsTableViewController
           // destin?.index = indexOfProduct
            let item = deliveries[indexOfProduct]
            destin?.products = item.products
        }
    }
    
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = (view.frame.size.width - 50)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width-200)
        ref = Database.database().reference()
        let db = Firestore.firestore()
        db.collection("Deliveries").getDocuments { (snapshot, error) in
            let document = snapshot?.documents
//            print(type(of: ))
            
            
            for i in 0...(snapshot?.documents.count)!-1{
                let deliverer = document![i].data()["deliverer"] as! String?
                let inProcess = document![i].data()["inProcess"] as! String
                let id = document![i].data()["id"] as! String?
                let objectId = document![i].documentID
                let products = document![i].data()["products"] as! Dictionary<String, [String]>
                
//                print(type(of: inProcess), "process")
//                print(type(of: deliverer), "deliver")
//                print(type(of: objectId), "id")
//                print(type(of: products), "produ")if
                
                if(inProcess != "inProcess"){
                    let newDelivery = Deliveries(deliverer: deliverer, inProcess: inProcess, objectId: objectId, products: products, id: id)
                DispatchQueue.main.async {
                    self.deliveries.append(newDelivery)
                    self.collectionView.reloadData()
                }
                
                }
            }
        

            
        }
        // Do any additional setup after loading the view.
        
//        print(self.deliveries.count)
    }
    


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //print(deliveries.count)
        return deliveries.count
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
    
    
    override func viewDidDisappear(_ animated: Bool) {
//        deliveries = []
    }
    
    
    
        override func viewWillAppear(_ animated: Bool) {
            
            print(indexOfProduct, "idishka")
            
            if(Auth.auth().currentUser != nil){
            let userID : String = (Auth.auth().currentUser?.uid)!
             print("Current user ID is" + userID)
            ref = Database.database().reference()
            self.ref?.child("name").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
                //print("qqqqqqqqqq")
                let db = Firestore.firestore()
                db.collection("users").getDocuments { (query, error) in
                    let document = query?.documents.first?.data()["phone"]
                    //print(document!)
                }


             })
    }
            
            if(Auth.auth().currentUser == nil){
                let secondViewController = (self.storyboard?.instantiateViewController(withIdentifier: "initial"))! as! InitialViewController
                self.navigationController!.pushViewController(secondViewController, animated: true)
            }
            
            
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deliveryCell", for: indexPath) as! DeliveriesCollectionViewCell
        
//        cell.update(deliveryNumber: "Delivery #\(1)", deliveryDescr: "you should embed each of the view controllers attached to the Tab Bar Controller inside Navigation Control", statusImage: UIImage(systemName: "flag")!, statusName: "Not Taken")
        
        let delivery = deliveries[indexPath.row]
        
        var TakenOrNot = ""
        var image: UIImage?
        var color: UIColor?
        
        if(delivery.inProcess == "inProcess"){
            TakenOrNot = "In Process"
            image = UIImage(systemName: "clock")!
            color = UIColor.yellow
        } else if(delivery.inProcess == "notTaken") {
            TakenOrNot = "Not Taken"
            image = UIImage(systemName: "flag")!
            color = UIColor.red
        } else if(delivery.inProcess == "done"){
            TakenOrNot = "Done"
            image = UIImage(systemName: "checkmark")!
            color = UIColor.green
        }
        
        cell.update(deliveryNumber: "\(delivery.objectId)", deliveryDescr: "Description", statusImage: image!, statusName: TakenOrNot, color: color!)
        
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
