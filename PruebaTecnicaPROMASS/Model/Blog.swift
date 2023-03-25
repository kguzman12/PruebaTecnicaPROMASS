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
    
    enum CodingKeys: String, CodingKey {
        case idBlog
        case titulo
        case autor
        case fechaPublicacion
        case contenido
    }
    
    init(idBlog: String? = nil, titulo: String, autor: String, fechaPublicacion: String, contenido: String) {
        self.idBlog = idBlog
        self.titulo = titulo
        self.autor = autor
        self.fechaPublicacion = fechaPublicacion
        self.contenido = contenido
    }
    
    init() {
        self.idBlog = ""
        self.titulo = ""
        self.autor = ""
        self.fechaPublicacion = ""
        self.contenido = ""
    }
    
    
}

