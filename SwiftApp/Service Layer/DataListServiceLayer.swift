//
//  DataListServiceLayer.swift
//  SwiftApp
//
//  Created by WYH_MAC001 on 05/09/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import Foundation

class DataListServiceLayer {
    
    func getDataList(success: @escaping (DataListModel) -> (), failure: @escaping (Error) -> ()){
        guard let url = URL(string: "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json") else { return }
        APIManager.shared.getRequest(url) { (result: Result<DataListModel>) in
            switch (result) {
            case .success(let model):
                success(model)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
