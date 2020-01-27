//
//  UserSettingsViewController.swift
//  PhotoJournal
//
//  Created by Cameron Rivera on 1/23/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class UserSettingsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaStepper: UIStepper!
    
    // MARK: Properties
    var alpha = 1.0
    
    // MARK: Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: Helper Methods
    private func setUp(){
        navigationItem.rightBarButtonItem?.title = "Save Changes"
        
        redSlider.maximumValue = 1.0
        redSlider.minimumValue = 0.0
        
        blueSlider.maximumValue = 1.0
        blueSlider.minimumValue = 0.0
        
        greenSlider.maximumValue = 1.0
        greenSlider.minimumValue = 0.0
        
        alphaStepper.maximumValue = 1.0
        alphaStepper.minimumValue = 0.0
        alphaStepper.stepValue = 0.1
        
        if let direction = UserPreferences.shared.loadScrollDirection() {
            if direction == "horizontal"{
                segmentedControl.selectedSegmentIndex = 0
            } else {
                segmentedControl.selectedSegmentIndex = 1
            }
        } else {
            segmentedControl.selectedSegmentIndex = 0
        }
        
        if let colour = UserPreferences.shared.loadBackgroundColour() {
            view.backgroundColor = UIColor(displayP3Red: colour.red, green: colour.green, blue: colour.blue, alpha: colour.alpha)
            displayRed(with: Float(colour.red))
            redSlider.value = Float(colour.red)
            displayBlue(with: Float(colour.blue))
            blueSlider.value = Float(colour.blue)
            displayGreen(with: Float(colour.green))
            greenSlider.value = Float(colour.green)
            stepperLabel.text = "Alpha: \(String(format: "%.1f",Float(colour.alpha)))"
            alphaStepper.value = Double(colour.alpha)
            
        } else {
            view.backgroundColor = UIColor.white
            displayRed(with: 1.0)
            redSlider.value = 1.0
            displayBlue(with: 1.0)
            blueSlider.value = 1.0
            displayGreen(with: 1.0)
            greenSlider.value = 1.0
            stepperLabel.text = "Alpha: \(String(format: "%.1f",1.0))"
            alphaStepper.value = 1.0
        }
    }
    
    // Changes red label text
    private func displayRed(with num: Float){
        redLabel.text = "Red: \(String(format: "%.2f", num))"
    }
    
    // Changes green label text
    private func displayGreen(with num: Float){
        greenLabel.text = "Green: \(String(format: "%.2f", num))"
    }
    
    // Changes blue label text
    private func displayBlue(with num: Float){
        blueLabel.text = "Blue: \(String(format: "%.2f", num))"
    }
    
    // MARK: Actions
    @IBAction func segmentedControlSwitch(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            UserPreferences.shared.saveScrollDirection(using: "horizontal")
        case 1:
            UserPreferences.shared.saveScrollDirection(using: "vertical")
        default:
            break
        }
    }
    
    @IBAction func sliderHasSlided(_ sender: UISlider){
        switch sender{
        case redSlider:
            displayRed(with: redSlider.value)
        case greenSlider:
            displayGreen(with: greenSlider.value)
        case blueSlider:
            displayBlue(with: blueSlider.value)
        default:
            break
        }
        view.backgroundColor = UIColor(displayP3Red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alpha))
    }

    @IBAction func stepperHasStepped(_ sender: UIStepper){
        alpha = alphaStepper.value
        stepperLabel.text = "Alpha: \(String(format: "%.1f",alpha))"
        view.backgroundColor = UIColor(displayP3Red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alpha))
    }
    
    @IBAction func saveChangesPressed(_ sender: UIBarButtonItem){
        let currentColour = Colour(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaStepper.value))
        UserPreferences.shared.saveBackgroundColour(using: currentColour)
        showAlert("Notice", "Changes have been saved"){ [weak self] alertAction in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
