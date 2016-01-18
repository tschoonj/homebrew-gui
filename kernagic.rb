class Kernagic < Formula
  homepage "https://github.com/hodefoting/kernagic/"
  url "https://github.com/hodefoting/kernagic/archive/v0.2.tar.gz"
  sha256 "41c328a2c177fd2c41f094641cdce4931115c34e69f140512d1461d42da502c2"
  head "https://github.com/hodefoting/kernagic.git"

  depends_on "pkg-config" => :build
  depends_on "gtk+"

  # removes option not provided by older clangs
  patch :DATA

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/kernagic -h"
  end
end
__END__
diff --git a/.mm/magic b/.mm/magic
index 088e5d9..d9e0a47 100644
--- a/.mm/magic
+++ b/.mm/magic
@@ -6,7 +6,7 @@ CFLAGS += -Wall -Wextra
 #CFLAGS += -g -O2 -rdynamic
 CFLAGS += -fPIC
 #CFLAGS += -fomit-frame-pointer
-CFLAGS += -funroll-loops -fforce-addr -ftracer -fpeel-loops -fmerge-all-constants
+CFLAGS += -funroll-loops -fforce-addr -ftracer -fmerge-all-constants
 CFLAGS += -Wno-unused-parameter  -Wno-sign-compare
 CFLAGS +=  -I. -D_XOPEN_SOURCE=500
 CFLAGS += -std=c99

