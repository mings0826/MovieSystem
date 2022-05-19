//
//  ViewController.swift
//  MovieSystem
//
//  Created by 滕富山 on 2022/5/10.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var dataArray:Array<[String:String]>!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = Bundle.main.path(forResource: "source", ofType:"json")
        let data = NSData.init(contentsOfFile: path!)! as Data
        do {
            let aray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Array<[String : String]>
            dataArray = aray
        } catch  {
        }
        
        self.tableView.rowHeight = 200
        self.title = "Movies"
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        let bar = UIBarButtonItem.init(title: "Reserved", style: .done, target: self, action: #selector(myRightClick))
        self.navigationItem.rightBarButtonItem = bar

    }
    
    @objc func myRightClick() {
        self.performSegue(withIdentifier: "resered", sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            cell?.textLabel?.numberOfLines = 0
            
            let imageView = UIImageView()
            imageView.tag = 10
            cell?.contentView.addSubview(imageView)
            let sc:CGFloat = 279.0/402.0
            imageView.frame = CGRect(x: 10, y: 10, width: 180.0*(sc), height: 180.0)
            imageView.layer.cornerRadius = 6
            imageView.layer.masksToBounds = true
            
            let w = UIScreen.main.bounds.size.width
            
            let label = UILabel()
            label.numberOfLines = 0
            label.tag = 20
            label.font = UIFont.boldSystemFont(ofSize: 18)
            cell?.contentView.addSubview(label)
            label.frame = CGRect(x: imageView.frame.size.width+10+15, y: 0, width: w-imageView.frame.size.width-10-15-50, height: 200)
            
            cell?.accessoryType = .disclosureIndicator
            
        }
        let imageView = cell?.contentView.viewWithTag(10) as! UIImageView
        let label = cell?.contentView.viewWithTag(20) as! UILabel
        
        imageView.image = UIImage.init(named: dataArray[indexPath.row]["pic"]!)
        label.text = dataArray[indexPath.row]["name"]!
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "selectTime", sender: dataArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "selectTime" {
            if let viewController = segue.destination as? SelectTimeViewController {
                viewController.data = sender as? Dictionary<String, String>
            }
        }
    }
}

