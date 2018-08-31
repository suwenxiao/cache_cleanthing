//
//  XGCache.swift
//  XGCache
//
//  Created by 苏文潇 on 2017/11/12.
//  Copyright © 2017年 Koalareading. All rights reserved.
//

import UIKit

class XGCache: NSObject {

    
    //    MARK: 读取缓存的大小
    static func returenCatchSize() -> String
    {
        return String.init(format: "%.2f", XGCache.forderSizeAtPath(folderPath: NSHomeDirectory()))
    }
    
    //    MARK: 计算单个文件的大小 单位:MB   path: 文件的路径  return： 返回文件的大小
    static func returnFileSize(path: String) -> Double
    {
        let manger = FileManager.default
        var fileSize: Double = 0
        
        do {
            let att = try manger.attributesOfItem(atPath: path)
            fileSize = att[FileAttributeKey.size] as! Double
        } catch  {
            print("文件出问题")
        }
        return fileSize / 1024 / 1024
    }
    
    //  MARK:  遍历所有子目录， 并计算文件大小   返回文件大小
    static func forderSizeAtPath(folderPath: String) -> Double
    {
        let manger = FileManager.default
//        如果文件不存在返回0
        if !manger.fileExists(atPath: folderPath)
        {
            return 0
        }
//        拿到所有的文件目录（是一个字符串数组）
        let childFilePath = manger.subpaths(atPath: folderPath)
        var fileSize: Double = 0
        for path in childFilePath!
        {
//            拿到所有文件的绝对路径  由于不会加/ 所以在拼接的时候自己添加上
            let fileAbsoluePath = folderPath + "/" + path
            fileSize += XGCache.returnFileSize(path: fileAbsoluePath)
        }
    
        return fileSize
    }
    
    //    MARK: 清除缓存
    static func cleanCache(complationCallBack: (Bool)->())
    {
        XGCache.deleteFolder(folderPath: NSHomeDirectory() + "/Documents", complationCallBack: complationCallBack)
        XGCache.deleteFolder(folderPath: NSHomeDirectory() + "/Library", complationCallBack: complationCallBack)
        XGCache.deleteFolder(folderPath: NSHomeDirectory() + "/tmp", complationCallBack: complationCallBack)
    }
    
    //    MARK: 删除单个文件  path： 路径
    static func deleteFile(path: String)
    {
        let manger = FileManager.default
        do {
            try manger.removeItem(atPath: path)
        } catch  {
            
        }
    }
    
    //    MARK: 删除文件夹下的所有文件
    
    static func deleteFolder(folderPath: String, complationCallBack: (Bool)->())
    {
        let manger = FileManager.default
        if !manger.fileExists(atPath: folderPath)
        {
            complationCallBack(false)
            return
        }
       
        let childFilePath = manger.subpaths(atPath: folderPath)
        for path in childFilePath!
        {
            let fileAbsoluePath = folderPath + "/" + path
            XGCache.deleteFile(path: fileAbsoluePath)
        }
        complationCallBack(true)
    }
}





