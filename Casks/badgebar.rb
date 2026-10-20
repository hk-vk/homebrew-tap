cask "badgebar" do
  version "0.2.0"
  sha256 "4da26d3186aba65a627409ff3ab70eaee609b90d2204e879b92c6b57a45025ba"

  url "https://github.com/hk-vk/badgebar/releases/download/v#{version}/BadgeBar-#{version}.zip"
  name "BadgeBar"
  desc "Shows Dock badge counts in the menu bar"
  homepage "https://badgebar.hari.works"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

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
    "~/Library/Preferences/io.github.hk-vk.badgebar.plist",
  ]
end
