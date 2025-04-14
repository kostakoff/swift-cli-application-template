import ArgumentParser
import Foundation

@main
public struct ApplicationTemplate: ParsableCommand {
    static public var configuration = CommandConfiguration(
        commandName: "swift-application",
        version: "master"
    )

    @Option(help: """
    Supported cli options, currently supported
    - echo, to print an argument
    - null print empty string
    \n
    """)
    var option: String
    var supportedOptions = ["echo", "null"]

    @Argument(help: "Argument to print")
    var argString: String
    
    public init() {
//        Public initializer required to conform to the ParsableCommand protocol
    }
    
    mutating public func validate() throws {
        guard supportedOptions.contains(option) else {
            throw ValidationError("Unsuppported option: " + option)
        }
    }
    
    mutating public func run() throws {
        var result = ""
        if option == "echo" {
            result = argString
        } else if option == "null" {
            result = ""
        }
        print(result)
    }
}
