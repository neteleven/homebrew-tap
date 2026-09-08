# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  # The archive the release built for macOS, republished on the tap.
  url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.9.1/den_0.9.1_darwin_arm64.zip"
  version "0.9.1"
  sha256 "624ac525a224ff384ee4343e265efc26f80e6c55b532b134eb2eaf89c58a386c"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  # macOS on Apple silicon only (ADR-0028, decision 4).
  depends_on arch: :arm64
  depends_on "lima"
  depends_on :macos

  def install
    bin.install "den"
    doc.install "README.md", "CHANGELOG.md", "LICENSE", "THIRD-PARTY-NOTICES.md"
    # Under docs/, as in the archive, so the user documents' links to each other resolve.
    (doc/"docs").install Dir["docs/*.md"]
    pkgshare.install "examples"
  end

  test do
    assert_match "den #{version}", shell_output("#{bin}/den --version")
  end
end
