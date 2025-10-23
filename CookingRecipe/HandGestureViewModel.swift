//
//  HandGestureViewModel.swift
//  CookingRecipe
//
//  Created by Jacob Wheeler on 10/23/25.
//

import SwiftUI
import Combine
import AVFoundation
import Vision

class HandGestureViewModel: NSObject, ObservableObject {
    private let captureSession = AVCaptureSession()
    private var handPoseRequest = VNDetectHumanHandPoseRequest()
    
    @Published var scrollDirection: String? 
    
    override init() {
        super.init()
        setupCamera()
    }
    
    private func setupCamera() {
        captureSession.sessionPreset = .medium
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .front),
              let input = try? AVCaptureDeviceInput(device: device)
        else { return }
        
        captureSession.addInput(input)
        
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "cameraQueue"))
        captureSession.addOutput(output)
        
        captureSession.startRunning()
    }
}

extension HandGestureViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .leftMirrored, options: [:])
        do {
            try handler.perform([handPoseRequest])
            guard let observation = handPoseRequest.results?.first else { return }
            
            let points = try observation.recognizedPoints(.all)
            if let wrist = points[.wrist], wrist.confidence > 0.5 {
                DispatchQueue.main.async {
                    if wrist.location.y > 0.7 {
                        self.scrollDirection = "up"
                    } else if wrist.location.y < 0.3 {
                        self.scrollDirection = "down"
                    } else {
                        self.scrollDirection = nil
                    }
                }
            }
        } catch {
            print("Vision error: \(error)")
        }
    }
}
