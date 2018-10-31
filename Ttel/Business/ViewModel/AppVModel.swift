//
//  AppVModel.swift
//  Ttel
//
//  Created by PandaApe on 2017/5/23.
//  Copyright © 2017年 Sunfit. All rights reserved.
//

import Foundation
import PromiseKit
import Moya
import RxSwift

class AppVModel: BaseViewModel {
    
    func listAllProds(pageNo:Int, pageSize:Int) -> Promise<[AppItem]> {
    
       return Promise(resolver: { (result) in
        
        self.sendRequest(target: ApiService.ListAllProds(pageNo: pageNo, pageSize: pageSize))
            .mapModelArray(AppItem.self)
            .subscribe(onNext: {
                result.fulfill($0)
            }, onError: {
                result.reject($0)
            })
            .disposed(by: self.disposeBag)

        })
    }
    
    func ListSpecificProd(prodType:Int, envType:Int, pageNo:Int, pageSize:Int) -> Promise< [[String:[AppItem]]]> {
        return Promise(resolver: { result in
            
            self.sendRequest(target: ApiService.ListSpecificProd(prodType: prodType, envType: envType, pageNo: pageNo, pageSize: pageSize))
                .mapModelArray(AppItem.self)
                .subscribe(onNext: {
                    let sortedArr = self.sortAppArray(appItems:$0)
                    result.fulfill(sortedArr)
                }, onError: {
                    result.reject($0)
                })
                .disposed(by: self.disposeBag)
  
        })
        
    }
    
    func SendEmailToTester(itemIds:Array<String>, receivers:Array<String>) -> Promise<Any> {
        
        return Promise(resolver: { result in
            
            self.sendRequest(target: ApiService.SendEmailToTester(itemIds:itemIds,emailAddresses:receivers))
                .subscribe(onNext: { res in
                    
                    result.fulfill(true)
                }, onError: {
                    result.reject($0)
                })
                .disposed(by:self.disposeBag)
        })
    }
    
    func deleteItem(itemId: String) -> Promise<Any> {
        
        return Promise(resolver: { result in
            
            self.sendRequest(target: ApiService.deleteItem(itemId: itemId))
                .subscribe(onNext: { res in
                    
                    result.fulfill(true)
                }, onError: {
                    result.reject($0)
                })
                .disposed(by: self.disposeBag)
        })
    }
    
    func sortAppArray(appItems:[AppItem]) -> [[String:[AppItem]]] {
        
        var versionArr = [String]()
        
        for appItem in appItems {
            
            var isRepeat = 0
            
            for versionStr in versionArr {
                
                if appItem.version == versionStr  {
                    
                    isRepeat = 1
                    
                    break
                }
            }
            
            if isRepeat == 0 {
                
                versionArr.append(appItem.version)
            }
        }
        
        let sortedVerArr = versionArr.sorted(by: >);
        
        var formattedDataArr = [[String:[AppItem]]]()
        
        for versionStr in sortedVerArr {
            
            var dict = Dictionary<String,[AppItem]>()
            
            var valueArr = [AppItem]()
            
            for appItem in appItems {
                
                if versionStr == appItem.version {
                    
                    valueArr.append(appItem)
                }
            }
            
            dict[versionStr] = valueArr
            
            formattedDataArr.append(dict)
        }
        
        return formattedDataArr
    }
    
    

}
