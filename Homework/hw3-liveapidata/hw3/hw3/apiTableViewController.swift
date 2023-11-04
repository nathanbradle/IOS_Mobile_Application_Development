//
//  apiTableViewController.swift
//  hw3
//
//  Created by Nathan Wangidjaja on 10/12/23.
//

import UIKit

class apiTableViewController: UITableViewController {
    struct Welcome: Decodable {
        let result: Result
        let news: [News]
    }

    // MARK: - News
    struct News: Decodable {
        let title: String
        let source: Source
        let url: String
        let publishedOn, description: String
        let language: Language
        let image: String
        let sourceNationality: SourceNationality
        let titleSentiment: TitleSentiment
        let summary: String
        let countries, cities: [String]
        let categories: Categories

        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case source = "Source"
            case url = "Url"
            case publishedOn = "PublishedOn"
            case description = "Description"
            case language = "Language"
            case image = "Image"
            case sourceNationality = "SourceNationality"
            case titleSentiment = "TitleSentiment"
            case summary = "Summary"
            case countries = "Countries"
            case cities = "Cities"
            case categories = "Categories"
        }
    
    }
    
    var newsContent: [News] = [] // Store the news items here
    //newsItem

    // MARK: - Categories
    struct Categories: Decodable {
        let label, iptcCode: String

        enum CodingKeys: String, CodingKey {
            case label
            case iptcCode = "IPTCCode"
        }
    }

    enum Language: String, Decodable {
        case en = "en"
    }

    enum Source: String, Decodable {
        case cryptoslateCOM = "cryptoslate.com"
        case prnewswireCOM = "prnewswire.com"
        case thetravelCOM = "thetravel.com"
        case unknown
        
        init(from decoder: Decoder) throws {
            self = try Source(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }
    }

    enum SourceNationality: String, Decodable {
        case us = "us"
    }

    // MARK: - TitleSentiment
    struct TitleSentiment: Decodable {
        let sentiment: Sentiment
        let score: Double
    }

    enum Sentiment: String, Decodable {
        case positive = "positive"
        case negative = "negative"
        case unknown
        
        init(from decoder: Decoder) throws {
            self = try Sentiment(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
        }
    }

    // MARK: - Result
    struct Result: Decodable {
        let response: String
        let newsCount, skipped: Int
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsContent.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell",
            for: indexPath) as! apiTableViewCell
        let newsContent = newsContent[indexPath.row]
        cell.titleLabel.text = newsContent.title
        cell.dateSumLabel.text = convertToReadableDate(newsContent.publishedOn)
      
        return cell
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "US Current News"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedNewsItem = newsContent[indexPath.row]
                

                if let destinationViewController = segue.destination as? apiViewController {
                    destinationViewController.selectedNewsItem = selectedNewsItem
                }
            }
        }
    }
    
    
    func getNewsData() {
        let headers = [
            "X-RapidAPI-Key": "95da4a0aa2msh50b644c779ffa01p16fe63jsnca27b7554568",
            "X-RapidAPI-Host": "news67.p.rapidapi.com"
        ]
        
        let url = URL(string: "https://news67.p.rapidapi.com/v2/country-news?fromCountry=us&languages=en&onlyInternational=true")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                //print("Error: \(error)")
                DispatchQueue.main.async {
                   let alert = UIAlertController(title: "Error:", message: "No network connection", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(alert, animated: true)
               }
            } else if let data = data {
                
                if let jsonDataString = String(data: data, encoding: .utf8) {
                    print("Received JSON data: \(jsonDataString)")
                }
                 
                
                do {
                    let decoder = JSONDecoder()
                    let newsData = try decoder.decode(Welcome.self, from: data)
                    print("TESTER")
                    print(newsData.news)
                    self.newsContent = newsData.news
                    //self.newsItems = newsResponse.articles
                    
                    //Update the UI on the main thread
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("JSON Decode error: \(error)")
                    print("Decoding failed in \(error.localizedDescription)")
                }
            }
        }

        dataTask.resume()
    }
}
