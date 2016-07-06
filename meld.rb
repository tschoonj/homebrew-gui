class Meld < Formula
  desc "Visual diff tool for developers"
  homepage "http://meldmerge.org"
  url "https://download.gnome.org/sources/meld/3.16/meld-3.16.1.tar.xz"
  sha256 "1bec697aa1ababa315ca8241ade65dc68ea87f0d316632f590975afcf967cfab"

  bottle do
    cellar :any_skip_relocation
    sha256 "4ed00dfb0da174abf2ba50f82eb278a60b38f59c83a378eb16084bc1771899d1" => :el_capitan
    sha256 "f58af48e73062f033b149db7afd28c7009974c1674b3e0c8e744fa787d065f91" => :yosemite
    sha256 "0a90d5e16c5623559484c6b76d7dffe87c2afc04fa87c05aeac1f97382d0d1b2" => :mavericks
  end

  depends_on "intltool" => :build
  depends_on "itstool" => :build
  depends_on "libxml2" => [:build, "with-python"]
  depends_on :python
  depends_on "gtksourceview3"
  depends_on "pygobject3"
  depends_on "gobject-introspection"
  depends_on "hicolor-icon-theme"
  depends_on "gnome-icon-theme"

  def install
    ENV.append_path "PYTHONPATH", "#{Formula["libxml2"].opt_lib}/python2.7/site-packages"
    system "python", "setup.py", "--no-update-icon-cache",
           "--no-compile-schemas", "install", "--prefix=#{prefix}"
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "-f", "-t", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    system "#{bin}/meld", "--version"
  end
end
