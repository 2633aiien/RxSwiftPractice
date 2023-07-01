//
//  UserDetailViewController.swift
//  RxSwiftPractice
//
//  Created by allen on 2023/6/30.
//

import UIKit
import RxSwift

class UserDetailViewController: UIViewController {
    @IBOutlet weak var albumsCountLabel: UILabel!
    @IBOutlet weak var postsCountLabel: UILabel!
    private var id : Int!
    
    private var viewModel: UserDetailViewModel? = nil
    private var disposeBag = DisposeBag()
    
    init(coder: NSCoder, id: Int) {
        self.id = id
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "userId: \(id!)"
        viewModel = UserDetailViewModel(id: id)
        bindData()
    }
    
    func bindData() {
        Observable.zip(
            viewModel!.getAlbums(),
            viewModel!.getPosts()
        ).subscribe(onNext: { (albums, posts) in
            self.albumsCountLabel.text = "albums.count: \(albums)"
            self.postsCountLabel.text = "posts.count: \(posts)"
        }).disposed(by: disposeBag)
    }


}
