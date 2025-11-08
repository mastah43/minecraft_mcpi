#!/bin/bash

# Setup script for Spigot with RaspberryJuice plugin
# This script downloads and builds Spigot server and installs the RaspberryJuice plugin

set -e  # Exit on error

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo "========================================="
echo "Spigot Server Setup Script"
echo "Installation directory: $SCRIPT_DIR"
echo "========================================="
echo ""

# Variables
SPIGOT_VERSION="1.21.8"
SPIGOT_JAR="spigot-${SPIGOT_VERSION}.jar"
BUILDTOOLS_URL="https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
RASPBERRYJUICE_VERSION="1.12.1"
RASPBERRYJUICE_URL="https://github.com/zhuowei/RaspberryJuice/releases/download/${RASPBERRYJUICE_VERSION}/raspberryjuice-${RASPBERRYJUICE_VERSION}.jar"
RASPBERRYJUICE_JAR="raspberryjuice-${RASPBERRYJUICE_VERSION}.jar"

# Step 1: Check for Java
echo "[1/7] Checking Java installation..."
if command -v jenv &> /dev/null; then
    echo "  ✓ jenv found, initializing..."
    eval "$(jenv init -)"
    if jenv versions | grep -q "21"; then
        jenv local 21
        echo "  ✓ Java 21 configured via jenv"
    else
        echo "  ✗ Java 21 not found in jenv. Please install Java 21. See ../README.md for instructions."
        exit 1
    fi
elif command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
    echo "  ✓ Java found (version: $JAVA_VERSION)"
    if [ "$JAVA_VERSION" -lt 21 ]; then
        echo "  ⚠ Warning: Java 21 or higher is recommended for Spigot 1.21.8"
    fi
else
    echo "  ✗ Java not found. Please install Java 21 or higher. See ../README.md for instructions."
    exit 1
fi
echo ""

# Step 2: Download BuildTools if Spigot jar doesn't exist
if [ -f "$SPIGOT_JAR" ]; then
    echo "[2/7] Spigot jar already exists: $SPIGOT_JAR"
    echo "  Skipping BuildTools download and build."
    echo ""
else
    echo "[2/7] Downloading Spigot BuildTools..."
    if [ ! -f "BuildTools.jar" ]; then
        curl -L -o BuildTools.jar "$BUILDTOOLS_URL"
        echo "  ✓ BuildTools.jar downloaded"
    else
        echo "  ✓ BuildTools.jar already exists"
    fi
    echo ""

    # Step 3: Build Spigot
    echo "[3/7] Building Spigot ${SPIGOT_VERSION}..."
    echo "  This may take several minutes..."
    java -jar BuildTools.jar --rev ${SPIGOT_VERSION}

    if [ -f "$SPIGOT_JAR" ]; then
        echo "  ✓ Spigot ${SPIGOT_VERSION} built successfully"
    else
        echo "  ✗ Failed to build Spigot. Check for errors above."
        exit 1
    fi
    echo ""
fi

# Step 4: Create plugins directory
echo "[4/7] Setting up plugins directory..."
mkdir -p plugins
echo "  ✓ plugins/ directory ready"
echo ""

# Step 5: Buid RaspberryJuice plugin
echo "[5/7] Installing RaspberryJuice plugin..."
if [ -f "plugins/$RASPBERRYJUICE_JAR" ]; then
    echo "  ✓ RaspberryJuice plugin already exists"
else
    echo "  Building RaspberryJuice ${RASPBERRYJUICE_VERSION}..."
    git clone https://github.com/zhuowei/RaspberryJuice
    cd RaspberryJuice
    sed -i.bak 's/<source>1\.7<\/source>/<source>1.8<\/source>/g' pom.xml
    sed -i.bak 's/<target>1\.7<\/target>/<target>1.8<\/target>/g' pom.xml
    mvn package
    cp target/raspberryjuice-${RASPBERRYJUICE_VERSION}.jar ../plugins/
    echo "  ✓ RaspberryJuice plugin installed"
fi
echo ""

# Step 6: Accept EULA
echo "[6/7] Accepting Minecraft EULA..."
if [ -f "eula.txt" ]; then
    sed -i.bak 's/eula=false/eula=true/g' eula.txt
    echo "  ✓ EULA already exists, ensured eula=true"
else
    echo "eula=true" > eula.txt
    echo "  ✓ EULA accepted (eula.txt created)"
fi
echo ""

# Step 7: Configuration check
echo "[7/7] Checking configuration files..."
if [ -f "server.properties" ]; then
    echo "  ✓ server.properties exists"
else
    echo "  ⚠ server.properties not found (will be generated on first run)"
fi

if [ -f "spigot.yml" ]; then
    echo "  ✓ spigot.yml exists"
else
    echo "  ⚠ spigot.yml not found (will be generated on first run)"
fi

echo ""

# Final summary
echo "========================================="
echo "Setup Complete!"
echo "========================================="
echo ""
echo "Installed components:"
echo "  - Spigot ${SPIGOT_VERSION} → $SPIGOT_JAR"
echo "  - RaspberryJuice ${RASPBERRYJUICE_VERSION} → plugins/$RASPBERRYJUICE_JAR"
echo ""
echo "To start the server, run:"
echo "  ./spigot-server.sh"
echo ""
