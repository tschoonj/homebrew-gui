class TransmissionRemoteGtk < Formula
  desc "GTK remote interface to the Transmission BT client"
  homepage "https://github.com/transmission-remote-gtk/transmission-remote-gtk"
  url "https://github.com/transmission-remote-gtk/transmission-remote-gtk/releases/download/1.2/transmission-remote-gtk-1.2.tar.gz"
  sha256 "d2be9d3f6d14a79d8f94c5423b1d9ac0373b1af9c67fc551d8732a1d86904993"

  bottle do
    sha256 "43bb2154c2ae72de79d279622fcba23b1891404c8ad1bcc047335faad59291b5" => :el_capitan
    sha256 "31d4aa3cba2fa14a36f1a1e727402e46ed3e7757763ebd9da6c8b8060751df80" => :yosemite
    sha256 "66f9c3d4ae7ac5949a4f9d6d72c1ccfde14ae2d761e141f68d5014d9b13879eb" => :mavericks
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
