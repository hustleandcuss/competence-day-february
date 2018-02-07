//
//  ViewController.swift
//  CompetenceDay
//
//  Created by Olivia Lennerö on 2018-01-12.
//  Copyright © 2018 Olivia Lennerö. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var highScoreLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    @IBOutlet var objectLabel: UILabel!
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var timeLabel: UILabel!
    
    let systemSoundID: SystemSoundID = 1016
    var score: Int = 0
    var highScore: Int = 0
    var previewLayer: CALayer!
    var timer : Timer!
    var remaningTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This function runs when the view loads
        // Here we need to:
        // 1. Set the scoreLabel from the score Int
        scoreLabel.text = "\(score)"
        
        // 2. Set the skipButton to disabled
        skipButton.isEnabled = false
        
        // 3. Call cameraSetup
        cameraSetup()
        
        // 4. Get the highscore using the highscore function
        getHighScore()
        
        // Extra
        timeLabel.text = "\(remaningTime)"
        
        // Sets the text color to gray if any of the buttons is disabled
        skipButton.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
        startButton.setTitleColor(UIColor.lightGray, for: UIControlState.disabled)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setHighScore(score : Int) {
        // This method is used to update the highscore in the user key-value store (that persists between runs) if a player gets more points than the current highscore.
        // See https://developer.apple.com/documentation/foundation/userdefaults for more info on how to set and get values.
        
        // Here we need to:
        // 1. Set the score in the UserDefaults key-value store if the score is more than the highScore
        UserDefaults.standard.set(score, forKey: "highScore")
    }
    
    func getHighScore() {
        // This method is used to get the current highscore from the user key-value store.
        
        // Here we need to:
        // 1. Get the value from the key-value store, if there is a value present, see https://developer.apple.com/documentation/foundation/userdefaults for more info on how to set and get values.
        if let score = UserDefaults.standard.object(forKey: "highScore") {
            highScore = score as! Int
        } else {
            highScore = 0
            setHighScore(score: 0)
        }
        
        // 3. Set the highScoreLabel from the highScore
        highScoreLabel.text = "\(highScore)"
    }
    
    @IBAction func start() {
        // Is being called when the player press "start" and should start the game.
        
        // Here we need to:
        // EXTRA: Implement some kind of times so that a round is for XX seconds, this can be done with Time.scheduledTime,
        // https://developer.apple.com/documentation/foundation/timer/2091889-scheduledtimer, end the game when the timer runs out,
        // also add a label to show how much time is remaining.
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            print("In timer")
            guard self.remaningTime != 0 else {
                timer.invalidate()
                self.endGame()
                return
            }
            
            self.remaningTime -= 1
            self.timeLabel.text = "\(self.remaningTime)"
        })
        
        // 1. Disable the startButton
        startButton.isEnabled = false
        
        // 2. Enable the skipButton
        skipButton.isEnabled = true
        
        // 3. Call nextObject
        nextObject()
    }
    
    @IBAction func skip() {
        // Is being called when the player press "skip" and should skip to the object in the objekt-list.
        
        // Here we need to:
        // 1. Call nextObject
        nextObject()
    }
    
    func nextObject() {
        // This function should choose a new random object from the object list.
        
        // First off:
        // 1. Create a new Swift-file called Objects (or something suitable)
        // 2. Create a struct with the same name
        // 3. Create a list and populate it with name of objects that you want the player to find,
        // see https://gist.github.com/yrevar/942d3a0ac09ec9e5eb3a for a list of objects that should be detectable with Inception-V3
        
        // Here we should:
        // 1. Get the list of objects from the Object struct
        // 2. Get a random index from the object list, see https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man3/arc4random_uniform.3.html
        let objects = Objects().objects
        let index = Int(arc4random_uniform(UInt32(objects.count)))
        // 3. Check that the object on that index is not the same as the current object, if so, call the function again
        guard objectLabel.text != objects[index] else {
            nextObject()
            return
        }
        
        // 4. Set the objectLabel to the objects (at the random index) name/text
        objectLabel.text = objects[index]
        
        // 5. Set the new score to the scoreLabel and highScoreLabel
        scoreLabel.text = "\(score)"
        getHighScore()
    }
    
    // This function is only needed if you have a button or a timer that actually ends the game
    func endGame() {
        // Call from button
        // Should be called when the game ends. So when does the game end? Perhaps after a certain amount of time, or perhaps after reaching a certain score.
        // Here would also be a good place to set the new high score if the player got enough points.
        
        // Here we need to:
        // 1. Enabel the startButton
        startButton.isEnabled = true
        
        // 2. Disable the skipButton
        skipButton.isEnabled = false
        
        // 3. Set the objectLabel to 'Game Over' or something simular to indicate that the game is over
        objectLabel.text = "Game Over"
        
        // 4. Check if the score is more than the highscore and in that case, set the new highscore and remove the set highScore from the completionHandler
        if (score > highScore) {
            setHighScore(score: score)
        }
        
        // 5. Reset the score to 0
        score = 0
        
        // 6. Get new highscore
        getHighScore()
        // highScoreLabel.text = "\(highScore)"
        
        // EXTRA: If you have created a timer, you should also reset the remaning time here
        remaningTime = 60
        timeLabel.text = ("\(remaningTime)")
    }
    
    func cameraSetup() {
        // This function is FULLY IMPLEMENTED but read the comments to get a hang of what is happening, and feel free to make changes.
        // The function is for setting up the camera capturing.
        // To be able to run this function you need to run the app on a actual iPhone.
        
        // Here we need to:
        // 1. Create a AVCaputreSession, see https://developer.apple.com/documentation/avfoundation/avcapturesession
        let captureSession = AVCaptureSession()
        
        // 2. Set the sessionPresent for photo this specifies the capture settings suitable for high resolution photo quality output
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        // 3. Create a AVCaptureDevice, moste likely you would like the phones back camera for a game like this
        // See https://developer.apple.com/documentation/avfoundation/avcapturedevice for more information
        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
        // The exclamation mark says that we "know" that this optional has a value, this will give a runtime error when we run it the simulator,
        // but will work just fine when run on an iPhone.
        
        // 4. Get the input (AVCaptureDeviceInput) from the device, see https://developer.apple.com/documentation/avfoundation/avcapturedeviceinput
        let input = try! AVCaptureDeviceInput(device: captureDevice)
        // try! sort of says the we promise that the function won't throw, eventhough it's a throwing function, if the function does thow we will get an runtime error,
        // although if this fails our game is useless.. so.. lets keep it like this.
        // For more about error handling, see https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html
        
        // 5. Add the AVCaptureInput to the AVCaptureSession
        captureSession.addInput(input)
        
        // 6. Create a AVCaptureVideoPreviewLayer from the AVCaptureSession
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        // 7. Add the AVCaptureVideoLayer as a sublayer to the view
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.bounds
        
        // 8. Put the top and bottom views to the front so it wont be covered by the camera view.
        view.bringSubview(toFront: topView)
        view.bringSubview(toFront: bottomView)
        
        // 9. Initiate the AVCaptureVideoDataOutput
        let videoOutput = AVCaptureVideoDataOutput()
        
        // 10. Set the SampleBufferDelegate on the video output
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "buffer delegate"))
        
        // 11. Set the recommendend video settings on the video output to .jpg and .mp4
        videoOutput.recommendedVideoSettings(forVideoCodecType: .jpeg, assetWriterOutputFileType: .mp4)
        
        // 12. Add the video output to the capture session
        captureSession.addOutput(videoOutput)
        
        // 13. Set the capture session present to .high
        captureSession.sessionPreset = .high
        
        // 14. Start running the capture session
        captureSession.startRunning()
    }
    
    func predict(image: CGImage) {
        // This function is called from the AVCaptureVideoDataOutputSampleBufferDelegate extension
        // and is used to predict the images from the camera with the CoreMLModel.
        
        // Here we need to:
        // 1. Initiate the VNCoreMLModel
        let model = try? VNCoreMLModel(for: Inceptionv3().model)
        
        // 2. Initiate a VNCoreMLRequest with the model and the completionHandler function
        let request = VNCoreMLRequest(model: model!, completionHandler: completionHandler)
        
        // 3. Initiate a VNSequenceRequestHandler()
        let requestHandler = VNSequenceRequestHandler()
        
        // 4. Call the perfrom function on the handler
        try! requestHandler.perform([request], on: image)
    }
    
    func completionHandler(request: VNRequest, error: Error?) { // The question mark means that this is an optional value
        // This is the function where we check if we get a match from our request
        
        // Here we should:
        // 1. Get the results (as VNClassificationObservation:s) from the request
        guard let results = request.results as? [VNClassificationObservation] else {
            print("Didn't find any results.")
            return
        }
        
        // 2. Check that the results isn't zero
        guard results.count != 0 else {
            print("Didn't find any results.")
            return
        }
        
        // 3. Get the result with the highest confidence (which should be the first)
        let highestConfidenceResult = results.first!
        
        // 4. Get the identifier from the highest confidence result, OBS the identifier can be two words separated by a comma,
        // so to be sure check for that and do a string split if you only want to match on the first word.
        let identifier = highestConfidenceResult.identifier.contains(",") ? String(describing: highestConfidenceResult.identifier.split(separator: ",").first!) : highestConfidenceResult.identifier
        
        // 5. Check if the identifier equals the objectLabel text and if thats the case, add one point to the score and call nextObject
        if (identifier == objectLabel.text) {
            score += 1
            
            // EXTRA: Play a sound to indicate that the player has scored, see https://developer.apple.com/documentation/audiotoolbox/1405248-audioservicesplaysystemsound
            AudioServicesPlaySystemSound(systemSoundID)
            nextObject()
        }
    }
}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            fatalError("Pixel buffer is nil")
        }
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext(options: nil)
        
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            fatalError("Could not create CGImage")
        }
        
        let uiImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .leftMirrored)
        
        DispatchQueue.main.sync {
            predict(image: uiImage.cgImage!)
        }
    }
}

