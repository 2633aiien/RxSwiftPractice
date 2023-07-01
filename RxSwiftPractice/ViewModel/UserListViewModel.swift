//
//  UserListViewModel.swift
//  RxSwiftPractice
//
//  Created by allen on 2023/6/30.
//

import Foundation
import RxCocoa
import RxSwift

struct UserListViewModel {
    var items = PublishSubject<[User]>()
    
    func fetchItems() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        WebService().getUserList(url: url) { userList in
            
            if let userList = userList {
                items.onNext(userList)
                items.onCompleted()
            }
        }
    }
}
