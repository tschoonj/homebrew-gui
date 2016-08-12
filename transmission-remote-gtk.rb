class TransmissionRemoteGtk < Formula
  desc "GTK remote interface to the Transmission BT client"
  homepage "https://github.com/transmission-remote-gtk/transmission-remote-gtk"
  url "https://github.com/transmission-remote-gtk/transmission-remote-gtk/releases/download/1.3.0/transmission-remote-gtk-1.3.0.tar.xz"
  sha256 "6fe30b4561681458500e61cc6db10c3b4b3771f69e2f6a74dbb7a20b03a3cbe6"

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
