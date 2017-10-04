// Simple class that gives you the current date in a string format
import Foundation

public struct CurrentDate {
    
    var day: String
    var dayNumber: String
    
    var month: String
    var monthNumber: String
    
    var year: String
    
    init() {
        let currentDate       = DateFormatter.localizedString(from: Date(), dateStyle: .full, timeStyle: .none)
        let currentDateNumber = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        
        let components = currentDate.components(separatedBy: ", ")
        
        let monthFull       = components[1]
        let monthComponents = monthFull.components(separatedBy: " ")
        self.month          = monthComponents[0]
        self.monthNumber    = currentDateNumber.components(separatedBy: "/").first!
        
        self.day = components[0]
        self.dayNumber = monthComponents[1]
        
        self.year   = components[2]
    }
    
    init?(dict: [String : Any]) {
        guard let day         = dict["day"] as? String else { return nil }
        guard let dayNumber   = dict["dayNumber"] as? String else { return nil }
        guard let month       = dict["month"] as? String else { return nil }
        guard let monthNumber = dict["monthNumber"] as? String else { return nil }
        guard let year        = dict["year"] as? String else { return nil }
        
        self.day         = day
        self.dayNumber   = dayNumber
        self.monthNumber = monthNumber
        self.month       = month
        self.year        = year
    }
    
    func toAnyObject() -> Any {
        return ["day" : self.day, "dayNumber" : self.dayNumber, "month" : self.month, "monthNumber" : self.monthNumber, "year" : self.year]
    }
    
    
}