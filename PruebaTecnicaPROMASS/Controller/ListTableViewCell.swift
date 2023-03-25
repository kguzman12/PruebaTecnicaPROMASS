//
//  ListTableViewCell.swift
//  PruebaTecnicaPROMASS
//
//  Created by MacBookMBA9 on 23/03/23.
//

import UIKit
import SwipeCellKit

class ListTableViewCell: SwipeTableViewCell {
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAutor: UILabel!
    @IBOutlet weak var lblContenido: UILabel!
    @IBOutlet weak var lblFechaPub: UILabel!
    @IBOutlet weak var imgBlog: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
