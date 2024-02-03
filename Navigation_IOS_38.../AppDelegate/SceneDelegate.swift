//
//  SceneDelegate.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//
import FirebaseAuth
import KeychainAccess
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let appConfiguration: AppConfiguration = AppConfiguration.notFound
        NetworkService.request(for: appConfiguration)
        
        let window = UIWindow(windowScene: scene)
        
        window.rootViewController = createCoreDataSceneViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func authViewController() -> UIViewController {
        let authVC = AuthViewController(delegate: self, keychainService: Keychain())
        return authVC
    }
    
    private func jokesViewController() -> UIViewController {
        let tabBarVC = UITabBarController()
        let service = JokeStorageServiceImpl()
        let randomVC = RandomJokeViewController(
            networkService: JokeNetworkServiceImpl(),
            storageService: service
        )
        let sortedJokesByTimeVC = JokesViewController(storageService: service)
        let groupedJokesByCategoriesVC = GroupedJokesViewController(storageService: service)
        
        tabBarVC.setViewControllers([randomVC, sortedJokesByTimeVC, groupedJokesByCategoriesVC], animated: false)
        
        return tabBarVC
    }
    
    private func createFileManagerViewController() -> UIViewController {
        let fileManagerService = FileManagerService()
        let controller = ListViewController(fileManagerService: fileManagerService)
        controller.tabBarItem = UITabBarItem(title: "Documents", image: UIImage(systemName: "Image 1"), tag: 0)
        let navigationController = UINavigationController(rootViewController: controller)
        
        return navigationController
    }
    
    private func createSettingsViewController() -> UIViewController {
        return SettingsViewController(userDefaults: .standard, keychainService: Keychain())
    }
    
    private func createFeedViewController() -> UINavigationController {
        let feedViewController = PostViewController(post: Post(author: "", description: "", image: "", likes: 0, views: 0))
        feedViewController.title = "Лента"
        feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "doc.richtext"), tag: 0)
        return UINavigationController(rootViewController: feedViewController)
    }
    
    private func createCoreDataSceneViewController() -> UIViewController {
        let postService = PostService(coreDataService: CoreDataService.shared)
        
        let postListViewController = PostListViewController(postService: postService)
        let selectedPostListViewController = SelectedPostListViewController(postService: postService)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([postListViewController, selectedPostListViewController], animated: false)
        
        return tabBarController
    }
    
    private func createPostListViewController() -> UINavigationController {
        let postListViewController = PostListViewController(postService: PostService(coreDataService: CoreDataService.shared))
        postListViewController.title = "Пост"
        postListViewController.tabBarItem = UITabBarItem(title: "Пост", image: UIImage(systemName: "pencil.and.list.clipboard"), tag: 0)
        return UINavigationController(rootViewController: postListViewController)
        
    }
    
    private func createProfileViewController() -> UINavigationController {
        let profileViewController = LogInViewController(
            user: .init(login: "", firstName: "", avatar: .init(), status: ""),
            viewModel: ProfileVMImp.init())
        let factory = MyLogInFactory()
        let inspector = factory.makeLoginInspector()
        profileViewController.delegate = inspector
        
        profileViewController.title = "Профиль"
        profileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
        return UINavigationController(rootViewController: profileViewController)
    }
    
    private func createFireBaseLoginViewController() -> UINavigationController {
        let checkerService = CheckerService()
        let loginViewController = FireBaseLoginViewController(service: checkerService)
        
        loginViewController.title = "Профиль"
        loginViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
        
        return UINavigationController(rootViewController: loginViewController)
    }
    
    private func createTabBarController() -> UITabBarController {
        
        let tabBarController = UITabBarController()
        
        UITabBar.appearance().backgroundColor = .systemGray6
        tabBarController.viewControllers = [createFeedViewController(), createProfileViewController(), createPostListViewController()]
        
        return tabBarController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        try? Auth.auth().signOut()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        CoreDataService.shared.saveContext()
    }
}

extension SceneDelegate: AuthViewControllerDelegate {
    func flowDidFinish() {
        let fileManagerVC = createFileManagerViewController()
        let settingsVC = createSettingsViewController()
        let tabBarViewController = UITabBarController()
        tabBarViewController.setViewControllers([fileManagerVC, settingsVC], animated: true)
        
        window?.rootViewController = tabBarViewController
    }
}
