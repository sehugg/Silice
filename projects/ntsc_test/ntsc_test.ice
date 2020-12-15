// -------------------------

// NTSC driver
$include('../common/ntsc.ice')

// -------------------------

algorithm frame_display(
  input   uint10 pix_x,
  input   uint10 pix_y,
  input   uint1  pix_active,
  input   uint1  pix_vblank,
  output! uint$color_depth$ pix_red,
  output! uint$color_depth$ pix_green,
  output! uint$color_depth$ pix_blue
) <autorun> {
  // by default r,g,b are set to zero
  pix_red   := 0;
  pix_green := 0;
  pix_blue  := 0; 
  // ---------- show time!
  while (1) {
	  // display frame
	  while (pix_vblank == 0) {
      if (pix_active) {
        pix_blue  = pix_x[4,$color_depth$];
        pix_green = pix_y[4,$color_depth$];
        pix_red   = pix_x[1,$color_depth$];
      }      
    }    
    while (pix_vblank == 1) {} // wait for sync
  }
}

// -------------------------

algorithm main(
$$if NTSC then  
  // NTSC
  output! uint$color_depth$ video_r,
  output! uint$color_depth$ video_g,
  output! uint$color_depth$ video_b,
  output! uint1 video_hs,
  output! uint1 video_vs
$$end
) 
<@clock,!reset> 
{

  uint1  active = 0;
  uint1  vblank = 0;
  uint10 pix_x  = 0;
  uint10 pix_y  = 0;

  ntsc ntsc_driver (
    ntsc_hs :> video_hs,
	  ntsc_vs :> video_vs,
	  active :> active,
	  vblank :> vblank,
	  ntsc_x  :> pix_x,
	  ntsc_y  :> pix_y
  );

  frame_display display (
	  pix_x      <: pix_x,
	  pix_y      <: pix_y,
	  pix_active <: active,
	  pix_vblank <: vblank,
	  pix_red    :> video_r,
	  pix_green  :> video_g,
	  pix_blue   :> video_b
  );

  uint8 frame  = 0;

  // forever
  while (1) {
  
    while (vblank == 0) { }
    frame = frame + 1;

  }
}
