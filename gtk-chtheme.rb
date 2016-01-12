class GtkChtheme < Formula
  desc "GTK+ 2.0 theme changer GUI"
  homepage "http://plasmasturm.org/code/gtk-chtheme/"
  url "http://plasmasturm.org/code/gtk-chtheme/gtk-chtheme-0.3.1.tar.bz2"
  sha256 "26f4b6dd60c220d20d612ca840b6beb18b59d139078be72c7b1efefc447df844"
  revision 1

  bottle do
    cellar :any
    sha256 "4e1559fa2ef3535ab4b8e90eab0956be94fde3a34250a96663957a457d3a9a7c" => :yosemite
    sha256 "697dcc6f584f5b3b2855aaec6ffe2c50a026de54c17b135c7c84079376fa3d4d" => :mavericks
    sha256 "50c9eb5b3b7dd20bab68ee748b13162e5466c4699f2c12bb10d15ee4fb9e052e" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "gtk+"

  def install
    # Unfortunately chtheme relies on some deprecated functionality
    # we need to disable errors for it to compile properly
    inreplace "Makefile", "-DGTK_DISABLE_DEPRECATED", ""

    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    # package contains just an executable and a man file
    # executable accepts no options and just spawns a GUI
    assert (bin/"gtk-chtheme").exist?
  end
end
