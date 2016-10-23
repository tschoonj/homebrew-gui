class Hexchat < Formula
  desc "IRC client based on XChat"
  homepage "https://hexchat.github.io/"
  url "https://dl.hexchat.net/hexchat/hexchat-2.12.3.tar.xz"
  sha256 "6f2b22372c7a9ed8ffab817079638e8f4178f5f8ba63c89cb3baa01be614f2ba"

  bottle do
    sha256 "28394453cdf0cd93b3e2af46a940de00ccbe57b9e0b2cdfae666e9365da9e108" => :sierra
    sha256 "a432a7905a20807635f0dd969967c01a6c4a3aa118e2ec2e44f89f992d003cd4" => :el_capitan
    sha256 "615a980cecbde57c6822cacf0f2b534896e0b323a4c9ec7dae8a7648aa8d6b48" => :yosemite
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
