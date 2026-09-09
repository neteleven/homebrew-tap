# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  version "0.10.0"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  depends_on "lima"

  # The archives the release built, republished on the tap.
  on_macos do
    # Apple silicon only: an Intel Mac finds no URL here and Homebrew says
    # "formula requires at least a URL" -- docs/install.md names that error.
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.10.0/den_0.10.0_darwin_arm64.zip"
      sha256 "3b510985e1de84f8258cf8f88c8b6aa659071922cc3f3b39e20926d5fe4fa63b"
    end
  end

  on_linux do
    # Lima's qemu driver; the UEFI firmware it needs ships inside qemu, and
    # Lima looks for it next to the qemu binary (ADR-0029).
    depends_on "qemu"
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.10.0/den_0.10.0_linux_arm64.zip"
      sha256 "f2ed08ac7aca63cc376a19fe91ccdf8c19a5ed2a3da41f1b1d7c7a8fcf5dac9c"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.10.0/den_0.10.0_linux_amd64.zip"
      sha256 "84e3a30fdc3bf8b407ffbd99edc4ced3f06ec0f4e2fe152813c671ac7b19ba93"
    end
  end

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
