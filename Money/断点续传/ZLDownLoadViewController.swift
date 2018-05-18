//
//  ZLDownLoadViewController.swift
//  Money
//
//  Created by 李占理 on 2018/5/18.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit
import Alamofire

class ZLDownLoadViewController: UIViewController {
    
    var progress:UIProgressView? = nil//下载进度条
    var downLoadRequest:DownloadRequest!//下载对象
    var destination:DownloadRequest.DownloadFileDestination!//保存文件路径
    var cancleData:Data?//存储已下载的部分
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zl_configTitle(title: "断点续传")
        self.view.backgroundColor = UIColor.white

        let pauseButton = UIButton(frame: CGRect(x: 0, y: 10, width: 100, height: 30))
        pauseButton.setTitle("开始", for: UIControlState.normal)
        pauseButton.backgroundColor = UIColor.red
        pauseButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        pauseButton.addTarget(self, action: #selector(self.clickPauseButton(btn:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(pauseButton)
        
        progress = UIProgressView(frame: CGRect(x: 0, y: 100, width: 400, height: 30))
        progress?.progressViewStyle = .default
        progress?.progressTintColor = UIColor.green
        self.view.addSubview(progress!)
    }
    @objc func clickPauseButton(btn:UIButton){
        let title = btn.titleLabel?.text
        if title == "开始" {
            startDownLoad()
            btn.setTitle("暂停", for: UIControlState.normal)
        }else if title == "暂停" {
            self.downLoadRequest.cancel()
            btn.setTitle("继续", for: UIControlState.normal)
        }else{
            if let data = cancleData{
                downLoadRequest = Alamofire.download(resumingWith:data, to: destination)
                downLoadRequest.downloadProgress(queue: DispatchQueue.main, closure: downLoadProgress)
                downLoadRequest.responseData(completionHandler: downLoadResponse)
            }
            btn.setTitle("暂停", for: UIControlState.normal)
        }
    }
    func startDownLoad(){
        destination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        downLoadRequest = Alamofire.download("http://dldir1.qq.com/qqfile/qq/QQ7.9/16621/QQ7.9.exe", method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil, to: destination)
        downLoadRequest.downloadProgress(queue: DispatchQueue.main, closure: downLoadProgress)
        downLoadRequest.responseData(completionHandler: downLoadResponse)
    }
    //设置进度条的值
    func downLoadProgress(progress:Progress){
        self.progress?.setProgress(Float(progress.fractionCompleted), animated: true)
        logInfo("当前进度：\(progress.fractionCompleted*100)%")
    }
    func downLoadResponse(response: DownloadResponse<Data>){
        switch response.result {
        case .success(let data):
            logInfo("文件下载完毕")
        case .failure:
            self.cancleData = response.resumeData
        }
    }
}
