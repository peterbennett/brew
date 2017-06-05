class StlinuxSh4Filesystem < Formula
  desc "This creates the opt location where all the other packages will be installed"
  homepage "http://www.stlinux.com"
  url "https://bitbucket.org/elkton/brew/overview"
  version "1.0"
  sha256 "189a51fdab9b28970211951d79ca5c4d3e5f5e06333fc85dc187e80f3768ce13"

  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/sh4/")
  end
  
  def install
    system "mkdir", "-p", "#{stdir}"
    system "mkdir", "-p","#{stdir}/include"
    system "mkdir", "-p","#{stdir}/bin"
    system "mkdir", "-p","#{stdir}/lib"
    system "mkdir", "-p","#{stdir}/libexec"
    system "mkdir", "-p","#{stdir}/sh4-linux"
    system "mkdir", "-p","#{stdir}/share"
    system "touch", "hello"
    system "touch", "#{prefix}/hello"
  end

  test do
    system "stat #{stdir}"
  end
end
