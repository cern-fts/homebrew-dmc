class Gfal2Python < Formula
  desc "Grid file access library 2"
  homepage "http://dmc.web.cern.ch/"
  url "https://gitlab.cern.ch/dmc/gfal2-bindings.git", :branch => "develop"
  version "1.8.3"

  depends_on "boost-python"
  depends_on "cmake" => :build
  depends_on "gfal2"
  depends_on "pkg-config" => :build
  depends_on "python"

  def install
    python = Formula["python"].opt_prefix

    system "cmake", "-DSKIP_DOC=ON",
        "-DPYTHON_LIBRARIES=#{python}/Frameworks/Python.framework/Versions/Current/lib/libpython2.7.dylib",
        "-DPYTHON_INCLUDE_PATH=#{python}/Frameworks/Python.framework/Versions/Current/include/python2.7",
        "-DPYTHON_EXECUTABLE=#{python}/Frameworks/Python.framework/Versions/Current/bin/python",
        ".", *std_cmake_args
    system "make", "install"
  end

  test do
    ENV["PYTHONPATH"] = lib+"python2.7/site-packages"
    system "python", "-c", "import gfal2; print gfal2.__version__"
  end
end

