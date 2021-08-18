//
//  HistoryViewController.swift
//  ObasProject
//
//  Created by Ibukunoluwa Soyebo on 18/08/2021.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tblHistory: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableHistory()
        
    }


    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func configureTableHistory(){
        tblHistory.delegate = self
        tblHistory.dataSource = self
        //tblDeliveries.backgroundColor = .clear
        tblHistory.register(HistoryTableViewCell.getNib(), forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tblHistory.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblHistory.separatorStyle = .none
        tblHistory.tableFooterView = UIView()
        tblHistory.rowHeight = 100
        //tblDeliveries.isEditing = true
        
    }

}


extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HelperClass.globalAdaFruit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyCell = tblHistory.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as! HistoryTableViewCell
        historyCell.lblPower.text = "\(HelperClass.globalAdaFruit[indexPath.row].kiloWattHour)"
        historyCell.lblTime.text = HelperClass.globalAdaFruit[indexPath.row].iOSTime.toTimeShortStrin()
        historyCell.lblDate.text = HelperClass.globalAdaFruit[indexPath.row].iOSDate.toDateShortString()
        return historyCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblHistory.deselectRow(at: indexPath, animated: true)
    }
    
}
