//
//  ApiUtils.swift
//  ApiUtils
//
//  Created by Ibukunoluwa Soyebo on 21/09/2020.
//

import Foundation
import Alamofire
import PKHUD

class ApiUtil{
    static var successBool = "status"
    static var message = "message"
    static var errorMssg = "errorMssg"
    
    static func postRequest(viewController:UIViewController,endpoint:String,params:Parameters,displayErrorAsAlert:Bool, jsonHandler: @escaping (AFDataResponse<Any>) -> Void, showHUd: Bool = false){
        Connectivity.isConnectedToInternet(viewcontroller: viewController)
        
        if showHUd{
            HUD.show(.progress)

        }
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON{
                response in
                switch response.result{
                case .success:
                    guard response.error == nil else {
                        // got an error in getting the data, need to handle it
                        print("error calling POST on /todos/1")
                        print(response.error!)
                        HUD.flash(.labeledError(title: "Network Error", subtitle: "Check internet Connection"),delay: 1)
                        return
                    }
                    // make sure we got some JSON since that's what we expect
                    guard let json = response.value as? [String: Any] else {
                        print("didn't get todo object as JSON from API")
                        if let error = response.error {
                            print("Error: \(error)")
                        }
                        return
                    }
                    print(json)
                    let success = json[successBool] as! Bool
                    //var myMessage = json[message] as! String
                    let errMssg = json[errorMssg] as! String
                    
                    if success{
                        HUD.hide()
                        jsonHandler(response)
                    }else{
                        print(params)
                        //print(myMessage)
                        if displayErrorAsAlert{
                            displayErrorMessageAsAlert(viewcontroller: viewController, errorMessage: errMssg)
                        }else{
                            HUD.flash(.labeledError(title: "Error", subtitle: errMssg),delay: 1)

                        }
                    }
                case .failure(let error):
                    displayErrorMessageAsAlert(viewcontroller: viewController, errorMessage: error.localizedDescription)
                    HUD.hide()
                    print("mess up")
                }
        }
        
    }
    
    
    static func getRequest(viewController:UIViewController,endpoint:String,customError:Bool, jsonHandler:@escaping (AFDataResponse<Any>)->Void, onFailure:@escaping ()-> Void){
        Connectivity.isConnectedToInternet(viewcontroller: viewController)
//        HUD.show(.progress)
        print(endpoint)
        AF.request(endpoint)
            .validate(statusCode: 200..<300)
            .responseJSON{
            response in
                switch response.result{
                case .success:
                    guard response.error == nil else {
                        // got an error in getting the data, need to handle it
                        print("error calling POST on /todos/1")
                        print(response.error!)
                        HUD.flash(.labeledError(title: "Network Error", subtitle: "Check internet Connection"),delay: 1)
                        return
                    }
                    // make sure we got some JSON since that's what we expect
//                    guard let json = response.value as? [String: Any] else {
//                        print("didn't get todo object as JSON from API")
//                        if let error = response.error {
//                            print("Error: \(error)")
//                        }
//                        return
//                    }
                    //print(json)
                    print("K")

                        HUD.hide()
                        jsonHandler(response)

                case .failure(let error):
                    HUD.flash(.label(error.localizedDescription), delay: 1)
                    //displayErrorMessageAsAlert(viewcontroller: viewController, errorMessage: )
                    print("wahala dey")
                }
        }
        
    }
    
    
    static func displayErrorMessageAsAlert(viewcontroller:UIViewController, errorMessage:String){
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        viewcontroller.present(alert, animated: true, completion: ({
          HUD.hide()
        }))
        
    }
    
    static func hmm(){
        let k: HTTPHeaders = ["":""]
        AF.request("hmm",headers:k).responseJSON{
            response in
            let k = response.value as! [String:Any]
        }
            
    }
    
}


//if let error = error as? AFError {
//        switch error {
//        case .invalidURL(let url):
//            print("Invalid URL: \(url) - \(error.localizedDescription)")
//        case .parameterEncodingFailed(let reason):
//            print("Parameter encoding failed: \(error.localizedDescription)")
//            print("Failure Reason: \(reason)")
//        case .multipartEncodingFailed(let reason):
//            print("Multipart encoding failed: \(error.localizedDescription)")
//            print("Failure Reason: \(reason)")
//        case .responseValidationFailed(let reason):
//            print("Response validation failed: \(error.localizedDescription)")
//            print("Failure Reason: \(reason)")
//
//            switch reason {
//            case .dataFileNil, .dataFileReadFailed:
//                print("Downloaded file could not be read")
//            case .missingContentType(let acceptableContentTypes):
//                print("Content Type Missing: \(acceptableContentTypes)")
//            case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
//                print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
//            case .unacceptableStatusCode(let code):
//                print("Response status code was unacceptable: \(code)")
//            }
//        case .responseSerializationFailed(let reason):
//            print("Response serialization failed: \(error.localizedDescription)")
//            print("Failure Reason: \(reason)")
//        }
//
//        print("Underlying error: \(error.underlyingError)")
//    } else if let error = error as? URLError {
//        print("URLError occurred: \(error)")
//    } else {
//        print("Unknown error: \(error)")
//    }
//}
