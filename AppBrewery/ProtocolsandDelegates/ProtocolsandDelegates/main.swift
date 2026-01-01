protocol AdvancedLifeSupport {
    func performCPR()
}

class EmergencyCallHandler {
    var delegate: AdvancedLifeSupport?
    
    func assessSitutation()
    {
        print("Can you tell me what happen?")
    }
    
    func medicalEmergency()
    {
        delegate?.performCPR()
    }
}


struct Paramedic: AdvancedLifeSupport {
        
    /// The paramedic on call will pick up the pager
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("The paramedic does chest compressions, 30 per second.")
    }
}

class Doctor: AdvancedLifeSupport {
    init(handler: EmergencyCallHandler)
    {
        handler.delegate = self
    }
    
    func performCPR() {
        print("The doctor does chest compressions, 30 per second.")
    }
    
    func startDiagnostics() {
        print("The doctor starts doing diagnostics.")
    }
}

class Surgeon: Doctor {
    override func performCPR() {
        super.performCPR()
        print("May need inject the patient with 2mmL of epinephrine and charge the electric paddles to 300 volts.")
    }
    
    func useAScapple(){
        print("The surgeon is ready to perform surgery.")
    }
}

let emilio = EmergencyCallHandler()
//let pete = Paramedic(handler: emilio)
let angela = Surgeon(handler: emilio)

emilio.assessSitutation()
emilio.medicalEmergency()


