//
//  ChatViewController.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 04.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit
import Firebase
import  FirebaseDatabase
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {

    
    var messages = [JSQMessage]()
    
    var idZakaza = ""
    var managerName = ""
    var myName = ""
    let userId = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    
    let databaseRoot = Database.database().reference()
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()

    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //document![i].documentID
        
//        db.collection("Deliveries").getDocuments { (snapshot, error) in
//            let document = snapshot?.documents
//            for i in 0...((snapshot?.documents.count)!-1){
//                if(document![i].data()["uid"] as! String == userId!){
//                    db.collection("Deliveries").document(self.id).updateData(["delivererId" : userId!,
//                    "delivererName": document![i].data()["name"] as! String,
//                    "inProcess": "inProcess"
//                    ])
//
//                    break
//                }
//            }
//        }
        
        
        
//        senderId = "1234"
//        senderDisplayName = "Khaled"
        
        let defaults = UserDefaults.standard
        
        if  let id = defaults.string(forKey: "jsq_id"),
            let name = defaults.string(forKey: "jsq_name")
        {
            //senderId = "567"
            //senderDisplayName = name
        }
        else
        {
            //senderId = String(arc4random_uniform(999999))
            //senderDisplayName = ""

            defaults.set(senderId, forKey: "jsq_id")
            defaults.synchronize()

            showDisplayNameDialog()
        }
        
        
        
        
        
        db.collection("Deliveries").document(idZakaza).getDocument { (document, error) in
//            self.myName = document?.data()!["delivererName"] as! String
//            self.managerName = document?.data()!["managerName"] as! String
            self.title = "Chat: \(document?.data()!["managerName"] as! String? ?? "idonno")"
        }
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDisplayNameDialog))
        tapGesture.numberOfTapsRequired = 1

        navigationController?.navigationBar.addGestureRecognizer(tapGesture)
        
        
        
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
//        let query = Constants.refs.databaseChats.queryLimited(toLast: 10)
        
        let query = databaseRoot.child("chats/\(idZakaza)").queryLimited(toLast: 50)

        _ = query.observe(.childAdded, with: { [weak self] snapshot in

            if  let data        = snapshot.value as? [String: String],
                let id          = data["sender_id"],
                let name        = data["name"],
                let text        = data["text"],
                !text.isEmpty
            {
                if let message = JSQMessage(senderId: id, displayName: name, text: text)
                    
                    
                {
                    self?.messages.append(message)

                    self?.finishReceivingMessage()
                }
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("pervii")
        db.collection("Deliveries").document(idZakaza).getDocument { (document, error) in
            
            self.senderId = document?.data()!["delivererId"] as! String
            self.senderDisplayName = document?.data()!["delivererName"] as! String
        }
        
//        db.collection("Deliveries").document(idZakaza).getDocument { (document, error) in
//            self.myName = document?.data()!["delivererName"] as! String
//            self.managerName = document?.data()!["managerName"] as! String
//            print("ehhhhh", document?.data()!["delivererName"] as! String)
//        }
    }
    
    @objc func showDisplayNameDialog()
    {
        let defaults = UserDefaults.standard

        let alert = UIAlertController(title: "Your Display Name", message: "Before you can chat, please choose a display name. Others will see this name when you send chat messages. You can change your display name again by tapping the navigation bar.", preferredStyle: .alert)

        alert.addTextField { textField in

            if let name = defaults.string(forKey: "jsq_name")
            {
                textField.text = name
            }
            else
            {
                let names = ["Ford", "Arthur", "Zaphod", "Trillian", "Slartibartfast", "Humma Kavula", "Deep Thought"]
                textField.text = names[Int(arc4random_uniform(UInt32(names.count)))]
            }
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak alert] _ in

            if let textField = alert?.textFields?[0], !textField.text!.isEmpty {

                self?.senderDisplayName = textField.text

                self?.title = "Chat: \(self!.senderDisplayName!)"

                defaults.set(textField.text, forKey: "jsq_name")
                defaults.synchronize()
            }
        }))

        present(alert, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        
        
        

//        db.collection("users").getDocuments { (snapshot, error) in
//            let document = snapshot?.documents
//            for i in 0...((snapshot?.documents.count)!-1){
//                if(document![i].data()["uid"] as! String == userId!){
//
//                }
//            }
//        }
//        let ref = Constants.refs.databaseChats.childByAutoId()
        
        let ref = self.databaseRoot.child("chats/\(idZakaza)").childByAutoId()
        
        
        var message:[String:String] = [:]
        
        
                db.collection("Deliveries").document(idZakaza).getDocument { (document, error) in
                    
                    
                    message = ["sender_id": document?.data()!["delivererId"] as! String, "name": document?.data()!["delivererName"] as! String, "text": text]
                    ref.setValue(message)
                }
        
//        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text]

//        ref.setValue(message)

        finishSendingMessage()
    }

    /*
    // MARK: - Navigon

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
