#!/bin/sh
eval "$(jenv init -)"
jenv local 21
java -Xmx2G -Xms1G -Djava.security.policy=java-minecraft-security.policy -jar spigot-1.21.8.jar nogui
