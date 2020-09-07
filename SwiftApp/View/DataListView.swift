//
//  DataListView.swift
//  SwiftApp
//
//  Created by WYH_MAC001 on 05/09/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit
import SnapKit

class DataListView: BaseView {

    var didSetupConstraints = false
    let tableView: UITableView = {
        let tblView = UITableView()
        return tblView
    }()
    
    var viewModel = DataListViewModel()
    var dataListDetails = [DataListDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        title = "Data List"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.setNeedsUpdateConstraints()
        showDetailsFromDatabase()
        setupViewModel()
        setupTableView()
        viewModel.getDataList()
    }
    
    fileprivate func setupTableView(){
        tableView.register(DataListTableViewCell.self, forCellReuseIdentifier: DataListTableViewCell.idnetifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }
    override func updateViewConstraints() {
        if(!didSetupConstraints){
            tableView.snp.makeConstraints { (make) in
                make.edges.equalTo(view).inset(UIEdgeInsets.zero)
            }
            didSetupConstraints =  true
        }
        super.updateViewConstraints()
    }
    
    fileprivate func setupViewModel() {
        
        self.viewModel.showAlertClosure = {
            let alert = self.viewModel.alertMessage ?? ""
            self.showAlert(title: nil, message: alert)
        }
        
        self.viewModel.updateLoadingStatus = {
            if self.viewModel.isLoading {
                self.startActivityIndicatory(uiView: self.view)
            } else {
                self.stopActivityIndicator()
            }
        }
        
        self.viewModel.serverErrorStatus = {
           self.showAlert(title: nil, message: "Please try again later")
        }
        
        self.viewModel.didGetData = {
            self.showDetailsFromDatabase()
        }
    }
    
    private func showDetailsFromDatabase(){
        self.dataListDetails.removeAll()
        self.dataListDetails = PersistenceManager.shared.fetch(DataListDetails.self)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension DataListView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataListDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataListTableViewCell.idnetifier, for: indexPath) as! DataListTableViewCell
        cell.detail = dataListDetails[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = DataListDetailView()
        detailView.dataListDetail = dataListDetails[indexPath.row]
        navigationController?.pushViewController(detailView, animated: true)
    }
}
