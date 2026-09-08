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
  version "0.20.0"
  license :cannot_represent # proprietary; internal use only

  on_macos do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.20.0/gh-broker-aarch64-apple-darwin.tar.gz"
      sha256 "2202230a72db8eb340c475c86d06e4f232e11e2e54e6b22cd6316176908c14c3"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.20.0/gh-broker-x86_64-apple-darwin.tar.gz"
      sha256 "2875abf598fa63759c255fa5f8b076e2dce2bef328b722ccb5803235d33add3e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.20.0/gh-broker-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3bf2d9497b0789ffa91a288639185a6603280b727bd81d16bfc77c5e59bf7ff8"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.20.0/gh-broker-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fabdca435b5a3696ec1a5e340c15183d89095325151785046a0ea8a0614b86ec"
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
