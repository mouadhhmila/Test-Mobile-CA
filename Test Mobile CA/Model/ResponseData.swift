//
//  ResponseData.swift
//  Test Mobile CA
//
//  Created by Mouadh Hmila on 4/1/2024.
//

import Foundation
import UIKit

class ResponseData: Codable{
    
    var accounts: [accounts]?
    var isCA: Int?
    var name: String?
        

        
    struct accounts: Codable{
            var balance: Double?
            var contract_number: String?
            var holder: String?
            var id: String?
            var label: String?
            var operations: [operations]?
            var order: Int?
            var product_code: String?
            var role: Int?
    }
    
    struct operations: Codable{
            var amount: String?
            var category: String?
            var date: String?
            var id: String?
            var title: String?
    }
    init(accounts: [accounts]? = nil, isCA: Int? = nil, name: String? = nil) {
        self.accounts = accounts
        self.isCA = isCA
        self.name = name
            
    }
        
}
