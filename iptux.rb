class Iptux < Formula
  homepage "https://github.com/iptux-src/iptux"
  url "https://github.com/iptux-src/iptux/archive/v0.6.2.tar.gz"
  sha256 "d567096d97b3b168dde1510f0ca00a13c6f8bb596131c234482377d7d8fb211b"

  depends_on :x11
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
