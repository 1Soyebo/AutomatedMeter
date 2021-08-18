//
//  SettingsViewController.swift
//  Oba's Project
//
//  Created by Ibukunoluwa Soyebo on 06/08/2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var whiteCard: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        curveTwoCorners()
    }


    @IBAction func goback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func curveTwoCorners(){
        whiteCard.layer.cornerRadius = 35
        whiteCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}
