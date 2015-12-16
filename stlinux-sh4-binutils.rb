class StlinuxSh4Binutils < Formula
  desc "FSF Binutils for native development"
  homepage "https://www.gnu.org/software/binutils/binutils.html"
  url "https://www.kernel.org/pub/linux/devel/binutils/binutils-2.24.51.0.3.tar.gz"
  sha256 "3ca44f752c445de05707b06f9467b6907e63a4a953390f29e371d5fcb1335666"
  version "2.24.51.0.3"
  
  depends_on "stlinux-sh4-filesystem"
  depends_on "gettext"
  depends_on "flex"
  depends_on "bison"

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-binutils/binutils-2.24.51.0.3-stm-140630.patch"
    sha256 "5fd058a1beec4aab0b7eb5356ca9d2259e49b07855dd88b7cd534d5f0309ade4"
  end
  
  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-binutils/binutils-2.23.2-config_bfd.patch"
    sha256 "3d8f5c16c7d7339f87603421cec66637571d61a216c285cd940cb7111360facf"
  end
  
  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/sh4/")
  end
  
  def install
    system "./configure",
           "--enable-nls",
           "--disable-multilib",
           "--with-system-zlib",
           "--program-prefix=sh4-linux-",
           "--with-pkgversion=\"GNU Binutils - STMicroelectronics/Linux Base\"",
           "--with-bugurl=\"https://bitbucket.org/elkton/brew/issues\"",
           "--enable-install-libiberty",
           "--enable-install-libbfd",
           "--with-sysroot=#{stdir}/target",
           "--target=sh4-linux",
           "--disable-werror",
           "--prefix=#{stdir}",
           "--mandir=#{stdir}/share/man",
           "--infodir=#{stdir}/share/info",
           "--datadir=#{stdir}/share",
           "--sysconfdir=#{stdir}/etc",
           "--localstatedir=#{stdir}/var/lib"
    system "make"
    system "make", "install"

    bin.install_symlink "#{stdir}/bin/sh4-linux-objcopy" => "sh4-linux-objcopy"
    bin.install_symlink "#{stdir}/bin/sh4-linux-objdump" => "sh4-linux-objdump"
    bin.install_symlink "#{stdir}/bin/sh4-linux-readelf" => "sh4-linux-readelf"
    bin.install_symlink "#{stdir}/bin/sh4-linux-nm" => "sh4-linux-nm"
    bin.install_symlink "#{stdir}/bin/sh4-linux-nm" => "sh4-linux-nm"
    bin.install_symlink "#{stdir}/bin/sh4-linux-as" => "sh4-linux-as"
    bin.install_symlink "#{stdir}/bin/sh4-linux-ar" => "sh4-linux-ar"
    bin.install_symlink "#{stdir}/bin/sh4-linux-ld" => "sh4-linux-ld"
    bin.install_symlink "#{stdir}/bin/sh4-linux-ld.bfd" => "sh4-linux-ld.bfd"
    bin.install_symlink "#{stdir}/bin/sh4-linux-ar" => "sh4-linux-ar"
    bin.install_symlink "#{stdir}/bin/sh4-linux-ranlib" => "sh4-linux-ranlib"
    bin.install_symlink "#{stdir}/bin/sh4-linux-addr2line" => "sh4-linux-addr2line"
    bin.install_symlink "#{stdir}/bin/sh4-linux-elfedit" => "sh4-linux-elfedit"
    bin.install_symlink "#{stdir}/bin/sh4-linux-gprof" => "sh4-linux-gprof"
    bin.install_symlink "#{stdir}/bin/sh4-linux-size" => "sh4-linux-size"
    bin.install_symlink "#{stdir}/bin/sh4-linux-strings" => "sh4-linux-strings"
    bin.install_symlink "#{stdir}/bin/sh4-linux-strip" => "sh4-linux-strip"
    bin.install_symlink "#{stdir}/bin/sh4-linux-c++filt" => "sh4-linux-c++filt"
  end

  test do
    system "#{stdir}/bin/sh4-linux-objcopy -V"
    system "#{stdir}/bin/sh4-linux-objdump -V"
    system "#{stdir}/bin/sh4-linux-readelf -v"
    system "#{stdir}/bin/sh4-linux-nm -V"
    system "#{stdir}/bin/sh4-linux-ld -V"
    system "#{stdir}/bin/sh4-linux-ar -V"
    system "#{stdir}/bin/sh4-linux-c++filt -v"
  end
end
