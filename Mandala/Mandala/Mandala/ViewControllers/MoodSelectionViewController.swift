//
//  ViewController.swift
//  Mandala
//
//  Created by Emilia Nedyalkova on 23.04.21.
//

import UIKit

class MoodSelectionViewController: UIViewController {
    @IBOutlet var moodSelector: ImageSelector!
    @IBOutlet var addMoodButton: UIButton!
    
    var moodsConfigurable: MoodsConfigurable!
    
    var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
            moodSelector.images = moods.map {
                $0.image
            }
            moodSelector.highlightColors = moods.map {
                $0.color
            }
        }
    }
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }
            
            addMoodButton?.setTitle("I'm \(currentMood.name)", for: .normal)

            let selectionAnimator = UIViewPropertyAnimator(
                duration: 0.3, dampingRatio: 0.7) {
                self.addMoodButton?.backgroundColor = currentMood.color
            }
            
            selectionAnimator.startAnimation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moods = ImageResource.allCases.map { Mood($0) }
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
    }
    
    @IBAction private func moodSelectionChanged(_ sender: ImageSelector) {
        currentMood = moods[sender.selectedIndex]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedContainerViewController":
            guard let moodsConfigurable = segue.destination as? MoodsConfigurable else {
                preconditionFailure("View controller expected to conform to MoodsConfigurable")
            }
            self.moodsConfigurable = moodsConfigurable
            segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    @IBAction func addMoodTapped(_ sender: Any) {
        guard let currentMood = currentMood else {
            return
        }
        let newMoodEntry = MoodEntry(mood: currentMood, timestamp: Date())
        moodsConfigurable.add(newMoodEntry)
    }
}

