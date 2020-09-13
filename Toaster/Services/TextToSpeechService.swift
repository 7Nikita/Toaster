//
//  TextToSpeechService.swift
//  Toaster
//
//  Created by Nikita Pekurin on 9/13/20.
//  Copyright © 2020 Nikita Pekurin. All rights reserved.
//

import AVFoundation

enum Language: String {
    case russian = "ru"
    case english = "en"
}

class TextToSpeechService {
    
    let language: Language
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var utterance: AVSpeechUtterance
    
    init(language: Language, text: String) {
        self.language = language
        self.utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: self.language.rawValue)

    }
    
    func generateSynth() -> AVSpeechSynthesizer {
        let synth = AVSpeechSynthesizer()
        return synth
    }
    
}
