//
//  Blog.swift
//  PruebaTecnicaPROMASS
//
//  Created by MacBookMBA9 on 22/03/23.
//

import Foundation

struct Blog: Codable{
    var idBlog: String? = ""
    var titulo: String = ""
    var autor: String = ""
    var fechaPublicacion: String = ""
    var contenido: String = ""
    var imagen: String = ""
    
    enum CodingKeys: String, CodingKey {
        case idBlog
        case titulo
        case autor
        case fechaPublicacion
        case contenido
        case imagen
    }
    
    init(idBlog: String? = nil, titulo: String, autor: String, fechaPublicacion: String, contenido: String, imagen: String) {
        self.idBlog = idBlog
        self.titulo = titulo
        self.autor = autor
        self.fechaPublicacion = fechaPublicacion
        self.contenido = contenido
        self.imagen = imagen
    }
    
    init() {
        self.idBlog = ""
        self.titulo = ""
        self.autor = ""
        self.fechaPublicacion = ""
        self.contenido = ""
        self.imagen = ""
    }
    
    
}

