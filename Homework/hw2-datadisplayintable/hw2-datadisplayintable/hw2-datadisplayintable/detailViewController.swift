//
//  detailViewController.swift
//  hw2-datadisplayintable
//
//  Created by Nathan Wangidjaja on 9/26/23.
//

import UIKit

class detailViewController: UIViewController {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    var name: String = ""
    var pic: UIImage? = nil
    var temp: String = ""
    var weather: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cityLabel.text = name
        self.temperature.text = temp
        self.weatherImage.image = pic
        self.weatherLabel.text = weather
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
