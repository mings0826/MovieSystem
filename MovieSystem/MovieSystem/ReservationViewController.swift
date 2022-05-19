//
//  ReservationViewController.swift
//  MovieSystem
//
//  Created by 滕富山 on 2022/5/10.
//

import UIKit

struct BtnStatus {
    var tag:Int!
    var valueStr:String!
}


class ReservationViewController: UIViewController {
    var data:[String:String]!
    @IBOutlet weak var selectLabel: UILabel!
    var selectArray:Array<[String:Any]>!
    @IBOutlet var btns: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reservation"
        let user = UserDefaults.standard
        let dic = (user.value(forKey: "SELECT_KEY") as? [String:Array<[String:Any]>] ?? Dictionary())
        
        if !dic.isEmpty {
            let array = (dic[data["name"]!]) ?? Array()
            if !array.isEmpty {
                for obj in array {
                    let tag:Int = obj["tag"]! as! Int
                    for btn in btns {
                        if btn.tag == tag {
                            btn.isSelected = true
                            btn.backgroundColor = UIColor.systemRed
                        }
                    }
                }
            }
            recordBtns()
        }
    }
    
    @IBAction func myRightClick(_ sender: Any) {
        
        let user = UserDefaults.standard
        var dic = (user.value(forKey: "SELECT_KEY") as? [String:Array<[String:Any]>] ?? Dictionary())
        dic[data["name"]!] = selectArray
        user.setValue(dic, forKey: "SELECT_KEY")
        print(dic)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = UIColor.systemRed
        } else {
            sender.backgroundColor = UIColor.systemGreen
        }
        recordBtns()
    }
    
    func getbtnStatus(tag:Int) -> BtnStatus {
        var valueStr = ""
        if tag < 3 {
            valueStr = "[A row of \(tag+1)]"
        } else if (tag < 8) {
            valueStr = "[B row of \(tag-2)]"
        } else {
            valueStr = "[C row of \(tag-7)]"
        }
        return BtnStatus(tag: tag, valueStr: valueStr)
    }
    
    func recordBtns() {
        var str = "You choose：\n"
        var array = Array<BtnStatus>()
        for (_,btn) in btns.enumerated() {
            if btn.isSelected {
                let status = getbtnStatus(tag: btn.tag)
                array.append(status)
                str += status.valueStr + " "
            }
        }
        var tarray = Array<[String:Any]>()
        for obj in array {
            tarray.append(["str":obj.valueStr!,"tag":obj.tag!,"time":data["time"]!])
        }
        selectArray = tarray
        self.selectLabel.text = str
    }
    
}
