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
    var blogs: [Blog] = []
    var db = Firestore.firestore()
    
   func AddEntrada(blog: Blog?){
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
            
            self.blogs.removeAll()
    
            for document in snapshot!.documents {
                let idBlog = document.documentID
                let titulo = document.data()["titulo"] as! String
                let autor = document.data()["autor"] as! String
                let contenido = document.data()["contenido"] as! String
                let string = document.data()["fechaPublicacion"]
                
                var imagen = ""
                if document.data()["imagen"] == nil {
                    imagen = ""
                } else {
                    imagen = document.data()["imagen"] as! String
                }
                
                let blog = Blog(idBlog: idBlog, titulo: titulo, autor: autor, fechaPublicacion: string as! String, contenido: contenido, imagen: imagen)
                self.blogs.append(blog)
            }
            bblog(self.blogs, nil)
        }
    }
    
    func tituloSearch(titulo: String) -> [Blog]{
        return self.blogs.filter { (blog) in
            blog.titulo.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(titulo)
        }
    }
    
    func autorSearch(autor: String)-> [Blog]{
        return self.blogs.filter { (blog) in
            blog.autor.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(autor)
        }
    }
    
    func contenidoSearch(contenido: String)-> [Blog]{
        return self.blogs.filter { (blog) in
            blog.contenido.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(contenido)
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
            var imagen = ""
            if document?.data()?["imagen"] == nil {
                imagen = ""
            } else {
                imagen = document?.data()?["imagen"] as! String
            }
            let blog = Blog(idBlog: idBlog, titulo: titulo, autor: autor, fechaPublicacion: "", contenido: contenido, imagen: imagen)
            blogs.append(blog)
            
            bblog(blogs, nil)
        }
    }
    
    func DeleteBlog(idBlog: String, result: @escaping(Bool?) -> Void) {
        do {
            db.collection("dataBlog").document("\(idBlog)").delete() { error in
                
                if let error = error {
                    result(false)
                } else {
                    result(true)
                }
            }
        } catch {
            result(false)
        }
    }
    
    
}
