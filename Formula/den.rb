# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  version "0.15.4"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  depends_on "lima"

  # The archives the release built, republished on the tap.
  on_macos do
    # Apple silicon only (ADR-0039): Intel carries the same archive so that the
    # formula loads, and the requirement refuses it.
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.4/den_0.15.4_darwin_arm64.zip"
      sha256 "66c1a56a0c53afb8f3a443519495fe2983932d19283f91afad3fb5e45b4acc48"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.4/den_0.15.4_darwin_arm64.zip"
      sha256 "66c1a56a0c53afb8f3a443519495fe2983932d19283f91afad3fb5e45b4acc48"
    end
  end

  on_linux do
    # Lima's qemu driver; the UEFI firmware it needs ships inside qemu, and
    # Lima looks for it next to the qemu binary (ADR-0029).
    depends_on "qemu"
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.4/den_0.15.4_linux_arm64.zip"
      sha256 "7d86833204881d650a32ef3fadcec39b53e347f9ad4afc19002f72f9ee29011a"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.4/den_0.15.4_linux_amd64.zip"
      sha256 "dce56985d4c815d7c3bc4328649350393033100178cd4cf271e7c87af5d7c259"
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
