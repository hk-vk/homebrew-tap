cask "badgebar" do
  version "0.3.1"
  sha256 "84341cfc90d4b377f1554570210d4f54ee7f1d4036a1ff740a1b7c0b62d0dede"

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
