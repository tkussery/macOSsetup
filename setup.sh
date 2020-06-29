#!/usr/bin/env sh
#####!!!!!!! NOT COMPLETE - DO NOT USE !!!!!!#####
##
# Customized based on multiple sources that come from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# Added some additional touches to match my requirements:
#   - Combined several scripts / activities
#   - Added preparation steps specific to my environment
#   - Ordered various activities to support the correct flow (install newest git, setup projects with clone, etc)
######### install it:
#########   curl -sL https://raw.github.com/gist/2470157/hack.sh | sh
#

####################
# INITIAL PREP     #
####################
echo "**** Beginning initial prep ****"

echo "Closing applications (System Preferences, Safari, etc) that may cause issues if open..."
osascript -e 'tell application "System Preferences" to quit'
osascript -e 'tell application "Safari" to quit'
osascript -e 'tell application "Safari Technology Preview" to quit'

echo "Need password for sudo: "
sudo -v

echo "Setting up process for sudo keep-alive..."
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Setting up required directories..."
echo "Creating screenshots in Pictures..."
mkdir "${HOME}/Pictures/screenshots"
echo "Creating torrents in Documents..."
mkdir "${HOME}/Documents/torrents"
echo "Creating projects in ~/"
mkdir "${HOME}/projects"

echo "**** PREPARATIONS COMPLETE ****"

####################
# CORE             #
####################

echo "~~~ Core System Defaults ~~~"

echo "Setting sidebar icons to small..."
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

echo "Increasing window resize speed..."
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "Save / Print panels will expand by default..."
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo "Quit printer app automatically..."
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo "Enable subpixel font rendering on non-Apple LCDs to medium..."
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo "Set minimum font size for antialiasing..."
defaults write NSGlobalDomain AppleAntiAliasingThreshold -int 2

echo "Enable full keyboard access for all controls..."
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "Remove slow animations when holding shift..."
defaults write NSGlobalDomain FXEnableSlowAnimation -bool false

echo "~~~~ CORE COMPLETE ~~~~"

####################
# DOCK / SPACES    #
####################
echo "~~~ Dock / Spaces Configurations ~~~"
echo "Always show the Dock..."
defaults write com.apple.dock autohide -bool false

echo "Set icons to a small 26 pixels..."
defaults write com.apple.dock tilesize -int 26

echo "Speed up dock show for other windows..."
defaults write com.apple.Dock autohide-delay -float 0

echo "Remove the delay for showing the Dock in full screen..."
defaults write com.apple.dock autohide-fullscreen-delayed -bool false

echo "Have windows minimize to their icon in Dock..."
defaults write com.apple.dock minimize-to-application -bool true

echo "Enable spring loading for all Dock items..."
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

echo "Use scale as the window effect..."
defaults write com.apple.dock mineffect -string "scale"

echo "Ensure the indicator lights for open apps are enabled..."
defaults write com.apple.dock show-process-indicators -bool true

echo "Remove recent applications function from the Dock..."
defaults write com.apple.dock show-recents -bool false

echo "Disable the auto-arrangement of Spaces based on recent..."
defaults write com.apple.dock mru-spaces -bool false

## TODO: Add logic to add spacers to Dock (left or right) based on user input
# Spacer-Left (Where Apps are): defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Spacer-Right (Where Trash is): defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

echo "~~~~ DOCK / SPACES COMPLETE ~~~~"

####################
# MENUBAR          #
####################
echo "~~~ Menubar Configurations ~~~"
echo "Show remaining battery time instead of percentage..."
defaults write com.apple.menuextra.battery ShowPercent -string "NO"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

echo "~~~~ MENUBAR COMPLETE ~~~~"

####################
# FINDER           #
####################
echo "~~~ Finder Configurations ~~~"
echo "Get rid of animations in Finder..."
defaults write com.apple.finder DisableAllAnimations -bool true

echo "Show the Library directory..."
chflags nohidden ~/Library

echo "Show all filename extensions in Finder..."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "For all that is holy, default to list view..."
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo "Set default location for new windows to home ~..."
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

echo "Set default search scope as current directory in Finder..."
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "Show Path and Status bars in Finder..."
defaults write com.apple.finder ShowPathBar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

echo "Disable showing any volumes on the desktop..."
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

echo "Show POSIX path in window title..."
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Keep folders on top when sorting by name..."
defaults write com.apple.finder _FXSortFoldersFirst -bool true

echo "Don't warn when changing extensions..."
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Enable spring loading for directories..."
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

echo "Remove the spring loading delay for directories..."
defaults write NSGlobalDomain com.apple.springing.delay -float 0

echo "Don't create .DS_Store files on network or USB volumes..."
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "Disable disk image verification..."
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo "Stop warning on emptying the Trash..."
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "Enable Airdrop on all interfaces..."
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

echo "Set default to expand for info panes..."
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

echo "~~~~ FINDER COMPLETE ~~~~"

####################
# SAFARI / TP      #
####################
echo "~~~ Safari & Technology Preview Configurations ~~~"

echo "Checking for Safari Technology Preview (SafariTP)..."
## TODO: Trial run needed.
if grep -q "does not exist" <<<$(defaults read com.apple.SafariTechnologyPreview 2>&1); then
    doesExistSTP = false
    echo "Safari Technology Preview does NOT exist, only configuring Safari..."
else
    doesExistSTP = true
    echo "Safari Technology Preview DOES exist, configuring both..."
fi

echo "Starting with Safari..."
echo "Allow tab to highlight all items on a webpage..."
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

echo "Show the full URL..."
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

echo "Set the homepage to blank..."
defaults write com.apple.Safari HomePage -string "about:blank"

echo "Don't allow Safari to automatically open any files after downloading..."
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

echo "Allow use of backspace to go to previous page..."
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

echo "Enable the bookmarks bar..."
defaults write com.apple.Safari ShowFavoritesBar -bool true

echo "Hide the sidebar in Top Sites..."
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

echo "Remove thumbnail caching for history and top sites..."
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo "Show the debug menu..."
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo "Set searches to default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

echo "Show the Develop and Web Inspector options..."
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

echo "Add context menu item for Web Inspector..."
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo "Do continuous spellchecking..."
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

echo "Disable auto-correct..."
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

echo "Don't AutoFill anything..."
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

echo "Warn about fraudulent websites..."
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

echo "Disable any Java use..."
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

echo "Send Do Not Tracks..."
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

echo "Make sure extensions are updated automatically..."
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

if $doesExistSTP; then
    echo "Now to Safari Technology Preview..."

    echo "Allow tab to highlight all items on a webpage..."
    defaults write com.apple.SafariTechnologyPreview WebKitTabToLinksPreferenceKey -bool true
    defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

    echo "Show the full URL..."
    defaults write com.apple.SafariTechnologyPreview ShowFullURLInSmartSearchField -bool true

    echo "Set the homepage to blank..."
    defaults write com.apple.SafariTechnologyPreview HomePage -string "about:blank"

    echo "Don't allow Safari to automatically open any files after downloading..."
    defaults write com.apple.SafariTechnologyPreview AutoOpenSafeDownloads -bool false

    echo "Allow use of backspace to go to previous page..."
    defaults write com.apple.SafariTechnologyPreview com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

    echo "Enable the bookmarks bar..."
    defaults write com.apple.SafariTechnologyPreview ShowFavoritesBar -bool true

    echo "Hide the sidebar in Top Sites..."
    defaults write com.apple.SafariTechnologyPreview ShowSidebarInTopSites -bool false

    echo "Remove thumbnail caching for history and top sites..."
    defaults write com.apple.SafariTechnologyPreview DebugSnapshotsUpdatePolicy -int 2

    echo "Show the debug menu..."
    defaults write com.apple.SafariTechnologyPreview IncludeInternalDebugMenu -bool true

    echo "Set searches to default to Contains instead of Starts With"
    defaults write com.apple.SafariTechnologyPreview FindOnPageMatchesWordStartsOnly -bool false

    echo "Show the Develop and Web Inspector options..."
    defaults write com.apple.SafariTechnologyPreview IncludeDevelopMenu -bool true
    defaults write com.apple.SafariTechnologyPreview WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.SafariTechnologyPreview com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

    echo "Do continuous spellchecking..."
    defaults write com.apple.SafariTechnologyPreview WebContinuousSpellCheckingEnabled -bool true

    echo "Disable auto-correct..."
    defaults write com.apple.SafariTechnologyPreview WebAutomaticSpellingCorrectionEnabled -bool false

    echo "Don't AutoFill anything..."
    defaults write com.apple.SafariTechnologyPreview AutoFillFromAddressBook -bool false
    defaults write com.apple.SafariTechnologyPreview AutoFillPasswords -bool false
    defaults write com.apple.SafariTechnologyPreview AutoFillCreditCardData -bool false
    defaults write com.apple.SafariTechnologyPreview AutoFillMiscellaneousForms -bool false

    echo "Warn about fraudulent websites..."
    defaults write com.apple.SafariTechnologyPreview WarnAboutFraudulentWebsites -bool true

    echo "Disable any Java use..."
    defaults write com.apple.SafariTechnologyPreview WebKitJavaEnabled -bool false
    defaults write com.apple.SafariTechnologyPreview com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
    defaults write com.apple.SafariTechnologyPreview com.apple.SafariTechnologyPreview.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

    echo "Send Do Not Tracks..."
    defaults write com.apple.SafariTechnologyPreview SendDoNotTrackHTTPHeader -bool true

    echo "Make sure extensions are updated automatically..."
    defaults write com.apple.SafariTechnologyPreview InstallExtensionUpdatesAutomatically -bool true

    echo "~~~~ SAFARI TECHNOLOGY PREVIEW COMPLETE ~~~~"
fi

echo "~~~~ SAFARI COMPLETE ~~~~"


####################
# TIME MACHINE     #
####################
echo "~~~ Time Machine Configurations ~~~"

echo "Don't ask everytime a new disk is added..."
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "~~~~ TIME MACHINE COMPLETE ~~~~"

####################
# MAC APP STORE    #
####################
echo "~~~ Mac App Store Configurations ~~~"

echo "Show WebKit Dev Tools..."
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

echo "Show Debug Menu options..."
defaults write com.apple.appstore ShowDebugMenu -bool true

echo "Always check for new updates..."
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

echo "Do that check once a day..."
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "Download the updates in the background..."
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

echo "Automatically install critical updates..."
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

echo "Turn on auto update..."
defaults write com.apple.commerce AutoUpdate -bool true

echo "~~~~ MAC APP STORE COMPLETE ~~~~"

####################
# PHOTOS           #
####################
echo "~~~ Photos Configuration ~~~"

echo "Please, please, stop opening automatically when stuff is plugged in..."
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

echo "~~~~ PHOTOS COMPLETE ~~~~"



echo "Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

echo "Save screenshots as PNG"
defaults write com.apple.screencapture type png

echo "Save screenshots to Downloads"
defaults write com.apple.screencapture location "${HOME}/Downloads"

echo "Enable highlight hover effect for the grid view of a stack (Dock)"
defaults write com.apple.dock mouse-over-hilte-stack -bool true

echo "Enable spring loading for all Dock items"
defaults write enable-spring-load-actions-on-all-items -bool true

echo "Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
# defaults write com.apple.dock launchanim -bool false

echo "Display ASCII control characters using caret notation in standard text views"
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
# defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# echo "Disable press-and-hold for keys in favor of key repeat"
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# echo "Set a blazingly fast keyboard repeat rate"
# defaults write NSGlobalDomain KeyRepeat -int 0.02

# echo "Set a shorter Delay until key repeat"
# defaults write NSGlobalDomain InitialKeyRepeat -int 12

echo "Automatically illuminate built-in MacBook keyboard in low light"
defaults write com.apple.BezelServices kDim -bool true

echo 'Turn off keyboard illumination when computer is not used for 5 minutes'
defaults write com.apple.BezelServices kDimTime -int 300

echo "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable opening and closing window animations
# defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

echo "Enable AirDrop over Ethernet and on unsupported Macs running Lion"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

echo "Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

echo "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "Increase window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# echo "Show item info below desktop icons"
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

echo "Enable snap-to-grid for desktop icons"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

echo "Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
# defaults write com.apple.finder EmptyTrashSecurely -bool true

# echo "Require password immediately after sleep or screen saver begins"
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

"Enable tap to click on Trackpad and login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.mouse.tapBehaviour -int 1

echo "Disable Natural Scroll Direction"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# echo "Map bottom right Trackpad corner to right-click"
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true


echo "Only use UTF-8 in Terminal.app"
defaults write com.apple.terminal StringEncodings -array 4



# Disable send and reply animations in Mail.app
# defaults write com.apple.Mail DisableReplyAnimations -bool true
# defaults write com.apple.Mail DisableSendAnimations -bool true

# Disable Resume system-wide
# defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false


echo "Enable Dashboard dev mode (allows keeping widgets on the desktop)"
defaults write com.apple.dashboard devmode -bool true


echo "Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false



echo "DOWNLOAD QLStephen to view all plain text files with QuickLook"
echo "http://coderwall.com/p/dlithw"

echo "Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true;

# echo "Disable local Time Machine backups"
# hash tmutil &> /dev/null && sudo tmutil disablelocal

echo "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# echo "Remove Dropbox’s green checkmark icons in Finder"
# file=/Applications/Dropbox.app/Contents/Resources/check.icns
# [ -e "$file" ] && mv -f "$file" "$file.bak"
# unset file

#Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)
# Commented out, as this is known to cause problems when saving files in Adobe Illustrator CS5 :(
#echo "0x08000100:0" > ~/.CFUserTextEncoding

echo "Set Desktop as the default location for new Finder windows"
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

echo "Hide icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

echo "Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo "Kill affected applications"
for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done