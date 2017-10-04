//
//  main.swift
//  TaskUtils
//
//  Created by Suolapeikko on 04/07/16.
//

import Foundation

// Create example command line interface commands that needs to be run chained / piped
let psefCommand = CliCommand(launchPath: "/bin/ps", arguments: ["-e", "-f"])
let grepMailCommand = CliCommand(launchPath: "/usr/bin/grep", arguments: ["mdworker"])

// Prepare cli command runner
let chainedCommand = CliCommandRunner(commands: [psefCommand, grepMailCommand])

// Prepare result tuple
var chainedCommandResult: String?

// Execute cli commands and prepare for exceptions
do {
    chainedCommandResult = try chainedCommand.execute()
}
catch CliError.no_TASKS{
    print("Empty task array")
    exit(0)
}
catch CliError.execute_FAILED(let statusCode, let resultText){
    print("Execute failed: status code=\(statusCode), result text=\(resultText)")
    exit(0)
}

print("Command output: \(chainedCommandResult!)")
