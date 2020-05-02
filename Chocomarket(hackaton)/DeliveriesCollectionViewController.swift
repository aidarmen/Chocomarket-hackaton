//
//  DeliveriesCollectionViewController.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 01.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit


class DeliveriesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UINavigationBarDelegate {
    
    //MARK: vars
    var deliveriesArray: [Deliveries] = []

    
    //MARK: View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadDeliveriesFromFirebase{
            (allDeliveries) in
            
            print("callback is completed")
        }
        

        let width = (view.frame.size.width - 50)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width-200)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadDeliveries()
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return deliveriesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deliveryCell", for: indexPath) as! DeliveriesCollectionViewCell
        
//        cell.update(deliveryNumber: "Delivery #\(1)", deliveryDescr: "you should embed each of the view controllers attached to the Tab Bar Controller inside Navigation Control", statusImage: UIImage(systemName: "flag")!, statusName: "Not Taken")
        
        cell.generateCell(deliveriesArray[indexPath.row])
        
        cell.layer.cornerRadius = 10
    
        return cell
    }
    
    //MARK: download delivereis
    
    private func loadDeliveries(){
        downloadDeliveriesFromFirebase{ (allDeliveries) in
            self.deliveriesArray = allDeliveries
            
            self.collectionView.reloadData()
            
        }
        
        
    }
    
    
    
    
    

   

}
