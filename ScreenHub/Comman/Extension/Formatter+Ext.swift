//
//  Formatter+Ext.swift
//  ScreenHub
//
//  Created by Pedro Denardi Minuzzi on 16/01/25.
//

#if DEBUG
import SwiftUI
#endif

import Foundation

struct ValueFormatter {
    
    static func formatVoteAverage(_ voteAverage: Double) -> String { String(format: "%.1f", voteAverage) }
    
    static func formatRuntime(_ runtime: Int) -> String { "\(runtime / 60)h \(runtime % 60)m" }
    
    static func formatLocale(_ countryCode: String, _ languageCode: String) -> (region: String, language: String) {
        let locale = Locale(identifier: languageCode)
        
        let language = locale.localizedString(forLanguageCode: languageCode) ?? LocalizedString.unknownLanguage
        let region = locale.localizedString(forRegionCode: countryCode) ?? LocalizedString.unknownRegion
        
        return (region: region.capitalized, language: language.capitalized)
    }
    
    static func formatISODate(_ isoDateString: String) -> (full: String, short: String, year: String) {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoDateFormatter.date(from: isoDateString) else { return (full: "", short: "", year: "") }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateFormat = "d 'de' MMMM 'de' yyyy"
        let full = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let short = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        
        return (full: full, short: short, year: year)
    }
    
    static func formatDate(_ dateString: String) -> (full: String, short: String, year: String) {
        let formatter = DateFormatter()
        
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: dateString) else { return (full: "", short: "", year: "") }
        
        formatter.dateFormat = "d 'de' MMMM 'de' yyyy"
        let full = formatter.string(from: date)
        
        formatter.dateFormat = "dd/MM/yyyy"
        let short = formatter.string(from: date)
        
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        
        return (full: full, short: short, year: year)
    }
    
    static func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let number = NSNumber(value: value)
        return formatter.string(from: number) ?? "$0.00"
    }
    
    static func formatEpisodeRuntime(_ runTimes: [Int]) -> String {
        guard !runTimes.isEmpty else { return LocalizedString.unknown }
        let average = runTimes.reduce(0, +) / runTimes.count
        return "\(average)m"
    }
    
    static func formatGender(_ genderCode: Int) -> String {
        if genderCode == 1 {
            LocalizedString.genderFemale
        } else if genderCode == 2 {
            LocalizedString.genderFemale
        } else {
            LocalizedString.unknown
        }
    }
    
}

#if DEBUG
#Preview {
    VStack(alignment: .leading) {
        let rating = ValueFormatter.formatVoteAverage(9.456)
        Text("Rating: \(rating)")
        
        let runtime = ValueFormatter.formatRuntime(147)
        Text("Runtime: \(runtime)")
        
        let runtimeAverage = ValueFormatter.formatEpisodeRuntime([23, 32, 43, 52, 48, 31, 27])
        Text("Runtime average: \(runtimeAverage)")
        
        let date = ValueFormatter.formatDate("2025-01-12")
        VStack(alignment: .leading) {
            Text("Normal date fully: \(date.full)")
            Text("Normal date short: \(date.short)")
            Text("Normal date year: \(date.year)")
        }.padding(.vertical, 16)
        
        let currency = ValueFormatter.formatCurrency(160000000)
        Text("Currency: \(currency)")
        
        let isoDate = ValueFormatter.formatISODate("2024-05-09T08:51:03.507Z")
        VStack(alignment: .leading) {
            Text("ISO date fully: \(isoDate.full)")
            Text("ISO date short: \(isoDate.short)")
            Text("ISO date year: \(isoDate.year)")
        }.padding(.vertical, 16)
        
        let gender = ValueFormatter.formatGender(1)
        Text("Gender: \(gender)")
        
        let locale = ValueFormatter.formatLocale("BR", "pt")
        VStack(alignment: .leading) {
            Text("Language: \(locale.language)")
            Text("Region: \(locale.region)")
        }.padding(.vertical, 16)
    }
}
#endif
