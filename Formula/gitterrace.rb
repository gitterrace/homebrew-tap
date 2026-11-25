class Gitterrace < Formula
  desc "Review your repo before you push, and hand findings to any tool."
  homepage "https://gitterrace.dev"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.2.1/gitterrace-aarch64-apple-darwin.tar.gz"
      sha256 "af20510f474fd71c6348a6dbba9870c2009f156ed60132e61044ae465028ba0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.2.1/gitterrace-x86_64-apple-darwin.tar.gz"
      sha256 "1683b540d31941c34048b2449977874615a6cb2a3d9f4a7506ed9af1cba07119"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.2.1/gitterrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "32998743cc42c4421391ba2d0c8caf6c3ad8e6af708b3af5a3d81e40651aeab3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.2.1/gitterrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d85f2f5cffc33b072e3de970e6073eec1194c2f5b245d6d8b5474cf30eea7799"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "git-terrace"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-terrace"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "git-terrace"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-terrace"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
