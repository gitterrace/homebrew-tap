class Gitterrace < Formula
  desc "A local, read-only git browser: code, history and insights, offline."
  homepage "https://gitterrace.dev"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.1.1/gitterrace-aarch64-apple-darwin.tar.gz"
      sha256 "e254f2f54406fad3180d76684f2967b5348b0dd23a5f57d181a7fe33fee27c9a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.1.1/gitterrace-x86_64-apple-darwin.tar.gz"
      sha256 "fff2bb2a1dd01fdfe9458a243e3c5e7934a81c7830064a69650bbfdb93c8a1e6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.1.1/gitterrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "744c930eec3b3ce221f01231a8cc2333371e8aa6b4f5bc6cd795ea40cbe0cebb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.1.1/gitterrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c43ea1c516bbc4c97cfefd23b1c50bf22691515fa2555b77d991137beafa96dd"
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
