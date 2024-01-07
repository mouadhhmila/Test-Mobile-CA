//
//  TabBarViewController.swift
//  Test Mobile CA
//
//  Created by Mouadh Hmila on 5/1/2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let topline = CALayer()
        topline.frame = CGRect(x: 0, y: 0, width: self.tabBar.frame.width, height: 0.5)
                topline.backgroundColor = UIColor.lightGray.cgColor
                self.tabBar.layer.addSublayer(topline)
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
