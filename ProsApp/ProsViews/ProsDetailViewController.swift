//
//  ProsDetailViewController.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//

import UIKit

class ProsDetailViewController: UIViewController {

    @IBOutlet weak var callButton: OrangeButton!
    @IBOutlet weak var emailButton: OrangeButton!
    @IBOutlet weak var proNameLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var ratingsLabel: RatingsLabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var selectedProsDataIndex: Int?
    var prosData: ProsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        callButton.setTitle("CALL", for: .normal)
        emailButton.setTitle("EMAIL", for: .normal)
        
        if let index = selectedProsDataIndex {
            prosData = sharedProsManager.prosData[index]
            displayDetails()
        }
    }
    
    private func displayDetails() {
        proNameLabel.text = prosData?.companyName
        specialtyLabel.text = prosData?.specialty
        ratingsLabel.setRatingText(rating: prosData?.compositeRating ?? "0", ratingCount: prosData?.ratingCount ?? "0")
        locationLabel.text = prosData?.primaryLocation
        servicesLabel.text = prosData?.servicesOffered
        overviewTextView.text = prosData?.companyOverview
    }
    
    @IBAction func didTapCallButton(_ sender: OrangeButton) {
        print("phone = \(prosData?.phoneNumber ?? "Not Available")")
    }
    @IBAction func didTapEmailButton(_ sender: OrangeButton) {
        print("email = \(prosData?.email ?? "Not Available")")
    }
    
}
