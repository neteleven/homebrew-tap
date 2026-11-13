# Template for the gh-broker Homebrew formula. Rendered by
# packaging/homebrew/render-formula.sh — never edited or installed directly.
#
# gh-broker's source repo is private, so this formula does not build from the
# git tag (that would need reused git credentials and still force a local
# `cargo build` with LTO) and does not download from a private GitHub release
# on this repo (that would need HOMEBREW_GITHUB_API_TOKEN, a token every user
# must set). Instead, release.yml's `brew-tap` job publishes the four prebuilt
# tarballs it already builds as a Release on the public neteleven/homebrew-tap
# repo, then renders this template with that release's version, public
# release-download URLs, and checksums, and commits the result as
# Formula/gh-broker.rb in that same repo. Users install anonymously via
# `brew tap neteleven/tap` — no token, no local compile. See README "Install"
# and docs/adr/0018.
class GhBroker < Formula
  desc "GitHub token broker client that mints short-lived repo-scoped tokens"
  homepage "https://github.com/neteleven/github-broker-client"
  version "0.21.2"
  license :cannot_represent # proprietary; internal use only

  on_macos do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.2/gh-broker-aarch64-apple-darwin.tar.gz"
      sha256 "3b822959b26b7cd27084f4480aa72ffbc9883002a5d86e984c40682d368c7c74"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.2/gh-broker-x86_64-apple-darwin.tar.gz"
      sha256 "df3bf2d9588249fbbf10613c01bf338ee9a5e7d4398f43c57fb604cef6c5f0a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.2/gh-broker-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4a4366c451721d7dfb0161995631bbf6439efb714094ef9d3165da6edfc5636c"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.2/gh-broker-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "65aab77fd471d22dcdb0812e1c132ef7947b416249ce8b0452884507f89d716d"
    end
  end

  def install
    # Each tarball unpacks into a single top-level gh-broker-<target>/ dir
    # (just the binary); Homebrew strips that leading directory first.
    bin.install "gh-broker"
  end

  test do
    assert_match "gh-broker #{version}", shell_output("#{bin}/gh-broker --version")
  end
end
