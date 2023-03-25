//
//  ListViewController.swift
//  PruebaTecnicaPROMASS
//
//  Created by MacBookMBA9 on 22/03/23.
//

import UIKit
import iOSDropDown
import SwipeCellKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dropDronSearc: DropDown!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var blogViewModel = BlogViewModel()
    var blogModel: [Blog]? = nil
    
    var idBlog: String = ""
    var searchTitulo: String = ""
    var dropId: [Int] = [1, 2, 3]
    var dropListArray: [String] = ["Titulo", "Autor", "Contenido"]
    var idBusqueda: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        
        dropDronSearc.optionArray = [String]()
        dropDronSearc.optionIds = [Int]()
        
        dropDronSearc.didSelect{ selected, index, id in
            self.idBusqueda = id
        }
        
        loadDrop()
    }
    
    func loadDrop(){
        for name in dropListArray {
            dropDronSearc.optionArray.append(name)
        }
        
        for id in dropId {
            dropDronSearc.optionIds?.append(id)
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalle" {
            let detalleViewController = segue.destination as! DetalleViewController
            detalleViewController.idBlog = self.idBlog
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        blogViewModel.GetAllEntradas(bblog: { request, error in
            if let requestData = request {
                DispatchQueue.main.async {
                    self.blogModel = requestData
                    //print(self.blogModel)
                    self.tableView.reloadData()
                }
            }
            
            if let _ = error {
                let alert = UIAlertController(title: "Alert", message: "Error al consultar las publicaciones", preferredStyle: .alert)
                
                let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                
                alert.addAction(aceptar)
                self.present(alert, animated: false)
            }
        })
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        let search = txtSearch.text!.lowercased().folding(options: .diacriticInsensitive, locale: .current)
        guard search != "" else{
                    loadData()
                    return
        }
        if idBusqueda == 1 {
                    self.blogModel = blogViewModel.tituloSearch(titulo: search)
        } else if idBusqueda == 2 {
                    self.blogModel = blogViewModel.autorSearch(autor: search)
        } else {
                    self.blogModel = blogViewModel.contenidoSearch(contenido: search)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        
        cell.delegate = self
        idBlog = blogModel?[indexPath.row].idBlog ?? ""
        
        var contenido = blogModel?[indexPath.row].contenido
        if contenido!.count > 70 {
            contenido = String(contenido!.prefix(70))
        } else {
            contenido = blogModel?[indexPath.row].contenido
        }
        
        cell.lblTitulo.text = blogModel?[indexPath.row].titulo
        cell.lblAutor.text = blogModel?[indexPath.row].autor
        cell.lblContenido.text = contenido
        cell.lblFechaPub.text = blogModel?[indexPath.row].fechaPublicacion
        
        if self.blogModel?[indexPath.row].imagen == "" {
            cell.imgBlog.image = UIImage(named: "SinFoto")
        } else {
            let imageData = Data(base64Encoded: (self.blogModel?[indexPath.row].imagen)!, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            cell.imgBlog.image = UIImage(data: imageData!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.idBlog = blogModel?[indexPath.row].idBlog ?? ""
        performSegue(withIdentifier: "detalle", sender: self)
    }
}

extension ListViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            let idBlog = self.blogModel?[indexPath.row].idBlog
            self.blogViewModel.DeleteBlog(idBlog: idBlog!) { result in
                if result == true {
                    let alert = UIAlertController(title: "Confirmación", message: "Publicación eliminada correctamente", preferredStyle: .alert)
                    let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                 
                    alert.addAction(aceptar)
                    self.present(alert, animated: false)
                }else {
                    let alert = UIAlertController(title: "Mensaje", message: "Se produjo un error al eliminar la publicación", preferredStyle: .alert)
                    let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                 
                    alert.addAction(aceptar)
                    self.present(alert, animated: false)
                }
            }
            
            DispatchQueue.main.async {
                self.loadData()
            }
        }
        
        deleteAction.image = UIImage(named: "delete")
        return [deleteAction]
    }
}

