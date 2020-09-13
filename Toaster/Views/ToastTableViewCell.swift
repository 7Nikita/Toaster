//
//  ToastTableViewCell.swift
//  Toaster
//
//  Created by Nikita Pekurin on 9/12/20.
//  Copyright © 2020 Nikita Pekurin. All rights reserved.
//

import UIKit

class ToastTableViewCell: UITableViewCell {

    @IBOutlet weak var toastContentLabel: UILabel!
    
    @IBOutlet weak var playButton: UIImageView! {
        didSet {
            playButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playText)))
            playButton.isUserInteractionEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @objc func playText() {
        let textToSpeechService = TextToSpeechService(language: .russian, text: toastContentLabel.text ?? "")
        textToSpeechService.generateSynth().speak(textToSpeechService.utterance)
    }
    
}
