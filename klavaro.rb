class Klavaro < Formula
  desc "A free touch typing tutor program"
  homepage "http://klavaro.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/klavaro/klavaro-3.01.tar.bz2"
  mirror "https://mirrors.kernel.org/debian/pool/main/k/klavaro/klavaro_3.01.orig.tar.bz2"
  sha256 "ed71d522c29113d5d6517a65cbf95dafbe85ca4bb978139b804b98f128015e85"

  bottle do
    sha256 "93914a2c1ab59e2584c76289e3bb70932093a255e88a459676c73fd053e69953" => :el_capitan
    sha256 "185b17400268d72f35ba0d0f3b3636ad38b65a30a12aac1686efb29eecdc39ee" => :yosemite
    sha256 "187ec06c8715d18402ec0aa445ad80ece89a38fdca7d087f0e828d98d7cc3cc5" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gtk+3"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"klavaro", "--help-gtk"
  end
end
