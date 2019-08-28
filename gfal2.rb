class Gfal2 < Formula
  desc "Grid file access library 2"
  homepage "http://dmc.web.cern.ch/"
  url "https://gitlab.cern.ch/dmc/gfal2.git", :branch => "mac_build"
  version "2.16.0"

  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "davix" => :build
  depends_on "json-c"
  depends_on "glib"
  depends_on "globus-toolkit"
  depends_on "libssh2"
  depends_on "pkg-config" => :build
  depends_on "srm-ifce"
  depends_on "xrootd"

  def install
    ENV.libcxx
    globus = Formula["globus-toolkit"].opt_prefix
    xrootd = Formula["xrootd"].opt_prefix

    system "cmake", "-DGLOBUS_PREFIX=#{globus}", "-DXROOTD_LOCATION=#{xrootd}", "-DSKIP_TESTS=ON", "-DPLUGIN_RFIO=OFF", "-DPLUGIN_LFC=OFF", "-DPLUGIN_DCAP=OFF", "-DPLUGIN_HTTP=ON", ".", *std_cmake_args
    system "make", "install"
  end

  test do
   system "#{bin}/gfal2_version"
  end
end
