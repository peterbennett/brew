class StlinuxSh4Autoconf < Formula
  desc "Automatic configure script builder"
  homepage "https://www.gnu.org/software/autoconf"
  url "http://ftpmirror.gnu.org/autoconf/autoconf-2.64.tar.gz"
  mirror "https://ftp.gnu.org/gnu/autoconf/autoconf-2.64.tar.gz"
  sha256 "a84471733f86ac2c1240a6d28b705b05a6b79c3cca8835c3712efbdf813c5eb6"

  depends_on "stlinux-sh4-filesystem"

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-autoconf/autoconf-2.64-nodefault_path.patch"
    sha256 "9425c664d853002b8e083598ab6163133c103c7ff735cc5655544afe00519c2e"
  end

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-autoconf/autoconf-2.64-m4_detection_not_portable.patch"
    sha256 "a3a84ed34573cdfe2fb9968f2b7fd9e8658be3873538be193ad5b15fdf7cc1d6"
  end

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-autoconf/autoconf-2.64-m4_detection_not_portable2.patch"
    sha256 "5564ba7f09c3883452728217f2b4164333a028a4d869425aed887c712213e5dc"
  end

  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/sh4/")
  end
  
  def install
    # GCC will suffer build errors if forced to use a particular linker.
    system "./configure",
           "--target=sh4-linux",
           "--prefix=#{stdir}",
           "--mandir=#{stdir}/share/man",
           "--infodir=#{stdir}/share/info",
           "--datadir=#{stdir}/share",
           "--sysconfdir=#{stdir}/etc",
           "--localstatedir=#{stdir}/var/lib",
           "--program-prefix=sh4-linux-",
           "--with-local-prefix=#{stdir}"
    system "make"
    system "make install"

    bin.install_symlink "#{stdir}/bin/sh4-linux-autoconf" => "sh4-linux-autoconf"
    bin.install_symlink "#{stdir}/bin/sh4-linux-autoheader" => "sh4-linux-autoheader"
    bin.install_symlink "#{stdir}/bin/sh4-linux-autom4te" => "sh4-linux-autom4te"
    bin.install_symlink "#{stdir}/bin/sh4-linux-autoreconf" => "sh4-linux-autoreconf"
    bin.install_symlink "#{stdir}/bin/sh4-linux-autoscan" => "sh4-linux-autoscan"
    bin.install_symlink "#{stdir}/bin/sh4-linux-autoupdate" => "sh4-linux-autoupdate"
    bin.install_symlink "#{stdir}/bin/sh4-linux-ifnames" => "sh4-linux-ifnames"
  end

  test do
    system "stat #{stdir}/bin/sh4-linux-autoconf"
  end
end
