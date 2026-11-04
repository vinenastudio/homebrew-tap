cask "snug" do
  version "0.1.8,11"
  sha256 "b77c882ac4b24788f0c07c8c4db4a9774877cf02b84c49a6f48c6a63b19b6494"

  url "https://snug.so/mac/snug-#{version.csv.first}-#{version.csv.second}.dmg"
  name "Snug"
  desc "Clipboard manager that keeps copied API keys away from AI agents"
  homepage "https://snug.so/"

  livecheck do
    url "https://snug.so/mac/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Snug.app"
  binary "#{appdir}/Snug.app/Contents/Helpers/snug"

  uninstall launchctl: "com.mertbuilds.snug.broker",
            quit:      "com.mertbuilds.snug"

  zap trash: [
    "~/.claude/skills/snug",
    "~/Library/Application Support/snug",
    "~/Library/Caches/com.mertbuilds.snug",
    "~/Library/HTTPStorages/com.mertbuilds.snug",
    "~/Library/Preferences/com.mertbuilds.snug.plist",
  ]

  caveats <<~EOS
    Snug is paid software with a 7-day trial.

    Uninstalling does not remove your secrets from the Keychain, and it does
    not change the entries that Settings > Agents wrote into
    ~/.claude/settings.json. Delete the secrets and choose Undo there before
    you uninstall.
  EOS
end
