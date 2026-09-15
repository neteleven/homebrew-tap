# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  version "0.14.0"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  depends_on "lima"

  # The archives the release built, republished on the tap.
  on_macos do
    # Apple silicon only: an Intel Mac finds no URL here and Homebrew says
    # "formula requires at least a URL" -- docs/install.md names that error.
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.14.0/den_0.14.0_darwin_arm64.zip"
      sha256 "03ee5ad3ba1ae732e608425b620cb391cf0a60b101c0884126f0cb25d7e5b6d2"
    end
  end

  on_linux do
    # Lima's qemu driver; the UEFI firmware it needs ships inside qemu, and
    # Lima looks for it next to the qemu binary (ADR-0029).
    depends_on "qemu"
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.14.0/den_0.14.0_linux_arm64.zip"
      sha256 "dc6ad1e0c4fbc355c687b09db18a735225ed6895be82ae32b95e7d5c473906e8"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.14.0/den_0.14.0_linux_amd64.zip"
      sha256 "7d645f4f2b0cb81283a1a0a8a8b9db0f39e05cf0695776f12d3bed5f411228b1"
    end
  end

  def install
    bin.install "den"
    doc.install "README.md", "CHANGELOG.md", "LICENSE", "THIRD-PARTY-NOTICES.md"
    # Under docs/, as in the archive, so the user documents' links to each other resolve.
    (doc/"docs").install Dir["docs/*.md"]
    pkgshare.install "examples"
    # A prompt, not a document: an agent reads it from ~/.claude/skills, so it
    # goes where the user can copy it from (ADR-0032). install.md says how.
    pkgshare.install "skills"
  end

  test do
    assert_match "den #{version}", shell_output("#{bin}/den --version")
  end
end
