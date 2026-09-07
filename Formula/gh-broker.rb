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
      url "https://github.com/neteleven/homebrew-tap/releases/download/v0.18.3/gh-broker-aarch64-apple-darwin.tar.gz"
      sha256 "bc80ab2770345f16c02929cba0f8f95d5c67086d44ffdbb72a82c40378d714c6"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/v0.18.3/gh-broker-x86_64-apple-darwin.tar.gz"
      sha256 "8f02c3125af246dba5cd3ccb5b7fc2b5960da9264eca1fa44836f0f7effd2639"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/v0.18.3/gh-broker-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "03a2a8a07f663e9db6e1660c9f91e254c75934872af874788f0ee1419339692c"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/v0.18.3/gh-broker-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fddfe57a6a5df85d8c0cf6fa33a7da94250e734b98e14395cbcdba14af207453"
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
