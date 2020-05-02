//
//  ProductManageViewController.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 01.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit

class ProductManageViewController: UIViewController {
    
    var quantity: String?
    var name: String?

    @IBOutlet weak var quantityOfProduct: UITextField!
    @IBOutlet weak var nameProduct: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        quantityOfProduct.text = quantity ?? ""
        nameProduct.text = name ?? ""
        // Do any additional setup after loading the view.
    }
    
   
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
