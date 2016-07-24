class StlinuxArmv7Filesystem < Formula
  desc "This creates the opt location where all the other packages will be installed"
  homepage "http://www.stlinux.com"
  url "https://bitbucket.org/elkton/brew/raw/master/README.md"
  version "1.1"
  sha256 "2a5c96d678830a15e6bb30d62696bea724007a4594e9b6f194819f727c1e6e62"

  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/armv7/")
  end
  
  def install
    system "mkdir", "-p", "#{stdir}"
    system "mkdir", "#{stdir}/include"
    system "mkdir", "#{stdir}/bin"
    system "mkdir", "#{stdir}/lib"
    system "mkdir", "#{stdir}/libexec"
    system "mkdir", "#{stdir}/armv7-linux"
    system "mkdir", "#{stdir}/share"
    system "echo Hello > #{prefix}/a.file.brew.does.not.know"
  end

  test do
    system "stat #{stdir}"
  end
end
