class TransmissionRemoteGtk < Formula
  desc "GTK remote interface to the Transmission BT client"
  homepage "https://github.com/transmission-remote-gtk/transmission-remote-gtk"
  url "https://github.com/transmission-remote-gtk/transmission-remote-gtk/releases/download/1.3.1/transmission-remote-gtk-1.3.1.tar.xz"
  sha256 "1b29c573b1e205e3e7c2433dc4a48f9574278d97e033845d19bbffa1d7f75345"

  bottle do
    sha256 "31152453f9a1f37be6a8a9708f4fe7700c0c2beab0a7df17b0bc7697b57b8981" => :el_capitan
    sha256 "71e03421172b0db9022536fd86b9df676773f1b34bd904107a689bcbba1791d2" => :yosemite
    sha256 "fda18813fe8c12f406748e5f2b1976777cb8df579474b10ccbdfe80a6cca7acb" => :mavericks
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
