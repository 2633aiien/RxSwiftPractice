//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by allen on 2023/6/30.
//

import UIKit
import RxSwift

class UserListViewController: UIViewController {
    
    private var viewModel = UserListViewModel()
    private var disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        bindData()
    }
    
    func bindData() {
        // bind items to table
        viewModel.items.bind(
            to: tableView.rx.items(
                cellIdentifier: "cell",
                cellType: UserListTableViewCell.self)
        ) {row, model, cell in
            cell.IDLabel.text = "id: \(model.id)"
            cell.nameLabel.text = "name: \(model.name)"
        }.disposed(by: disposeBag)
        // bind a model selected handler
        tableView.rx.modelSelected(User.self).subscribe { user in
            let viewController = self.storyboard?.instantiateViewController(identifier: "userDetail", creator: { coder in
                UserDetailViewController(coder: coder, id: user.id)
            })
            self.navigationController?.pushViewController(viewController!, animated: true)
        }.disposed(by: disposeBag)
        // fetch items
        viewModel.fetchItems()
    }


}

extension UserListViewController: UITableViewDelegate {
    
}
