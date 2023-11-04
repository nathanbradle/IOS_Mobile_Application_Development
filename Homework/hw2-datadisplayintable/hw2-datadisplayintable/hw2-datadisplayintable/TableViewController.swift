//
//  TableViewController.swift
//  hw2-datadisplayintable
//
//  Created by Nathan Wangidjaja on 9/26/23.
//

import UIKit

class myCustomCell: UITableViewCell{
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
}

class TableViewController: UITableViewController {
    
    var city: [String] = ["Manhattan", "Brooklyn", "Queens", "Staten Island", "The Bronx", "Jakarta"]
    var temp: [String] = ["52°F", "48°F", "50°F", "54°F", "49°F", "81°F"]
    var weatherPicture: [UIImage] = [UIImage(named: "cloudy")!, UIImage(named: "sunny")!, UIImage(named: "sunny")!, UIImage(named: "cloudy")!, UIImage(named: "rain")!, UIImage(named: "sunny")!]
    var weatherLabel: [String] = ["Cloudy", "Sunny", "Sunny", "Cloudy", "Rain", "Sunny"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return city.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myCustomCell
        cell.cityName.text = city[indexPath.row]
        cell.temperature.text = temp[indexPath.row]
        cell.weatherImage.image = weatherPicture[indexPath.row]
        cell.weatherLabel.text = weatherLabel[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return "Cities"
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            city.remove(at: indexPath.row)
            temp.remove(at: indexPath.row)
            weatherPicture.remove(at: indexPath.row)
            weatherLabel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let rearrangedCity = self.city[fromIndexPath.row]
        city.remove(at: fromIndexPath.row)
        city.insert(rearrangedCity, at:to.row)
        
        let rearrangedWeather = self.weatherLabel[fromIndexPath.row]
        weatherLabel.remove(at: fromIndexPath.row)
        weatherLabel.insert(rearrangedWeather, at:to.row)
        
        let rearrangedImage = self.weatherPicture[fromIndexPath.row]
        weatherPicture.remove(at: fromIndexPath.row)
        weatherPicture.insert(rearrangedImage, at: to.row)
        
        let rearrangedTemp = self.temp[fromIndexPath.row]
        temp.remove(at: fromIndexPath.row)
        temp.insert(rearrangedTemp, at:to.row)

    }
    

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destVC = segue.destination as! detailViewController
        let selectedRow = tableView.indexPathForSelectedRow?.row
        
        destVC.name = city[selectedRow!]
        destVC.pic = weatherPicture[selectedRow!]
        destVC.temp = temp[selectedRow!]
        destVC.weather = weatherLabel[selectedRow!]
    }
    

}
