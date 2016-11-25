//
//  DataService.swift
//  Firebase_Social
//
//  Created by Surachet Songsakaew on 11/25/2559 BE.
//  Copyright © 2559 Surachet Songsakaew. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()

class DataService {
    
    static let de = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    var REEF_BASE:FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS:FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS:FIRDatabaseReference {
        return _REF_USERS
    }
    
    func createFirbaseDBUser(uid:String,userData:Dictionary<String,String>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
}
