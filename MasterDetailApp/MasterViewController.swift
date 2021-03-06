//
//  MasterViewController.swift
//  MasterDetailApp
//
//  Created by 川崎 隆介 on 2015/10/14.
//  Copyright (c) 2015年 川崎 隆介. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var spotService = SpotService()
    
    @IBAction func done(_ segue:UIStoryboardSegue){
        if segue.identifier == "DoneInput"{
            let addController = segue.source as! SpotInfoAddtionalTableViewController
            if let spotInfo = addController.spotInfo {
                self.spotService.add(spotInfo:spotInfo)
                self.tableView.reloadData()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ segue:UIStoryboardSegue){
        self.dismiss(animated: true, completion: nil)        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        for info in self.spotService.spotInfoList {
            print(info.name)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    */
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let spotInfo = self.spotService.objectInListAt(index:indexPath.row)
                (segue.destination as! DetailViewController).detailItem = spotInfo
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return objects.count
        return self.spotService.countOfList()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "観光地";
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Cellの識別子を指定してCellを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpotCell", for: indexPath) 
        //Cellに表示したいデータを設定
        let spotInfo = self.spotService.objectInListAt(index:indexPath.row)
        cell.textLabel?.text = spotInfo.name
        cell.detailTextLabel?.text = spotInfo.comment
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.spotService.removeSpotInfo(index:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

}

