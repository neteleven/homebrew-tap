# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  version "0.12.2"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  depends_on "lima"

  # The archives the release built, republished on the tap.
  on_macos do
    # Apple silicon only: an Intel Mac finds no URL here and Homebrew says
    # "formula requires at least a URL" -- docs/install.md names that error.
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.12.2/den_0.12.2_darwin_arm64.zip"
      sha256 "079e915097f022b25f2a6d8d5339cdfa022f6b4ca08c07b3aaff2c05107dcd46"
    end
  end

  on_linux do
    # Lima's qemu driver; the UEFI firmware it needs ships inside qemu, and
    # Lima looks for it next to the qemu binary (ADR-0029).
    depends_on "qemu"
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.12.2/den_0.12.2_linux_arm64.zip"
      sha256 "4a4a550e741c39caf1ff5f8439441e03d739f7acf801c1c29ae5bcaa1cf0f2c9"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.12.2/den_0.12.2_linux_amd64.zip"
      sha256 "5ec6bebd66ada0792f58bda32facc05ac9132a3e2a0465b0fdb7d964aeecfa87"
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
