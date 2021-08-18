//
//  ObasMenuViewController.swift
//  ObasProject
//
//  Created by Ibukunoluwa Soyebo on 17/08/2021.
//

import UIKit

class ObasMenuViewController: UIViewController {

    @IBOutlet weak var whiteCard: UIView!
    @IBOutlet var arrayButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayButtons.forEach{
            $0.layer.cornerRadius = 35
        }
        curveTwoCorners()
    }

    fileprivate func curveTwoCorners(){
        whiteCard.layer.cornerRadius = 35
        whiteCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func goBackToHome(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToSettings(_ sender: Any) {
        let historyVC = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
        navigationController?.pushViewController(historyVC, animated: true)
    }
    
    
}
