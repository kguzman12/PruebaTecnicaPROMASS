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
    var dropId: [Int] = [0,1, 2]
    var dropListArray: [String] = ["", "Titulo", "Autor o contenido"]
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
            print(name)
            dropDronSearc.optionArray.append(name)
        }
        
        for id in dropId {
            print(id)
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
                    print("controlador", self.blogModel)
                    
                    self.tableView.reloadData()
                }
            }
            
            if let error = error {
                let alert = UIAlertController(title: "Alert", message: "Error al consultar las publicaciones" + error.localizedDescription, preferredStyle: .alert)
                
                let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                
                alert.addAction(aceptar)
                self.present(alert, animated: false)
            }
        })
    }
    
    @IBAction func btnSearch(_ sender: UIButton) {
        searchTitulo = txtSearch.text!
        
        if idBusqueda == 1{
            blogViewModel.tituloSearch(titulo: searchTitulo, bblog: { request, error in
                if let requestData = request {
                    DispatchQueue.main.async {
                        self.blogModel = requestData
                        print("busqueda", self.blogModel)
                        
                        self.tableView.reloadData()
                    }
                }
                
                if let error = error {
                    let alert = UIAlertController(title: "Alert", message: "Error al ejecutar la busqueda" + error.localizedDescription, preferredStyle: .alert)
                    
                    let aceptar = UIAlertAction(title: "Aceptar", style: .default)
                    
                    alert.addAction(aceptar)
                    self.present(alert, animated: false)
                }
            })
        } else if idBusqueda == 2{
            print(idBusqueda,"Autor o contenido")
        } else {
            print(idBusqueda)
            loadData()
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
        
        cell.lblTitulo.text = blogModel?[indexPath.row].titulo
        cell.lblAutor.text = blogModel?[indexPath.row].autor
        cell.lblContenido.text = blogModel?[indexPath.row].contenido
        cell.lblFechaPub.text = "23/03/2023" //blogModel?.fechaPublicacion
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.idBlog = blogModel?[indexPath.row].idBlog ?? ""
        performSegue(withIdentifier: "detalle", sender: self)
    }

}

