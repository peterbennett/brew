class StlinuxSh4Filesystem < Formula
  desc "This creates the opt location where all the other packages will be installed"
  homepage "http://www.stlinux.com"
  url "https://bitbucket.org/elkton/brew/overview"
  version "1.0"
  sha256 "8cd3e0bb4d1d2cf5a008a301eb6e46b5d41f64ca1eceedabd92ad1284dc69c82"

  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/sh4/")
  end
  
  def install
    system "mkdir", "-p", "#{stdir}"
    system "mkdir", "#{stdir}/include"
    system "mkdir", "#{stdir}/bin"
    system "mkdir", "#{stdir}/lib"
    system "mkdir", "#{stdir}/libexec"
    system "mkdir", "#{stdir}/sh4-linux"
    system "mkdir", "#{stdir}/share"
  end

  test do
    system "stat #{stdir}"
  end
end
