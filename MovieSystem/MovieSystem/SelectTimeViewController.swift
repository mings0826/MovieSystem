//
//  SelectTimeViewController.swift
//  MovieSystem
//
//  Created by 滕富山 on 2022/5/10.
//

import UIKit

class SelectTimeViewController: UIViewController {

    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    var data:[String:String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose Session"
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM-dd"
        let dateStr = format.string(from: date)
        self.label1.text = dateStr+" "+"14:00"
        self.label2.text = dateStr+" "+"15:00"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showZW1" {
            if let viewController = segue.destination as? ReservationViewController {
                data["time"] = self.label1.text
                viewController.data = data
            }
        }
        if segue.identifier == "showZW2" {
            if let viewController = segue.destination as? ReservationViewController {
                data["time"] = self.label2.text
                viewController.data = data
            }
        }
    }

}
