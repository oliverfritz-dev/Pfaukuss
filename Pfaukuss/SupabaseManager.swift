//
//  SupabaseManager.swift
//  Pfaukuss
//
//  Created by Privat on 19.03.26.
//

import Foundation
import Supabase

let url = Bundle.main.infoDictionary!["SUPABASE_URL"] as! String
let key = Bundle.main.infoDictionary!["SUPABASE_KEY"] as! String

let supabase = SupabaseClient(
    supabaseURL: URL(string: url)!,
    supabaseKey: key
)

