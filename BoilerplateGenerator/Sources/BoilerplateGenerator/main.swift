import Foundation

if CommandLine.arguments.count > 1 {
    //running in command line mode
    let sourceDirectory = URL(fileURLWithPath: CommandLine.arguments[1])
    let fileDirectory = sourceDirectory.appendingPathComponent("Classes")
    for (file, content) in SIMDTypeKVCSupportCodeGenerator.generate() {
        let url = fileDirectory.appendingPathComponent(file)
        try! content.write(to: url, atomically: true, encoding: .utf8)
    }
} else {
    //running in playground mode
    print(SIMDTypeKVCSupportCodeGenerator.generate())
}
