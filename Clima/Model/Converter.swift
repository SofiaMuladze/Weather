//
//  Converter.swift
//  Clima
//
//  Created by Sofia Muladze on 18/02/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit


extension Double {
    func convertTimeToString() -> String{
        let currentDateTime = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM hh:mm"
        return dateFormatter.string(from: currentDateTime as Date)
    }
}
