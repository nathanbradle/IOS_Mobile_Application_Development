//
//  apiViewController.swift
//  hw3
//
//  Created by Nathan Wangidjaja on 10/12/23.
//

import UIKit

class apiViewController: UIViewController {
    var selectedNewsItem: apiTableViewController.News?

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var urlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summaryLabel.numberOfLines = 0
        titleLabel.numberOfLines = 0
        urlLabel.numberOfLines = 0
        dateLabel.numberOfLines = 0
        
        if let newsContent = selectedNewsItem {
            DispatchQueue.main.async { [weak self] in
                self?.titleLabel.text = newsContent.title
                self?.summaryLabel.text = newsContent.summary
                self?.urlLabel.text = newsContent.url
                self?.dateLabel.text = self?.convertToReadableDate(newsContent.publishedOn) ?? "Date conversion failed"
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func convertToReadableDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMMM dd, yyyy, h:mm a"
            return dateFormatter.string(from: date)
        } else {
            return "Invalid date string"
        }
    }
}
