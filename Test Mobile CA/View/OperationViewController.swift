//
//  OperationViewController.swift
//  Test Mobile CA
//
//  Created by Mouadh Hmila on 4/1/2024.
//

import UIKit

class OperationViewController: UIViewController {

    @IBOutlet weak var _tableViewOA: UITableView!
    @IBOutlet weak var _accountBalance: UILabel!
    @IBOutlet weak var _AccountName: UILabel!
    
    
    var dataViewModel = DataViewModel()
    var accounts = ResponseData.accounts()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        LoadInformation()
        
        
        self._tableViewOA.register(UINib(nibName: "OperationCell", bundle: Bundle.main), forCellReuseIdentifier: "OperationCell")
        self._tableViewOA.dataSource = self
        self._tableViewOA.delegate = self
    }
    
    
    func LoadInformation(){
        
        _AccountName.text = accounts.label
        _accountBalance.text = "\(accounts.balance!) €".replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
        
        accounts.operations = dataViewModel.arrangeOperation(operations: accounts.operations!)
        
    }

    

}

extension OperationViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return accounts.operations!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OperationCell", for: indexPath) as! OperationCell
        cell.selectionStyle = .none
        
        cell._operationtitle.text = accounts.operations![indexPath.row].title
        cell._operationBalance.text = accounts.operations![indexPath.row].amount! + " €"
        cell._operationDate.text = dataViewModel.TimestampToSring(date: accounts.operations![indexPath.row].date!)
           
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65
    }
    
}
