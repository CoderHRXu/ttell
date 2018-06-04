fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### pemInfo
```
fastlane pemInfo
```


----

## iOS
### ios test
```
fastlane ios test
```
Submit a new TEST Build to pgyer server
### ios dev
```
fastlane ios dev
```
Submit a new DEV Build to pgyer server
### ios pro
```
fastlane ios pro
```
Submit a new PRO Build to pgyer server
### ios agent
```
fastlane ios agent
```
Submit a new Agent Build to pgyer server
### ios dep
```
fastlane ios dep
```
Deploy a new version to the App Store
### ios syncCer
```
fastlane ios syncCer
```
Synchronize provisioningProfiles(Development,Ad-Hoc,App Store) of all bundle_id. 
### ios syncPemInfo
```
fastlane ios syncPemInfo
```
Synchronize Development & APNS certificates of all bundle_id. 
### ios cy
```
fastlane ios cy
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
