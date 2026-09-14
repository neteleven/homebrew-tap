# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  version "0.13.1"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  depends_on "lima"

  # The archives the release built, republished on the tap.
  on_macos do
    # Apple silicon only: an Intel Mac finds no URL here and Homebrew says
    # "formula requires at least a URL" -- docs/install.md names that error.
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.13.1/den_0.13.1_darwin_arm64.zip"
      sha256 "287ff36fad60d0e72e7b5bb9e5bc5f35839be5f4b4f38032b05da3ea72907c35"
    end
  end

  on_linux do
    # Lima's qemu driver; the UEFI firmware it needs ships inside qemu, and
    # Lima looks for it next to the qemu binary (ADR-0029).
    depends_on "qemu"
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.13.1/den_0.13.1_linux_arm64.zip"
      sha256 "05cd9fc6ac84309b42670967d55236a0dd064d747a9af9571428d0d88db6aca9"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.13.1/den_0.13.1_linux_amd64.zip"
      sha256 "03ff80bd0bea63790056ad0fdc8eaf31ed887e9e3f46843211d2c9764d7f82ab"
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
