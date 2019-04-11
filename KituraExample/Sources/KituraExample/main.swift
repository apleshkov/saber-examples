import Application
import LoggerAPI
import HeliumLogger

HeliumLogger.use(.warning)

do {
    let app = try App()
    try app.run(port: 8080)
} catch {
    Log.error(error.localizedDescription)
}
