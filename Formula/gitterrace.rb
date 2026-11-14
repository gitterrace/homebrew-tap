class Gitterrace < Formula
  desc "A local, read-only git browser: code, history and insights, offline."
  homepage "https://gitterrace.dev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.1.0/gitterrace-aarch64-apple-darwin.tar.gz"
      sha256 "29f9949fd11831161fd50285ac47a33fd4b759a9f4a8d9bc9b364039055ec664"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.1.0/gitterrace-x86_64-apple-darwin.tar.gz"
      sha256 "f0235dedfc18b6b4cddbfc5b955b2875dface7774d53dc05a2b1955649adb015"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.1.0/gitterrace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "91ed35e935499b325ddd4a8ad4d86b2b80363f6bb8d8f0a126816b05e564aeb6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gitterrace/gitterrace/releases/download/v0.1.0/gitterrace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bd42051650002780220d222d752c0fe70e6d3bd150a0aa4c77501d5d26ec76a6"
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
