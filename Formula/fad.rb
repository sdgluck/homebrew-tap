class Fad < Formula
  desc "Find and destroy: a terminal UI for finding what is using your disk and deleting it"
  homepage "https://github.com/sdgluck/fad"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sdgluck/fad/releases/download/v0.1.0/fad-aarch64-apple-darwin.tar.xz"
      sha256 "7ff0fbcb290d4e8c9a483b7ce89e5bd471a044abc0c4191fc2f59c2b82501d0c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sdgluck/fad/releases/download/v0.1.0/fad-x86_64-apple-darwin.tar.xz"
      sha256 "aae564600183b8b7ce6fd904aad67eaf3332d2fe5a0dacf7c6addee6e55ed86d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sdgluck/fad/releases/download/v0.1.0/fad-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9de3d178357a8c8026720460062485571c1bccfc0b42da4cc7467c659962e853"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sdgluck/fad/releases/download/v0.1.0/fad-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8df3a538d281bab9b1eedfb13cfebf2886ea34dde90fbd02af21043be5b312fb"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "fad"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fad"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "fad"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fad"
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
