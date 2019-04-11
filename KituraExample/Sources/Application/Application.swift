import Kitura
import KituraStencil

public class App {
    
    let container: AppContainer
    
    let router = Router()
    
    public init() throws {
        container = AppContainer()
        router.add(templateEngine: StencilTemplateEngine())
        router.all(middleware: Saber(appContainer: container))
        try initializeBasicAuthRoutes(app: self)
        initializeUserRoutes(app: self)
        initializeStaticFileServers(app: self)
    }
    
    public func run(port: Int) throws {
        Kitura.addHTTPServer(onPort: port, with: router)
        Kitura.run()
    }
}
