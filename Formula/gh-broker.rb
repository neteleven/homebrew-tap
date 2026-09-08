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
  version "0.18.3"
  license :cannot_represent # proprietary; internal use only

  on_macos do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.18.3/gh-broker-aarch64-apple-darwin.tar.gz"
      sha256 "59df535b137b1c162edeeb68aa18af9dd1276f9b7ebef4bcc47e8c882b42d27c"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.18.3/gh-broker-x86_64-apple-darwin.tar.gz"
      sha256 "5af72ecd6d6276368937cfa37ae57ebd2083599a8562fa1bbd2f4a4d8b8d3fe8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.18.3/gh-broker-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4646eb1fb15559cd2506087587c18acaf63036bfa0056778524f72cb16977b50"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.18.3/gh-broker-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ce0643be03d8756d0ea414c74e16e7ecfd09344853bf01f2d68fb61e2640f94b"
    end
  end

  def install
    # Each tarball unpacks into a single top-level gh-broker-<target>/ dir
    # (binary + README.md); Homebrew strips that leading directory first.
    bin.install "gh-broker"
  end

  test do
    assert_match "gh-broker #{version}", shell_output("#{bin}/gh-broker --version")
  end
end
