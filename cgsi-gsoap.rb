class CgsiGsoap < Formula
  desc "Client and server side library to secure gSOAP using the Globus Security Infrastructure"
  homepage "http://dmc.web.cern.ch/"
  url "https://gitlab.cern.ch/dmc/cgsi-gsoap.git", :branch => "develop"
  version "1.3.11"

  depends_on "cmake" => :build
  depends_on "gsoap" => :build
  depends_on "globus-toolkit"
  depends_on "pkg-config" => :build
  depends_on "cern-fts/dmc/voms2"

  def install
    globus = Formula["globus-toolkit"].opt_prefix

    system "cmake", ".", "-DGLOBUS_PREFIX=#{globus}" , *std_cmake_args
    system "make", "install"
  end

  test do
   system "true"
  end
end
