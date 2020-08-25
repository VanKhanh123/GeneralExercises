//
//  CustomTableViewCell.swift
//  GeneralExercises
//
//  Created by Van Khanh Vuong on 8/21/20.
//  Copyright © 2020 IMT. All rights reserved.
//

import UIKit


class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewNews: UIImageView!
    
    @IBOutlet weak var labelTagNews: UILabel!
    
    
    @IBOutlet weak var labelTitleNews: UILabel!
    
    @IBOutlet weak var labelContentNews: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.height / 7
        self.clipsToBounds = true
        super.awakeFromNib()

    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
