//
//  NotificationService.swift
//  PushServiceExtension
//
//  Created by haoran on 2018/3/7.
//  Copyright © 2018年 Sunfit. All rights reserved.
//

import UserNotifications
import AVFoundation

class NotificationService: UNNotificationServiceExtension {

    // MARK: - Property
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    lazy var speech : AVSpeechSynthesizer = {
        let speech              = AVSpeechSynthesizer.init()
        speech.delegate         = self as AVSpeechSynthesizerDelegate
        return speech
    }()
    
    lazy var iflySpeecher:IFlySpeechSynthesizer = {
        let speecher            = IFlySpeechSynthesizer.sharedInstance()
        speecher?.delegate      = self as IFlySpeechSynthesizerDelegate
        speecher?.setParameter(IFlySpeechConstant.type_CLOUD(), forKey: IFlySpeechConstant.engine_TYPE())
        speecher?.setParameter("50", forKey: IFlySpeechConstant.volume())
        speecher?.setParameter("xiaoyan", forKey: IFlySpeechConstant.voice_NAME())
        speecher?.setParameter("tts.pcm", forKey: IFlySpeechConstant.tts_AUDIO_PATH())
        return speecher!
    }()
    
    // MARK: - Method
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
       
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            print("❤️"+bestAttemptContent.body)
            bestAttemptContent.title = "李云龙❤️"
//            readcontent(content: bestAttemptContent.body)
            readContentByIFly(content: bestAttemptContent.body)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            stopRead()
            contentHandler(bestAttemptContent)
        }
    }

    
    func readContent(content : String) {
        // 要说的文字
        let speechUtterance = AVSpeechUtterance.init(string: content)
        speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
        // 要说的语种
        speechUtterance.voice = AVSpeechSynthesisVoice.init(language: "zh-CN")
        // 发音
        self.speech.speak(speechUtterance)
    }
    
    
    func stopRead() {
        
        speech.stopSpeaking(at: .immediate)
        iflySpeecher.stopSpeaking()
    }
    
    func readContentByIFly(content : String) {
        #if DEBUG
            IFlySetting.showLogcat(true)
        #else
            IFlySetting.showLogcat(false)
        #endif
        IFlySpeechUtility.createUtility("appid=5a9fae53")
        iflySpeecher.startSpeaking(content)
    }
}


extension NotificationService : AVSpeechSynthesizerDelegate{
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        
        
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("开始读文字")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("文字读完毕")
        if let bestAttemptContent = bestAttemptContent {
            self.contentHandler!(bestAttemptContent)
            
        }
    }
}

extension NotificationService : IFlySpeechSynthesizerDelegate {
    func onCompleted(_ error: IFlySpeechError!) {
        print(error.errorDesc)
        self.contentHandler!(self.bestAttemptContent!)
    }
    
    
}
