//
//  ViewController.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//

import UIKit


class ProsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        self.title = "Pros"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedProsManager.prosData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IDProsTVCell", for: indexPath) as! ProsTableViewCell
        cell.companyNameLabel.text = sharedProsManager.prosData[indexPath.row].companyName
        cell.companyRatingLabel.setRatingText(rating: sharedProsManager.prosData[indexPath.row].compositeRating,
                                              ratingCount: sharedProsManager.prosData[indexPath.row].ratingCount)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prosDetailStoryboard = UIStoryboard(name: "ProsDetailView", bundle: nil)
        if let prosDetailViewController = prosDetailStoryboard.instantiateInitialViewController() as? ProsDetailViewController {
            prosDetailViewController.selectedProsDataIndex = indexPath.row
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Pros", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(prosDetailViewController, animated: true)
        }
    }
    
    @IBAction func didTapSortButton(_ sender: Any) {
        
        let sortView = UIAlertController()
        
        sortView.addAction(UIAlertAction(title: "Name", style: .default, handler: { action in
            self.processSort(action: action)
        }))
        
        sortView.addAction(UIAlertAction(title: "specialty", style: .default, handler: { action in
            self.processSort(action: action)
        }))
        
        sortView.addAction(UIAlertAction(title: "rating", style: .default, handler:{ action in
            self.processSort(action: action)
        }))
        
        self.present(sortView, animated: true, completion: nil)
    }
   
    func processSort(action: UIAlertAction) {
        
    }
    
}


class ProsTableViewCell: UITableViewCell {
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyRatingLabel: RatingsLabel!
}



