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
  version "0.21.0"
  license :cannot_represent # proprietary; internal use only

  on_macos do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.0/gh-broker-aarch64-apple-darwin.tar.gz"
      sha256 "030b9f3c848f3a74dde0004291c0228c1d47e5deb7d2b09a03a1f5b5bfcbe199"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.0/gh-broker-x86_64-apple-darwin.tar.gz"
      sha256 "d50597522ea3633f3cc8a4a1d8b9a9db3922434cdc47e089176c0eb1fb781580"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.0/gh-broker-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e4f529510ab985922c1b8a7b3a61f4d21dc87e4be6bc32521bfaa3b0237d4a03"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.21.0/gh-broker-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6d7ddaeca7e982a1ab1dd6b4eeb3c099900ee3462aa231697de047b01ff2bf50"
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
