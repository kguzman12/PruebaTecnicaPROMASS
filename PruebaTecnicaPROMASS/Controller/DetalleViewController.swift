//
//  DetalleViewController.swift
//  PruebaTecnicaPROMASS
//
//  Created by MacBookMBA9 on 22/03/23.
//

import UIKit

class DetalleViewController: UIViewController {
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAutor: UILabel!
    @IBOutlet weak var lblContenido: UITextView!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var imgDetalle: UIImageView!
    
    var blogViewModel = BlogViewModel()
    var blogModel: [Blog]? = nil
    var idBlog: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData(){
        blogViewModel.detalleBlog(idBlog: idBlog, bblog: { request, error in
            if let requestData = request {
                DispatchQueue.main.async {
                    self.blogModel = requestData
                    
                    self.lblTitulo.text = self.blogModel?[0].titulo
                    self.lblAutor.text = self.blogModel?[0].autor
                    self.lblContenido.text = self.blogModel?[0].contenido
                    self.lblFecha.text = self.blogModel?[0].fechaPublicacion
                    
                    if self.blogModel?[0].imagen == "" {
                        self.imgDetalle.image = UIImage(named: "SinFoto")
                    } else {
                        let imageData = Data(base64Encoded: (self.blogModel?[0].imagen)!, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
                        self.imgDetalle.image = UIImage(data: imageData!)
                    }
                }
            }
            
            if let error = error {
                let alert = UIAlertController(title: "Alert", message: "Error al ejecutar la busqueda" + error.localizedDescription, preferredStyle: .alert)
                
                let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                
                alert.addAction(aceptar)
                self.present(alert, animated: false)
            }
        })
    }


}
