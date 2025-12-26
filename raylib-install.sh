sudo dnf install -y \
  alsa-lib-devel \
  mesa-libGL-devel \
  libX11-devel \
  libXrandr-devel \
  libXi-devel \
  libXcursor-devel \
  libXinerama-devel \
  libatomic \
  wayland-devel \
  libxkbcommon-devel \
  wayland-protocols-devel

git clone https://github.com/raysan5/raylib.git raylib
cd raylib
mkdir build && cd build
cmake -DBUILD_SHARED_LIBS=ON -DGLFW_BUILD_WAYLAND=ON ..
make
sudo make install
sudo ldconfig
