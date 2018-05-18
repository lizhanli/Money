//
//  HttpUtils.swift
//  Money
//
//  Created by 李占理 on 2018/5/18.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit
import Alamofire

class HttpUtils: NSObject {

    private static let manager:SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
    /*
     使用GET类型请求的时候，参数会自动拼接在url后面
     使用POST类型请求的时候，参数是放在在HTTP body里传递，url上看不到的
     至于加header的post 请求，实际上也是GET 一样的
    */
    @discardableResult
    static func httpGet(_ url:String,params:DictionaryDefault?,header: Dictionary<String, String>? = nil,completionHandler:SimpleCallBackWithDic?)->Request{
        return manager.request(url, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON(completionHandler: { (response) in
            let dict = parse(response: response)
            completionHandler?(dict)
        })
    }
    
    @discardableResult
    static func httpPost(_ url:String,params:DictionaryDefault?,header: Dictionary<String, String>? = nil,completionHandler:SimpleCallBackWithDic?)->Request{
        return manager.request(url, method: HTTPMethod.post, parameters: params, encoding: URLEncoding.default, headers:header).responseJSON(completionHandler: { (response) in
            let dict = parse(response: response)
            completionHandler?(dict)
        })
    }
    private static func parse(response:DataResponse<Any>)->DictionaryDefault?{
        var dict = response.result.value as? Dictionary<String, Any>
        if dict == nil{
            //如果返回的数据只是一个Int，则生成Dictionary
            if let code = response.result.value as? Int {
                dict = [Consts.kCode: code]
                return dict
            }
        }
        if dict == nil{
            return nil
        }
        return dict
    }
    //MARK: -文件下载,不存储
    @discardableResult
    static func httpGetImage(_ url:String,params:DictionaryDefault?,header: Dictionary<String, String>? = nil,completionHandler:SimpleCallBackAny?)->Request{
        return manager.request(url, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: header).responseData(completionHandler: { (response) in
            if let data = response.data{
                completionHandler?(UIImage(data: data))
            }else{
                completionHandler?(nil)
            }
        })
    }
    //MARK: -文件下载,存储
    @discardableResult
    static func httpDownLoad(_ url:String,params:DictionaryDefault?,header: Dictionary<String, String>? = nil,completionHandler:SimpleCallBackAny?)->Request{
        //指定下载路径和保存文件名
        //response.suggestedFilename! 此处也可以自定义文件名 "file/test.png"
        let destination:DownloadRequest.DownloadFileDestination = { (_, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions.ArrayLiteralElement) in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            logInfo("fileURL==\(fileURL)")
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        return manager.download(url, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: header, to: destination).response(completionHandler: { (response) in
            if let imagePath = response.destinationURL?.path {
                let image = UIImage(contentsOfFile: imagePath)
                completionHandler?(image)
            }else{
                completionHandler?(nil)
            }
        })
    }
    //MARK: -文件下载,存储,包含下载进度
    @discardableResult
    static func httpDownLoadProgress(_ url:String,params:DictionaryDefault?,header: Dictionary<String, String>? = nil,completionHandler:SimpleCallBackAny?)->Request{
        //指定下载路径和保存文件名
        //response.suggestedFilename! 此处也可以自定义文件名 "file/test.png"
        let destination:DownloadRequest.DownloadFileDestination = { (_, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions.ArrayLiteralElement) in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            logInfo("fileURL==\(fileURL)")
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        return manager.download(url, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: header, to: destination).downloadProgress(closure: { (progress) in
            logInfo("当前进度:\(progress.fractionCompleted)")
            logInfo("已下载：\(progress.completedUnitCount/1024)KB")
            logInfo("总大小：\(progress.totalUnitCount/1024)KB")
        }).responseData(completionHandler: { (response) in
            if response.result.isSuccess{
                logInfo("下载成功")
            }else{
                logInfo("下载失败")
            }
        })
    }
    /*
     Alamofire支持如下上传类型：
     File
     Data
     Stream
     MultipartFormData
    */
    //MARK: -文件上传form表单形式
    static func httpUpLoad(_ url:String,params:DictionaryDefault?,progressHandler:((Progress) -> Void)? = nil,completionHandler:SimpleCallBackAny?){
        manager.upload(multipartFormData: { (multipartFormData) in
            if let data = params{
                for (key, value) in data{
                    if let value = value as? String {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }else if let value = value as? NSNumber {
                        multipartFormData.append(String(describing: value).data(using: String.Encoding.utf8)!, withName: key)
                    }else if let value = value as? Data {
                        multipartFormData.append(value, withName: key, fileName: "\(key).jpg", mimeType: "jpg")
                    }
                }
            }
        }, to: url, encodingCompletion: { (encodingResult) in
            switch encodingResult{
            case .success(let upLoad,_,_):
                upLoad.uploadProgress(closure: { (progress) in
                    logInfo("当前上传进度: \(progress.fractionCompleted)")
                    progressHandler?(progress)
                })
//                upLoad.validate()
                upLoad.responseJSON(completionHandler: { (response) in
                    logInfo("上传成功")
                    let dict = parse(response: response)
                    completionHandler?(dict)
                })
            case .failure:
                logInfo("上传失败")
            }
        })
    }
    //MARK: -使用文件流的形式上传文件 file:文件路径
    static func httpUpLoadFile(file:URL,_ url:String,progressHandler:((Progress) -> Void)? = nil,completionHandler:SimpleCallBackAny?){
        manager.upload(file, to: url)
        .uploadProgress { (progress) in
            progressHandler?(progress)
        }
        .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    logInfo("上传成功")
                case .failure:
                    logInfo("上传失败")
                }
        }
    }
}
