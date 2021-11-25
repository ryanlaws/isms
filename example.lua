--- script
print("example.lua -------------> hello there")

function rgb4(r,g,b)
  return 0x110000*(r&0xf) + 0x001100*(g&0xf) + 0x000011*(b&0xf)
end

function rgb8(r,g,b)
  return 0x010000*(r&0xff) + 0x000100*(g&0xff) + 0x000001*(b&0xff)
end

for i=0,255 do
  window.pixel(i,4,0xFFFF00-i);
  window.pixel(i,8,0x00FFFF-i);
  window.pixel(i,12,0xFF00FF-i);
end

window.redraw()

x = 0
c,r,g,b = 0xff,0xff,0xff,0xff

function draw()
  x = (x + 3) % 250
  c = (c-5) & 0xff
  window.line(x,160,x+8,80,rgb8(c,c,c))
  window.redraw()
  print("color: "..string.format("0x%06x", rgb8(c,c,c)))
end

key = function(k)
  osc.send({"localhost",57120},"/n",{k%127})
  draw()
  print("key: "..k)
end

metro.tick = function(i,s)
  print("metro",i,s)
  draw()
  --grid.all(s)
  --grid.redraw()
end

metro.start(0.02,0.02,500,0);

g = grid.connect()
g.key = function(x,y,z)
  print("grid",x,y,z)
  osc.send({"localhost",57120},"/n",{(7-y)*5+x+30})
  g:led(x,y,15);
  g:redraw();
end

dofile("test.lua")

m = midi.connect()
m.event = function(d) tab.print(d) end

w = midi.connect(2)
--[[
w:note_on(60,100)
w:note_off(60,100)
]]--
