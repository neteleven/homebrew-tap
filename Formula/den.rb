# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  version "0.15.3"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  depends_on "lima"

  # The archives the release built, republished on the tap.
  on_macos do
    # Apple silicon only (ADR-0039): Intel carries the same archive so that the
    # formula loads, and the requirement refuses it.
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.3/den_0.15.3_darwin_arm64.zip"
      sha256 "378b074b9084d1e1e2d5d1fbe9846a86aa585f2e2be0432c5b498b14d7ada35f"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.3/den_0.15.3_darwin_arm64.zip"
      sha256 "378b074b9084d1e1e2d5d1fbe9846a86aa585f2e2be0432c5b498b14d7ada35f"
    end
  end

  on_linux do
    # Lima's qemu driver; the UEFI firmware it needs ships inside qemu, and
    # Lima looks for it next to the qemu binary (ADR-0029).
    depends_on "qemu"
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.3/den_0.15.3_linux_arm64.zip"
      sha256 "f1f2b5d96ca9c7e35450677f8b505b372b08c74acb5786b7dee3b5ac85a47fca"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.3/den_0.15.3_linux_amd64.zip"
      sha256 "30cd8a3b7fe192d27cce95d5acbfcef61d4fb2495397e8f9d521f9ffb25c91cb"
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
