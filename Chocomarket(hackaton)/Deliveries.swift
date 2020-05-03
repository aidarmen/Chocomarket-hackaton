//
//  Deliveries.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 03.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import Foundation

class Deliveries{
    var deliverer: String?
    var inProcess: String
    var objectId: String
    var products: [String:[String]]
    var id: String?
    
    init(deliverer: String?, inProcess: String, objectId: String, products: [String:[String]], id: String?){
        self.deliverer = deliverer
        self.inProcess = inProcess
        self.objectId = objectId
        self.products = products
        self.id = id
    }
    
}
