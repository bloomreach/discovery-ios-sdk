//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//

import Foundation

class RetryStrategy {
        private let DEFAULT_RETRIES = 3
        private let DEFAULT_WAIT_TIME_IN_MILLI: Int = 1000

        private var numberOfRetries = 3
        private var numberOfTriesLeft = 3
        private var timeToWait: Int = 1000
    
 
       //true if there are tries left
        func shouldRetry() ->  Bool {
            return numberOfTriesLeft > 0
        }
}
