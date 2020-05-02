//
//  FirebaseCollectionReference.swift
//  Chocomarket(hackaton)
//
//  Created by Aidar Batyrbekov on 5/2/20.
//  Copyright © 2020 Khaled. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Items
    case Deliveries
}

func FirebaseReference(_ collectionReference: FCollectionReference)->
    CollectionReference{
        return Firestore.firestore().collection(collectionReference.rawValue)
}
