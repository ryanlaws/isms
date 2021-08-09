#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

#include "event.h"
#include "metro.h"
#include "sdl.h"
#include "lua.h"

#include "core.h"

void init();
void deinit();

int main(int argc, char **argv) {
  init();

  redraw(pixels);
  metro_start(1,1,5,0);

  printf(">> running core.lua\n");
  if (luaL_dostring(L, core) != LUA_OK) printf("ERROR: core.lua");

  printf(">> running example.lua\n");
  lua_run("example.lua");

  printf(">> starting event loop\n");
  event_loop();

  deinit();
  return 0;
}

void init() {
  printf(">>>> INIT\n");
  init_event();
  init_lua();
  init_metro();
  init_sdl();
}

void deinit() {
  printf(">>>> CLEANUP\n");
  deinit_lua();
  deinit_metro();
  deinit_sdl();
  printf(">>>> DONE\n");
}
