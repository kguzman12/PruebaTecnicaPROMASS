//
//  BlogViewModel.swift
//  PruebaTecnicaPROMASS
//
//  Created by MacBookMBA9 on 22/03/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift

class BlogViewModel{
    var blog: Blog? = nil
    var db = Firestore.firestore()
    
    /*func AddEntrada(blog: Blog){
        //print("ViewModel" ,blog)
        do {
            try db.collection("dataBlog").document().setData(from: blog)
        } catch {
            print("Error al almacenar los datos en Firestone")
        }
    }*/
    
    func AddEntrada(blog: Blog?){
        //print("ViewModel" ,blog)
        do {
            try db.collection("dataBlog").document().setData(from: blog)
            
            
        } catch {
            print("Error al almacenar los datos en Firestone")
        }
    }
    
    func GetAllEntradas(bblog: @escaping([Blog]?, Error?) -> Void){
        db.collection("dataBlog").getDocuments() { snapshot, error in
            if let error = error{
                bblog(nil, error)
                return
            }
            
            var blogs : [Blog] = []
    
            for document in snapshot!.documents {
                //print(document.data()["fechaPublicacion"]!)
                let idBlog = document.documentID
                let titulo = document.data()["titulo"] as! String
                let autor = document.data()["autor"] as! String
                let contenido = document.data()["contenido"] as! String
                
                let timestamp = document.data()["fechaPublicacion"] as? TimeInterval ?? 0
                //print(timestamp)
                let date = Date(timeIntervalSince1970: timestamp)
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "dd-MM-yyyy HH:ss"
                let strDate = dateformatter.string(from: date)
                //print("47", strDate)
                
                let blog = Blog(idBlog: idBlog, titulo: titulo, autor: autor, fechaPublicacion: strDate, contenido: contenido)
                blogs.append(blog)
        
            }
            bblog(blogs, nil)
        }
    }
    
    func tituloSearch(titulo: String, bblog: @escaping([Blog]?, Error?) -> Void){
        //db.collection("dataBlog").order(by: "titulo").start(at: "").end(at: titulo+"\uf8ff").getDocuments { snapshot, error in
       
        //let citiesRef = db.collection("dataBlog")
        //citiesRef.whereField("titulo", arrayContainsAny: ["\(titulo)"]).getDocuments { snapshot, error in
        db.collection("dataBlog").whereField("titulo", isEqualTo: "\(titulo)").getDocuments { snapshot, error in
            //self.db.collection("dataBlog").whereField("titulo", isGreaterThanOrEqualTo: "\(titulo)").getDocuments { snapshot, error in
            //citiesRef.whereField("titulo", isEqualTo: titulo).getDocuments { snapshot, error in
                    //print(snapshot)
            //citiesRef.whereField("titulo", isGreaterThanOrEqualTo: titulo).getDocuments { snapshot, error in
                    
                
            if let error = error {
                bblog(nil, error)
                return
            }
            
            var blogs : [Blog] = []
                
            for document in snapshot!.documents {
                print(document.documentID, document.data())
                let idBlog = document.documentID
                let titulo = document.data()["titulo"] as! String
                let autor = document.data()["autor"] as! String
                let contenido = document.data()["contenido"] as! String
                //let fecha = document.data()["fechaPublicacion"] as! Date
                let blog = Blog(idBlog: idBlog, titulo: titulo, autor: autor, fechaPublicacion: "", contenido: contenido)
                blogs.append(blog)
            }
            bblog(blogs, nil)
        }
    }
    
    func autorSearch(autor: String, bblog: @escaping([Blog]?, Error?) -> Void){
        db.collection("dataBlog").whereField("autor", isEqualTo: "\(autor)").getDocuments { snapshot, error in
            
            if let error = error {
                bblog(nil, error)
                return
            }
            
            var blogs : [Blog] = []
            
            for document in snapshot!.documents {
                print(document.documentID, document.data())
                let idBlog = document.documentID
                let titulo = document.data()["titulo"] as! String
                let autor = document.data()["autor"] as! String
                let contenido = document.data()["contenido"] as! String
                //let fecha = document.data()["fechaPublicacion"] as! Date
                let blog = Blog(idBlog: idBlog, titulo: titulo, autor: autor, fechaPublicacion: "", contenido: contenido)
                blogs.append(blog)
            }
            bblog(blogs, nil)
        }
    }
    
    func contenidoSearch(contenido: String, bblog: @escaping([Blog]?, Error?) -> Void){
        db.collection("dataBlog").whereField("contenido", isEqualTo: "\(contenido)").getDocuments { snapshot, error in
            
            if let error = error {
                bblog(nil, error)
                return
            }
            
            var blogs : [Blog] = []
            
            for document in snapshot!.documents {
                print(document.documentID, document.data())
                let idBlog = document.documentID
                let titulo = document.data()["titulo"] as! String
                let autor = document.data()["autor"] as! String
                let contenido = document.data()["contenido"] as! String
                //let fecha = document.data()["fechaPublicacion"] as! Date
                let blog = Blog(idBlog: idBlog, titulo: titulo, autor: autor, fechaPublicacion: "", contenido: contenido)
                blogs.append(blog)
            }
            bblog(blogs, nil)
        }
    }
    
    func detalleBlog(idBlog: String, bblog: @escaping([Blog]?, Error?) -> Void){
        let collection = db.collection("dataBlog").document("\(idBlog)")
        collection.getDocument { document, error in
            
            if let error = error {
                bblog(nil, error)
                return
            }
            
            var blogs : [Blog] = []
            let idBlog = idBlog
            let titulo = document?.data()?["titulo"] as! String
            let autor = document?.data()?["autor"] as! String
            let contenido = document?.data()?["contenido"] as! String
                //let fecha = document.data()["fechaPublicacion"] as! Date
            let blog = Blog(idBlog: idBlog, titulo: titulo, autor: autor, fechaPublicacion: "", contenido: contenido)
            blogs.append(blog)
            
            bblog(blogs, nil)
        }
    }
    
    
}
