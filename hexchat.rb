class Hexchat < Formula
  desc "IRC client based on XChat"
  homepage "https://hexchat.github.io/"
  url "https://dl.hexchat.net/hexchat/hexchat-2.12.2.tar.xz"
  sha256 "6dad783f37aac32a8301a12d498af7a74900f011aec4e77bb378ae9797a3ccf6"

  bottle do
    sha256 "4128005f89e860e3c2d086e3b19f9ae739606e13a20d7c64273937bf393155a2" => :el_capitan
    sha256 "2ed209db21c5dbf5c3767bf4553d32b348c53d9d37dae73759b9a60b84b4afe1" => :yosemite
    sha256 "7d8f17c46dd3e45b2ba4b3c8e84645dc94a7153f8fb03f52486963e2657f5c8e" => :mavericks
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
