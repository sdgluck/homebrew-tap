class Awo < Formula
  desc "Per-tmux-window AWS SSO profile switcher"
  homepage "https://github.com/sdgluck/awo"
  url "https://github.com/sdgluck/awo/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "16871c09f752d1a1c78f25a72b49862103e32f755e184d7e2c74a7eb75f72320"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}")
  end

  def caveats
    <<~EOS
      Add the shell hook to ~/.zshrc:
        eval "$(awo init zsh)"
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/awo version").strip
  end
end
