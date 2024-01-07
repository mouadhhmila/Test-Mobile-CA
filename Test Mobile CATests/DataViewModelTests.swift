//
//  DataViewModelTests.swift
//  Test Mobile CATests
//
//  Created by Mouadh Hmila on 5/1/2024.
//

import XCTest
@testable import Test_Mobile_CA

final class DataViewModelTests: XCTestCase {
        
        var dataViewModel: DataViewModel!
        
        override func setUp() {
            super.setUp()
            dataViewModel = DataViewModel()
        }
        
        override func tearDown() {
            dataViewModel = nil
            super.tearDown()
        }

        func testIsConnectedToNetwork() {
            XCTAssertTrue(DataViewModel.isConnectedToNetwork(), "Le test de connexion réseau a échoué.")
        }
        

        
        func testGet_data() {
            
            let expectation = self.expectation(description: "Get_data a réussi.")
            
            dataViewModel.Get_data()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                XCTAssertEqual(DataViewModel.DATA_CREDIT_AGRIGOLE.count, 2, "La récupération des données CA a échoué.")
                XCTAssertEqual(DataViewModel.DATA_AUTRE_BANK.count, 2, "La récupération des données autre banque a échoué.")
                
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 10, handler: nil)
        }
    
    
    
    func testArrangeOperation() {
            let dataViewModel = DataViewModel()

            let testData = [
                ResponseData.operations(date: "1234567890", title: "Operation D"),
                ResponseData.operations(date: "1234567891", title: "Operation C"),
                ResponseData.operations(date: "1234567891", title: "Operation B"),
                ResponseData.operations(date: "1234567892", title: "Operation A")
            ]

            let arrangedData = dataViewModel.arrangeOperation(operations: testData)

            XCTAssertEqual(arrangedData[0].title, "Operation A")
            XCTAssertEqual(arrangedData[1].title, "Operation B")
            XCTAssertEqual(arrangedData[2].title, "Operation C")
            XCTAssertEqual(arrangedData[3].title, "Operation D")

        }
    
    
    func testArrangeAccount() {
           let dataViewModel = DataViewModel()

           let testData = [
               ResponseData.accounts(label: "Account C"),
               ResponseData.accounts(label: "Account A"),
               ResponseData.accounts(label: "Account B")
           ]

           let arrangedData = dataViewModel.arrangeAccount(account: testData)

           XCTAssertEqual(arrangedData[0].label, "Account A")
           XCTAssertEqual(arrangedData[1].label, "Account B")
           XCTAssertEqual(arrangedData[2].label, "Account C")
       }
    
    func testCalculTotalBalance() {
            let dataViewModel = DataViewModel()

            let testData: [ResponseData.accounts] = [
                ResponseData.accounts(balance: 100.52, label: "Account A"),
                ResponseData.accounts(balance: 50.750, label: "Account B"),
                ResponseData.accounts(balance: 75.2, label: "Account C")
            ]

            let totalBalance = dataViewModel.calculTotalBalance(account: testData)

            XCTAssertEqual(totalBalance, "226,47 €")
        }
    
        
    }
