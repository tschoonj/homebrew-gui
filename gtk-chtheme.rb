class GtkChtheme < Formula
  desc "GTK+ 2.0 theme changer GUI"
  homepage "http://plasmasturm.org/code/gtk-chtheme/"
  url "http://plasmasturm.org/code/gtk-chtheme/gtk-chtheme-0.3.1.tar.bz2"
  sha256 "26f4b6dd60c220d20d612ca840b6beb18b59d139078be72c7b1efefc447df844"
  revision 1

  bottle do
    cellar :any
    sha256 "33e72ae094e1e993a20f183a99b8aae76627bd1759d423bfef9f5fe569a3e60b" => :el_capitan
    sha256 "58943301b57507c6dc0044123a15e2ef09f563be3811b54424514811b8dd7732" => :yosemite
    sha256 "2bc04ecbf045292305bd7c14e0c717c5f27b9fbd2ada823703cdc6e35a7e8d96" => :mavericks
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
