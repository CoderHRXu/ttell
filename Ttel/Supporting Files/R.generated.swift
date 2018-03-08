//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 color palettes.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 7 files.
  struct file {
    /// Resource file `AppIcon60x60@3x.png`.
    static let appIcon60x603xPng = Rswift.FileResource(bundle: R.hostingBundle, name: "AppIcon60x60@3x", pathExtension: "png")
    /// Resource file `CerInstallation.jpg`.
    static let cerInstallationJpg = Rswift.FileResource(bundle: R.hostingBundle, name: "CerInstallation", pathExtension: "jpg")
    /// Resource file `Info.plist`.
    static let infoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "Info", pathExtension: "plist")
    /// Resource file `canvas-particle.js`.
    static let canvasParticleJs = Rswift.FileResource(bundle: R.hostingBundle, name: "canvas-particle", pathExtension: "js")
    /// Resource file `hackStyle.html`.
    static let hackStyleHtml = Rswift.FileResource(bundle: R.hostingBundle, name: "hackStyle", pathExtension: "html")
    /// Resource file `particle.html`.
    static let particleHtml = Rswift.FileResource(bundle: R.hostingBundle, name: "particle", pathExtension: "html")
    /// Resource file `yunlong.mp3`.
    static let yunlongMp3 = Rswift.FileResource(bundle: R.hostingBundle, name: "yunlong", pathExtension: "mp3")
    
    /// `bundle.url(forResource: "AppIcon60x60@3x", withExtension: "png")`
    static func appIcon60x603xPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.appIcon60x603xPng
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "CerInstallation", withExtension: "jpg")`
    static func cerInstallationJpg(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.cerInstallationJpg
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "Info", withExtension: "plist")`
    static func infoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.infoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "canvas-particle", withExtension: "js")`
    static func canvasParticleJs(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.canvasParticleJs
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "hackStyle", withExtension: "html")`
    static func hackStyleHtml(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.hackStyleHtml
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "particle", withExtension: "html")`
    static func particleHtml(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.particleHtml
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "yunlong", withExtension: "mp3")`
    static func yunlongMp3(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.yunlongMp3
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 10 images.
  struct image {
    /// Image `Alipay`.
    static let alipay = Rswift.ImageResource(bundle: R.hostingBundle, name: "Alipay")
    /// Image `AppIcon60x60`.
    static let appIcon60x60 = Rswift.ImageResource(bundle: R.hostingBundle, name: "AppIcon60x60")
    /// Image `CerInstallation.jpg`.
    static let cerInstallationJpg = Rswift.ImageResource(bundle: R.hostingBundle, name: "CerInstallation.jpg")
    /// Image `background`.
    static let background = Rswift.ImageResource(bundle: R.hostingBundle, name: "background")
    /// Image `defaultIcon`.
    static let defaultIcon = Rswift.ImageResource(bundle: R.hostingBundle, name: "defaultIcon")
    /// Image `defaultQrCode`.
    static let defaultQrCode = Rswift.ImageResource(bundle: R.hostingBundle, name: "defaultQrCode")
    /// Image `dottedline`.
    static let dottedline = Rswift.ImageResource(bundle: R.hostingBundle, name: "dottedline")
    /// Image `navigationBack`.
    static let navigationBack = Rswift.ImageResource(bundle: R.hostingBundle, name: "navigationBack")
    /// Image `send`.
    static let send = Rswift.ImageResource(bundle: R.hostingBundle, name: "send")
    /// Image `setting`.
    static let setting = Rswift.ImageResource(bundle: R.hostingBundle, name: "setting")
    
    /// `UIImage(named: "Alipay", bundle: ..., traitCollection: ...)`
    static func alipay(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.alipay, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "AppIcon60x60", bundle: ..., traitCollection: ...)`
    static func appIcon60x60(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.appIcon60x60, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "CerInstallation.jpg", bundle: ..., traitCollection: ...)`
    static func cerInstallationJpg(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.cerInstallationJpg, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "background", bundle: ..., traitCollection: ...)`
    static func background(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.background, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "defaultIcon", bundle: ..., traitCollection: ...)`
    static func defaultIcon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.defaultIcon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "defaultQrCode", bundle: ..., traitCollection: ...)`
    static func defaultQrCode(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.defaultQrCode, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "dottedline", bundle: ..., traitCollection: ...)`
    static func dottedline(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dottedline, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "navigationBack", bundle: ..., traitCollection: ...)`
    static func navigationBack(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.navigationBack, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "send", bundle: ..., traitCollection: ...)`
    static func send(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.send, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "setting", bundle: ..., traitCollection: ...)`
    static func setting(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.setting, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 8 nibs.
  struct nib {
    /// Nib `AboutViewController`.
    static let aboutViewController = _R.nib._AboutViewController()
    /// Nib `AppDetailViewController`.
    static let appDetailViewController = _R.nib._AppDetailViewController()
    /// Nib `AppItemCell`.
    static let appItemCell = _R.nib._AppItemCell()
    /// Nib `HelpViewController`.
    static let helpViewController = _R.nib._HelpViewController()
    /// Nib `HistoryVersionCell`.
    static let historyVersionCell = _R.nib._HistoryVersionCell()
    /// Nib `LeftMenuViewController`.
    static let leftMenuViewController = _R.nib._LeftMenuViewController()
    /// Nib `SendEmailViewController`.
    static let sendEmailViewController = _R.nib._SendEmailViewController()
    /// Nib `SettingViewController`.
    static let settingViewController = _R.nib._SettingViewController()
    
    /// `UINib(name: "AboutViewController", in: bundle)`
    static func aboutViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.aboutViewController)
    }
    
    /// `UINib(name: "AppDetailViewController", in: bundle)`
    static func appDetailViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.appDetailViewController)
    }
    
    /// `UINib(name: "AppItemCell", in: bundle)`
    static func appItemCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.appItemCell)
    }
    
    /// `UINib(name: "HelpViewController", in: bundle)`
    static func helpViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.helpViewController)
    }
    
    /// `UINib(name: "HistoryVersionCell", in: bundle)`
    static func historyVersionCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.historyVersionCell)
    }
    
    /// `UINib(name: "LeftMenuViewController", in: bundle)`
    static func leftMenuViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.leftMenuViewController)
    }
    
    /// `UINib(name: "SendEmailViewController", in: bundle)`
    static func sendEmailViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.sendEmailViewController)
    }
    
    /// `UINib(name: "SettingViewController", in: bundle)`
    static func settingViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.settingViewController)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `AppItemCell`.
    static let appItemCell: Rswift.ReuseIdentifier<AppItemCell> = Rswift.ReuseIdentifier(identifier: "AppItemCell")
    /// Reuse identifier `HistoryVersionCell`.
    static let historyVersionCell: Rswift.ReuseIdentifier<HistoryVersionCell> = Rswift.ReuseIdentifier(identifier: "HistoryVersionCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
    try nib.validate()
  }
  
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _LeftMenuViewController.validate()
      try _AboutViewController.validate()
    }
    
    struct _AboutViewController: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "AboutViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "Alipay") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Alipay' is used in nib 'AboutViewController', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct _AppDetailViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "AppDetailViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _AppItemCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = AppItemCell
      
      let bundle = R.hostingBundle
      let identifier = "AppItemCell"
      let name = "AppItemCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> AppItemCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? AppItemCell
      }
      
      fileprivate init() {}
    }
    
    struct _HelpViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "HelpViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _HistoryVersionCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = HistoryVersionCell
      
      let bundle = R.hostingBundle
      let identifier = "HistoryVersionCell"
      let name = "HistoryVersionCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> HistoryVersionCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? HistoryVersionCell
      }
      
      fileprivate init() {}
    }
    
    struct _LeftMenuViewController: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "LeftMenuViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "AppIcon60x60.png") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'AppIcon60x60.png' is used in nib 'LeftMenuViewController', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct _SendEmailViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SendEmailViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _SettingViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SettingViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ContainerViewController
      
      let bundle = R.hostingBundle
      let homeViewController = StoryboardViewControllerResource<HomeViewController>(identifier: "HomeViewController")
      let name = "Main"
      let rootNaviViewController = StoryboardViewControllerResource<RootNaviViewController>(identifier: "RootNaviViewController")
      
      func homeViewController(_: Void = ()) -> HomeViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: homeViewController)
      }
      
      func rootNaviViewController(_: Void = ()) -> RootNaviViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: rootNaviViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "setting") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'setting' is used in storyboard 'Main', but couldn't be loaded.") }
        if _R.storyboard.main().homeViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'homeViewController' could not be loaded from storyboard 'Main' as 'HomeViewController'.") }
        if _R.storyboard.main().rootNaviViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'rootNaviViewController' could not be loaded from storyboard 'Main' as 'RootNaviViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}