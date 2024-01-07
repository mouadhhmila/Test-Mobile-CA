//
//  DataViewModel.swift
//  Test Mobile CA
//
//  Created by Mouadh Hmila on 5/1/2024.
//

import Foundation
import UIKit
import SystemConfiguration

public class DataViewModel {
    
    static var arrayHeaderCA = [Int]()
    static var arrayHeaderAB = [Int]()
    static var DATA_CREDIT_AGRIGOLE = [ResponseData]()
    static var DATA_AUTRE_BANK = [ResponseData]()
    
    
    var reloadTableView: (()->())?
    var showError: (()->())?
    
    var Storyboard:String = "Main"
    var COMMAND_GET_ACCOUNT_BANK:String = "https://cdf-test-mobile-default-rtdb.europe-west1.firebasedatabase.app/banks.json"
    
    
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let response = (isReachable && !needsConnection)
        
        return response
    }
    
   
    
   
    func arrangeBank(account: [ResponseData]) -> [ResponseData]{
        
        let _arrange = account.sorted { $0.name!.lowercased() < $1.name!.lowercased()}
        return _arrange
    }
    func arrangeAccount(account: [ResponseData.accounts]) -> [ResponseData.accounts]{
        
        let _arrange = account.sorted { $0.label!.lowercased() < $1.label!.lowercased()}
        return _arrange
    }
    func arrangeOperation(operations: [ResponseData.operations]) -> [ResponseData.operations]{
       
        let _arrange1 = operations.sorted { $0.title!.lowercased() < $1.title!.lowercased()}
        let _arrange2 = _arrange1.sorted{
            TimestampToDate(date: $0.date!).compare(TimestampToDate(date: $1.date!)) == .orderedDescending
        }
        return _arrange2
    }
    
    func calculTotalBalance(account: [ResponseData.accounts]) -> String{
        let balance = account.compactMap { Double(round(100 * Double($0.balance!)) / 100)}.reduce(0, +)
        return "\(Double(round(100 * balance) / 100)) €".replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
    }
    
    
    
    
    func Get_data(){
        
        WebServiceRequest.callWebService(loader : true , event : COMMAND_GET_ACCOUNT_BANK , header : ["Content-Type": "application/json"], method: .get, completion: {(response : [ResponseData]!, error: Bool) in
                
             if error == false{
             //print("response", response!)
                 
                 DispatchQueue.main.async{ [self] in
                     DataViewModel.DATA_CREDIT_AGRIGOLE = response.filter{
                     $0.isCA == 1
                 }
                     DataViewModel.DATA_AUTRE_BANK = response.filter{
                     $0.isCA == 0
                 }
                     
                     DataViewModel.DATA_CREDIT_AGRIGOLE = arrangeBank(account: DataViewModel.DATA_CREDIT_AGRIGOLE)
                     DataViewModel.DATA_AUTRE_BANK = arrangeBank(account: DataViewModel.DATA_AUTRE_BANK)
                 

                     DataViewModel.arrayHeaderCA = [Int](repeating: 0, count: DataViewModel.DATA_CREDIT_AGRIGOLE.count)
                     DataViewModel.arrayHeaderAB = [Int](repeating: 0, count: DataViewModel.DATA_AUTRE_BANK.count)
                 

                 self.reloadTableView?()
                 }
                            
             }else{
                 self.showError?()
             }
            
            })
              
            
            
        }
    
    
    func Get_account(is_CA: Int, section: Int, row: Int) -> ResponseData.accounts{
        return (is_CA == 1) ? DataViewModel.DATA_CREDIT_AGRIGOLE[section].accounts![row] : DataViewModel.DATA_AUTRE_BANK[section].accounts![row]
    }
    
    func TimestampToSring(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let _date = Date(timeIntervalSince1970: TimeInterval("\(date)")!)
        let strDate = dateFormatter.string(from: _date)
        return strDate
    }
    
    func TimestampToDate(date: String) -> Date{
        return Date(timeIntervalSince1970: TimeInterval("\(date)")!)
    }
    
    
}
