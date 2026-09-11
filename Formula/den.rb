# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  version "0.12.1"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  depends_on "lima"

  # The archives the release built, republished on the tap.
  on_macos do
    # Apple silicon only: an Intel Mac finds no URL here and Homebrew says
    # "formula requires at least a URL" -- docs/install.md names that error.
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.12.1/den_0.12.1_darwin_arm64.zip"
      sha256 "37ecb19e8e79e0bb3a7e0105acfe28a86aaf182a65e443a47a47161eb8ee6e9a"
    end
  end

  on_linux do
    # Lima's qemu driver; the UEFI firmware it needs ships inside qemu, and
    # Lima looks for it next to the qemu binary (ADR-0029).
    depends_on "qemu"
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.12.1/den_0.12.1_linux_arm64.zip"
      sha256 "9919276381f8cf287276ab1d1078b7fb976353bac604f3f46f307df1ceb15e49"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.12.1/den_0.12.1_linux_amd64.zip"
      sha256 "cb5540ed7206599c5ba8c29ca5fb0109f249b83ef8c6cb94aac86b770095de13"
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
