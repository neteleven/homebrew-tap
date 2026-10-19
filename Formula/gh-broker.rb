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
  version "0.21.1"
  license :cannot_represent # proprietary; internal use only

  on_macos do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.1/gh-broker-aarch64-apple-darwin.tar.gz"
      sha256 "2235c7f64131ca43f2e7900af22ce2cc93a3ee3b86ed0396cc85724f084f93f3"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.1/gh-broker-x86_64-apple-darwin.tar.gz"
      sha256 "6442166a6a85d710682201676d0860f1b5f450649b6c2b7218fa310fb55add43"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.1/gh-broker-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "089cd3d3d26459b834200dd300b2e47edc77cf131a3332ce92835a7e4059580b"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.1/gh-broker-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fa0c9c5d8da5d7cdc95bfddd658d0e74bed0851718e88661ab2eea72774ae2d4"
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
