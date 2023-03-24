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
    
    func AddEntrada(blog: Blog){
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
                    //print(document.data()["titulo"]!, document.data()["autor"]!)
                    let idBlog = document.documentID
                    let titulo = document.data()["titulo"] as! String
                    let autor = document.data()["autor"] as! String
                    let contenido = document.data()["contenido"] as! String
                    //let fecha = document.data()["fechaPublicacion"] as! Date
                    let blog = Blog(titulo: titulo, autor: autor, fechaPublicacion: Date.now, contenido: contenido)
                    blogs.append(blog)
        
                }
                bblog(blogs, nil)
        }
    }
    
    func tituloSearch(titulo: String, bblog: @escaping([Blog]?, Error?) -> Void){
        //db.collection("dataBlog").order(by: "titulo").start(at: titulo).end(at: titulo+"\uf8ff").getDocuments { snapshot, error in
        db.collection("dataBlog").whereField("titulo", isEqualTo: "\(titulo)").getDocuments { snapshot, error in
            
            if let error = error {
                bblog(nil, error)
                return
            }
            
            var blogs: [Blog] = []
            
            for document in snapshot!.documents {
                print(document.documentID, document.data())
                let idBlog = document.documentID
                let titulo = document.data()["titulo"] as! String
                let autor = document.data()["autor"] as! String
                let contenido = document.data()["contenido"] as! String
                //let fecha = document.data()["fechaPublicacion"] as! Date
                let blog = Blog(titulo: titulo, autor: autor, fechaPublicacion: Date.now, contenido: contenido)
                blogs.append(blog)
            }
            bblog(blogs, nil)
        }
    }
    
}
