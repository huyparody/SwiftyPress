//
//  Tutorable.swift
//  SwiftyPress
//
//  Created by Basem Emara on 5/9/16.
//
//

import UIKit

protocol Tutorable: class, AlertOnboardingDelegate {
    
}

extension Tutorable where Self: UIViewController {
    
    func showTutorial(_ displayMultipleTimes: Bool = true) {
        // Start tutorial if applicable
        if displayMultipleTimes || !AppGlobal.userDefaults[.isTutorialFinished] {
            let alertView = AlertOnboarding(
                arrayOfImage: AppGlobal.userDefaults[.tutorial].compactMap { $0["image"] as? String },
                arrayOfTitle: AppGlobal.userDefaults[.tutorial].compactMap { $0["title"] as? String },
                arrayOfDescription: AppGlobal.userDefaults[.tutorial].compactMap { $0["desc"] as? String })

            alertView.delegate = self
    
            alertView.percentageRatioHeight = 0.9
            alertView.percentageRatioWidth = 0.9
            alertView.colorButtonBottomBackground = UIColor(rgb: AppGlobal.userDefaults[.tintColor])
            alertView.colorButtonText = .white

            alertView.show()
        }
    }
    
    // Optional functions for delegate
    func alertOnboardingCompleted() {
        AppGlobal.userDefaults[.isTutorialFinished] = true
    }
    
    func alertOnboardingNext(_ nextStep: Int) {
    
    }
    
    func alertOnboardingSkipped(_ currentStep: Int, maxStep: Int) {
        alertOnboardingCompleted()
    }
}
