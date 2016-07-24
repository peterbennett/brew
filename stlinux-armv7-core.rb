class StlinuxArmv7Core < Formula
  desc "Core binaries and development files for ARMV7 target filesystem"
  homepage "http://www.stlinux.com"
  url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-armv7-patch/target-core-armv7-2.4.tar.bz2"
  sha256 "f101d7aaafd296d61894305fad3d91a172283a1ea6f8e25bdcd9ed8198f4965c"
  version "2.4"
  
  depends_on "stlinux-armv7-filesystem"
  
  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/armv7/")
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
