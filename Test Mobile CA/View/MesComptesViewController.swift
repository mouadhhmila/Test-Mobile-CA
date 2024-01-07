//
//  MesComptesViewController.swift
//  Test Mobile CA
//
//  Created by Mouadh Hmila on 4/1/2024.
//

import UIKit
import Combine

class MesComptesViewController: UIViewController {
    
    
    @IBOutlet weak var _tableViewCA: UITableView!
    @IBOutlet weak var _tableViewAB: UITableView!
    @IBOutlet weak var _height_table_CA: NSLayoutConstraint!
    @IBOutlet weak var _height_table_AB: NSLayoutConstraint!
    
    var cancellablesCA: Set<AnyCancellable> = []
    var cancellablesAB: Set<AnyCancellable> = []

    
    var dataViewModel = DataViewModel()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = _tableViewCA.indexPathForSelectedRow {
            _tableViewCA.deselectRow(at: indexPath, animated: true)
        }
        if let indexPath = _tableViewAB.indexPathForSelectedRow {
            _tableViewAB.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self._tableViewCA.register(UINib(nibName: "BankAccount", bundle: nil), forHeaderFooterViewReuseIdentifier: "BankAccount")
        self._tableViewCA.register(UINib(nibName: "AccountCell", bundle: Bundle.main), forCellReuseIdentifier: "AccountCell")
        
        self._tableViewAB.register(UINib(nibName: "BankAccount", bundle: nil), forHeaderFooterViewReuseIdentifier: "BankAccount")
        self._tableViewAB.register(UINib(nibName: "AccountCell", bundle: Bundle.main), forCellReuseIdentifier: "AccountCell")
        
        
        initViewModel()
    
        _tableViewCA.publisher(for: \.contentSize)
            .receive(on: DispatchQueue.main)
            .sink { self._height_table_CA?.constant = $0.height }
            .store(in: &cancellablesCA)
        
        _tableViewAB.publisher(for: \.contentSize)
            .receive(on: DispatchQueue.main)
            .sink { self._height_table_AB?.constant = $0.height }
            .store(in: &cancellablesAB)
        
        
        
    }
    
    func initViewModel(){
        dataViewModel.Get_data()
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self._tableViewCA.reloadData() }
            DispatchQueue.main.async { self._tableViewAB.reloadData() }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async { self.showAlert("Ups, something went wrong.") }
        }
        
        
    }
    
    
    @objc func tapSectionCA(sender: UIButton) {
        DataViewModel.arrayHeaderCA[sender.tag] = (DataViewModel.arrayHeaderCA[sender.tag] == 0) ? 1 : 0
            self._tableViewCA.reloadSections([sender.tag], with: .fade)
    }
    
    @objc func tapSectionAB(sender: UIButton) {
        DataViewModel.arrayHeaderAB[sender.tag] = (DataViewModel.arrayHeaderAB[sender.tag] == 0) ? 1 : 0
            self._tableViewAB.reloadSections([sender.tag], with: .fade)
    }

    
    
    
    

}


extension MesComptesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BankAccount") as! BankAccount
        let button = UIButton(type: .custom)
            button.frame = headerView.bounds
            button.tag = section
        
        if tableView == _tableViewCA {
            
            button.addTarget(self, action: #selector(tapSectionCA(sender:)), for: .touchUpInside)
            if DataViewModel.arrayHeaderCA[section] == 0{
                headerView.chevron.image = UIImage(systemName: "chevron.down")
            }else{
                headerView.chevron.image = UIImage(systemName: "chevron.up")
            }
            
            headerView.BankAccountTitle.text = DataViewModel.DATA_CREDIT_AGRIGOLE[section].name
            headerView.TotalBalance.text = dataViewModel.calculTotalBalance(account: DataViewModel.DATA_CREDIT_AGRIGOLE[section].accounts!)
            DataViewModel.DATA_CREDIT_AGRIGOLE[section].accounts = dataViewModel.arrangeAccount(account: DataViewModel.DATA_CREDIT_AGRIGOLE[section].accounts!)
            
            
        }else{
            
            
            button.addTarget(self, action: #selector(tapSectionAB(sender:)), for: .touchUpInside)
            
            if DataViewModel.arrayHeaderAB[section] == 0{
                headerView.chevron.image = UIImage(systemName: "chevron.down")
            }else{
                headerView.chevron.image = UIImage(systemName: "chevron.up")
            }
            
            headerView.BankAccountTitle.text = DataViewModel.DATA_AUTRE_BANK[section].name
            headerView.TotalBalance.text = dataViewModel.calculTotalBalance(account: DataViewModel.DATA_AUTRE_BANK[section].accounts!)
            DataViewModel.DATA_AUTRE_BANK[section].accounts = dataViewModel.arrangeAccount(account: DataViewModel.DATA_AUTRE_BANK[section].accounts!)
            
            
        }
        
        headerView.addSubview(button)
        

        return headerView
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        if tableView == _tableViewCA{
            return DataViewModel.arrayHeaderCA.count
        }else{
            return DataViewModel.arrayHeaderAB.count
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == _tableViewCA{
            return (DataViewModel.arrayHeaderCA[section] == 0) ? 0 : DataViewModel.DATA_CREDIT_AGRIGOLE[section].accounts!.count
        }else{
            return (DataViewModel.arrayHeaderAB[section] == 0) ? 0 : DataViewModel.DATA_AUTRE_BANK[section].accounts!.count
        }
    }
    
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountCell
        
        if tableView == _tableViewCA{
            
            cell.AccountName.text = DataViewModel.DATA_CREDIT_AGRIGOLE[indexPath.section].accounts?[indexPath.row].label
            if DataViewModel.DATA_CREDIT_AGRIGOLE[indexPath.section].accounts?[indexPath.row].balance != nil{
            cell.AccountBalance.text = "\(DataViewModel.DATA_CREDIT_AGRIGOLE[indexPath.section].accounts![indexPath.row].balance!) €".replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
            }
        }else{
            
            cell.AccountName.text = DataViewModel.DATA_AUTRE_BANK[indexPath.section].accounts?[indexPath.row].label
            if DataViewModel.DATA_AUTRE_BANK[indexPath.section].accounts?[indexPath.row].balance != nil{
            cell.AccountBalance.text = "\(DataViewModel.DATA_AUTRE_BANK[indexPath.section].accounts![indexPath.row].balance!) €".replacingOccurrences(of: ".", with: ",", options: .literal, range: nil)
            }
        }
        
        return cell

        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: dataViewModel.Storyboard, bundle: nil)
        let VC1 = storyboard.instantiateViewController(withIdentifier: "OperationViewController") as! OperationViewController
        
        
        var is_CA = 1
        if tableView == _tableViewAB{
            is_CA = 0
        }
        VC1.accounts = dataViewModel.Get_account(is_CA: is_CA, section: indexPath.section, row: indexPath.row)
        
        self.navigationController?.pushViewController(VC1, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55
    }
    
}
