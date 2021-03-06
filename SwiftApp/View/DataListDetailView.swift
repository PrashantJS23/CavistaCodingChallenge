//
//  DataListDetailView.swift
//  SwiftApp
//
//  Created by WYH_MAC001 on 05/09/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit
import SnapKit

class DataListDetailView: UIViewController {
    
    var didSetupConstraints = false
    let scrollView  = UIScrollView()
    let contentView = UIView()
    var dataListDetail: DataListDetails?
    let lblId: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.preferredFont(forTextStyle: .body)
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    let lblIdTitle: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Id :"
        lbl.font = UIFont.preferredFont(forTextStyle: .body).bold()
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    let lblType: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.preferredFont(forTextStyle: .body)
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    let lblTypeTitle: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Type :"
        lbl.font = UIFont.preferredFont(forTextStyle: .body).bold()
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    let lblDate: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.preferredFont(forTextStyle: .body)
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    let lblDateTitle: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Date :"
        lbl.font = UIFont.preferredFont(forTextStyle: .body).bold()
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    let lblDesc: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.preferredFont(forTextStyle: .body)
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    let lblDescTitle: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Description :"
        lbl.font = UIFont.preferredFont(forTextStyle: .body).bold()
        lbl.adjustsFontForContentSizeCategory = true
        return lbl
    }()
    
    let stackView : UIStackView = {
        let stView = UIStackView()
        stView.alignment = .fill
        stView.distribution = .fill
        stView.axis = .vertical
        stView.spacing = 5.0
        return stView
    }()
    let stackView1 : UIStackView = {
        let stView = UIStackView()
        stView.alignment = .fill
        stView.distribution = .fill
        stView.axis = .horizontal
        stView.spacing = 5.0
        return stView
    }()
    let stackView2: UIStackView = {
        let stView = UIStackView()
        stView.alignment = .fill
        stView.distribution = .fill
        stView.axis = .horizontal
        stView.spacing = 5.0
        return stView
    }()
    let stackView3 : UIStackView = {
        let stView = UIStackView()
        stView.alignment = .fill
        stView.distribution = .fill
        stView.axis = .horizontal
        stView.spacing = 5.0
        return stView
    }()
    let stackView4 : UIStackView = {
        let stView = UIStackView()
        stView.alignment = .top
        stView.distribution = .fill
        stView.axis = .horizontal
        stView.spacing = 5.0
        return stView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        title = "Data List Details"
        view.backgroundColor = .systemBackground
        configure()
        view.setNeedsUpdateConstraints()
        lblDescTitle.text = dataListDetail?.type == "text" ? "Description :" : "ImageUrl :"
        lblId.text = dataListDetail?.id
        lblDate.text = dataListDetail?.date
        lblType.text =  dataListDetail?.type
        lblDesc.text = dataListDetail?.desc
    }
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            scrollView.snp.makeConstraints { make in
                make.edges.equalTo(view).inset(UIEdgeInsets.zero)
            }
            contentView.snp.makeConstraints { make in
                make.edges.equalTo(scrollView).inset(UIEdgeInsets.zero)
                make.width.equalTo(scrollView)
            }
            stackView.snp.makeConstraints { (make) in
                make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
            }
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func configure(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
        stackView.addArrangedSubview(stackView1)
        stackView.addArrangedSubview(stackView2)
        stackView.addArrangedSubview(stackView3)
        stackView.addArrangedSubview(stackView4)
//        stackView.addArrangedSubview(imgView)
        
        stackView1.addArrangedSubview(lblIdTitle)
        stackView1.addArrangedSubview(lblId)
        
        stackView2.addArrangedSubview(lblTypeTitle)
        stackView2.addArrangedSubview(lblType)
        
        stackView3.addArrangedSubview(lblDateTitle)
        stackView3.addArrangedSubview(lblDate)
        
        stackView4.addArrangedSubview(lblDescTitle)
        stackView4.addArrangedSubview(lblDesc)
        
        lblIdTitle.snp.makeConstraints { (make) in
            make.width.equalTo(stackView1.snp.width).multipliedBy(0.3)
        }
        lblTypeTitle.snp.makeConstraints { (make) in
            make.width.equalTo(stackView2.snp.width).multipliedBy(0.3)
        }
        lblDateTitle.snp.makeConstraints { (make) in
            make.width.equalTo(stackView3.snp.width).multipliedBy(0.3)
        }
        lblDescTitle.snp.makeConstraints { (make) in
            make.width.equalTo(stackView4.snp.width).multipliedBy(0.3)
        }
//        imgView.snp.makeConstraints { (make) in
//            make.height.equalTo(stackView.snp.width).multipliedBy(0.6)
//        }
    }
}
