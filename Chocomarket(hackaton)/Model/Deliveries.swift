//
//  Deliveries.swift
//  Chocomarket(hackaton)
//
//  Created by Aidar Batyrbekov on 5/2/20.
//  Copyright © 2020 Khaled. All rights reserved.
//

import Foundation
import UIKit


class Deliveries{
    
    var id: String
    var inProcces: String
    
    init(_inProcces: String){
        id = ""
        inProcces = _inProcces
    }
    
    init(_dictionary: NSDictionary){
        id = _dictionary[kOBJECTID] as! String
        inProcces = _dictionary[kINPROCESS] as! String
    }
    
}


//MARK: save Deliveriesfunction

func saveDeliveriesToFirebase (_ deliveries: Deliveries){
    let id = UUID().uuidString
    deliveries.id = id
    
    
    FirebaseReference(.Deliveries).document(id).setData(deliveriesDictionaryFrom(deliveries)
        as! [String: Any])
    
}

//MARK: Helpers

func deliveriesDictionaryFrom(_ deliveries: Deliveries) ->NSDictionary{
    return NSDictionary(objects :[deliveries.id, deliveries.inProcces],forKeys:[kOBJECTID as NSCopying ,kINPROCESS as NSCopying  ] )
}


//MARK: Download deliveries from Firebase

func downloadDeliveriesFromFirebase(completion: @escaping (_ deliveriesArray: [Deliveries] )
    -> Void ){
        var deliveriesArray: [Deliveries] = []
        
        FirebaseReference(.Deliveries).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                completion(deliveriesArray)
                return
            }
            
            if !snapshot.isEmpty{
                
                for deleviryDict in snapshot.documents{
//                    print("created new deliveries with")
                    deliveriesArray.append(Deliveries(_dictionary: deleviryDict.data() as NSDictionary))
                }
                
            }
            completion(deliveriesArray)
            
        }
}


//Mark: run once
//func createDeliveries(){
//    let delivery001 = Deliveries(_inProcces: "False")
//    let delivery002 = Deliveries(_inProcces: "False")
//
//    let arrayOfDeliveries = [delivery001,delivery002]
//
//    for delivery in arrayOfDeliveries{
//        saveDeliveriesToFirebase(delivery )
//    }
//}
