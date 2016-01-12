class Gtkwave < Formula
  desc "A fully featured GTK+ based wave viewer"
  homepage "http://gtkwave.sourceforge.net/"
  url "http://gtkwave.sourceforge.net/gtkwave-3.3.68.tar.gz"
  sha256 "9846ced0601c32c87bfda236ccadc2c6435a76c3a799b0d17ed54a5d7391343e"

  bottle do
    cellar :any
    sha256 "2ad4705fc8de2c8b5bff566a075f938e65117bbed5c6b54b05b1c87433965b09" => :el_capitan
    sha256 "81dc8bab9aa104cb072042681e0eaa8d1b3b1c856bef17d9aa55bcdc048b7163" => :yosemite
    sha256 "7408ae0aa0af02fa1447c6930f0909e065fe7fbccc82b8852f1f0de1e92b7152" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "gtk+"
  depends_on "gtk-mac-integration"
  depends_on "xz" # For LZMA support

  def install
    args = ["--disable-dependency-tracking",
            "--disable-silent-rules",
            "--prefix=#{prefix}"
           ]

    unless MacOS::CLT.installed?
      args << "--with-tcl=#{MacOS.sdk_path}/System/Library/Frameworks/Tcl.framework"
      args << "--with-tk=#{MacOS.sdk_path}/System/Library/Frameworks/Tk.framework"
    end

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/gtkwave", "--version"
  end
end
