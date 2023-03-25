//
//  ListViewController.swift
//  PruebaTecnicaPROMASS
//
//  Created by MacBookMBA9 on 22/03/23.
//

import UIKit
import iOSDropDown

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dropDronSearc: DropDown!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var blogViewModel = BlogViewModel()
    var blogModel: [Blog]? = nil
    
    var idBlog: String = ""
    var searchTitulo: String = ""
    var dropId: [Int] = [0, 1, 2, 3]
    var dropListArray: [String] = ["", "Titulo", "Autor", "Contenido"]
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
            
            if let error = error {
                let alert = UIAlertController(title: "Alert", message: "Error al consultar las publicaciones", preferredStyle: .alert)
                
                let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                
                alert.addAction(aceptar)
                self.present(alert, animated: false)
            }
        })
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        searchTitulo = txtSearch.text!
        
        if idBusqueda == 0 {
            loadData()
        } else if idBusqueda == 1 {
            blogViewModel.tituloSearch(titulo: searchTitulo, bblog: { request, error in
                if let requestData = request {
                    DispatchQueue.main.async {
                        self.blogModel = requestData
                        print("titulo", self.blogModel?[0].idBlog)
                        
                        self.tableView.reloadData()
                    }
                }
                
                if let error = error {
                    let alert = UIAlertController(title: "Alert", message: "Error al ejecutar la busqueda", preferredStyle: .alert)
                    
                    let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                    
                    alert.addAction(aceptar)
                    self.present(alert, animated: false)
                }
            })
        } else if idBusqueda == 2 {
            blogViewModel.autorSearch(autor: searchTitulo, bblog: { request, error in
                if let requestData = request {
                    DispatchQueue.main.async {
                        self.blogModel = requestData
                        print("autor", self.blogModel)
                        
                        self.tableView.reloadData()
                    }
                }
                
                if let error = error {
                    let alert = UIAlertController(title: "Alert", message: "Error al ejecutar la busqueda", preferredStyle: .alert)
                    
                    let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                    
                    alert.addAction(aceptar)
                    self.present(alert, animated: false)
                }
            })
        } else {
            blogViewModel.contenidoSearch(contenido: searchTitulo, bblog: { request, error in
                if let requestData = request {
                    DispatchQueue.main.async {
                        self.blogModel = requestData
                        print("contenido", self.blogModel)
                        
                        self.tableView.reloadData()
                    }
                }
                
                if let error = error {
                    let alert = UIAlertController(title: "Alert", message: "Error al ejecutar la busqueda", preferredStyle: .alert)
                    
                    let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                    
                    alert.addAction(aceptar)
                    self.present(alert, animated: false)
                }
            })
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
        
        idBlog = blogModel?[indexPath.row].idBlog ?? ""
        let contenido = blogModel?[indexPath.row].contenido
        let index = (contenido?.index(contenido!.startIndex, offsetBy: 70))!
        let newContenido = contenido![..<index]
        print("newContenido", newContenido)
        
        cell.lblTitulo.text = blogModel?[indexPath.row].titulo
        cell.lblAutor.text = blogModel?[indexPath.row].autor
        cell.lblContenido.text = blogModel?[indexPath.row].contenido
        cell.lblFechaPub.text = blogModel?[indexPath.row].fechaPublicacion
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.idBlog = blogModel?[indexPath.row].idBlog ?? ""
        performSegue(withIdentifier: "detalle", sender: self)
    }


}

