import Foundation

class UpdateMenu: CCLayout {
    weak var magnetPrice: CCLabelTTF!
    weak var magnetTier: CCLabelTTF!
    weak var magnetUpgrade1: CCLabelTTF!
    weak var magnetUpgrade2: CCLabelTTF!
    weak var magnetUpgrade3: CCLabelTTF!
    weak var magnetUpgrade4: CCLabelTTF!
    weak var magnetUpgrade5: CCLabelTTF!
    weak var armorPrice: CCLabelTTF!
    weak var armorTier: CCLabelTTF!
    weak var armorUpgrade1: CCLabelTTF!
    weak var armorUpgrade2: CCLabelTTF!
    weak var armorUpgrade3: CCLabelTTF!
    weak var armorUpgrade4: CCLabelTTF!
    weak var armorUpgrade5: CCLabelTTF!
    weak var starPrice: CCLabelTTF!
    weak var starTier: CCLabelTTF!
    weak var starUpgrade1: CCLabelTTF!
    weak var starUpgrade2: CCLabelTTF!
    weak var starUpgrade3: CCLabelTTF!
    weak var starUpgrade4: CCLabelTTF!
    weak var starUpgrade5: CCLabelTTF!
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
    var mUpgradeColor: Int = 0 {
        didSet {
            if defaults.integerForKey("mUpgradeColor")  > oldValue {
                mUpgradeColor = defaults.integerForKey("mUpgradeColor")
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
    var aUpgradeColor: Int = 0 {
        didSet {
            if defaults.integerForKey("aUpgradeColor")  > oldValue {
                aUpgradeColor = defaults.integerForKey("aUpgradeColor")
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
    var sPrice: Int = 0 {
        didSet {
            if defaults.integerForKey("starPrice") > oldValue {
                sPrice = defaults.integerForKey("starPrice")
            }
        }
    }
    var sTier: Int = 0 {
        didSet {
            if defaults.integerForKey("starTier") > oldValue {
                sTier = defaults.integerForKey("starTier")
            }
        }
    }
    var sUpgradeColor: Int = 0 {
        didSet {
            if defaults.integerForKey("sUpgradeColor")  > oldValue {
                sUpgradeColor = defaults.integerForKey("sUpgradeColor")
            }
        }
    }
    var sDone: Bool = false {
        didSet {
            if defaults.boolForKey("sDone") != oldValue {
                sDone = defaults.boolForKey("sDone")
            }
        }
    }
    
    override init() {
        self.totalCoins = defaults.integerForKey("totalCoins")
    }
    
    func didLoadFromCCB() {
        upgradeColor()
        
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
        
        sDone = false
        if sDone == false {
            sPrice = 250
            sTier = 1
            starPrice.string = "\(sPrice)"
            starTier.string = "\(sTier)"
        } else {
            starPrice.string = "-----"
            starTier.string = "*"
        }
    }
    
    override func update(delta: CCTime) {
        upgradeColor()
    }
    
    func upgradeColor() {
        mUpgradeColor = 0
        if mUpgradeColor == 1 {
            magnetUpgrade1.color = CCColor.yellowColor()
        } else if mUpgradeColor == 2 {
            magnetUpgrade1.color = CCColor.yellowColor()
            magnetUpgrade2.color = CCColor.yellowColor()
        } else if mUpgradeColor == 3 {
            magnetUpgrade1.color = CCColor.yellowColor()
            magnetUpgrade2.color = CCColor.yellowColor()
            magnetUpgrade3.color = CCColor.yellowColor()
        } else if mUpgradeColor == 4 {
            magnetUpgrade1.color = CCColor.yellowColor()
            magnetUpgrade2.color = CCColor.yellowColor()
            magnetUpgrade3.color = CCColor.yellowColor()
            magnetUpgrade4.color = CCColor.yellowColor()
        } else if mUpgradeColor == 5 {
            magnetUpgrade1.color = CCColor.yellowColor()
            magnetUpgrade2.color = CCColor.yellowColor()
            magnetUpgrade3.color = CCColor.yellowColor()
            magnetUpgrade4.color = CCColor.yellowColor()
            magnetUpgrade5.color = CCColor.yellowColor()
        }
        
        aUpgradeColor = 0
        if aUpgradeColor == 1 {
            armorUpgrade1.color = CCColor.yellowColor()
        } else if aUpgradeColor == 2 {
            armorUpgrade1.color = CCColor.yellowColor()
            armorUpgrade2.color = CCColor.yellowColor()
        } else if aUpgradeColor == 3 {
            armorUpgrade1.color = CCColor.yellowColor()
            armorUpgrade2.color = CCColor.yellowColor()
            armorUpgrade3.color = CCColor.yellowColor()
        } else if aUpgradeColor == 4 {
            armorUpgrade1.color = CCColor.yellowColor()
            armorUpgrade2.color = CCColor.yellowColor()
            armorUpgrade3.color = CCColor.yellowColor()
            armorUpgrade4.color = CCColor.yellowColor()
        } else if aUpgradeColor == 5 {
            armorUpgrade1.color = CCColor.yellowColor()
            armorUpgrade2.color = CCColor.yellowColor()
            armorUpgrade3.color = CCColor.yellowColor()
            armorUpgrade4.color = CCColor.yellowColor()
            armorUpgrade5.color = CCColor.yellowColor()
        }
        
        sUpgradeColor = 0
        if sUpgradeColor == 1 {
            starUpgrade1.color = CCColor.yellowColor()
        } else if sUpgradeColor == 2 {
            starUpgrade1.color = CCColor.yellowColor()
            starUpgrade2.color = CCColor.yellowColor()
        } else if sUpgradeColor == 3 {
            starUpgrade1.color = CCColor.yellowColor()
            starUpgrade2.color = CCColor.yellowColor()
            starUpgrade3.color = CCColor.yellowColor()
        } else if sUpgradeColor == 4 {
            starUpgrade1.color = CCColor.yellowColor()
            starUpgrade2.color = CCColor.yellowColor()
            starUpgrade3.color = CCColor.yellowColor()
            starUpgrade4.color = CCColor.yellowColor()
        } else if sUpgradeColor == 5 {
            starUpgrade1.color = CCColor.yellowColor()
            starUpgrade2.color = CCColor.yellowColor()
            starUpgrade3.color = CCColor.yellowColor()
            starUpgrade4.color = CCColor.yellowColor()
            starUpgrade5.color = CCColor.yellowColor()
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
            defaults.setInteger(1, forKey: "mUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(6.5, forKey: "magnetSpeed")
        } else if totalCoins >= mPrice  && mTier == 2 {
            mPrice = 750
            magnetPrice.string = "\(mPrice)"
            mTier++
            magnetTier.string = "\(mTier)"
            totalCoins = totalCoins - 500
            defaults.setInteger(mPrice, forKey: "magnetPrice")
            defaults.setInteger(mTier, forKey: "magnetTier")
            defaults.setInteger(2, forKey: "mUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(15.0, forKey: "magnetDuration")
        } else if totalCoins >= mPrice  && mTier == 3 {
            mPrice = 1000
            magnetPrice.string = "\(mPrice)"
            mTier++
            magnetTier.string = "\(mTier)"
            totalCoins = totalCoins - 750
            defaults.setInteger(mPrice, forKey: "magnetPrice")
            defaults.setInteger(mTier, forKey: "magnetTier")
            defaults.setInteger(3, forKey: "mUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(10.0, forKey: "magnetSpeed")
        } else if totalCoins >= mPrice  && mTier == 4 {
            mPrice = 1500
            magnetPrice.string = "\(mPrice)"
            mTier++
            magnetTier.string = "\(mTier)"
            totalCoins = totalCoins - 1000
            defaults.setInteger(mPrice, forKey: "magnetPrice")
            defaults.setInteger(mTier, forKey: "magnetTier")
            defaults.setInteger(4, forKey: "mUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(20.0, forKey: "magnetDuration")
        } else if totalCoins >= mPrice  && mTier == 5 {
            magnetPrice.string = "-----"
            mUpgradeColor = 5
            mTier++
            magnetTier.string = "*"
            totalCoins = totalCoins - 1500
            defaults.setInteger(5, forKey: "mUpgradeColor")
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
            defaults.setInteger(1, forKey: "aUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(15.0, forKey: "armorDuration")
        } else if totalCoins >= aPrice  && aTier == 2 {
            aPrice = 750
            armorPrice.string = "\(aPrice)"
            aTier++
            armorTier.string = "\(aTier)"
            totalCoins = totalCoins - 500
            defaults.setInteger(aPrice, forKey: "armorPrice")
            defaults.setInteger(aTier, forKey: "armorTier")
            defaults.setInteger(2, forKey: "aUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(1.5, forKey: "armorPenalty")
        } else if totalCoins >= aPrice  && aTier == 3 {
            aPrice = 1000
            armorPrice.string = "\(aPrice)"
            aTier++
            armorTier.string = "\(aTier)"
            totalCoins = totalCoins - 750
            defaults.setInteger(aPrice, forKey: "armorPrice")
            defaults.setInteger(aTier, forKey: "armorTier")
            defaults.setInteger(3, forKey: "aUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(20.0, forKey: "armorDuration")
        } else if totalCoins >= aPrice  && aTier == 4 {
            aPrice = 1500
            armorPrice.string = "\(aPrice)"
            aTier++
            armorTier.string = "\(aTier)"
            totalCoins = totalCoins - 1000
            defaults.setInteger(aPrice, forKey: "armorPrice")
            defaults.setInteger(aTier, forKey: "armorTier")
            defaults.setInteger(4, forKey: "aUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(1.25, forKey: "armorPenalty")
        } else if totalCoins >= aPrice  && aTier == 5 {
            armorPrice.string = "-----"
            aTier++
            armorTier.string = "*"
            totalCoins = totalCoins - 1500
            defaults.setInteger(5, forKey: "aUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setBool(true, forKey: "obstacleCoin")
            defaults.setBool(true, forKey: "aDone")
        }
    }
    
    func upgradeStar() {
        if totalCoins >= sPrice  && sTier == 1 {
            sPrice = 500
            starPrice.string = "\(sPrice)"
            sTier++
            starTier.string = "\(sTier)"
            totalCoins = totalCoins - 250
            defaults.setInteger(sPrice, forKey: "starPrice")
            defaults.setInteger(sTier, forKey: "starTier")
            defaults.setInteger(1, forKey: "sUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(15.0, forKey: "starDuration")
        } else if totalCoins >= sPrice  && sTier == 2 {
            sPrice = 750
            starPrice.string = "\(sPrice)"
            sTier++
            starTier.string = "\(sTier)"
            totalCoins = totalCoins - 500
            defaults.setInteger(sPrice, forKey: "starPrice")
            defaults.setInteger(sTier, forKey: "starTier")
            defaults.setInteger(2, forKey: "sUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(3.0, forKey: "starBoost")
        } else if totalCoins >= sPrice  && sTier == 3 {
            sPrice = 1000
            starPrice.string = "\(sPrice)"
            sTier++
            starTier.string = "\(sTier)"
            totalCoins = totalCoins - 750
            defaults.setInteger(sPrice, forKey: "starPrice")
            defaults.setInteger(sTier, forKey: "starTier")
            defaults.setInteger(3, forKey: "sUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(20.0, forKey: "starDuration")
        } else if totalCoins >= sPrice  && sTier == 4 {
            sPrice = 1500
            starPrice.string = "\(sPrice)"
            sTier++
            starTier.string = "\(sTier)"
            totalCoins = totalCoins - 1000
            defaults.setInteger(sPrice, forKey: "starPrice")
            defaults.setInteger(sTier, forKey: "starTier")
            defaults.setInteger(4, forKey: "sUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setDouble(4.0, forKey: "starBoost")
        } else if totalCoins >= sPrice  && sTier == 5 {
            starPrice.string = "-----"
            sTier++
            starTier.string = "*"
            totalCoins = totalCoins - 1500
            defaults.setInteger(5, forKey: "sUpgradeColor")
            defaults.setInteger(totalCoins, forKey: "totalCoins")
            defaults.setBool(true, forKey: "starCoins")
            defaults.setBool(true, forKey: "sDone")
        }
    }
}