cask "badgebar" do
  version "0.4.0"
  sha256 "dc77f1d944db5a8374cd2439a743c7f70e0ca80eb4ef28876d8c63221ad958cd"
  auto_updates true

  url "https://github.com/hk-vk/badgebar/releases/download/v#{version}/BadgeBar-#{version}.zip"
  name "BadgeBar"
  desc "Shows Dock badge counts in the menu bar"
  homepage "https://badgebar.hari.works/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "BadgeBar.app"

  # BadgeBar isn't notarized, so clear the download quarantine to open it without a Gatekeeper prompt.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/BadgeBar.app"],
        must_succeed:   false,
        writable_paths: ["{{appdir}}/BadgeBar.app"]
  end

  uninstall quit: "io.github.hk-vk.badgebar"

  zap trash: [
    "~/Library/Application Support/BadgeBar",
    "~/Library/Preferences/io.github.hk-vk.badgebar.plist",
  ]
end
