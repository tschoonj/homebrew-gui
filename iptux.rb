class Iptux < Formula
  desc "Software for sharing in LAN"
  homepage "https://github.com/iptux-src/iptux"
  url "https://github.com/iptux-src/iptux/archive/v0.6.3.tar.gz"
  sha256 "91f4e478a4adfbfdb67be155fb68d01aa58cff9b2b27cd1dfe0dd1d4a4c26d93"

  bottle do
    sha256 "c24e790c78d6928472bd0740a843228715d9721f81e9a1e6f5f907b9fa7116eb" => :el_capitan
    sha256 "8c46792ae8a379a74fb9552e2307ee848cd1791d1fd24a9fe83b9656efd432ee" => :yosemite
    sha256 "24d1570b4fd4bf4f27993f503b25ec911243d2bb1da0771505dc53fa0bb04b16" => :mavericks
  end

  depends_on "gettext"
  depends_on "gtk+"
  depends_on "gconf"
  depends_on "hicolor-icon-theme"
  depends_on "pkg-config" => :build

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/iptux", "--version"
  end
end
