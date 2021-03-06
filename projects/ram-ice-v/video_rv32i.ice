// SL 2020-12-02 @sylefeb
// ------------------------- 

// pre-compilation script, embeds compile code within sdcard image
$$dofile('pre_include_asm.lua')

// basic palette
$$palette = {}
$$for i=1,256 do
$$  palette[i]= (i) | (((i<<1)&255)<<8) | (((i<<2)&255)<<16)
$$end

$include('../common/video_sdram_main.ice')

$include('ram-ice-v.ice')
$include('sdram_ram_32bits.ice')

// ------------------------- 

algorithm frame_drawer(
  output uint8  leds,
  sdram_user    sd,
  input  uint1  sdram_clock,
  input  uint1  sdram_reset,
  input  uint1  vsync,
  output uint1  fbuffer
) <autorun> {

$$if SIMULATION then
  uint16 iter = 0;
$$end

  sdram_raw_io sdh;
  sdram_half_speed_access sdram_slower<@sdram_clock,!sdram_reset>(
    sd  <:> sd,
    sdh <:> sdh
  );

  rv32i_ram_io ram;

  // sdram io
  sdram_ram_32bits bridge(
    sdr <:> sdh,
    r32 <:> ram
  );
  
  uint1 cpu_enable = 0;

  // cpu 
  rv32i_cpu cpu(
    enable <:  cpu_enable,
    ram    <:> ram
  );

  uint1  vsync_filtered = 0;
  
  vsync_filtered ::= vsync;
  fbuffer        := 0;
  leds           := 0;

  while (1) {
  
    cpu_enable      = 1;
  
    if (ram.in_valid) {
      if (ram.rw) {
        __display("RAM write @%h = %h (%b)",ram.addr,ram.data_in,ram.wmask);
      } else {
        __display("RAM read  @%h",ram.addr);
      }
    }
  
  }
}

// ------------------------- 
