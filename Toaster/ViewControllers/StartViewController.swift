//
//  ViewController.swift
//  Toaster
//
//  Created by Nikita Pekurin on 9/2/20.
//  Copyright © 2020 Nikita Pekurin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class StartViewController: UIViewController {

    @IBOutlet weak var randomToastView: CircleView! {
        didSet {
            randomToastView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playRandomToast)))
            randomToastView.isUserInteractionEnabled = true
        }
    }
        
    var toastsViewController: ToastsViewController!
    var visualEffectView: UIVisualEffectView!
    
    private let database = Database.database().reference()
    private let cardHeight: CGFloat = 600
    
    private lazy var cardHandleAreaHeight: CGFloat = toastsViewController.handleView.frame.height
    
    private var cardState: CardState = .collapsed
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = 0
    
    private var toasts = [Toast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database.child("alco").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            let value = snapshot.value as? NSArray
            if let value = value {
                for content in value {
                    let toast = Toast(content: content as? String ?? "")
                    self?.toasts.append(toast)
                }
            }
            self?.setupCard()
        })
    }

    @objc func playRandomToast() {
        let toastContent = toasts.randomElement()?.content ?? "Нет доступных тостов"
        let textToSpeechService = TextToSpeechService(language: .russian, text: toastContent)
        textToSpeechService.generateSynth().speak(textToSpeechService.utterance)
    }
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        toastsViewController = ToastsViewController(nibName: "ToastsViewController", bundle: nil)
        toastsViewController.toasts = self.toasts
        self.addChild(toastsViewController)
        self.view.addSubview(toastsViewController.view)
        
        toastsViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        
        toastsViewController.view.clipsToBounds = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        
        toastsViewController.handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func handleCardPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: cardState.oppositeState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.toastsViewController.handleView)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardState == .expanded ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
        
    }
    
    func animateTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.toastsViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.toastsViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardState = self.cardState.oppositeState
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    func startInteractiveTransition(state: CardState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }

}
