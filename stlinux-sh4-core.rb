class StlinuxSh4Core < Formula
  desc "Core binaries and development files for SH4 target filesystem"
  homepage "http://www.stlinux.com"
  url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-core/target-core-sh4-2.4.tgz"
  sha256 "bfc8efb8df2df7fa1b3babcd47f3ca05f92b55a9cb9afe75fd761609f5ac1baa"
  version "2.4"
  
  depends_on "stlinux-sh4-filesystem"
  
  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/sh4/")
  end
  
  def install
    system "pushd ..; cp -prf target #{stdir}; popd"
    system "rm -rf #{stdir}/target/.brew_home"
    system "echo Hello > #{prefix}/a.file.brew.does.not.know"
  end

  test do
    system "stat #{stdir}/target/etc/fstab"
    system "stat #{stdir}/target/tmp"
  end
end
