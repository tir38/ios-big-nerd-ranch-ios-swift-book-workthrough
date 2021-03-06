import Foundation

class Item: NSObject {

    static let nouns = [
        "Necromancer",
        "Harbinger",
        "Bane",
        "Clash",
        "Assault",
        "Battle",
        "Attack",
        "War",
        "Siege",
        "Unicorn"
    ]
    
    static let adjectives = [
        "the Nil",
        "Snaggletooth",
        "Dark Hill",
        "The Coders",
        "Advisors",
        "Allies",
        "Ancients",
        "Attrition",
        "Bad Omen",
        "Beliefs",
        "Bent Truths",
        "Betrayal",
        "Blind Justice",
        "Bloodthirst",
        "Bows",
        "Broken Bones",
        "Broken Dreams",
        "Broken Homes",
        "Broken Laws",
        "Broken Love",
        "Broken Minds",
        "Broken Mountains",
        "Broken Pacts",
        "Broken Wills",
        "Brothers",
        "Burning Fields",
        "Burning Lands",
        "Burning Plains",
        "Camouflage",
        "Chemistry",
        "Chiefs",
        "Corrupted Lands",
        "Corrupted Minds",
        "Courage",
        "Covert Actions",
        "Cowards",
        "Craftsmen",
        "Death's Fall",
        "Death's Rise",
        "Deception",
        "Delirium",
        "Devotion",
        "Dictators",
        "Differences",
        "Dishonesty",
        "Equality",
        "Eternal Bombardments",
        "Eternal Fires",
        "Eternal Hunger",
        "Eternal Regrets",
        "Eternal Suffering",
        "Executioners",
        "Exploding Mountains",
        "Faiths",
        "Fallen Angels",
        "False Promises",
        "False Prophets",
        "Fear",
        "Final Rests",
        "Fools",
        "Freedom",
        "Frozen Fires",
        "Frozen Lakes",
        "Glimmering Hope",
        "Glorious Conquests",
        "Gold",
        "Hallow Hill",
        "Heaven",
        "Heroes",
        "High Tide",
        "Horrors",
        "Ignorance",
        "Imbalance",
        "Impending Doom",
        "Independence",
        "Insanity",
        "Integrity",
        "Iron",
        "Ivory",
        "Justice",
        "Kings Betrayal",
        "Kings Glory",
        "Kings Hill",
        "Kings Mountain",
        "Last Resorts",
        "Last Rites",
        "Liberty",
        "Lost Brothers",
        "Lost Faiths",
        "Lost Friends",
        "Lost Security",
        "Lost Sons",
        "Lost Souls",
        "Loyalties",
        "Mad Bulls",
        "Mad Kings",
        "Mad Minds",
        "Maidens",
        "Mercy",
        "Naive Trust",
        "Nature",
        "Nature's Protectors",
        "New Allies",
        "New Hope",
        "New Orphans",
        "Nightmares",
        "Open Seas",
        "Pawns",
        "Pests",
        "Plagued Fires",
        "Poisoned Crops",
        "Poisoned Minds",
        "Purification",
        "Rats",
        "Red Waters",
        "Regrets",
        "Resources",
        "Scimitars",
        "Secrets",
        "Silence",
        "Smoking Homes",
        "Sons",
        "Spears",
        "Spies",
        "Starvation",
        "Steel",
        "Storms",
        "Strong Desires",
        "Tenacity",
        "Terror",
        "Titans",
        "Total Destruction",
        "Total Domination",
        "Treason",
        "Tribulation",
        "Trust",
        "Truth",
        "Tycoons",
        "Tyrants",
        "Unforseen Victory",
        "Unsung Heroes",
        "Utopia",
        "Vengeance",
        "Vile Actions",
        "White Mountain",
        "Widow Makers",
        "Widows",
        "Wits",
        "the Ancestors",
        "the Apocalypse",
        "the Atlantic",
        "the Betrayed",
        "the Black Scar",
        "the Blood River",
        "the Broken Mountain",
        "the Burning Forest",
        "the Burning Sea",
        "the Chanceless",
        "the Curse",
        "the Dark",
        "the Dead Sea",
        "the Dieing Forest",
        "the Drained Sea",
        "the Dry Sea",
        "the Dunes",
        "the Eclipse",
        "the Endless Storm",
        "the Eternal Day",
        "the Eternal Night",
        "the Falling Sky",
        "the False King",
        "the False Prophet",
        "the Fiery Lake",
        "the Frozen Harbor",
        "the Frozen Ocean",
        "the High Seas",
        "the Homeless",
        "the Infested",
        "the Last Stand",
        "the Light",
        "the Molten Mountain",
        "the Night",
        "the Nomads",
        "the Oppressor",
        "the Peaks",
        "the People",
        "the Plague",
        "the Planet",
        "the Rebellion",
        "the Red Mountain",
        "the Retreating Ocean",
        "the Righteous",
        "the Risen",
        "the River Bank",
        "the Scorching Lands",
        "the Scourge",
        "the Shores",
        "the Towers",
        "the True King",
        "the True Prophet",
        "the Void",
    ]
    
    private static let NameKey = "name"
    private static let DateKey = "date"
    private static let ItemKeyKey = "itemKey"
    private static let SerialNumberKey = "serialNumber"
    private static let ValueInDollarsKey = "valueInDollars"
    
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: NSDate
    let itemKey: String
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().UUIDString
        
        super.init()
    }
    
    convenience init(random: Bool) {
        if random {
            var idx = arc4random_uniform(UInt32(Item.adjectives.count))
            let randomAdjective = Item.adjectives[Int(idx)]
            idx = arc4random_uniform(UInt32(Item.nouns.count))
            let randomNoun = Item.nouns[Int(idx)]
            let randomName = "\(randomNoun) of \(randomAdjective)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().UUIDString
            
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
        }
            else {
            self.init(name: "Item", serialNumber: "", valueInDollars: 0)
        }
    }
    
    // MARK: NSCoding implementation
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(name, forKey: Item.NameKey)
        aCoder.encodeObject(dateCreated, forKey: Item.DateKey)
        aCoder.encodeObject(itemKey, forKey: Item.ItemKeyKey)
        
        if let serialNumber = serialNumber {
            aCoder.encodeObject(serialNumber, forKey: Item.SerialNumberKey)
        }
        
        aCoder.encodeInteger(valueInDollars, forKey: Item.ValueInDollarsKey)
    }
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(Item.NameKey) as! String
        dateCreated = aDecoder.decodeObjectForKey(Item.DateKey) as! NSDate
        itemKey = aDecoder.decodeObjectForKey(Item.ItemKeyKey) as! String
        serialNumber = aDecoder.decodeObjectForKey(Item.SerialNumberKey) as! String?
        
        valueInDollars = aDecoder.decodeIntegerForKey(Item.ValueInDollarsKey)
        
        super.init()
    }
}