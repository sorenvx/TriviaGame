//
//  InfoTableViewController.swift
//  TriviaGame
//
//  Created by Toni De Gea on 05/05/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//

import UIKit
import CoreData

class InfoTableViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var infoGeneralArray: [InfoGeneral] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    func loadItems() {
        let request: NSFetchRequest<InfoGeneral> = InfoGeneral.fetchRequest()
        do{
            try infoGeneralArray = context.fetch(request)
        } catch {
            print(error)
        }
        
    }
    
    
}


extension InfoTableViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoGeneralArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? InfoCell else {
            return UITableViewCell()
        }
        if (indexPath.row < infoGeneralArray.count) {
            let info = infoGeneralArray[indexPath.row]
            cell.configureCell(player1: info.firstPlayer!, player2: info.secondPlayer!, player1Points: String(info.firstPlayerScore), player2Points: String(info.secondPlayerScore), CurrentDate: info.currentDate!)
        }
        
        return cell
    }
}


//cell.configureCell(player1: info.firstPlayer ?? "", player2: info.secondPlayer ?? "", player1Points: String(info.firstPlayerScore), player2Points: String(info.secondPlayerScore), CurrentDate: info.currentDate ?? Date())
