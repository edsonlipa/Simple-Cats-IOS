//
//  LocalizedStrings.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 13/02/25.
//

import SwiftUICore

enum LocalizedStrings {
    enum CatList {
        static var title: String { NSLocalizedString("catList.title", comment: "") }
    }
    
    enum CatDetail {
        static var title: String { NSLocalizedString("catDetail.title", comment: "") }
        static var about: String { NSLocalizedString("catDetail.about", comment: "") }
        static var temperament: String { NSLocalizedString("catDetail.temperament", comment: "") }
        static var details: String { NSLocalizedString("catDetail.details", comment: "") }
        static var lifeSpan: String { NSLocalizedString("catDetail.lifeSpan", comment: "") }
        static var readMore: String { NSLocalizedString("catDetail.readMore", comment: "") }
        
        static func lifeSpan(with years: String) -> String {
            String(format: NSLocalizedString("%@ catDetail.lifeSpan", comment: ""), years)
        }
        static func originWithCountry(_ country: String) -> String {
            String(format: NSLocalizedString("catDetail.originWithCountry %@", comment: ""), country)
        }
    }
    
    enum Common {
        static let error = Bundle.main.localizedString(forKey: "Error", value: nil, table: nil)
        static let ok = Bundle.main.localizedString(forKey: "OK", value: nil, table: nil)
        static let unknown = Bundle.main.localizedString(forKey: "Unknown", value: nil, table: nil)
    }
}
