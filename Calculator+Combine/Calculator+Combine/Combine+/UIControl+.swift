//
//  UIControl+.swift
//  Calculator+Combine
//
//  Created by 김도연 on 2022/06/12.
//

import UIKit
import Combine

extension UIControl {
    func controlPublisher(for event: UIControl.Event) -> UIControl.EventPublisher {
        return UIControl.EventPublisher(control: self, event: event)
    }
    
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never
        
        let control: UIControl
        let event: UIControl.Event
        
        func receive<S>(subscriber: S) where S : Subscriber, S.Failure == Never, S.Input == UIControl {
            let subscription = EventSubscription(control: control, event: event, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
    
    final class EventSubscription<EventSubsriber: Subscriber>: Subscription where EventSubsriber.Input == UIControl, EventSubsriber.Failure == Never {
        
        let control: UIControl
        let event: UIControl.Event
        var subscriber: EventSubsriber?
        
        init(control: UIControl, event: UIControl.Event, subscriber: EventSubsriber) {
            self.control = control
            self.event = event
            self.subscriber = subscriber
            
            control.addTarget(self, action: #selector(eventDidOccur), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {
            // empty
        }
        
        func cancel() {
            subscriber = nil
            control.removeTarget(self, action: #selector(eventDidOccur), for: event)
        }
        
        @objc
        private func eventDidOccur() {
            _ = subscriber?.receive(control)
        }
        
    }
}
