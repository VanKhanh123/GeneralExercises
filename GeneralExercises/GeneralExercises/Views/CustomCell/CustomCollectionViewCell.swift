//
//  CustomCollectionViewCell.swift
//  GeneralExercises
//
//  Created by Van Khanh Vuong on 8/24/20.
//  Copyright © 2020 IMT. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sliderImageNews: UIImageView!
    
    @IBOutlet weak var viewImageNews: UIView!
    
    @IBOutlet weak var labelTag : UILabel!
    
    @IBOutlet weak var labelTitleNew: UILabel!
    
    @IBOutlet weak var labelTrend: UILabel!
    override func awakeFromNib() {
        self.sliderImageNews.layer.cornerRadius = self.frame.size.height / 7
        self.sliderImageNews.clipsToBounds = true
        super.awakeFromNib()
    }
    
}
