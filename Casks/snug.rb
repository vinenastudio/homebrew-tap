cask "snug" do
  version "0.1.12,15"
  sha256 "449a0ffb73576d53d9f4dbfdf6bb8082ef5140211125b5f4d533d54884454eb6"

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
