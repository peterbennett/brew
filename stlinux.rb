class Stlinux < Formula
  desc ""
  homepage ""
  url "stlinux24"
  version "2.4"
  sha256 "ef5b82d6aa275dd2e56bfe4fec1021d6ff0ffd30f7fe1b6e9e7dab659a9c79ec"

  depends_on "stlinux-sh4-filesystem"
  depends_on "stlinux-sh4-gcc"

  
  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/sh4/")
  end
  
  def install
  end

  test do
    system "true"
  end
end
