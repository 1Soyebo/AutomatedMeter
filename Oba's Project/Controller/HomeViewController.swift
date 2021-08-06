//
//  HomeViewController.swift
//  Oba's Project
//
//  Created by Ibukunoluwa Soyebo on 06/08/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    let getRequestURL = "https://sim800lapi.herokuapp.com/api/v1/get/"
    var array_Dates = [Date]()
    var array_of_array_powerResults = [[AdaFruitResult]]()
    @IBOutlet weak var daysPageControl: UIPageControl!
    
//    var array_realm_persistentAdaFruit: Results<ArraysPersistentAdaFruit>?
    
//    @IBOutlet weak var myLineChart: LineChartView!
    var array_power_results = [AdaFruitResult]()

    @IBOutlet weak var obaCollectionView: UICollectionView!
    @IBOutlet weak var whiteCard: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        curveTwoCorners()
        configureColledtionView()
        callApi()
    }

    fileprivate func callApi(){
        ApiUtil.getRequest(viewController: self, endpoint: getRequestURL, customError: false, jsonHandler: {
            [self]
            request in
            let jsonRequest = request.value as? NSArray
            guard let _array_power_reults = jsonRequest else { return  }

            let time_diff:Double = (5/3600) * (1/1000)
            for power_result in _array_power_reults{
                
                let json_power_result = power_result as? [String:Any]
                
                let current = json_power_result?["current"] as? String ?? ""
                let date_stamp = json_power_result?["date_stamp"] as? String
                let id = json_power_result?["id"] as? Int
                let time_stamp = json_power_result?["time_stamp"] as? String ?? ""
                let power = json_power_result?["power"] as? String ?? ""
                let voltage = json_power_result?["voltage"] as? String ?? ""

                //create datestamp formatter
                let dateStampFormatter = DateFormatter()
                dateStampFormatter.dateFormat = "yyyy-MM-dd"
                
                //create timestmap formatter
                let timeStampFormatter = DateFormatter()
                timeStampFormatter.dateFormat = "HH:mm:ss"
                
                
                //trim timestamp
                let range = time_stamp.index(time_stamp.startIndex, offsetBy: 8)..<time_stamp.index(time_stamp.startIndex, offsetBy: 15)
                let k = time_stamp.replacingCharacters(in: range, with: "")
                
                let iOSTimeStamp = timeStampFormatter.date(from: k) ?? Date()
            
                let calculatedKilowattHour = (Double(power) ?? 0) * time_diff
                let single_power = AdaFruitResult(current: Double(current) ?? 0, date_stamp: date_stamp ?? "", id: id ?? 0, power: (Double(power) ?? 0), time_stamp: time_stamp, voltage: Double(voltage) ?? 0, iOSDate: dateStampFormatter.date(from: date_stamp ?? "") ?? Date(), iOSTime: iOSTimeStamp, kiloWattHour: calculatedKilowattHour)
                
                array_Dates.append(single_power.iOSDate)
//                array_power_results.insert(single_power, at: 0)
                array_power_results.append(single_power)
            }
            array_Dates = array_Dates.unique()
            sortArrayPowerResults()
//            checkIfLastDataFromAPICallIsTheSameAsRealm()
//            HUD.hide()
            obaCollectionView.reloadData()
            let hmm = IndexPath(item: array_Dates.count - 1, section: 0)
            obaCollectionView.scrollToItem(at: hmm, at: .right, animated: true)
            daysPageControl.numberOfPages = array_Dates.count
            updateViewControllerValuesAccordingToDay(currentPageNumber: array_Dates.count - 1)
            print("hmm")
        }, onFailure: {})
    }

    fileprivate func updateViewControllerValuesAccordingToDay(currentPageNumber:Int){
//        calculateTotalPowerPerDay(arraySmallPower: array_of_array_powerResults[currentPageNumber])
        daysPageControl.currentPage = currentPageNumber
    }
    
    fileprivate func curveTwoCorners(){
        whiteCard.layer.cornerRadius = 35
        whiteCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func goToHome(_ sender: Any) {
        
    }
    
    fileprivate func configureColledtionView(){
        obaCollectionView.delegate = self
        obaCollectionView.dataSource = self
        obaCollectionView.register(HistoryCVC.getNib(), forCellWithReuseIdentifier: HistoryCVC.identifier)
        obaCollectionView.isPagingEnabled = true
        if let flowlayout = obaCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowlayout.scrollDirection = .horizontal
            flowlayout.minimumLineSpacing = 0
        }
    }
    
    func sortArrayPowerResults(){
        
        for oneDate in array_Dates{
            
            let oneArray = array_power_results.filter({
                $0.iOSDate == oneDate
            })

            var cumulativePower:Double = 0
            for singlePowerResult in oneArray{
                cumulativePower += singlePowerResult.kiloWattHour
                singlePowerResult.cumulativePower = cumulativePower
            }
            /** do the sorting for realm
            print(oneArray.count)
            let oneArrPersistentPowerResult = ArraysPersistentAdaFruit(iOSDate: oneDate)

            for onePowerReslt in oneArray{
                let ah = onePowerReslt.createPAdaObject()
                oneArrPersistentPowerResult.listOfPersAdafruits.append(ah)
                oneArrPersistentPowerResult.consumpitonTotal.value = (oneArrPersistentPowerResult.consumpitonTotal.value ?? 0) + (ah.power.value ?? 0)
            }
            
            try! localRealm.write {
                localRealm.add(oneArrPersistentPowerResult)
            }
            **/
            print(oneDate)
            
            
//            if oneDate.isToday {
//                todayPower = 0
//                for hm in oneArray{
//                    todayPower += hm.kiloWattHour
//                }
//            }
            
            array_of_array_powerResults.append(oneArray)
        }
//        if let firstArray = array_of_array_powerResults.first{
//            calculateTotalPowerPerDay(arraySmallPower: firstArray)
//        }

        print(array_of_array_powerResults.count)
//         print(array_of_array_powerResults[0])
//        convertToChartDataEntry(array_adafruit: array_of_array_powerResults[2])

    }


}


extension HomeViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array_of_array_powerResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let historyCVCell = obaCollectionView.dequeueReusableCell(withReuseIdentifier: HistoryCVC.identifier, for: indexPath) as! HistoryCVC
        
        if array_power_results.isEmpty{
            return historyCVCell
        }
        
        let singleIndexDate = array_Dates[indexPath.item]
        let singleIndexDateString = singleIndexDate.toShortString()
//        historyCVCell.labelDate.text = "\(singleIndexDate.isToday ?  ("Today: " + singleIndexDateString):singleIndexDateString)"
        historyCVCell.labelDate.text = "\(singleIndexDateString)"

        historyCVCell.convertToChartDataEntry(array_adafruit: self.array_of_array_powerResults[indexPath.item])
        return historyCVCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: obaCollectionView.frame.width, height: obaCollectionView.frame.height)
    }
}
