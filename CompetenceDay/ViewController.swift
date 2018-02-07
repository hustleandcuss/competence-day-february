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
    
    var score: Int = 0
    var highScore: Int = 0
    var previewLayer: CALayer!
    var timer : Timer!
    var remaningTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This function runs when the view loads
        // Here we need to set:
        // 1. The scoreLabel from the score Int
        // 2. Set the skipButton to disabled
        // 3. call cameraSetup
        // 4. The highscore using the highscore function
        // 5. Set the timeLabel to the remaning time
        
        // EXTRA - Change the appearens of the buttons when they are disabled
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setHighScore(score: Int) {
        // This method is used to update the highscore in the user key-value store (that persists between runs) if a player gets more points than the current highscore.
        // See https://developer.apple.com/documentation/foundation/userdefaults for more info on how to set and get values.
        
        // Here we need to:
        // 1. Set the score in the UserDefaults key-value store if the score is more than the highScore
    }
    
    func getHighScore() {
        // This method is used to get the current highscore from the user key-value store.
        
        // Here we need to:
        // 1. Get the value from the key-value store, if there is a value present, see https://developer.apple.com/documentation/foundation/userdefaults for more info on how to set and get values.
        // 2. Set the highscore from highscore fetched fro the key-value store (as Int).
        // 3. Set the highscoreLabel from the highscore
    }
    
    @IBAction func start() {
        // Is being called when the player press "start" and should start the game.
        
        // This creates a timer for the game play
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            guard self.remaningTime != 0 else {
                timer.invalidate()
                self.endGame()
                return
            }
            
            self.remaningTime -= 1
            self.timeLabel.text = "\(self.remaningTime)"
        })
        
        // Here we also need to:
        // 1. Disable the startButton
        // 2. Enable the skipButton
        // 3. Call nextObject
        
        // EXTRA: Implement some kind of times so that a round is for XX seconds, this can be done with Time.scheduledTime,
        // https://developer.apple.com/documentation/foundation/timer/2091889-scheduledtimer, end the game when the timer runs out,
        // also add a label to show how much time is remaining.
    }
    
    @IBAction func skip() {
        // Is being called when the player press "skip" and should skip to the object in the objekt-list.
        // Here we need to:
        // 1. Call nextObject
    }
    
    func nextObject() {
        // This function should choose a new random object from the object list.
        
        // First off:
        // 1. Create a new Swift-file called Object (or something suitable)
        // 2. Create a struct with the same name
        // 3. Create a list and populate it with name of objects that you want the player to find,
        // see https://gist.github.com/yrevar/942d3a0ac09ec9e5eb3a for a list of objects that should be detectable with Inception-V3
        
        // Here we should:
        // 1. Get the list of objects from the Object struct
        // 2. Get a random index from the object list, see https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man3/arc4random_uniform.3.html
        // 3. Check that the object on that index is not the same as the current object, if so, call the function again
        // 4. Set the objectLabel to the objects (at the random index) name/text
        // 5. Set the new score to the scoreLabel
    }
    
    func endGame() {
        // Should be called when the game ends thus when the timer runs out.
        
        // Here we need to:
        // 1. Enabel the startButton
        // 2. Disable the skipButton
        // 3. Set the objectLabel to 'Game Over' or something simular to indicate that the game is over
        // 4. Check if the score is more than the highscore and in that case, set the new highscore
        // 5. Reset the score to 0
        // 6. Call getHighScore
        
        // This resets the timer
        remaningTime = 60
        timeLabel.text = ("\(remaningTime)")
    }
    
    func predict(image: CGImage) {
        // This function is called from the AVCaptureVideoDataOutputSampleBufferDelegate extension
        // and is used to predict the images from the camera with the CoreMLModel.
        
        // Here we need to:
        // 1. Initiate the VNCoreMLModel
        // 2. Initiate a VNCoreMLRequest with the model and the completionHandler function
        // 3. Initiate a VNSequenceRequestHandler()
        // 4. Call the perfrom function on the handler
    }
    
    func completionHandler(request: VNRequest, error: Error?) { // The question mark means that this is an optional value
        // This is the function where we check if we get a match from our request
        
        // Here we should:
        // 1. Get the results (as VNClassificationObservation:s) from the request
        // 2. Check that the results isn't zero
        // 3. Get the result with the highest confidence (which should be the first)
        // 4. Get the identifier from the highest confidence result, OBS the identifier can be two words separated by a comma,
        // so to be sure check for that and do a string split if you only want to match on the first word.
        // 5. Check if the identifier equals the objectLabel text and if thats the case, add one point to the score and call nextObject
        
        // EXTRA: Play a sound to indicate that the player has scored, see https://developer.apple.com/documentation/audiotoolbox/1405248-audioservicesplaysystemsound
    }
    
    func cameraSetup() {
        // This function is FULLY IMPLEMENTED but read the comments to get a hang of what is happening, and feel free to make changes.
        // The function is for setting up the camera capturing.
        // To be able to run this function you need to run the app on a actual iPhone.
        
        // Create a AVCaputreSession, see https://developer.apple.com/documentation/avfoundation/avcapturesession
        let captureSession = AVCaptureSession()
        
        // Set the sessionPresent for photo this specifies the capture settings suitable for high resolution photo quality output
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        // Create a AVCaptureDevice, moste likely you would like the phones back camera for a game like this
        // See https://developer.apple.com/documentation/avfoundation/avcapturedevice for more information
        let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
        // The exclamation mark says that we "know" that this optional has a value, this will give a runtime error when we run it the simulator,
        // but will work just fine when run on an iPhone.
        
        // Get the input (AVCaptureDeviceInput) from the device, see https://developer.apple.com/documentation/avfoundation/avcapturedeviceinput
        let input = try! AVCaptureDeviceInput(device: captureDevice)
        // try! kind of says the we promise that the function won't throw, eventhough it's a throwing function, if the function does thow we will get an runtime error,
        // although if this fails our game is useless.. so.. lets keep it like this.
        // For more about error handling, see https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html
        
        // Add the AVCaptureInput to the AVCaptureSession
        captureSession.addInput(input)
        
        // Create a AVCaptureVideoPreviewLayer from the AVCaptureSession
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        // Add the AVCaptureVideoLayer as a sublayer to the view
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.bounds
        
        // Put the top and bottom views to the frot so it wont be covered by the camera view.
        view.bringSubview(toFront: topView)
        view.bringSubview(toFront: bottomView)
        
        // Initiate the AVCaptureVideoDataOutput
        let videoOutput = AVCaptureVideoDataOutput()
        
        // Set the SampleBufferDelegate on the video output
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "buffer delegate"))
        
        // Set the recommendend video settings on the video output to .jpg and .mp4
        videoOutput.recommendedVideoSettings(forVideoCodecType: .jpeg, assetWriterOutputFileType: .mp4)
        
        // Add the video output to the capture session
        captureSession.addOutput(videoOutput)
        
        // Set the capture session present to .high
        captureSession.sessionPreset = .high
        
        // Start running the capture session
        captureSession.startRunning()
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
            fatalError("cg image")
        }
        
        let uiImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: .leftMirrored)
        
        DispatchQueue.main.sync {
            predict(image: uiImage.cgImage!)
        }
    }
}

