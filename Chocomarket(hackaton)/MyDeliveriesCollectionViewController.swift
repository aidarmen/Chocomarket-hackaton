//
//  MyDeliveriesCollectionViewController.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 03.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class MyDeliveriesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UINavigationBarDelegate, DeliveryCellDelegate {
    func MoreButtonTapped(sender: DeliveriesCollectionViewCell) {
        print()
    }
    

    
    var ref: DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    var deliveries: [Deliveries] = []
    
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
                        let inProcess = Bool(document![i].data()["inProcess"] as! String)!
                        let objectId = document![i].documentID
                        let products = document![i].data()["products"] as! Dictionary<String, [String]>
    
                        var name:String = ""

                        if(Auth.auth().currentUser != nil){
                                let userID : String = (Auth.auth().currentUser?.uid)!
                                 print("Current user ID is" + userID)
                            self.ref = Database.database().reference()
                                self.ref?.child("first_name").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
                                    print("qqqqqqqqqq")
                                    let db = Firestore.firestore()
                                    db.collection("users").getDocuments { (query, error) in
                                        let document = query?.documents.first?.data()["first_name"]
                                        name = document as! String
                                        
                                    }


                                 })
                        }
                        
                        
                        
                        if(name == deliverer){
                            let newDelivery = Deliveries(deliverer: deliverer, inProcess: inProcess, objectId: objectId, products: products)
                        DispatchQueue.main.async {
                            self.deliveries.append(newDelivery)
                            self.collectionView.reloadData()
                        }
                        
                        }
                    }
                

                    
                }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return deliveries.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myDeliveryCell", for: indexPath) as! DeliveriesCollectionViewCell
                
        //        cell.update(deliveryNumber: "Delivery #\(1)", deliveryDescr: "you should embed each of the view controllers attached to the Tab Bar Controller inside Navigation Control", statusImage: UIImage(systemName: "flag")!, statusName: "Not Taken")
                
                let delivery = deliveries[indexPath.row]
                
                var TakenOrNot = ""
                var image: UIImage
                var color: UIColor
                if(delivery.inProcess){
                    TakenOrNot = "In Process"
                    image = UIImage(systemName: "checkmark")!
                    color = UIColor.green
                } else {
                    TakenOrNot = "Not Taken"
                    image = UIImage(systemName: "flag")!
                    color = UIColor.red
                }
                
                cell.update(deliveryNumber: "\(delivery.objectId)", deliveryDescr: "Description", statusImage: image, statusName: TakenOrNot, color: color)
        //        cell.update(deliveryNumber: delivery.objectId, deliveryDescr: "Description", statusImage: <#T##UIImage#>, statusName: <#T##String#>)
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
