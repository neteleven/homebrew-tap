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
  version "0.18.4"
  license :cannot_represent # proprietary; internal use only

  on_macos do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.18.4/gh-broker-aarch64-apple-darwin.tar.gz"
      sha256 "e9e382fd34694f84815e8fc1270b1efcd8d31baa2435953db374b95e5a31e14a"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.18.4/gh-broker-x86_64-apple-darwin.tar.gz"
      sha256 "ee17b9915326bdea0ea7d968270440898732b45c6d8e8dbcc25aab12bee88f6c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.18.4/gh-broker-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bce3b8282286e2f0457c02fbc17d907ddec11a46afa033acdc38c3acefab8df6"
    end
    on_intel do
      url "https://github.com/neteleven/homebrew-tap/releases/download/gh-broker-v0.18.4/gh-broker-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9a4feca106aded6f888451f062448738476efb8acc6ef5f91940e4cc194a704c"
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
