//
//  ZLAVSpeechSynthesizer.swift
//  Money
//
//  Created by 李占理 on 2018/7/26.
//  Copyright © 2018年 Marsli. All rights reserved.
//

import UIKit
import AVFoundation

class ZLAVSpeechSynthesizer: UIViewController,AVSpeechSynthesizerDelegate{
    
    let avSpeech = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.zl_configTitle(title: "语音播报")
        self.view.backgroundColor = UIColor.white
        //初始化语音播报
        //设置播报内容
        avSpeech.delegate = self
        let speechContent = AVSpeechUtterance(string: "南非当地时间7月24日上午，位于行政首都比勒陀利亚的南非总统府洋溢着热情友好的气氛。南非总统拉马福萨在这里举行隆重的仪式，欢迎中国国家主席习近平在中南建交20周年之际对这个美丽的“彩虹之国”进行第三次国事访问。双方期待这次访问能够推动中南全面战略伙伴关系更好更快向前发展，共同开创中南友好新时代！总统府前广场，微风拂面，阳光和煦。中南两国国旗迎风飘扬。习近平和夫人彭丽媛受到拉马福萨和夫人莫采佩热情迎接。两国元首夫妇登上检阅台。仪仗队行持枪礼。现场鸣放21响礼炮。军乐队奏中国国歌。习近平检阅仪仗队。军乐队奏南非国歌。习近平和彭丽媛同南方主要官员握手。拉马福萨夫妇同中方陪同人员握手。两国元首夫妇亲切寒暄。拉马福萨对习近平在南中建交20周年之际访问南非并出席金砖国家领导人会晤表示热烈欢迎。")
        //设置语言类别
        let speechLanguage = AVSpeechSynthesisVoice(language: "zh-CN")
        speechContent.voice = speechLanguage
        //设置语速
        speechContent.rate = 0.5
        speechContent.pitchMultiplier = 0.1
        avSpeech.speak(speechContent)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .duckOthers)
        } catch {
            print(error.localizedDescription)
        }
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        logInfo("播放结束")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !avSpeech.isPaused {
            avSpeech.pauseSpeaking(at: AVSpeechBoundary.immediate)
        }else{
            avSpeech.continueSpeaking()
        }
    }
}


