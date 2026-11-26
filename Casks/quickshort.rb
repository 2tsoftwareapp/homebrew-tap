# Homebrew cask for the signed and notarized Quickshort build.
# Publish in a custom tap repo `2tsoftwareapp/homebrew-tap` at Casks/quickshort.rb;
# the release workflow can bump version+sha256 automatically via TAP_TOKEN.
#
#   brew tap 2tsoftwareapp/tap
#   brew install --cask quickshort
cask "quickshort" do
  version "0.4.1"
  sha256 "14389a6eeeed1a2aa0bc05b82858ba20a73977b1df085cbb1ac48e02bbb054ac"

  url "https://github.com/2tsoftwareapp/quickshort/releases/download/v#{version}/Quickshort-v#{version}-macos.zip"
  name "Quickshort"
  desc "Region screenshot tool with annotations and OCR"
  homepage "https://github.com/2tsoftwareapp/quickshort"

  app "Quickshort.app"

  # Builds are Developer ID signed and notarized, so Homebrew must not strip
  # quarantine: Gatekeeper can assess the stapled notarization ticket normally.

  # screen recording (⌘R) pipes frames into ffmpeg — optional, everything
  # else works without it, so this is a hint rather than a dependency
  def caveats
    <<~EOS
      Screen recording needs ffmpeg:
        brew install ffmpeg
    EOS
  end

  zap trash: [
    "~/.config/quickshort",
    "~/Library/LaunchAgents/ai.quickshort.plist",
  ]
end
