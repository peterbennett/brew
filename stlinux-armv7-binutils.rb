class StlinuxArmv7Binutils < Formula
  desc "FSF Binutils for native development"
  homepage "https://www.gnu.org/software/binutils/binutils.html"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.25.tar.gz"
  sha256 "cccf377168b41a52a76f46df18feb8f7285654b3c1bd69fc8265cb0fc6902f2d"
  
  depends_on "stlinux-armv7-filesystem"
  depends_on "gettext"
  depends_on "flex"
  depends_on "bison"

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-armv7-patch/binutils-2.25-linaro-4.9-2015.01.patch"
    sha256 "d261f021e393c6879ce3ba49284c33888537ae3ee59b3406470a3b36d83b2edc"
  end
  
  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-armv7-patch/binutils-2.22-arm-warn-tag-vfp.patch"
    sha256 "9768039be9da83aa6c3579e5130c2e2d497bfddcf94664d32db80ebe3a8afe1c"
  end
  
  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/armv7/")
  end
  
  def install
    system "./configure",
           "--target=arm-cortex-linux-gnueabi",
           "--prefix=#{stdir}",
           "--mandir=#{stdir}/share/man",
           "--infodir=#{stdir}/share/info",
           "--datadir=#{stdir}/share",
           "--sysconfdir=#{stdir}/etc",
           "--localstatedir=#{stdir}/var/lib",
           "--enable-nls",
           "--disable-multilib",
           "--with-system-zlib",
           "--with-float=hard",
           "--program-prefix=armv7-linux-",
           "--with-pkgversion=\"GNU Binutils - STMicroelectronics/Linux Base\"",
           "--with-bugurl=\"https://bitbucket.org/elkton/brew/issues\"",
           "--enable-install-libiberty",
           "--enable-install-libbfd",
           "--with-sysroot=#{stdir}/target",
           "--disable-werror"
    system "make"
    system "make", "install"

    bin.install_symlink "#{stdir}/bin/armv7-linux-objcopy" => "armv7-linux-objcopy"
    bin.install_symlink "#{stdir}/bin/armv7-linux-objdump" => "armv7-linux-objdump"
    bin.install_symlink "#{stdir}/bin/armv7-linux-readelf" => "armv7-linux-readelf"
    bin.install_symlink "#{stdir}/bin/armv7-linux-nm" => "armv7-linux-nm"
    bin.install_symlink "#{stdir}/bin/armv7-linux-nm" => "armv7-linux-nm"
    bin.install_symlink "#{stdir}/bin/armv7-linux-as" => "armv7-linux-as"
    bin.install_symlink "#{stdir}/bin/armv7-linux-ar" => "armv7-linux-ar"
    bin.install_symlink "#{stdir}/bin/armv7-linux-ld" => "armv7-linux-ld"
    bin.install_symlink "#{stdir}/bin/armv7-linux-ld.bfd" => "armv7-linux-ld.bfd"
    bin.install_symlink "#{stdir}/bin/armv7-linux-ar" => "armv7-linux-ar"
    bin.install_symlink "#{stdir}/bin/armv7-linux-ranlib" => "armv7-linux-ranlib"
    bin.install_symlink "#{stdir}/bin/armv7-linux-addr2line" => "armv7-linux-addr2line"
    bin.install_symlink "#{stdir}/bin/armv7-linux-elfedit" => "armv7-linux-elfedit"
    bin.install_symlink "#{stdir}/bin/armv7-linux-gprof" => "armv7-linux-gprof"
    bin.install_symlink "#{stdir}/bin/armv7-linux-size" => "armv7-linux-size"
    bin.install_symlink "#{stdir}/bin/armv7-linux-strings" => "armv7-linux-strings"
    bin.install_symlink "#{stdir}/bin/armv7-linux-strip" => "armv7-linux-strip"
    bin.install_symlink "#{stdir}/bin/armv7-linux-c++filt" => "armv7-linux-c++filt"
  end

  test do
    system "#{stdir}/bin/armv7-linux-objcopy -V"
    system "#{stdir}/bin/armv7-linux-objdump -V"
    system "#{stdir}/bin/armv7-linux-readelf -v"
    system "#{stdir}/bin/armv7-linux-nm -V"
    system "#{stdir}/bin/armv7-linux-ld -V"
    system "#{stdir}/bin/armv7-linux-ar -V"
    system "#{stdir}/bin/armv7-linux-c++filt -v"
  end
end
