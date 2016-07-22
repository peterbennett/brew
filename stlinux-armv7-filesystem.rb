class StlinuxArmv7Filesystem < Formula
  desc "This creates the opt location where all the other packages will be installed"
  homepage "http://www.stlinux.com"
  url "https://bitbucket.org/elkton/brew/overview"
  version "1.0"
  sha256 "1ca438cea5862975631bdc61fdbec3767f88221306f295df81c98c160d82c823"

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
