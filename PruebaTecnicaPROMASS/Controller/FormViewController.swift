//
//  FormViewController.swift
//  PruebaTecnicaPROMASS
//
//  Created by MacBookMBA9 on 22/03/23.
//

import UIKit

class FormViewController: UIViewController {
    @IBOutlet weak var txtTitulo: UITextField!
    @IBOutlet weak var txtAutor: UITextField!
    @IBOutlet weak var txtContenido: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    
    var blogViewModel = BlogViewModel()
    var bloModel: Blog? = nil
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()

    }
    

    @IBAction func saveEntreda(_ sender: UIButton) {
        //print("funciona")
        guard let titulo = txtTitulo.text else {
            return
        }
        
        guard let autor = txtAutor.text else {
            return
        }
        
        guard let contenido = txtContenido.text else {
            return
        }
        
        
        if titulo == "" && autor == "" && contenido == "" {
            let alert = UIAlertController(title: "Mensaje", message: "No se pueden registrar datos vacios", preferredStyle: .alert)
            
            let aceptar = UIAlertAction(title: "Aceptar", style: .default)
            
            alert.addAction(aceptar)
            self.present(alert, animated: false)
        } else {
            //print(titulo, autor, contenido)
            let date = Date()
            let dataFormatter = DateFormatter()
            dataFormatter.dateFormat = "dd-MM-yyyy, HH:mm:ss"
            dataFormatter.string(from: date)
            let newDate = dataFormatter.string(from: date)
            print(dataFormatter.string(from: date))
            
            bloModel = Blog(titulo: titulo, autor: autor, fechaPublicacion: newDate, contenido: contenido)
            //print(bloModel)
            let result = blogViewModel.AddEntrada(blog: bloModel!)
            
            if result != nil {
                let alert = UIAlertController(title: "Confirmación", message: "Nota agregada", preferredStyle: .alert)
                let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: {
                    action in
                    self.txtTitulo.text = ""
                    self.txtAutor.text = ""
                    self.txtContenido.text = ""
                })
                
                alert.addAction(aceptar)
                self.present(alert, animated: false)
            } else {
                let alert = UIAlertController(title: "Mensaje", message: "Error al intentar registrar una nota", preferredStyle: .alert)
                let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(aceptar)
                self.present(alert, animated: false)
            }
        }
        
    }
    

}
