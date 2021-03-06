// SL 2019-10
//
//      GNU AFFERO GENERAL PUBLIC LICENSE
//        Version 3, 19 November 2007
//      
//  A copy of the license full text is included in 
//  the distribution, please refer to it for details.

algorithm ntsc(
  output! uint1  ntsc_hs,
  output! uint1  ntsc_vs,
  output! uint1  active,
  output! uint1  vblank,
  output! uint10 ntsc_x,
  output! uint10 ntsc_y
) <autorun> {

  uint10 H_FRT_PORCH = 7;
  uint10 H_SYNCH     = 23;
  uint10 H_BCK_PORCH = 23;
  uint10 H_RES       = 256;

  uint10 V_FRT_PORCH = 5;
  uint10 V_SYNCH     = 3;
  uint10 V_BCK_PORCH = 14;
  uint10 V_RES       = 240;

  uint10 HS_START = 0;
  uint10 HS_END   = 0;
  uint10 HA_START = 0;
  uint10 H_END    = 0;

  uint10 VS_START = 0;
  uint10 VS_END   = 0;
  uint10 VA_START = 0;
  uint10 V_END    = 0;

  uint10 xcount = 0;
  uint10 ycount = 0;

  HS_START := H_FRT_PORCH;
  HS_END   := H_FRT_PORCH + H_SYNCH;
  HA_START := H_FRT_PORCH + H_SYNCH + H_BCK_PORCH;
  H_END    := H_FRT_PORCH + H_SYNCH + H_BCK_PORCH + H_RES;

  VS_START := V_FRT_PORCH;
  VS_END   := V_FRT_PORCH + V_SYNCH;
  VA_START := V_FRT_PORCH + V_SYNCH + V_BCK_PORCH;
  V_END    := V_FRT_PORCH + V_SYNCH + V_BCK_PORCH + V_RES;

  ntsc_hs := ((xcount >= HS_START && xcount < HS_END));
  ntsc_vs := ((ycount >= VS_START && ycount < VS_END));

  active := (xcount >= HA_START && xcount < H_END)
         && (ycount >= VA_START && ycount < V_END);
  vblank := (ycount < VA_START);

  xcount = 0;
  ycount = 0;

  while (1) {

    ntsc_x = (active) ? xcount - HA_START : 0;
    ntsc_y = (vblank) ? 0 : ycount - VA_START;

    if (xcount == H_END-1) {
      xcount = 0;
      if (ycount == V_END-1) {
        ycount = 0;
      } else {
        ycount = ycount + 1;
	    }
    } else {
      xcount = xcount + 1;
	  }
  }

}

// -------------------------
