# dart_demo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Deployment

### Web Deployment

Build the Flutter web app:

```bash
flutter build web
```

The built files will be located in `build/web/`. You can deploy these
files to any static web hosting service.

#### Local Development Server

**Using Python HTTP server (localhost only):**

```bash
cd build/web
python3 -m http.server 8080
```

Then open `http://localhost:8080` in your browser.

**Allow LAN access (bind to all interfaces):**

```bash
cd build/web
python3 -m http.server 8080 --bind 0.0.0.0
```

Then access via your machine's IP address:

- From local machine: `http://localhost:8080`
- From other devices on LAN: `http://<your-ip>:8080`

### Linux Deployment

**Prerequisites:**

- Linux development tools (build-essential, cmake, ninja-build)
- GTK development headers

**Install dependencies (Debian/Ubuntu):**

```bash
sudo apt-get update
sudo apt-get install -y build-essential cmake ninja-build \
    libgtk-3-dev libblkid-dev liblzma-dev pkg-config
```

**Build the Linux app:**

```bash
flutter build linux
```

**Run the app:**

```bash
./build/linux/x64/release/bundle/dart_demo
```

**Distribute the Linux app:**

The `build/linux/x64/release/bundle/` folder contains all necessary
files including the executable and shared libraries. You can:

1. **Archive and distribute:**

   ```bash
   cd build/linux/x64/release/
   tar czvf dart_demo_linux.tar.gz bundle/
   ```

1. **Create a desktop entry** (optional):

   Create a `.desktop` file in `~/.local/share/applications/`
   to add the app to your system menu.
