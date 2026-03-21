#!/bin/bash
cd "$(dirname "$0")"

# Start with template
cat .release_template > Release

# Add timestamp
date -u +"%a, %d %b %Y %H:%M:%S +0000" | awk '{print "Date: " $0}' >> Release

# Add blank line before hashes
echo "" >> Release

# Calculate hashes for Packages and Packages.gz
if [ -f Packages ]; then
    PACKAGES_SHA=$(sha256sum Packages | cut -d' ' -f1)
    echo "  $PACKAGES_SHA  Packages" >> Release
fi

if [ -f Packages.gz ]; then
    PACKAGE SGZ_SHA=$(sha256sum Packages.gz | cut -d' ' -f1)
    echo "  $PACKAGES_GZ_SHA  Packages.gz" >> Release
fi

# Compress
gzip -fk Release
