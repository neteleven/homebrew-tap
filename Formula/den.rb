# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  version "0.15.5"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  depends_on "lima"

  # The archives the release built, republished on the tap.
  on_macos do
    # Apple silicon only (ADR-0039): Intel carries the same archive so that the
    # formula loads, and the requirement refuses it.
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.5/den_0.15.5_darwin_arm64.zip"
      sha256 "06dbb387d6f9aec7b98a9eef83a52047b1dfdbd15de4e0143bb17e0cb828c21f"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.5/den_0.15.5_darwin_arm64.zip"
      sha256 "06dbb387d6f9aec7b98a9eef83a52047b1dfdbd15de4e0143bb17e0cb828c21f"
    end
  end

  on_linux do
    # Lima's qemu driver; the UEFI firmware it needs ships inside qemu, and
    # Lima looks for it next to the qemu binary (ADR-0029).
    depends_on "qemu"
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.5/den_0.15.5_linux_arm64.zip"
      sha256 "b69da0563bad18b13dd126fa7fe6c740117752b09d73a6502d6bf7ffa197fd3b"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.5/den_0.15.5_linux_amd64.zip"
      sha256 "71e98313dc87f6c326949ef7983378bd6776a971a87fe2a0e5f5af0a0e35a7d1"
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
