class Hexchat < Formula
  desc "An IRC client based on XChat"
  homepage "https://hexchat.github.io/"
  url "https://dl.hexchat.net/hexchat/hexchat-2.12.1.tar.xz"
  sha256 "5201b0c6d17dcb8c2cb79e9c39681f8e052999ba8f7b5986d5c1e7dc68fa7c6b"

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
  depends_on "gettext"
  depends_on "gtk+"
  depends_on "gtk-mac-integration"
  depends_on "openssl"
  depends_on :python => :optional
  depends_on :python3 => :optional
  depends_on "lua" => :optional

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-openssl=#{Formula["openssl"].opt_prefix}
    ]

    if build.with? "python3"
      ENV.delete("PYTHONPATH")
      # https://github.com/Homebrew/homebrew-gui/pull/9
      ENV["PYTHON_EXTRA_LIBS"] = " "
      args << "--enable-python=python3"
    elsif build.with? "python"
      args << "--enable-python=python2.7"
    else
      args << "--disable-python"
    end

    args << "--disable-perl" if build.without? "perl"
    args << "--disable-plugin" if build.without? "plugins"
    args << "--disable-lua" if build.without? "lua"

    # https://github.com/hexchat/hexchat/issues/1657
    args << "--disable-sysinfo" if MacOS.version <= :mavericks

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
