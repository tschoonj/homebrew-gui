class TransmissionRemoteGtk < Formula
  desc "GTK remote interface to the Transmission BT client"
  homepage "https://github.com/transmission-remote-gtk/transmission-remote-gtk"
  url "https://github.com/transmission-remote-gtk/transmission-remote-gtk/releases/download/1.2/transmission-remote-gtk-1.2.tar.gz"
  sha256 "d2be9d3f6d14a79d8f94c5423b1d9ac0373b1af9c67fc551d8732a1d86904993"

  bottle do
    sha256 "66d37cefff6690f5295d62aaf724559124d148440fe4801d498e199b03cbd7ce" => :el_capitan
    sha256 "0f02165bff2345a47efa536bd1c88e5179b32b2c45080780e5ed908095b8f47b" => :yosemite
    sha256 "9c9a223e1b669b32f9b1d8d3733e632a7507878c709aae244993ff850c126019" => :mavericks
  end

  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "gtk+3"
  depends_on "json-glib"

  def install
    system "./configure", "--prefix=#{prefix}", "--enable-gtk3"
    system "make", "install"
  end
end
