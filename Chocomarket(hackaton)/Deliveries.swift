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
    var inProcess: Bool
    var objectId: String
    var products: [String:[String]]
    
    init(deliverer: String?, inProcess: Bool, objectId: String, products: [String:[String]]){
        self.deliverer = deliverer
        self.inProcess = inProcess
        self.objectId = objectId
        self.products = products
    }
    
}
