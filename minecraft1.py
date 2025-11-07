from mcpi.minecraft import Minecraft
from mcpi.block import Block

# mcpi is supported on minecraft java servers 
# via the plugin https://www.curseforge.com/minecraft/bukkit-plugins/raspberryjuice

mc = Minecraft.create(address = "localhost", port = 4711)
mc.postToChat("Hello, Minecraft!")
for i in range(10):
    mc.setBlock(1, -59 + i, 1, 5)

print("player position:", mc.player.getPos())