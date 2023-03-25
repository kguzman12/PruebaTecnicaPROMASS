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

        //print(idBlog)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        blogViewModel.detalleBlog(idBlog: idBlog, bblog: { request, error in
            if let requestData = request {
                DispatchQueue.main.async {
                    self.blogModel = requestData
                    //print("detalle", self.blogModel)
                    
                    self.lblTitulo.text = self.blogModel?[0].titulo
                    self.lblAutor.text = self.blogModel?[0].autor
                    self.lblContenido.text = self.blogModel?[0].contenido
                    
                    let dateformatter = DateFormatter()
                    dateformatter.dateFormat = "dd-MM-yyyy'T'HH:ss"
                    let string = self.blogModel?[0].fechaPublicacion
                    dateformatter.dateStyle = .full
                    let date = dateformatter.date(from: string as! String)
                    print("47", date)
                    self.lblFecha.text = self.blogModel?[0].fechaPublicacion
                    
                    if self.blogModel?[0].imagen == "" {
                        self.imgDetalle.image = UIImage(named: "")
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
