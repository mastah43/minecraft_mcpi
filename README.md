# Minecraft MCPI Experiments

Some experiments using minecraft mcpi for minecraft java edition.

## Prerequisites

### Install Java and Jenv

Java 21 is used for running the spigot minecraft server.

#### On MacOS

To install Java 21 for use with jEnv on macOS, follow these steps:

1. Install Java 21 (OpenJDK 21) via Homebrew cask:

    ```bash
    brew tap homebrew/cask-versions
    brew install --cask temurin21
    ```

2. Create the symlink so macOS recognizes the Java installation in the standard JVM folder:

    ```bash
    sudo ln -sfn /opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-21.jdk
    ```

    (If you installed with temurin21, the path might be `/Library/Java/JavaVirtualMachines/temurin-21.jdk` instead.)

3. Install and initialize jEnv if not already installed:

    ```bash
    brew install jenv

    echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(jenv init -)"' >> ~/.zshrc
    echo 'jenv enable-plugin export' >> ~/.zshrc
    source ~/.zshrc
    ```

4. Add the Java 21 installation to jEnv:

    ```bash
    jenv add /Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home/
    ```

5. Verify the installed Java versions and active version:

    ```bash
    jenv versions
    java -version
    ```

    This method gives you Java 21 managed by jEnv on macOS, allowing easy switching between Java versions.

### Setup Spigot Minecraft Server

```bash
cd minecraft_server
./setup-spigot-server.sh
```

## Start Spigot Minecraft Server

```bash
cd minecraft_server
./spigot-server.sh
```
