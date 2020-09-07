//
//  DataListViewModel.swift
//  SwiftApp
//
//  Created by WYH_MAC001 on 05/09/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import Foundation

class DataListViewModel{
    
    private let service: DataListServiceLayer
    
    private var networkStatus = Reach().connectionStatus()
    
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
        
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?
    
    init(withtest serviceProtocol: DataListServiceLayer = DataListServiceLayer() ) {
        self.service = serviceProtocol
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
        
    }
    
    @objc private func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    
    func getDataList() {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.isLoading = true
            self.service.getDataList(success: { (dataDetails) in
                self.isLoading = false
                PersistenceManager.shared.deleteAll(DataListDetails.self)
                for data in dataDetails{
                    let dataDetail = DataListDetails(context: PersistenceManager.shared.context)
                    dataDetail.id = data.id
                    dataDetail.type = data.type?.rawValue
                    dataDetail.date = data.date
                    dataDetail.desc = data.data
                    PersistenceManager.shared.save()
                }
                self.didGetData?()
            }) {(error) in
                self.isLoading = false
                self.alertMessage = error.localizedDescription
            }
        default:
            break
        }
    }
}
