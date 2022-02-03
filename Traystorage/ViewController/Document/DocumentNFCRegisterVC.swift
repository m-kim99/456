import CoreNFC
import UIKit

class DocumentNFCRegisterVC: BaseVC, NFCNDEFReaderSessionDelegate {
    var session: NFCNDEFReaderSession?
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.startNFCScan()
        }
    }

    func startNFCScan() {
        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        session?.begin()
    }

    @IBAction func onClickCacnel(_ sender: Any) {
        popVC()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let string = String(data: record.payload, encoding: .ascii) {
                    print(string)
                }
            }
        }
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        if tags.count > 1 {
            // Restart polling in 500 milliseconds.
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "More than 1 tag is detected. Please remove all tags and try again."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval) {
                session.restartPolling()
            }
            return
        }

        // Connect to the found tag and write an NDEF message to it.
        let tag = tags.first!
        session.connect(to: tag, completionHandler: { (error: Error?) in
            if error != nil {
                session.alertMessage = "Unable to connect to tag."
                session.invalidate()
                return
            }

            tag.queryNDEFStatus(completionHandler: { (ndefStatus: NFCNDEFStatus, _: Int, error: Error?) in
                guard error == nil else {
                    session.alertMessage = "Unable to query the NDEF status of tag."
                    session.invalidate()
                    return
                }

                switch ndefStatus {
                case .notSupported:
                    session.alertMessage = "Tag is not NDEF compliant."
                    session.invalidate()
                case .readOnly:
                    session.alertMessage = "Tag is read only."
                    session.invalidate()
                case .readWrite:
                    let date = Date()
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: date)
                    let minutes = calendar.component(.minute, from: date)
                    let year = calendar.component(.year, from: date)
                    let month = calendar.component(.month, from: date)
                    let day = calendar.component(.day, from: date)
                    let currentTime = String(format: "%d-%d-%d %d:%d", year, month, day, hour, minutes)
//                    let message = NFCNDEFMessage(data: currentTime.data(using: .utf8)!)
//                    var message: NFCNDEFMessage = .init(records: [])

                    let uriPayloadFromString = NFCNDEFPayload.wellKnownTypeURIPayload(
                        string: "https://twitter.com/HeyDaveTheDev" // dim link
                    )!
                    let uriPayloadFromURL = NFCNDEFPayload.wellKnownTypeURIPayload(
                        url: URL(string: "www.apple.com")! // dim link
                    )!

                    // 2
                    let textPayload = NFCNDEFPayload.wellKnownTypeTextPayload(
                        string: currentTime,
                        locale: Locale(identifier: "en")
                    )!

                    // 3
                    let customTextPayload = NFCNDEFPayload(
                        format: .nfcWellKnown,
                        type: "T".data(using: .utf8)!,
                        identifier: Data(),
                        payload: currentTime.data(using: .utf8)!
                    )
                    let message = NFCNDEFMessage(
                        records: [
                            uriPayloadFromString,
                            uriPayloadFromURL,
                            textPayload,
                            customTextPayload
                        ]
                    )
                    tag.writeNDEF(message, completionHandler: { (error: Error?) in
                        if error != nil {
                            session.alertMessage = "Write NDEF message fail: \(error!)"
                        } else {
                            session.alertMessage = "NFC태그에 문서가 등록되었습니다."
                        }
                        session.invalidate()
                    })
                @unknown default:
                    session.alertMessage = "Unknown NDEF tag status."
                    session.invalidate()
                }
            })
        })
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
}
