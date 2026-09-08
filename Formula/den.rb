# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  version "0.9.2"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  depends_on "lima"

  # The archives the release built, republished on the tap.
  on_macos do
    # Apple silicon only: an Intel Mac finds no URL here and Homebrew says
    # "formula requires at least a URL" -- docs/install.md names that error.
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.9.2/den_0.9.2_darwin_arm64.zip"
      sha256 "ba3caa48362cfda6aeca7a1473456c207209a76927c4f2589fe28e33f4ab0b20"
    end
  end

  on_linux do
    # Lima's qemu driver; the UEFI firmware it needs ships inside qemu, and
    # Lima looks for it next to the qemu binary (ADR-0029).
    depends_on "qemu"
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.9.2/den_0.9.2_linux_arm64.zip"
      sha256 "174268b778fd049f8dcb62e2ad2a745086cac02173e64fa4e498be8c7a43504b"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.9.2/den_0.9.2_linux_amd64.zip"
      sha256 "a174e0001284744ab6e5228958c4997234be00404256a7373bbc1f8d9d6f9ade"
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
