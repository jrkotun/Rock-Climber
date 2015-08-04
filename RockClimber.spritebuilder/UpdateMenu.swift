import Foundation

class UpdateMenu: CCLayout {
    weak var magnetPrice: CCLabelTTF!
    weak var magnetTier: CCLabelTTF!
    weak var armorPrice: CCLabelTTF!
    weak var armorTier: CCLabelTTF!
    let defaults = NSUserDefaults.standardUserDefaults()
    var totalCoins: Int
    var mPrice: Int = 0 {
        didSet {
            if defaults.integerForKey("magnetPrice") > oldValue {
                mPrice = defaults.integerForKey("magnetPrice")
            }
        }
    }
    var mTier: Int = 0 {
        didSet {
            if defaults.integerForKey("magnetTier") > oldValue {
                mTier = defaults.integerForKey("magnetTier")
            }
        }
    }
    var mDone: Bool = false {
        didSet {
            if defaults.boolForKey("mDone") != oldValue {
                mDone = defaults.boolForKey("mDone")
            }
        }
    }
    var aPrice: Int = 0 {
        didSet {
            if defaults.integerForKey("armorPrice") > oldValue {
                aPrice = defaults.integerForKey("armorPrice")
            }
        }
    }
    var aTier: Int = 0 {
        didSet {
            if defaults.integerForKey("armorTier") > oldValue {
                aTier = defaults.integerForKey("armorTier")
            }
        }
    }
    var aDone: Bool = false {
        didSet {
            if defaults.boolForKey("aDone") != oldValue {
                mDone = defaults.boolForKey("aDone")
            }
        }
    }
    
    override init() {
        self.totalCoins = defaults.integerForKey("totalCoins")
    }
    
    func didLoadFromCCB() {
        mDone = false
        if mDone == false {
            mPrice = 250
            mTier = 1
            magnetPrice.string = "\(mPrice)"
            magnetTier.string = "\(mTier)"
        } else {
            magnetPrice.string = "-----"
            magnetTier.string = "*"
        }
        
        aDone = false
        if aDone == false {
            aPrice = 250
            aTier = 1
            armorPrice.string = "\(aPrice)"
            armorTier.string = "\(aTier)"
        } else {
            armorPrice.string = "-----"
            armorTier.string = "*"
        }
    }
    
    func upgradeMagnet() {
        if totalCoins >= mPrice  && mTier == 1 {
            mPrice = 500
            magnetPrice.string = "\(mPrice)"
            mTier++
            magnetTier.string = "\(mTier)"
            totalCoins = totalCoins - 250
            defaults.setInteger(mPrice, forKey: "magnetPrice")
            defaults.setInteger(mTier, forKey: "magnetTier")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(6.5, forKey: "magnetSpeed")
        } else if totalCoins >= mPrice  && mTier == 2 {
            mPrice = 1000
            magnetPrice.string = "\(mPrice)"
            mTier++
            magnetTier.string = "\(mTier)"
            totalCoins = totalCoins - 500
            defaults.setInteger(mPrice, forKey: "magnetPrice")
            defaults.setInteger(mTier, forKey: "magnetTier")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(15.0, forKey: "magnetDuration")
        } else if totalCoins >= mPrice  && mTier == 3 {
            mPrice = 1500
            magnetPrice.string = "\(mPrice)"
            mTier++
            magnetTier.string = "\(mTier)"
            totalCoins = totalCoins - 1000
            defaults.setInteger(mPrice, forKey: "magnetPrice")
            defaults.setInteger(mTier, forKey: "magnetTier")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(10.0, forKey: "magnetSpeed")
        } else if totalCoins >= mPrice  && mTier == 4 {
            mPrice = 2000
            magnetPrice.string = "\(mPrice)"
            mTier++
            magnetTier.string = "\(mTier)"
            totalCoins = totalCoins - 1500
            defaults.setInteger(mPrice, forKey: "magnetPrice")
            defaults.setInteger(mTier, forKey: "magnetTier")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(20.0, forKey: "magnetDuration")
        } else if totalCoins >= mPrice  && mTier == 5 {
            magnetPrice.string = "-----"
            mTier++
            magnetTier.string = "*"
            totalCoins = totalCoins - 2000
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setInteger(1, forKey: "magnetCoinModifier")
            defaults.setBool(true, forKey: "mDone")
        }
    }
    
    func upgradeArmor() {
        if totalCoins >= aPrice  && aTier == 1 {
            aPrice = 500
            armorPrice.string = "\(aPrice)"
            aTier++
            armorTier.string = "\(aTier)"
            totalCoins = totalCoins - 250
            defaults.setInteger(aPrice, forKey: "armorPrice")
            defaults.setInteger(aTier, forKey: "armorTier")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(15.0, forKey: "armorDuration")
        } else if totalCoins >= aPrice  && aTier == 2 {
            aPrice = 1000
            armorPrice.string = "\(aPrice)"
            aTier++
            armorTier.string = "\(aTier)"
            totalCoins = totalCoins - 500
            defaults.setInteger(aPrice, forKey: "armorPrice")
            defaults.setInteger(aTier, forKey: "armorTier")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(1.5, forKey: "armorPenalty")
        } else if totalCoins >= aPrice  && aTier == 3 {
            aPrice = 1500
            armorPrice.string = "\(aPrice)"
            aTier++
            armorTier.string = "\(aTier)"
            totalCoins = totalCoins - 1000
            defaults.setInteger(aPrice, forKey: "armorPrice")
            defaults.setInteger(aTier, forKey: "armorTier")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(20.0, forKey: "armorDuration")
        } else if totalCoins >= aPrice  && aTier == 4 {
            aPrice = 2000
            armorPrice.string = "\(aPrice)"
            aTier++
            magnetTier.string = "\(aTier)"
            totalCoins = totalCoins - 1500
            defaults.setInteger(aPrice, forKey: "armorPrice")
            defaults.setInteger(aTier, forKey: "armorTier")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(1.25, forKey: "armorPenalty")
        } else if totalCoins >= aPrice  && aTier == 5 {
            armorPrice.string = "-----"
            aTier++
            armorTier.string = "*"
            totalCoins = totalCoins - 2000
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setBool(true, forKey: "aDone")
        }
    }
}