# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  version "0.11.4"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  depends_on "lima"

  # The archives the release built, republished on the tap.
  on_macos do
    # Apple silicon only: an Intel Mac finds no URL here and Homebrew says
    # "formula requires at least a URL" -- docs/install.md names that error.
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.11.4/den_0.11.4_darwin_arm64.zip"
      sha256 "84b6b4e0600dad57a25a3e3787be2c30db39e66a2c557f78726e9785a0ca1464"
    end
  end

  on_linux do
    # Lima's qemu driver; the UEFI firmware it needs ships inside qemu, and
    # Lima looks for it next to the qemu binary (ADR-0029).
    depends_on "qemu"
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.11.4/den_0.11.4_linux_arm64.zip"
      sha256 "e5909ee04696b773a57429d480efdba7cb1ab64d47f1943161fd46a4dca7cfe6"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.11.4/den_0.11.4_linux_amd64.zip"
      sha256 "c4e53ab72d97cd2598c3ae4051fb0a744605214aafce9ba42811526384f16c66"
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
