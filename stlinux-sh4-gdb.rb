class StlinuxSh4Gdb < Formula
  def arch
    if Hardware::CPU.type == :intel
      if MacOS.prefer_64_bit?
        "x86_64"
      else
        "i686"
      end
    elsif Hardware::CPU.type == :ppc
      if MacOS.prefer_64_bit?
        "powerpc64"
      else
        "powerpc"
      end
    end
  end

  def osmajor
    `uname -r`.chomp
  end

  desc "GNU debugger"
  homepage "https://www.gnu.org/software/gdb/"
  url "http://ftpmirror.gnu.org/gdb/gdb-7.6.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/gdb/gdb-7.6.tar.bz2"
  sha256 "a410e8f35ee70cce83dbbf1da9e2a8373f271ac0e4b71db4336ae293fc7bdf1b"
  
  depends_on "stlinux-sh4-filesystem"
  depends_on "stlinux-sh4-autoconf"
  depends_on "stlinux-sh4-core"

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-gdb/0001-gdb-7.6-stm.patch"
    sha256 "9f4434393cbee092619a71f2757e7f40917d37f92f4d3fa7cb6875e6b853be86"
  end

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-gdb/0002-darwin-nested-functions-aren-t-enabled-by-default-so.patch"
    sha256 "b5670641d96df7ce3b980f15a8277061f87158c2dd848a1f854561dafe1c6612"
  end

  patch :p1 do
    url "https://bitbucket.org/elkton/brew-patches/raw/master/stlinux-sh4-gdb/0003-fix-crap-code.c"
    sha256 "e0862ac0f58dbb14600d8608d325981d9a85ea348c8d352b97c97bd3c9cc0b5f"
  end

  def stdir
    Pathname.new("#{HOMEBREW_PREFIX}/opt/STM/STLinux-2.4/devkit/sh4/")
  end
  
  def install
    system "#{stdir}/bin/sh4-linux-autoconf"
    system "mkdir", "../gdb-obj"
    system "cd ../gdb-obj; ../gdb-7.6/configure " \
           "--build=#{arch}-apple-darwin#{osmajor} " \
           "--host=#{arch}-apple-darwin#{osmajor} " \
           "--target=sh4-linux " \
           "--prefix=#{stdir} " \
           "--mandir=#{stdir}/share/man " \
           "--infodir=#{stdir}/share/info " \
           "--datadir=#{stdir}/share " \
           "--sysconfdir=#{stdir}/etc " \
           "--localstatedir=#{stdir}/var/lib " \
           "--program-prefix=sh4-linux- " \
           "--with-sysroot=#{stdir}/target " \
           "--disable-gdbtk " \
           "--disable-werror " \
           "--without-python " \
           "--enable-linux-kernel-aware " \
           "--enable-shtdi"
    system "cd ../gdb-obj; make"
    system "cd ../gdb-obj; make install"

    bin.install_symlink "#{stdir}/bin/sh4-linux-gdb" => "sh4-linux-gdb"
  end

  test do
    system "#{stdir}/bin/sh4-linux-gdb -v"
  end
end
