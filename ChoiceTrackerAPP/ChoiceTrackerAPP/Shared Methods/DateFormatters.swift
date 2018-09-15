//
//  DateFormatters.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/20/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

let sortableShortDate: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "en_US")
    return formatter
}()

let prettyDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "en_US")
    return formatter
}()

let exportFileNameDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd_HH_mm_ss"
    formatter.locale = Locale(identifier: "en_US")
    return formatter
}()
