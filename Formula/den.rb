# Rendered by packaging/homebrew/render-formula.sh into Formula/den.rb of
# neteleven/homebrew-tap; never edited or installed from here (ADR-0028).
class Den < Formula
  desc "Per-customer isolated development environments for AI agents"
  homepage "https://github.com/neteleven/den"
  version "0.15.6"
  license :cannot_represent # internal use only; THIRD-PARTY-NOTICES.md lists what den links

  depends_on "lima"

  # The archives the release built, republished on the tap.
  on_macos do
    # Apple silicon only (ADR-0039): Intel carries the same archive so that the
    # formula loads, and the requirement refuses it.
    depends_on arch: :arm64
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.6/den_0.15.6_darwin_arm64.zip"
      sha256 "256614a5c6ea10e2b1cc9c8b66b19902cc948c67622d74f49550d4675968f7d3"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.6/den_0.15.6_darwin_arm64.zip"
      sha256 "256614a5c6ea10e2b1cc9c8b66b19902cc948c67622d74f49550d4675968f7d3"
    end
  end

  on_linux do
    # Lima's qemu driver; the UEFI firmware it needs ships inside qemu, and
    # Lima looks for it next to the qemu binary (ADR-0029).
    depends_on "qemu"
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.6/den_0.15.6_linux_arm64.zip"
      sha256 "1f51a7c223ac37e4d02d512f87c6c2d89bc4c22e2346c306f8184f11f2ea5ac8"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/den-v0.15.6/den_0.15.6_linux_amd64.zip"
      sha256 "32a8fed3c61d14b11b20da27c5c611f0ec5befd7b26dc18fe056b9d8fbb53cee"
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
