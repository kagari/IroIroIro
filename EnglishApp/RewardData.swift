import Foundation

// 報酬のデータを保持するクラス
class RewardData {
    private var reward: String?
    let userDefaults: UserDefaults
    
    init() {
        self.userDefaults = UserDefaults.standard
        self.reward = self.userDefaults.object(forKey: "Reward") as? String
    }
    
    // MARK: - setter, getter
    func setReward(reward: String?) {
        self.reward = reward
        self.userDefaults.set(reward, forKey: "Reward")
    }
    
    func getReward() -> String? {
        return self.reward
    }
}
