class Hexchat < Formula
  desc "An IRC client based on XChat"
  homepage "https://hexchat.github.io/"
  url "https://dl.hexchat.net/hexchat/hexchat-2.10.2.tar.xz"
  mirror "https://mirrors.kernel.org/debian/pool/main/h/hexchat/hexchat_2.10.2.orig.tar.xz"
  sha256 "87ebf365c576656fa3f23f51d319b3a6d279e4a932f2f8961d891dd5a5e1b52c"
  revision 1

  bottle do
    sha256 "d7779c8e815a1a1e10ce39aa193b61dae38a51f190e8a56a96533e4aee70460f" => :el_capitan
    sha256 "4aedd07d7eae8d9554243356bdfd2bc055aa2797dc3de4f9fde45bbf1a87b4e1" => :yosemite
    sha256 "e7eff363cd99fa2003212a9426465a12f31f646e8709a762c07bf862f2eaa605" => :mavericks
  end

  head do
    url "https://github.com/hexchat/hexchat.git"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
    depends_on "autoconf-archive" => :build
  end

  option "without-perl", "Build without Perl support"
  option "without-plugins", "Build without plugin support"

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on :python => :optional
  depends_on :python3 => :optional
  depends_on "gettext"
  depends_on "gtk+"
  depends_on "gtk-mac-integration"
  depends_on "openssl"

  def install
    args = %W[--prefix=#{prefix}
              --disable-dependency-tracking
              --enable-openssl]

    if build.with? "python3"
      py_ver = Formula["python3"].version.to_s[0..2] # e.g "3.4"
      ENV.append_path "PKG_CONFIG_PATH", "#{HOMEBREW_PREFIX}/Frameworks/Python.framework/Versions/#{py_ver}/lib/pkgconfig/"
      args << "--enable-python=python#{py_ver}"
    elsif build.with? "python"
      ENV.append_path "PKG_CONFIG_PATH", "#{HOMEBREW_PREFIX}/Frameworks/Python.framework/Versions/2.7/lib/pkgconfig/"
      ENV.append_path "PKG_CONFIG_PATH", "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/pkgconfig/"
      args << "--enable-python=python2.7"
    else
      args << "--disable-python"
    end

    args << "--disable-perl" if build.without? "perl"
    args << "--disable-plugin" if build.without? "plugins"

    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end
    system "make", "install"

    rm_rf share/"applications"
    rm_rf share/"appdata"
  end

  test do
    system bin/"hexchat", "--help-gtk"
  end
end
