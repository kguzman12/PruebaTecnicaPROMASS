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
            bloModel = Blog(titulo: titulo, autor: autor, fechaPublicacion: Date.now, contenido: contenido)
            //print(bloModel)
            blogViewModel.AddEntrada(blog: bloModel!)
        }
        
    }
    

}
