class Awo < Formula
  desc "Per-tmux-window AWS SSO profile switcher"
  homepage "https://github.com/sdgluck/awo"
  url "https://github.com/sdgluck/awo/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "e84a3602155363dbf2f473e7ed657d8935d630f7483ea965a3b2a8a20c53cf02"
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
