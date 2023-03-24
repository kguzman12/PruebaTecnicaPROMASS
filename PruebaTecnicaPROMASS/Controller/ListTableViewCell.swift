//
//  ListTableViewCell.swift
//  PruebaTecnicaPROMASS
//
//  Created by MacBookMBA9 on 23/03/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAutor: UILabel!
    @IBOutlet weak var lblContenido: UILabel!
    @IBOutlet weak var lblFechaPub: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
