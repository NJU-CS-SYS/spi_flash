module SPIFlashModule(input clk, input reset,
    input  io_flash_en,
    input  io_flash_write,
    input [3:0] io_quad_io,
    input [23:0] io_flash_addr,
    input [31:0] io_flash_data_in,
    output[31:0] io_flash_data_out,
    output[11:0] io_state_to_cpu,
    output io_SI,
    output io_tri_si,
    output io_cs,
    output io_ready
);

  wire T0;
  wire T1;
  reg [5:0] state;
  wire[5:0] T403;
  wire[5:0] T2;
  wire[5:0] T3;
  wire[5:0] T4;
  wire[5:0] T5;
  wire[5:0] T6;
  wire[5:0] T7;
  wire T8;
  wire T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire T21;
  reg [5:0] counter;
  wire[5:0] T404;
  wire[6:0] T405;
  wire[6:0] T22;
  wire[6:0] T23;
  wire[6:0] T24;
  wire[6:0] T25;
  wire[6:0] T26;
  wire[6:0] T27;
  wire[6:0] T406;
  wire[5:0] T28;
  wire[5:0] T29;
  wire[5:0] T30;
  wire[5:0] T31;
  wire[5:0] T32;
  wire[5:0] T33;
  wire[5:0] T34;
  wire[5:0] T35;
  wire[5:0] T36;
  wire[5:0] T37;
  wire[5:0] T38;
  wire[5:0] T39;
  wire[5:0] T40;
  wire[5:0] T41;
  wire[5:0] T42;
  wire[5:0] T43;
  wire[5:0] T44;
  wire[5:0] T45;
  wire[5:0] T46;
  wire[5:0] T47;
  wire[5:0] T48;
  wire[5:0] T49;
  wire[5:0] T50;
  wire[5:0] T51;
  wire[5:0] T52;
  wire[5:0] T53;
  wire[5:0] T54;
  wire[5:0] T55;
  wire[5:0] T56;
  wire[5:0] T57;
  wire[5:0] T58;
  wire[5:0] T59;
  wire T60;
  wire T61;
  reg [5:0] sub_state;
  wire[5:0] T407;
  wire[5:0] T62;
  wire[5:0] T63;
  wire[5:0] T64;
  wire[5:0] T65;
  wire[5:0] T66;
  wire[5:0] T67;
  wire[5:0] T68;
  wire[5:0] T69;
  wire[5:0] T70;
  wire[5:0] T71;
  wire[5:0] T72;
  wire[5:0] T73;
  wire[5:0] T74;
  wire[5:0] T75;
  wire[5:0] T76;
  wire[5:0] T77;
  wire[5:0] T78;
  wire[5:0] T79;
  wire[5:0] T80;
  wire[5:0] T81;
  wire[5:0] T82;
  wire[5:0] T83;
  wire[5:0] T84;
  wire[5:0] T85;
  wire[5:0] T86;
  wire T87;
  wire T88;
  wire T89;
  wire T90;
  wire T91;
  wire T92;
  wire T93;
  wire T94;
  wire T95;
  wire T96;
  wire T97;
  wire T98;
  wire T99;
  wire T100;
  wire T101;
  wire T102;
  wire T103;
  wire[5:0] T104;
  wire T105;
  wire T106;
  wire T107;
  wire T108;
  wire[5:0] T109;
  wire T110;
  wire T111;
  wire T112;
  wire T113;
  wire[5:0] T114;
  wire T115;
  wire T116;
  wire T117;
  wire T118;
  wire[5:0] T119;
  wire T120;
  wire T121;
  wire T122;
  wire T123;
  wire[5:0] T124;
  wire T125;
  wire T126;
  wire T127;
  wire T128;
  wire[5:0] T129;
  wire T130;
  wire T131;
  wire T132;
  wire T133;
  wire[5:0] T134;
  wire T135;
  wire T136;
  wire T137;
  wire T138;
  wire[5:0] T139;
  wire[5:0] T140;
  wire T141;
  wire T142;
  wire T143;
  wire T144;
  wire T145;
  wire[5:0] T146;
  wire T147;
  wire T148;
  wire T149;
  wire T150;
  wire[5:0] T151;
  wire T152;
  wire T153;
  wire[5:0] T154;
  wire T155;
  wire T156;
  wire T157;
  wire T158;
  wire[5:0] T159;
  wire T160;
  wire T161;
  wire T162;
  wire T163;
  wire[5:0] T164;
  wire T165;
  wire T166;
  wire[5:0] T167;
  wire[5:0] T168;
  wire[5:0] T408;
  wire[3:0] T169;
  wire[3:0] T170;
  wire[1:0] T409;
  wire T410;
  wire[5:0] T171;
  wire[5:0] T172;
  wire[5:0] T173;
  wire[5:0] T174;
  wire[6:0] T175;
  wire[6:0] T176;
  wire[6:0] T177;
  wire[6:0] T411;
  wire T178;
  wire T179;
  wire[6:0] T180;
  wire[6:0] T181;
  wire[6:0] T412;
  wire T182;
  wire T183;
  wire[6:0] T184;
  wire[6:0] T413;
  wire[2:0] T185;
  wire[2:0] T186;
  wire[2:0] T187;
  wire[2:0] T188;
  wire[6:0] T189;
  wire[6:0] T414;
  wire[3:0] T190;
  wire[3:0] T191;
  wire[2:0] T415;
  wire T416;
  wire T192;
  wire T193;
  wire[6:0] T194;
  wire[6:0] T417;
  wire[4:0] T195;
  wire[1:0] T196;
  wire[1:0] T197;
  wire[1:0] T198;
  wire[6:0] T199;
  wire[6:0] T418;
  wire[5:0] T200;
  wire[5:0] T201;
  wire T419;
  wire T202;
  wire T203;
  wire[2:0] T204;
  wire[6:0] T420;
  wire[5:0] T205;
  wire T206;
  wire T207;
  wire T208;
  wire T209;
  wire T210;
  wire T211;
  wire T212;
  wire T213;
  wire T214;
  wire T215;
  wire T216;
  wire T217;
  wire T218;
  wire T219;
  wire T220;
  wire T221;
  wire T222;
  wire T223;
  wire T224;
  wire T225;
  wire T226;
  wire T227;
  wire T228;
  wire[1:0] T229;
  wire T230;
  wire not_move;
  wire T231;
  wire T232;
  reg  write_old;
  wire T421;
  wire T233;
  wire T234;
  wire T235;
  reg [23:0] addr_old;
  wire[23:0] T422;
  wire[23:0] T236;
  wire T237;
  wire T238;
  wire T239;
  wire T240;
  reg  cs;
  wire T423;
  wire T241;
  wire T242;
  wire T243;
  wire T244;
  wire T245;
  wire T246;
  wire T247;
  wire T248;
  wire T249;
  wire T250;
  wire T251;
  wire T252;
  wire T253;
  wire T254;
  wire T255;
  wire T256;
  wire T257;
  wire T258;
  wire T259;
  wire T260;
  wire T261;
  wire T262;
  wire T263;
  wire[2:0] T264;
  reg [7:0] RDCR;
  wire[7:0] T424;
  wire T265;
  wire[2:0] T266;
  reg [7:0] RDSR1;
  wire[7:0] T425;
  wire T267;
  wire[2:0] T268;
  reg [7:0] WRR;
  wire[7:0] T426;
  wire T269;
  wire[2:0] T270;
  reg [7:0] reg_buffer_sr1;
  wire[7:0] T427;
  wire[8:0] T428;
  wire[8:0] T271;
  wire[8:0] T272;
  wire[8:0] T429;
  wire[8:0] T273;
  wire[8:0] T274;
  wire[8:0] T275;
  wire[8:0] T276;
  wire[7:0] T277;
  wire[2:0] T278;
  wire[8:0] T430;
  wire T279;
  wire T280;
  wire T281;
  wire[8:0] T282;
  wire[8:0] T283;
  wire[8:0] T431;
  wire[8:0] T284;
  wire[8:0] T285;
  wire[8:0] T286;
  wire[8:0] T287;
  wire[7:0] T288;
  wire[2:0] T289;
  wire[8:0] T432;
  wire T290;
  wire T291;
  wire T292;
  wire[8:0] T293;
  wire[8:0] T294;
  wire T295;
  wire[2:0] T296;
  reg [7:0] reg_buffer_cr;
  wire[7:0] T433;
  wire[8:0] T434;
  wire[8:0] T297;
  wire[8:0] T298;
  wire[8:0] T435;
  wire[8:0] T299;
  wire[8:0] T300;
  wire[8:0] T301;
  wire[8:0] T302;
  wire[7:0] T303;
  wire[2:0] T304;
  wire[8:0] T436;
  wire T305;
  wire T306;
  wire T307;
  wire[8:0] T308;
  wire[8:0] T309;
  wire[8:0] T437;
  wire[8:0] T438;
  wire[7:0] T310;
  wire T311;
  wire[2:0] T312;
  wire T313;
  wire[2:0] T314;
  reg [7:0] QREAD;
  wire[7:0] T439;
  wire T315;
  wire[4:0] T316;
  wire T317;
  wire[2:0] T318;
  reg [7:0] WREN;
  wire[7:0] T440;
  wire T319;
  wire[2:0] T320;
  reg [7:0] PP;
  wire[7:0] T441;
  wire T321;
  wire[4:0] T322;
  wire T323;
  wire[4:0] T324;
  wire T325;
  wire[2:0] T326;
  wire[11:0] T327;
  reg [31:0] buffer;
  wire[31:0] T442;
  wire[32:0] T443;
  wire[32:0] T328;
  wire[32:0] T329;
  wire[32:0] T444;
  wire[31:0] T330;
  wire[31:0] T331;
  wire[31:0] T332;
  wire[31:0] T333;
  wire[31:0] T334;
  wire[31:0] T335;
  wire[31:0] T336;
  wire[31:0] T445;
  wire[7:0] T337;
  wire[3:0] T338;
  wire[31:0] T339;
  wire[31:0] T446;
  wire[8:0] T340;
  wire[8:0] T341;
  wire[22:0] T447;
  wire T448;
  wire T342;
  wire[31:0] T343;
  wire[31:0] T449;
  wire[3:0] T344;
  wire[3:0] T345;
  wire[31:0] T346;
  wire[31:0] T450;
  wire[4:0] T347;
  wire[4:0] T348;
  wire[26:0] T451;
  wire T452;
  wire T349;
  wire T350;
  wire T351;
  wire[31:0] T352;
  wire[31:0] T453;
  wire[15:0] T353;
  wire[3:0] T354;
  wire[31:0] T355;
  wire[31:0] T454;
  wire[16:0] T356;
  wire[16:0] T357;
  wire[14:0] T455;
  wire T456;
  wire T358;
  wire T359;
  wire T360;
  wire[31:0] T361;
  wire[31:0] T457;
  wire[11:0] T362;
  wire[3:0] T363;
  wire[31:0] T364;
  wire[31:0] T458;
  wire[12:0] T365;
  wire[12:0] T366;
  wire[18:0] T459;
  wire T460;
  wire T367;
  wire T368;
  wire T369;
  wire[31:0] T370;
  wire[31:0] T461;
  wire[23:0] T371;
  wire[3:0] T372;
  wire[31:0] T373;
  wire[31:0] T462;
  wire[24:0] T374;
  wire[24:0] T375;
  wire[6:0] T463;
  wire T464;
  wire T376;
  wire T377;
  wire T378;
  wire[31:0] T379;
  wire[31:0] T465;
  wire[19:0] T380;
  wire[3:0] T381;
  wire[31:0] T382;
  wire[31:0] T466;
  wire[20:0] T383;
  wire[20:0] T384;
  wire[10:0] T467;
  wire T468;
  wire T385;
  wire T386;
  wire T387;
  wire[32:0] T388;
  wire[32:0] T469;
  wire[31:0] T389;
  wire[3:0] T390;
  wire[32:0] T391;
  wire[32:0] T392;
  wire[32:0] T393;
  wire[32:0] T470;
  wire T394;
  wire T395;
  wire T396;
  wire[32:0] T397;
  wire[32:0] T471;
  wire[27:0] T398;
  wire[3:0] T399;
  wire[32:0] T400;
  wire[32:0] T472;
  wire[28:0] T401;
  wire[28:0] T402;
  wire[3:0] T473;
  wire T474;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    state = {1{$random}};
    counter = {1{$random}};
    sub_state = {1{$random}};
    write_old = {1{$random}};
    addr_old = {1{$random}};
    cs = {1{$random}};
    RDCR = {1{$random}};
    RDSR1 = {1{$random}};
    WRR = {1{$random}};
    reg_buffer_sr1 = {1{$random}};
    reg_buffer_cr = {1{$random}};
    QREAD = {1{$random}};
    WREN = {1{$random}};
    PP = {1{$random}};
    buffer = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_ready = T0;
  assign T0 = not_move | T1;
  assign T1 = state == 6'h3;
  assign T403 = reset ? 6'h0 : T2;
  assign T2 = T230 ? 6'h0 : T3;
  assign T3 = T227 ? 6'h3 : T4;
  assign T4 = T212 ? 6'h3 : T5;
  assign T5 = T16 ? 6'h1 : T6;
  assign T6 = T14 ? 6'h2 : T7;
  assign T7 = T8 ? 6'h4 : state;
  assign T8 = T11 & T9;
  assign T9 = io_flash_en & T10;
  assign T10 = ~ io_flash_write;
  assign T11 = T13 & T12;
  assign T12 = ~ not_move;
  assign T13 = state == 6'h0;
  assign T14 = T11 & T15;
  assign T15 = io_flash_en & io_flash_write;
  assign T16 = T20 & T17;
  assign T17 = T18 ^ 1'h1;
  assign T18 = T19 == 1'h1;
  assign T19 = io_quad_io[1];
  assign T20 = T210 & T21;
  assign T21 = counter == 6'h0;
  assign T404 = T405[5:0];
  assign T405 = reset ? 7'h0 : T22;
  assign T22 = T208 ? 7'h7 : T23;
  assign T23 = T206 ? T420 : T24;
  assign T24 = T227 ? 7'h7 : T25;
  assign T25 = T202 ? T194 : T26;
  assign T26 = T192 ? T184 : T27;
  assign T27 = T182 ? T175 : T406;
  assign T406 = {1'h0, T28};
  assign T28 = T182 ? T171 : T29;
  assign T29 = T182 ? T167 : T30;
  assign T30 = T165 ? T164 : T31;
  assign T31 = T162 ? 6'h17 : T32;
  assign T32 = T160 ? T159 : T33;
  assign T33 = T157 ? 6'h7 : T34;
  assign T34 = T155 ? T154 : T35;
  assign T35 = T152 ? T151 : T36;
  assign T36 = T149 ? 6'h0 : T37;
  assign T37 = T147 ? T146 : T38;
  assign T38 = T144 ? 6'h17 : T39;
  assign T39 = T141 ? T140 : T40;
  assign T40 = T16 ? 6'h7 : T41;
  assign T41 = T210 ? T139 : T42;
  assign T42 = T137 ? 6'h7 : T43;
  assign T43 = T135 ? T134 : T44;
  assign T44 = T132 ? 6'h7 : T45;
  assign T45 = T130 ? T129 : T46;
  assign T46 = T127 ? 6'h7 : T47;
  assign T47 = T125 ? T124 : T48;
  assign T48 = T122 ? 6'h7 : T49;
  assign T49 = T120 ? T119 : T50;
  assign T50 = T117 ? 6'h7 : T51;
  assign T51 = T115 ? T114 : T52;
  assign T52 = T112 ? 6'h7 : T53;
  assign T53 = T110 ? T109 : T54;
  assign T54 = T107 ? 6'h7 : T55;
  assign T55 = T105 ? T104 : T56;
  assign T56 = T102 ? 6'h7 : T57;
  assign T57 = T60 ? T59 : T58;
  assign T58 = T11 ? 6'h7 : counter;
  assign T59 = counter - 6'h1;
  assign T60 = T101 & T61;
  assign T61 = sub_state == 6'hb;
  assign T407 = reset ? 6'h0 : T62;
  assign T62 = T97 ? 6'h9 : T63;
  assign T63 = T208 ? 6'ha : T64;
  assign T64 = T227 ? 6'h0 : T65;
  assign T65 = T182 ? 6'h8 : T66;
  assign T66 = T162 ? 6'h5 : T67;
  assign T67 = T94 ? 6'h4 : T68;
  assign T68 = T157 ? 6'h7 : T69;
  assign T69 = T212 ? 6'h0 : T70;
  assign T70 = T149 ? 6'h6 : T71;
  assign T71 = T144 ? 6'h5 : T72;
  assign T72 = T16 ? 6'h4 : T73;
  assign T73 = T93 ? 6'h10 : T74;
  assign T74 = T137 ? 6'h11 : T75;
  assign T75 = T91 ? 6'h10 : T76;
  assign T76 = T132 ? 6'h13 : T77;
  assign T77 = T127 ? 6'hf : T78;
  assign T78 = T122 ? 6'he : T79;
  assign T79 = T89 ? 6'hd : T80;
  assign T80 = T117 ? 6'h12 : T81;
  assign T81 = T112 ? 6'ha : T82;
  assign T82 = T87 ? 6'h3 : T83;
  assign T83 = T107 ? 6'h7 : T84;
  assign T84 = T102 ? 6'hc : T85;
  assign T85 = T14 ? 6'h1 : T86;
  assign T86 = T8 ? 6'hb : sub_state;
  assign T87 = T101 & T88;
  assign T88 = sub_state == 6'h7;
  assign T89 = T101 & T90;
  assign T90 = sub_state == 6'h12;
  assign T91 = T101 & T92;
  assign T92 = sub_state == 6'h13;
  assign T93 = T20 & T18;
  assign T94 = T96 & T95;
  assign T95 = sub_state == 6'h7;
  assign T96 = state == 6'h2;
  assign T97 = T99 & T98;
  assign T98 = counter == 6'h0;
  assign T99 = T96 & T100;
  assign T100 = sub_state == 6'ha;
  assign T101 = state == 6'h4;
  assign T102 = T60 & T103;
  assign T103 = counter == 6'h0;
  assign T104 = counter - 6'h1;
  assign T105 = T101 & T106;
  assign T106 = sub_state == 6'hc;
  assign T107 = T105 & T108;
  assign T108 = counter == 6'h0;
  assign T109 = counter - 6'h1;
  assign T110 = T101 & T111;
  assign T111 = sub_state == 6'h3;
  assign T112 = T110 & T113;
  assign T113 = counter == 6'h0;
  assign T114 = counter - 6'h1;
  assign T115 = T101 & T116;
  assign T116 = sub_state == 6'ha;
  assign T117 = T115 & T118;
  assign T118 = counter == 6'h0;
  assign T119 = counter - 6'h1;
  assign T120 = T101 & T121;
  assign T121 = sub_state == 6'hd;
  assign T122 = T120 & T123;
  assign T123 = counter == 6'h0;
  assign T124 = counter - 6'h1;
  assign T125 = T101 & T126;
  assign T126 = sub_state == 6'he;
  assign T127 = T125 & T128;
  assign T128 = counter == 6'h0;
  assign T129 = counter - 6'h1;
  assign T130 = T101 & T131;
  assign T131 = sub_state == 6'hf;
  assign T132 = T130 & T133;
  assign T133 = counter == 6'h0;
  assign T134 = counter - 6'h1;
  assign T135 = T101 & T136;
  assign T136 = sub_state == 6'h10;
  assign T137 = T135 & T138;
  assign T138 = counter == 6'h0;
  assign T139 = counter - 6'h1;
  assign T140 = counter - 6'h1;
  assign T141 = T143 & T142;
  assign T142 = sub_state == 6'h4;
  assign T143 = state == 6'h1;
  assign T144 = T141 & T145;
  assign T145 = counter == 6'h0;
  assign T146 = counter - 6'h1;
  assign T147 = T143 & T148;
  assign T148 = sub_state == 6'h5;
  assign T149 = T147 & T150;
  assign T150 = counter == 6'h0;
  assign T151 = counter + 6'h1;
  assign T152 = T143 & T153;
  assign T153 = sub_state == 6'h6;
  assign T154 = counter - 6'h1;
  assign T155 = T96 & T156;
  assign T156 = sub_state == 6'h1;
  assign T157 = T155 & T158;
  assign T158 = counter == 6'h0;
  assign T159 = counter - 6'h1;
  assign T160 = T96 & T161;
  assign T161 = sub_state == 6'h4;
  assign T162 = T160 & T163;
  assign T163 = counter == 6'h0;
  assign T164 = counter - 6'h1;
  assign T165 = T96 & T166;
  assign T166 = sub_state == 6'h5;
  assign T167 = T168 | 6'h7;
  assign T168 = T30 & T408;
  assign T408 = {T409, T169};
  assign T169 = ~ T170;
  assign T170 = 4'h7;
  assign T409 = T410 ? 2'h3 : 2'h0;
  assign T410 = T169[3];
  assign T171 = T172 | 6'h0;
  assign T172 = T29 & T173;
  assign T173 = ~ T174;
  assign T174 = 6'h18;
  assign T175 = T180 | T176;
  assign T176 = T411 & T177;
  assign T177 = 7'h20;
  assign T411 = T178 ? 7'h7f : 7'h0;
  assign T178 = T179;
  assign T179 = 1'h0;
  assign T180 = T412 & T181;
  assign T181 = ~ T177;
  assign T412 = {1'h0, T28};
  assign T182 = T165 & T183;
  assign T183 = counter == 6'h0;
  assign T184 = T189 | T413;
  assign T413 = {4'h0, T185};
  assign T185 = T186 << 1'h0;
  assign T186 = T187 & 3'h7;
  assign T187 = T188 - 3'h1;
  assign T188 = counter[2:0];
  assign T189 = T27 & T414;
  assign T414 = {T415, T190};
  assign T190 = ~ T191;
  assign T191 = 4'h7;
  assign T415 = T416 ? 3'h7 : 3'h0;
  assign T416 = T190[3];
  assign T192 = T96 & T193;
  assign T193 = sub_state == 6'h8;
  assign T194 = T199 | T417;
  assign T417 = {2'h0, T195};
  assign T195 = T196 << 2'h3;
  assign T196 = T197 & 2'h3;
  assign T197 = T198 + 2'h1;
  assign T198 = counter[4:3];
  assign T199 = T26 & T418;
  assign T418 = {T419, T200};
  assign T200 = ~ T201;
  assign T201 = 6'h18;
  assign T419 = T200[5];
  assign T202 = T192 & T203;
  assign T203 = T204 == 3'h0;
  assign T204 = counter[2:0];
  assign T420 = {1'h0, T205};
  assign T205 = counter - 6'h1;
  assign T206 = T96 & T207;
  assign T207 = sub_state == 6'h3;
  assign T208 = T206 & T209;
  assign T209 = counter == 6'h0;
  assign T210 = T101 & T211;
  assign T211 = sub_state == 6'h11;
  assign T212 = T152 & T213;
  assign T213 = T214 ^ 1'h1;
  assign T214 = T216 | T215;
  assign T215 = counter == 6'h6;
  assign T216 = T218 | T217;
  assign T217 = counter == 6'h5;
  assign T218 = T220 | T219;
  assign T219 = counter == 6'h4;
  assign T220 = T222 | T221;
  assign T221 = counter == 6'h3;
  assign T222 = T224 | T223;
  assign T223 = counter == 6'h2;
  assign T224 = T226 | T225;
  assign T225 = counter == 6'h1;
  assign T226 = counter == 6'h0;
  assign T227 = T202 & T228;
  assign T228 = T229 == 2'h3;
  assign T229 = counter[4:3];
  assign T230 = state == 6'h3;
  assign not_move = T238 | T231;
  assign T231 = T234 & T232;
  assign T232 = write_old == io_flash_write;
  assign T421 = reset ? 1'h0 : T233;
  assign T233 = T230 ? io_flash_write : write_old;
  assign T234 = T237 & T235;
  assign T235 = addr_old == io_flash_addr;
  assign T422 = reset ? 24'h0 : T236;
  assign T236 = T230 ? io_flash_addr : addr_old;
  assign T237 = state == 6'h0;
  assign T238 = T240 & T239;
  assign T239 = io_flash_en == 1'h0;
  assign T240 = state == 6'h0;
  assign io_cs = cs;
  assign T423 = reset ? 1'h1 : T241;
  assign T241 = T227 ? 1'h1 : T242;
  assign T242 = T94 ? 1'h0 : T243;
  assign T243 = T157 ? 1'h1 : T244;
  assign T244 = T212 ? 1'h1 : T245;
  assign T245 = T91 ? 1'h0 : T246;
  assign T246 = T132 ? 1'h1 : T247;
  assign T247 = T89 ? 1'h0 : T248;
  assign T248 = T87 ? 1'h0 : T249;
  assign T249 = T11 ? 1'h0 : cs;
  assign io_tri_si = T152;
  assign io_SI = T250;
  assign T250 = T206 ? T325 : T251;
  assign T251 = T192 ? T323 : T252;
  assign T252 = T165 ? T321 : T253;
  assign T253 = T160 ? T319 : T254;
  assign T254 = T155 ? T317 : T255;
  assign T255 = T147 ? T315 : T256;
  assign T256 = T141 ? T313 : T257;
  assign T257 = T135 ? T311 : T258;
  assign T258 = T130 ? T295 : T259;
  assign T259 = T125 ? T269 : T260;
  assign T260 = T120 ? T267 : T261;
  assign T261 = T110 ? T265 : T262;
  assign T262 = T60 ? T263 : 1'h0;
  assign T263 = RDCR[T264];
  assign T264 = counter[2:0];
  assign T424 = reset ? 8'h35 : RDCR;
  assign T265 = RDSR1[T266];
  assign T266 = counter[2:0];
  assign T425 = reset ? 8'h5 : RDSR1;
  assign T267 = WRR[T268];
  assign T268 = counter[2:0];
  assign T426 = reset ? 8'h1 : WRR;
  assign T269 = reg_buffer_sr1[T270];
  assign T270 = counter[2:0];
  assign T427 = T428[7:0];
  assign T428 = reset ? 9'h0 : T271;
  assign T271 = T210 ? T284 : T272;
  assign T272 = T115 ? T273 : T429;
  assign T429 = {1'h0, reg_buffer_sr1};
  assign T273 = T282 | T274;
  assign T274 = T430 & T275;
  assign T275 = T276;
  assign T276 = {1'h0, T277};
  assign T277 = 1'h1 << T278;
  assign T278 = counter[2:0];
  assign T430 = T279 ? 9'h1ff : 9'h0;
  assign T279 = T280;
  assign T280 = T281;
  assign T281 = io_quad_io[1];
  assign T282 = T431 & T283;
  assign T283 = ~ T275;
  assign T431 = {1'h0, reg_buffer_sr1};
  assign T284 = T293 | T285;
  assign T285 = T432 & T286;
  assign T286 = T287;
  assign T287 = {1'h0, T288};
  assign T288 = 1'h1 << T289;
  assign T289 = counter[2:0];
  assign T432 = T290 ? 9'h1ff : 9'h0;
  assign T290 = T291;
  assign T291 = T292;
  assign T292 = io_quad_io[1];
  assign T293 = T272 & T294;
  assign T294 = ~ T286;
  assign T295 = reg_buffer_cr[T296];
  assign T296 = counter[2:0];
  assign T433 = T434[7:0];
  assign T434 = reset ? 9'h0 : T297;
  assign T297 = T127 ? T438 : T298;
  assign T298 = T105 ? T299 : T435;
  assign T435 = {1'h0, reg_buffer_cr};
  assign T299 = T308 | T300;
  assign T300 = T436 & T301;
  assign T301 = T302;
  assign T302 = {1'h0, T303};
  assign T303 = 1'h1 << T304;
  assign T304 = counter[2:0];
  assign T436 = T305 ? 9'h1ff : 9'h0;
  assign T305 = T306;
  assign T306 = T307;
  assign T307 = io_quad_io[1];
  assign T308 = T437 & T309;
  assign T309 = ~ T301;
  assign T437 = {1'h0, reg_buffer_cr};
  assign T438 = {1'h0, T310};
  assign T310 = reg_buffer_cr | 8'h2;
  assign T311 = RDSR1[T312];
  assign T312 = counter[2:0];
  assign T313 = QREAD[T314];
  assign T314 = counter[2:0];
  assign T439 = reset ? 8'h6b : QREAD;
  assign T315 = io_flash_addr[T316];
  assign T316 = counter[4:0];
  assign T317 = WREN[T318];
  assign T318 = counter[2:0];
  assign T440 = reset ? 8'h6 : WREN;
  assign T319 = PP[T320];
  assign T320 = counter[2:0];
  assign T441 = reset ? 8'h2 : PP;
  assign T321 = io_flash_addr[T322];
  assign T322 = counter[4:0];
  assign T323 = io_flash_data_in[T324];
  assign T324 = counter[4:0];
  assign T325 = RDSR1[T326];
  assign T326 = counter[2:0];
  assign io_state_to_cpu = T327;
  assign T327 = {state, sub_state};
  assign io_flash_data_out = buffer;
  assign T442 = T443[31:0];
  assign T443 = reset ? 33'h0 : T328;
  assign T328 = T212 ? T397 : T329;
  assign T329 = T394 ? T388 : T444;
  assign T444 = {1'h0, T330};
  assign T330 = T385 ? T379 : T331;
  assign T331 = T376 ? T370 : T332;
  assign T332 = T367 ? T361 : T333;
  assign T333 = T358 ? T352 : T334;
  assign T334 = T349 ? T343 : T335;
  assign T335 = T342 ? T336 : buffer;
  assign T336 = T339 | T445;
  assign T445 = {24'h0, T337};
  assign T337 = T338 << 3'h4;
  assign T338 = io_quad_io & 4'hf;
  assign T339 = buffer & T446;
  assign T446 = {T447, T340};
  assign T340 = ~ T341;
  assign T341 = 9'hf0;
  assign T447 = T448 ? 23'h7fffff : 23'h0;
  assign T448 = T340[8];
  assign T342 = T152 & T226;
  assign T343 = T346 | T449;
  assign T449 = {28'h0, T344};
  assign T344 = T345 << 1'h0;
  assign T345 = io_quad_io & 4'hf;
  assign T346 = T335 & T450;
  assign T450 = {T451, T347};
  assign T347 = ~ T348;
  assign T348 = 5'hf;
  assign T451 = T452 ? 27'h7ffffff : 27'h0;
  assign T452 = T347[4];
  assign T349 = T152 & T350;
  assign T350 = T351 & T225;
  assign T351 = T226 ^ 1'h1;
  assign T352 = T355 | T453;
  assign T453 = {16'h0, T353};
  assign T353 = T354 << 4'hc;
  assign T354 = io_quad_io & 4'hf;
  assign T355 = T334 & T454;
  assign T454 = {T455, T356};
  assign T356 = ~ T357;
  assign T357 = 17'hf000;
  assign T455 = T456 ? 15'h7fff : 15'h0;
  assign T456 = T356[16];
  assign T358 = T152 & T359;
  assign T359 = T360 & T223;
  assign T360 = T224 ^ 1'h1;
  assign T361 = T364 | T457;
  assign T457 = {20'h0, T362};
  assign T362 = T363 << 4'h8;
  assign T363 = io_quad_io & 4'hf;
  assign T364 = T333 & T458;
  assign T458 = {T459, T365};
  assign T365 = ~ T366;
  assign T366 = 13'hf00;
  assign T459 = T460 ? 19'h7ffff : 19'h0;
  assign T460 = T365[12];
  assign T367 = T152 & T368;
  assign T368 = T369 & T221;
  assign T369 = T222 ^ 1'h1;
  assign T370 = T373 | T461;
  assign T461 = {8'h0, T371};
  assign T371 = T372 << 5'h14;
  assign T372 = io_quad_io & 4'hf;
  assign T373 = T332 & T462;
  assign T462 = {T463, T374};
  assign T374 = ~ T375;
  assign T375 = 25'hf00000;
  assign T463 = T464 ? 7'h7f : 7'h0;
  assign T464 = T374[24];
  assign T376 = T152 & T377;
  assign T377 = T378 & T219;
  assign T378 = T220 ^ 1'h1;
  assign T379 = T382 | T465;
  assign T465 = {12'h0, T380};
  assign T380 = T381 << 5'h10;
  assign T381 = io_quad_io & 4'hf;
  assign T382 = T331 & T466;
  assign T466 = {T467, T383};
  assign T383 = ~ T384;
  assign T384 = 21'hf0000;
  assign T467 = T468 ? 11'h7ff : 11'h0;
  assign T468 = T383[20];
  assign T385 = T152 & T386;
  assign T386 = T387 & T217;
  assign T387 = T218 ^ 1'h1;
  assign T388 = T391 | T469;
  assign T469 = {1'h0, T389};
  assign T389 = T390 << 5'h1c;
  assign T390 = io_quad_io & 4'hf;
  assign T391 = T470 & T392;
  assign T392 = ~ T393;
  assign T393 = 33'hf0000000;
  assign T470 = {1'h0, T330};
  assign T394 = T152 & T395;
  assign T395 = T396 & T215;
  assign T396 = T216 ^ 1'h1;
  assign T397 = T400 | T471;
  assign T471 = {5'h0, T398};
  assign T398 = T399 << 5'h18;
  assign T399 = io_quad_io & 4'hf;
  assign T400 = T329 & T472;
  assign T472 = {T473, T401};
  assign T401 = ~ T402;
  assign T402 = 29'hf000000;
  assign T473 = T474 ? 4'hf : 4'h0;
  assign T474 = T401[28];

  always @(posedge clk) begin
    if(reset) begin
      state <= 6'h0;
    end else if(T230) begin
      state <= 6'h0;
    end else if(T227) begin
      state <= 6'h3;
    end else if(T212) begin
      state <= 6'h3;
    end else if(T16) begin
      state <= 6'h1;
    end else if(T14) begin
      state <= 6'h2;
    end else if(T8) begin
      state <= 6'h4;
    end
    counter <= T404;
    if(reset) begin
      sub_state <= 6'h0;
    end else if(T97) begin
      sub_state <= 6'h9;
    end else if(T208) begin
      sub_state <= 6'ha;
    end else if(T227) begin
      sub_state <= 6'h0;
    end else if(T182) begin
      sub_state <= 6'h8;
    end else if(T162) begin
      sub_state <= 6'h5;
    end else if(T94) begin
      sub_state <= 6'h4;
    end else if(T157) begin
      sub_state <= 6'h7;
    end else if(T212) begin
      sub_state <= 6'h0;
    end else if(T149) begin
      sub_state <= 6'h6;
    end else if(T144) begin
      sub_state <= 6'h5;
    end else if(T16) begin
      sub_state <= 6'h4;
    end else if(T93) begin
      sub_state <= 6'h10;
    end else if(T137) begin
      sub_state <= 6'h11;
    end else if(T91) begin
      sub_state <= 6'h10;
    end else if(T132) begin
      sub_state <= 6'h13;
    end else if(T127) begin
      sub_state <= 6'hf;
    end else if(T122) begin
      sub_state <= 6'he;
    end else if(T89) begin
      sub_state <= 6'hd;
    end else if(T117) begin
      sub_state <= 6'h12;
    end else if(T112) begin
      sub_state <= 6'ha;
    end else if(T87) begin
      sub_state <= 6'h3;
    end else if(T107) begin
      sub_state <= 6'h7;
    end else if(T102) begin
      sub_state <= 6'hc;
    end else if(T14) begin
      sub_state <= 6'h1;
    end else if(T8) begin
      sub_state <= 6'hb;
    end
    if(reset) begin
      write_old <= 1'h0;
    end else if(T230) begin
      write_old <= io_flash_write;
    end
    if(reset) begin
      addr_old <= 24'h0;
    end else if(T230) begin
      addr_old <= io_flash_addr;
    end
    if(reset) begin
      cs <= 1'h1;
    end else if(T227) begin
      cs <= 1'h1;
    end else if(T94) begin
      cs <= 1'h0;
    end else if(T157) begin
      cs <= 1'h1;
    end else if(T212) begin
      cs <= 1'h1;
    end else if(T91) begin
      cs <= 1'h0;
    end else if(T132) begin
      cs <= 1'h1;
    end else if(T89) begin
      cs <= 1'h0;
    end else if(T87) begin
      cs <= 1'h0;
    end else if(T11) begin
      cs <= 1'h0;
    end
    if(reset) begin
      RDCR <= 8'h35;
    end
    if(reset) begin
      RDSR1 <= 8'h5;
    end
    if(reset) begin
      WRR <= 8'h1;
    end
    reg_buffer_sr1 <= T427;
    reg_buffer_cr <= T433;
    if(reset) begin
      QREAD <= 8'h6b;
    end
    if(reset) begin
      WREN <= 8'h6;
    end
    if(reset) begin
      PP <= 8'h2;
    end
    buffer <= T442;
  end
endmodule

