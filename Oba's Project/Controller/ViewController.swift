//
//  ViewController.swift
//  Oba's Project
//
//  Created by Ibukunoluwa Soyebo on 06/08/2021.
//


//, .layerMinXMaxYCorner - bottom left
//, .layerMaxXMaxYCorner - bottom right
import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var whiteCardBackground: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        curveTwoCorners()
        goToHomeVC()
        
    }


    fileprivate func curveTwoCorners(){
        whiteCardBackground.layer.cornerRadius = 35
        whiteCardBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    fileprivate func goToHomeVC(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
}

