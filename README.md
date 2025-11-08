# Minecraft MCPI Experiments

Some experiments using minecraft mcpi for minecraft java edition.

## Prerequisites

The following is given for MacOS as prerequisites to be able to setup and start the minecraft server.

### Install Jenv

To install jEnv on macOS:

1. Install with Homebrew:

   ``` bash
   brew install jenv
   ```

2. After installation, add jEnv to your shell environment by adding the following lines to your shell configuration file (e.g., `~/.zshrc` for Zsh or `~/.bash_profile` for Bash):

   ``` bash
   export PATH="$HOME/.jenv/bin:$PATH"
   eval "$(jenv init -)"
   ```

3. Apply the changes by restarting the terminal or running:

   ``` bash
   source ~/.zshrc  
   ```

   or

   ``` bash
   source ~/.bash_profile
   ```

4. To verify installation, run:

   ``` bash
   jenv doctor
   ```

This setup helps manage multiple Java versions easily by switching between them without manually changing environment variables.

### Install Java and Register with Jenv

Java 21 is used for running the spigot minecraft server.
To install this Java version for use with jEnv follow these steps:

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

### Install Maven

To install Apache Maven on macOS, the easiest and most recommended method is to use the Homebrew package manager:

1. Install Apache Maven with the command:

   ```bash
   brew install maven
   ```

2. After installation, verify Maven is correctly installed by checking the version:

   ```bash
   mvn -version
   ```

This will install Maven and automatically set up the PATH environment variable for you.

## Setup Spigot Minecraft Server

```bash
cd minecraft_server
./setup-spigot-server.sh
```

## Start Spigot Minecraft Server

```bash
cd minecraft_server
./spigot-server.sh
```

## Stop Spigot Minecraft Server

Type command. 'stop' in the terminal 