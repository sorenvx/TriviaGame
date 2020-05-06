//
//  InfoCell.swift
//  TriviaGame
//
//  Created by Toni De Gea on 05/05/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    
    @IBOutlet weak var player1Name: UILabel!
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Name: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.roundCorners(corners: [.topLeft, .topRight], radius: 25.0)
       
    }
    override func prepareForReuse() {
        player1Name.text = nil
        player2Name.text = nil
        player1Score.text = nil
        player2Score.text = nil
        date.text = nil
    }
    
    func configureCell(player1: String, player2: String, player1Points: String, player2Points: String, CurrentDate: Date) {
        
        player1Name.text = player1
        player2Name.text = player2
        player1Score.text = player1Points
        player2Score.text = player2Points
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"

        let myDateInString = formatter.string(from: CurrentDate) // string purpose I add here
        // convert your string to date
        date.text = myDateInString
       
    }

}


extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
