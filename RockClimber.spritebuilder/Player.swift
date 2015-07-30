import Foundation

class Player: CCSprite {
    func defaultClimber() {
        self.animationManager.runAnimationsForSequenceNamed("Default Climber")
    }
    
    func magnetPowerUp() {
        self.animationManager.runAnimationsForSequenceNamed("Magnet Climber")
    }
    
    func magnetRunningOut() {
        self.animationManager.runAnimationsForSequenceNamed("Magnet Climber Running Out")
    }
    
    func armorPowerUp() {
        self.animationManager.runAnimationsForSequenceNamed("Armor Climber")
    }
    
    func armorRunningOut() {
        self.animationManager.runAnimationsForSequenceNamed("Armor Climber Running Out")
    }
    
    func goldenPowerUp() {
        self.animationManager.runAnimationsForSequenceNamed("Golden Climber")
    }
    
    func goldenRunningOut() {
        self.animationManager.runAnimationsForSequenceNamed("Golden Climber Running Out")
    }
}