cask "unabridged" do
  version "0.1.0"
  sha256 "a35766abcf0dea0af2dd97a2c1b94db4cb76b0b04581e593fff752b930cf4173"
  auto_updates true

  url "https://github.com/hk-vk/unabridged/releases/download/v#{version}/Unabridged-#{version}.zip"
  name "Unabridged"
  desc "Native Mac player for your Audible library"
  homepage "https://github.com/hk-vk/unabridged"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Unabridged.app"

  # Unabridged isn't notarized, so clear the download quarantine to open it
  # without a Gatekeeper prompt.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Unabridged.app"],
        must_succeed:   false,
        writable_paths: ["{{appdir}}/Unabridged.app"]
  end

  uninstall quit: "io.github.hk-vk.unabridged"

  zap trash: [
    "~/Library/Application Support/Better Audible",
    "~/Library/Caches/Better Audible",
    "~/Library/Preferences/io.github.hk-vk.unabridged.plist",
  ]
end
