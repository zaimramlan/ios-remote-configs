//
//  RemoteConfigurationWorker.swift
//  RemoteConfigs
//
//  Created by Zaim Ramlan on 29/04/2018.
//  Copyright © 2018 ZaimRamlan. All rights reserved.
//

import Foundation
import Firebase

class RemoteConfigurationWorker {
  
  // MARK: Singleton
  
  static var sharedInstance = RemoteConfigurationWorker()
  private init(){}
  
  // MARK: Config Keys
  
  enum Keys {
    static let questionOfTheDay = "question_of_the_day"
    static let answerOfTheDay = "answer_of_the_day"
  }
  
  // MARK: Properties
  
  var remoteConfig: RemoteConfig?
  var remoteConfigSettings: RemoteConfigSettings?
  var defaultRemoteConfigFile = "DefaultRemoteConfigValues"
  
  // MARK: Main Functions
  
  func setup() {
    FirebaseApp.configure()
    
    remoteConfig = RemoteConfig.remoteConfig()
    remoteConfigSettings = RemoteConfigSettings(developerModeEnabled: false)

    if let settings = remoteConfigSettings { remoteConfig?.configSettings = settings }
    remoteConfig?.setDefaults(fromPlist: defaultRemoteConfigFile)
  }
}
