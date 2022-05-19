//
//  BookedViewController.swift
//  MovieSystem
//
//  Created by 滕富山 on 2022/5/11.
//

import UIKit

class BookedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var dataArray:Array<[String:Any]>! = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Booked"
        self.tableView.backgroundColor = UIColor.systemGray5
        
        let user = UserDefaults.standard
        let dic = (user.value(forKey: "SELECT_KEY") as? [String:Array<[String:Any]>] ?? Dictionary())
        for key in dic.keys {
            dataArray.append(["name":key,
                              "time":dic[key]!.first!["time"] as? String ?? "",
                              "data":dic[key]!])
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookedTableViewCell
        let array = dataArray[indexPath.section]["data"] as! Array<[String:Any]>
        var str = ""
        for obj in array {
            str += obj["str"] as! String + " "
        }

        cell.nameLabel.text = (dataArray[indexPath.section]["name"] as! String) + " " + "\(array.count)" + " " + "Tickets"
        cell.timeLabel.text = (dataArray[indexPath.section]["time"] as! String)
        cell.zwLabel.text = str
        
        return cell
    }
    
    
    // MARK: 左滑删除
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 不设置这个，可以避免左滑偶尔出现红底的bug
    // func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    //    return "删除"
    // }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.row < self.dataArray.count {
            
            let alert = UIAlertController(title: "Sure you want to delete it？", message: "", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Delete", style: .default) { [self] (action :UIAlertAction!) in
                let name = (dataArray[indexPath.section]["name"] as! String)
                let user = UserDefaults.standard
                var dic = (user.value(forKey: "SELECT_KEY") as? [String:Array<[String:Any]>] ?? Dictionary())
                dic.removeValue(forKey: name)
                user.setValue(dic, forKey: "SELECT_KEY")
                dataArray.remove(at: indexPath.section)
                tableView.reloadData()
                
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action: UIAlertAction) in
                
            }
            
            saveAction.setValue(UIColor.red, forKey: "_titleTextColor")
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
            
        }
    }
    
}
