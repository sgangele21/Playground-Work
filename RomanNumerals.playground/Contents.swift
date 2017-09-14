// Max Number Represented In Roman Numerals: 3599
struct RomanNumeral: CustomStringConvertible {
    
    var description: String {
        return "\(thousandsNumeral)\(hundredsNumeral)\(tensNumeral)\(onesNumeral)"
    }
    
    // Dictionary values of merely 24 key value pairs... not bad
    let numToRomDict: [Int:String] =
        [     0:""
            , 1:"I"
            , 2:"II"
            , 3:"III"
            , 4:"IV"
            , 5:"V"
            , 9:"IX"
            , 10:"X"
            , 20:"XX"
            , 30:"XXX"
            , 40:"XL"
            , 50:"L"
            , 90:"XC"
            , 100:"C"
            , 200:"CC"
            , 300:"CCC"
            , 400:"CD"
            , 500:"D"
            , 600:"DC"
            , 700:"DCC"
            , 800:"DCCC"
            , 900:"CM"
            , 1000:"M"
            , 2000:"MM"
            , 3000:"MMM"
       ]
    
    private var thousandsNumeral: String
    private var hundredsNumeral:  String
    private var tensNumeral:      String
    private var onesNumeral:      String
    
    init(number: Int) {
        let thousands = (number / 1000) * 1000
        let hundreds  = (number / 100)  * 100  - thousands
        let tens      = (number / 10)   * 10   - thousands - hundreds
        let ones      = (number - thousands    - hundreds  - tens)
        
        self.thousandsNumeral = numToRomDict[thousands]!
        self.hundredsNumeral  = numToRomDict[hundreds]!
        self.tensNumeral      = numToRomDict[tens]!
        self.onesNumeral      = numToRomDict[ones]!
    }
    
}

let romanNumeral = RomanNumeral(number: 2014)
print(romanNumeral)
// 2014 as MMXIV, the year of the games of the XXII (22nd) Olympic Winter Games (in Sochi) - Wikipedia

