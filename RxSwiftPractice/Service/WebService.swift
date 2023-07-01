//
//  WebService.swift
//  RxSwiftPractice
//
//  Created by allen on 2023/6/30.
//

import Foundation
import Alamofire

class WebService {
    func getUserList(url: URL, completion: @escaping ([User]?) -> ()) {
        AF.request(url).responseDecodable(of: [User].self) { response in
            switch response.result {
            case .success:
                if let value = response.value {
                    completion(value)
                }
                
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func getCount(url: URL, completion: @escaping (Int?) -> ()) {
        // 若要改用responseDecodable，需要見一個struct來接資料，暫時先用responseJSON
        AF.request(url,method: .get).responseJSON { response in
            switch response.result {
            case .success:
                let dictionary = response.value as? [[String:Any]]
                completion(dictionary?.count)
                
            case .failure:
                completion(0)
            }
        }
    }
    

}
