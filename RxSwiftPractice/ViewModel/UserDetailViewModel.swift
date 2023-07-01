//
//  UserDetailViewModel.swift
//  RxSwiftPractice
//
//  Created by allen on 2023/7/1.
//

import Foundation
import RxCocoa
import RxSwift


struct UserDetailViewModel {
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
    func getAlbums() -> Observable<String> {
        return Observable.create { observer -> Disposable in

            let url = URL(string: "https://jsonplaceholder.typicode.com/albums?userId=\(id)")!
            WebService().getCount(url: url) { count in
                if let count = count {
                    observer.onNext("\(count)")
                }
            }
            return Disposables.create{
                observer.onNext("error")
            }
        }
    }
    
    func getPosts() -> Observable<String> {
        return Observable.create { observer -> Disposable in
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(id)")!
            WebService().getCount(url: url) { count in
                if let count = count {
                    observer.onNext("\(count)")
                }
            }
            return Disposables.create{
                observer.onNext("error")
            }
        }
    }
    
    
}
