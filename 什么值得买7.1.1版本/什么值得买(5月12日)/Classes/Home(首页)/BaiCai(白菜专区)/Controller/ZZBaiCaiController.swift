//
//  ZZBaiCaiController.swift
//  什么值得买
//
//  Created by Wang_ruzhou on 2016/11/21.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//  白菜专区

import UIKit

private let kZuiXinBaiCaiCell = "kZuiXinBaiCaiCell"

class ZZBaiCaiController: ZZSecondTableViewController {

    var headerView: ZZBaiCaiTableHeaderView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "白菜专区"

        headerView = ZZBaiCaiTableHeaderView()
        
        tableView.tableHeaderView = headerView
    }
    

//精选和头条: http://api.smzdm.com/v1/baicai/baicai_propagate?f=iphone&v=7.3.3&weixin=1
//最新白菜:   https://api.smzdm.com/v1/baicai/list?f=iphone&limit=20&offset=0&tag_name=%E6%AF%8F%E6%97%A5%E7%99%BD%E8%8F%9C&v=7.3.3&weixin=1
    

    override func loadData() { //每日精选和白菜头条数据
        
        offset = 0
        
        ZZNetworking.get("v1/baicai/baicai_propagate", parameters: NSMutableDictionary()) {(responseObj, error) in
            
            if let _ = error {
                
                self.tableView.mj_header.endRefreshing()
                return
            }
            
            if let responseObj = responseObj as? [AnyHashable: Any]{
                
                
                let baiCaiJingXuanModel = ZZBaiCaiJingXuanModel.model(with: responseObj)
                
                let baiCaiLayout = ZZZuiXinBaiCaiLayout.init(jingXuanModel: baiCaiJingXuanModel!)
                
                self.headerView?.baiCaiLayout = baiCaiLayout
                
                self.tableView.tableHeaderView = self.headerView
     
            }
  
            self.requestNewestBaiCaiList()
        
        }
        
    }
    
    
    func requestNewestBaiCaiList(){ //最新白菜数据
        ZZNetworking.get("v1/baicai/list", parameters: configureParameters()) {(responseObj, error) in
            if let _ = error {
                self.tableView.mj_header.endRefreshing()
                return
            }
            
            if let resopnseObj = responseObj as? [AnyHashable: Any]{
                
                if let rows = resopnseObj["data"] as? [AnyHashable: Any]{

                    let baiCaiRows = NSArray.modelArray(with: ZZWorthyArticle.self, json: rows)
                    
                    self.dataSource.addObjects(from: baiCaiRows!)
                    
                    self.offset = rows.count
                }
                
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
                
            }
            
        }
    }
    
    override func configureParameters() -> NSMutableDictionary! {
        
        let parameters = NSMutableDictionary()
        
        parameters.setObject("每日白菜", forKey: "tag_name" as NSCopying)
        parameters.setObject("20", forKey: "limit" as NSCopying)
        parameters.setObject("\(self.offset)", forKey: "offset" as NSCopying)
        return parameters
    }
    
    

}


extension ZZBaiCaiController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        
//    }
}
    
