/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R)
// Version   : K-2015.06
// Date      : Wed Dec 13 03:18:46 2023
/////////////////////////////////////////////////////////////


module Washing_Machine ( CLK, RST_n, Open_Door, Close_Door, Clothes_in, Start, 
        Weight, Pause, Stop, Operation, Finish, Failure, Filling_Water_Done, 
        Heating_Water_Done, Washing_Done, Rinsing_Done, Spinning_Done );
  input [1:0] Weight;
  input [1:0] Operation;
  input CLK, RST_n, Open_Door, Close_Door, Clothes_in, Start, Pause, Stop;
  output Finish, Failure, Filling_Water_Done, Heating_Water_Done, Washing_Done,
         Rinsing_Done, Spinning_Done;
  wire   N0, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15,
         N16, N17, N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28,
         Spinning_Done, N29, N30, N31, N32, N33, N34, N35, N36, N37, N38, N39,
         N40, N41, N42, N43, N44, N45, N46, N47, N48, N49, N50, N51, N52, N53,
         N54, N55, N56, N57, N58, N59, N60, N61, N62, N63, N64, N65, N66, N67,
         N68, N69, N70, N71, N72, N73, N74, N75, N76, N77, N78, N79, N80, N81,
         N82, N83, N84, N85, N86, N87, N88, N89, N90, N91, N92, N93, N94, N95,
         N96, N97, N98, N99, N100, N101, N102, N103, N104, N105, N106, N107,
         N108, N109, N110, N111, N112, N113, N114, N115, N116, N117, N118,
         N119, N120, N121, N122, N123, N124, N125, N126, N127, N128, N129,
         N130, N131, N132, N133, N134, N135, N136, N137, N138, N139, N140,
         N141, N142, N143, N144, flag, N145, N146, N147, N148, N149, N150,
         N151, N152, N153, N154, N155, N156, N157, N158, N159, N160, N161,
         N162, N163, N164, N165, N166, N167, N168, N169, N170, N171, N172,
         N173, N174, N175, N176, N177, N178, N179, N180, N181, N182, N183,
         N184, N185, N186, N187, N188, N189, N190, N191, N192, N193, N194,
         N195, N196, N197, N198, N199, N200, N201, N202, N203, N204, N205,
         N206, N207, net86;
  wire   [2:0] Current_State;
  wire   [2:0] Next_State;
  wire   [2:0] Counter;
  wire   [2:0] WATER_LEVEL;
  wire   [2:0] Resume_State;
  assign Finish = Spinning_Done;

  \**SEQGEN**  \Current_State_reg[2]  ( .clear(N29), .preset(1'b0), 
        .next_state(N33), .clocked_on(CLK), .data_in(1'b0), .enable(1'b0), .Q(
        Current_State[2]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \Current_State_reg[1]  ( .clear(N29), .preset(1'b0), 
        .next_state(N32), .clocked_on(CLK), .data_in(1'b0), .enable(1'b0), .Q(
        Current_State[1]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \Current_State_reg[0]  ( .clear(N29), .preset(1'b0), 
        .next_state(N31), .clocked_on(CLK), .data_in(1'b0), .enable(1'b0), .Q(
        Current_State[0]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  GTECH_AND2 C26 ( .A(N34), .B(N35), .Z(N36) );
  GTECH_AND2 C27 ( .A(N36), .B(N173), .Z(N37) );
  GTECH_OR2 C29 ( .A(Current_State[2]), .B(Current_State[1]), .Z(N38) );
  GTECH_OR2 C30 ( .A(N38), .B(N173), .Z(N39) );
  GTECH_OR2 C34 ( .A(Current_State[2]), .B(N35), .Z(N41) );
  GTECH_OR2 C35 ( .A(N41), .B(N173), .Z(N42) );
  GTECH_OR2 C38 ( .A(Current_State[2]), .B(N35), .Z(N44) );
  GTECH_OR2 C39 ( .A(N44), .B(Current_State[0]), .Z(N45) );
  GTECH_OR2 C43 ( .A(N34), .B(N35), .Z(N47) );
  GTECH_OR2 C44 ( .A(N47), .B(Current_State[0]), .Z(N48) );
  GTECH_AND2 C46 ( .A(Current_State[2]), .B(Current_State[1]), .Z(N50) );
  GTECH_AND2 C47 ( .A(N50), .B(Current_State[0]), .Z(N51) );
  GTECH_OR2 C49 ( .A(N34), .B(Current_State[1]), .Z(N52) );
  GTECH_OR2 C50 ( .A(N52), .B(Current_State[0]), .Z(N53) );
  GTECH_OR2 C54 ( .A(N34), .B(Current_State[1]), .Z(N55) );
  GTECH_OR2 C55 ( .A(N55), .B(N173), .Z(N56) );
  EQ_UNS_OP eq_96 ( .A(Counter), .B(WATER_LEVEL), .Z(N59) );
  GTECH_AND2 C222 ( .A(N34), .B(N35), .Z(N100) );
  GTECH_AND2 C223 ( .A(N100), .B(N173), .Z(N101) );
  GTECH_OR2 C225 ( .A(Current_State[2]), .B(Current_State[1]), .Z(N102) );
  GTECH_OR2 C226 ( .A(N102), .B(N173), .Z(N103) );
  GTECH_OR2 C230 ( .A(Current_State[2]), .B(N35), .Z(N105) );
  GTECH_OR2 C231 ( .A(N105), .B(N173), .Z(N106) );
  GTECH_OR2 C234 ( .A(Current_State[2]), .B(N35), .Z(N108) );
  GTECH_OR2 C235 ( .A(N108), .B(Current_State[0]), .Z(N109) );
  GTECH_OR2 C239 ( .A(N34), .B(N35), .Z(N111) );
  GTECH_OR2 C240 ( .A(N111), .B(Current_State[0]), .Z(N112) );
  GTECH_AND2 C242 ( .A(Current_State[2]), .B(Current_State[1]), .Z(N114) );
  GTECH_AND2 C243 ( .A(N114), .B(Current_State[0]), .Z(N115) );
  GTECH_OR2 C245 ( .A(N34), .B(Current_State[1]), .Z(N116) );
  GTECH_OR2 C246 ( .A(N116), .B(Current_State[0]), .Z(N117) );
  GTECH_OR2 C250 ( .A(N34), .B(Current_State[1]), .Z(N119) );
  GTECH_OR2 C251 ( .A(N119), .B(N173), .Z(N120) );
  EQ_UNS_OP eq_250 ( .A(Counter), .B(WATER_LEVEL), .Z(N122) );
  \**SEQGEN**  Filling_Water_Done_reg ( .clear(1'b0), .preset(1'b0), 
        .next_state(1'b0), .clocked_on(1'b0), .data_in(N124), .enable(N123), 
        .Q(Filling_Water_Done), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b0) );
  EQ_UNS_OP eq_405_2 ( .A(Counter), .B(WATER_LEVEL), .Z(N129) );
  \**SEQGEN**  \Counter_reg[2]  ( .clear(N29), .preset(1'b0), .next_state(N142), .clocked_on(CLK), .data_in(1'b0), .enable(1'b0), .Q(Counter[2]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \Counter_reg[1]  ( .clear(N29), .preset(1'b0), .next_state(N141), .clocked_on(CLK), .data_in(1'b0), .enable(1'b0), .Q(Counter[1]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \Counter_reg[0]  ( .clear(N29), .preset(1'b0), .next_state(N140), .clocked_on(CLK), .data_in(1'b0), .enable(1'b0), .Q(Counter[0]), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  flag_reg ( .clear(N29), .preset(1'b0), .next_state(N148), 
        .clocked_on(CLK), .data_in(1'b0), .enable(1'b0), .Q(flag), 
        .synch_clear(1'b0), .synch_preset(1'b0), .synch_toggle(1'b0), 
        .synch_enable(1'b1) );
  \**SEQGEN**  \Resume_State_reg[2]  ( .clear(N29), .preset(1'b0), 
        .next_state(N151), .clocked_on(CLK), .data_in(1'b0), .enable(1'b0), 
        .Q(Resume_State[2]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \Resume_State_reg[1]  ( .clear(N29), .preset(1'b0), 
        .next_state(N150), .clocked_on(CLK), .data_in(1'b0), .enable(1'b0), 
        .Q(Resume_State[1]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  \**SEQGEN**  \Resume_State_reg[0]  ( .clear(N29), .preset(1'b0), 
        .next_state(N149), .clocked_on(CLK), .data_in(1'b0), .enable(1'b0), 
        .Q(Resume_State[0]), .synch_clear(1'b0), .synch_preset(1'b0), 
        .synch_toggle(1'b0), .synch_enable(1'b1) );
  GTECH_NOT I_0 ( .A(Counter[1]), .Z(N154) );
  GTECH_OR2 C384 ( .A(N154), .B(Counter[2]), .Z(N155) );
  GTECH_OR2 C385 ( .A(Counter[0]), .B(N155), .Z(N156) );
  GTECH_NOT I_1 ( .A(N156), .Z(N157) );
  GTECH_OR2 C388 ( .A(N154), .B(Counter[2]), .Z(N158) );
  GTECH_OR2 C389 ( .A(Counter[0]), .B(N158), .Z(N159) );
  GTECH_NOT I_2 ( .A(N159), .Z(N160) );
  GTECH_OR2 C392 ( .A(N154), .B(Counter[2]), .Z(N161) );
  GTECH_OR2 C393 ( .A(Counter[0]), .B(N161), .Z(N162) );
  GTECH_NOT I_3 ( .A(N162), .Z(N163) );
  GTECH_OR2 C396 ( .A(N154), .B(Counter[2]), .Z(N164) );
  GTECH_OR2 C397 ( .A(Counter[0]), .B(N164), .Z(N165) );
  GTECH_NOT I_4 ( .A(N165), .Z(N166) );
  GTECH_NOT I_5 ( .A(Next_State[2]), .Z(N167) );
  GTECH_OR2 C400 ( .A(Next_State[1]), .B(N167), .Z(N168) );
  GTECH_OR2 C401 ( .A(Next_State[0]), .B(N168), .Z(N169) );
  GTECH_OR2 C405 ( .A(N154), .B(Counter[2]), .Z(N170) );
  GTECH_OR2 C406 ( .A(Counter[0]), .B(N170), .Z(N171) );
  GTECH_NOT I_6 ( .A(N171), .Z(N172) );
  GTECH_NOT I_7 ( .A(Current_State[0]), .Z(N173) );
  GTECH_OR2 C409 ( .A(Current_State[1]), .B(Current_State[2]), .Z(N174) );
  GTECH_OR2 C410 ( .A(N173), .B(N174), .Z(N175) );
  GTECH_OR2 C414 ( .A(Current_State[1]), .B(Current_State[2]), .Z(N176) );
  GTECH_OR2 C415 ( .A(N173), .B(N176), .Z(N177) );
  GTECH_NOT I_8 ( .A(N177), .Z(N178) );
  GTECH_NOT I_9 ( .A(Operation[1]), .Z(N179) );
  GTECH_OR2 C418 ( .A(Operation[0]), .B(N179), .Z(N180) );
  GTECH_NOT I_10 ( .A(N180), .Z(N181) );
  GTECH_AND2 C420 ( .A(Operation[0]), .B(Operation[1]), .Z(N182) );
  GTECH_OR2 C422 ( .A(N154), .B(Counter[2]), .Z(N183) );
  GTECH_OR2 C423 ( .A(Counter[0]), .B(N183), .Z(N184) );
  GTECH_NOT I_11 ( .A(N184), .Z(N185) );
  GTECH_OR2 C426 ( .A(N154), .B(Counter[2]), .Z(N186) );
  GTECH_OR2 C427 ( .A(Counter[0]), .B(N186), .Z(N187) );
  GTECH_NOT I_12 ( .A(N187), .Z(N188) );
  GTECH_OR2 C430 ( .A(N154), .B(Counter[2]), .Z(N189) );
  GTECH_OR2 C431 ( .A(Counter[0]), .B(N189), .Z(N190) );
  GTECH_NOT I_13 ( .A(N190), .Z(N191) );
  GTECH_OR2 C433 ( .A(Current_State[1]), .B(Current_State[2]), .Z(N192) );
  GTECH_OR2 C434 ( .A(Current_State[0]), .B(N192), .Z(N193) );
  GTECH_OR2 C437 ( .A(Weight[0]), .B(Weight[1]), .Z(N194) );
  GTECH_NOT I_14 ( .A(N194), .Z(N195) );
  GTECH_NOT I_15 ( .A(Weight[0]), .Z(N196) );
  GTECH_OR2 C440 ( .A(N196), .B(Weight[1]), .Z(N197) );
  GTECH_NOT I_16 ( .A(N197), .Z(N198) );
  GTECH_NOT I_17 ( .A(Weight[1]), .Z(N199) );
  GTECH_OR2 C443 ( .A(Weight[0]), .B(N199), .Z(N200) );
  GTECH_NOT I_18 ( .A(N200), .Z(N201) );
  GTECH_OR2 C446 ( .A(N154), .B(Counter[2]), .Z(N202) );
  GTECH_OR2 C447 ( .A(Counter[0]), .B(N202), .Z(N203) );
  GTECH_NOT I_19 ( .A(N203), .Z(N204) );
  ADD_UNS_OP add_414 ( .A(Counter), .B(1'b1), .Z({N136, N135, N134}) );
  SELECT_OP C449 ( .DATA1({1'b0, 1'b0, 1'b0}), .DATA2(Next_State), .CONTROL1(
        N0), .CONTROL2(N1), .Z({N33, N32, N31}) );
  GTECH_BUF B_0 ( .A(Stop), .Z(N0) );
  GTECH_BUF B_1 ( .A(N30), .Z(N1) );
  SELECT_OP C450 ( .DATA1({1'b1, 1'b0, 1'b0}), .DATA2({1'b1, 1'b0, 1'b1}), 
        .DATA3({1'b0, 1'b1, 1'b1}), .DATA4({1'b0, 1'b0, 1'b1}), .CONTROL1(N2), 
        .CONTROL2(N95), .CONTROL3(N91), .CONTROL4(N61), .Z({N64, N63, N62}) );
  GTECH_BUF B_2 ( .A(Pause), .Z(N2) );
  SELECT_OP C451 ( .DATA1({1'b1, 1'b0}), .DATA2({1'b1, 1'b1}), .DATA3({1'b0, 
        1'b0}), .CONTROL1(N3), .CONTROL2(N4), .CONTROL3(N5), .Z({N68, N67}) );
  GTECH_BUF B_3 ( .A(N181), .Z(N3) );
  GTECH_BUF B_4 ( .A(N182), .Z(N4) );
  GTECH_BUF B_5 ( .A(N179), .Z(N5) );
  SELECT_OP C452 ( .DATA1({1'b1, 1'b0, 1'b0}), .DATA2({1'b1, 1'b0, 1'b1}), 
        .DATA3({N68, 1'b1, N67}), .DATA4({1'b0, 1'b1, 1'b1}), .CONTROL1(N2), 
        .CONTROL2(N95), .CONTROL3(N92), .CONTROL4(N66), .Z({N71, N70, N69}) );
  SELECT_OP C454 ( .DATA1({1'b1, 1'b0, 1'b0}), .DATA2({1'b1, 1'b0, 1'b1}), 
        .DATA3({1'b1, 1'b1, N206}), .DATA4({1'b0, 1'b1, 1'b0}), .CONTROL1(N2), 
        .CONTROL2(N95), .CONTROL3(N93), .CONTROL4(N73), .Z({N76, N75, N74}) );
  SELECT_OP C455 ( .DATA1({1'b0, 1'b0}), .DATA2({1'b0, 1'b1}), .DATA3({1'b1, 
        1'b1}), .DATA4({1'b1, 1'b0}), .CONTROL1(N2), .CONTROL2(N95), 
        .CONTROL3(N98), .CONTROL4(N79), .Z({N81, N80}) );
  SELECT_OP C456 ( .DATA1({1'b1, 1'b0, 1'b0}), .DATA2({1'b1, 1'b0, 1'b1}), 
        .DATA3({1'b0, 1'b0, 1'b0}), .DATA4({1'b1, 1'b1, 1'b1}), .CONTROL1(N2), 
        .CONTROL2(N95), .CONTROL3(N99), .CONTROL4(N83), .Z({N86, N85, N84}) );
  SELECT_OP C457 ( .DATA1({1'b1, 1'b0, 1'b0}), .DATA2({1'b1, 1'b0, 1'b1}), 
        .DATA3(Resume_State), .CONTROL1(N2), .CONTROL2(N95), .CONTROL3(N87), 
        .Z({N90, N89, N88}) );
  SELECT_OP C458 ( .DATA1({1'b0, 1'b0, N58}), .DATA2({N64, N63, N62}), .DATA3(
        {N71, N70, N69}), .DATA4({N76, N75, N74}), .DATA5({1'b1, N81, N80}), 
        .DATA6({N86, N85, N84}), .DATA7({N90, N89, N88}), .DATA8({1'b0, 1'b0, 
        1'b0}), .CONTROL1(N6), .CONTROL2(N7), .CONTROL3(N8), .CONTROL4(N9), 
        .CONTROL5(N10), .CONTROL6(N11), .CONTROL7(N12), .CONTROL8(N13), .Z(
        Next_State) );
  GTECH_BUF B_6 ( .A(N37), .Z(N6) );
  GTECH_BUF B_7 ( .A(N40), .Z(N7) );
  GTECH_BUF B_8 ( .A(N43), .Z(N8) );
  GTECH_BUF B_9 ( .A(N46), .Z(N9) );
  GTECH_BUF B_10 ( .A(N49), .Z(N10) );
  GTECH_BUF B_11 ( .A(N51), .Z(N11) );
  GTECH_BUF B_12 ( .A(N54), .Z(N12) );
  GTECH_BUF B_13 ( .A(N57), .Z(N13) );
  SELECT_OP C459 ( .DATA1(1'b0), .DATA2(1'b0), .DATA3(1'b0), .DATA4(1'b0), 
        .DATA5(1'b0), .DATA6(1'b0), .DATA7(1'b0), .DATA8(1'b1), .CONTROL1(N14), 
        .CONTROL2(N15), .CONTROL3(N16), .CONTROL4(N17), .CONTROL5(N18), 
        .CONTROL6(N19), .CONTROL7(N20), .CONTROL8(N21), .Z(Failure) );
  GTECH_BUF B_14 ( .A(N101), .Z(N14) );
  GTECH_BUF B_15 ( .A(N104), .Z(N15) );
  GTECH_BUF B_16 ( .A(N107), .Z(N16) );
  GTECH_BUF B_17 ( .A(N110), .Z(N17) );
  GTECH_BUF B_18 ( .A(N113), .Z(N18) );
  GTECH_BUF B_19 ( .A(N115), .Z(N19) );
  GTECH_BUF B_20 ( .A(N118), .Z(N20) );
  GTECH_BUF B_21 ( .A(N121), .Z(N21) );
  SELECT_OP C460 ( .DATA1(1'b1), .DATA2(1'b1), .DATA3(1'b1), .DATA4(1'b1), 
        .DATA5(1'b0), .DATA6(1'b0), .DATA7(1'b0), .DATA8(1'b0), .CONTROL1(N14), 
        .CONTROL2(N15), .CONTROL3(N16), .CONTROL4(N17), .CONTROL5(N18), 
        .CONTROL6(N19), .CONTROL7(N20), .CONTROL8(N21), .Z(N123) );
  SELECT_OP C461 ( .DATA1(1'b0), .DATA2(N122), .DATA3(1'b0), .DATA4(1'b0), 
        .CONTROL1(N14), .CONTROL2(N15), .CONTROL3(N16), .CONTROL4(N17), .Z(
        N124) );
  SELECT_OP C462 ( .DATA1(1'b0), .DATA2(1'b0), .DATA3(N160), .DATA4(1'b0), 
        .DATA5(1'b0), .DATA6(1'b0), .DATA7(1'b0), .DATA8(1'b0), .CONTROL1(N14), 
        .CONTROL2(N15), .CONTROL3(N16), .CONTROL4(N17), .CONTROL5(N18), 
        .CONTROL6(N19), .CONTROL7(N20), .CONTROL8(N21), .Z(Heating_Water_Done)
         );
  SELECT_OP C463 ( .DATA1(1'b0), .DATA2(1'b0), .DATA3(1'b0), .DATA4(N163), 
        .DATA5(1'b0), .DATA6(1'b0), .DATA7(1'b0), .DATA8(1'b0), .CONTROL1(N14), 
        .CONTROL2(N15), .CONTROL3(N16), .CONTROL4(N17), .CONTROL5(N18), 
        .CONTROL6(N19), .CONTROL7(N20), .CONTROL8(N21), .Z(Washing_Done) );
  SELECT_OP C464 ( .DATA1(1'b0), .DATA2(1'b0), .DATA3(1'b0), .DATA4(1'b0), 
        .DATA5(N166), .DATA6(1'b0), .DATA7(1'b0), .DATA8(1'b0), .CONTROL1(N14), 
        .CONTROL2(N15), .CONTROL3(N16), .CONTROL4(N17), .CONTROL5(N18), 
        .CONTROL6(N19), .CONTROL7(N20), .CONTROL8(N21), .Z(Rinsing_Done) );
  SELECT_OP C465 ( .DATA1(1'b0), .DATA2(1'b0), .DATA3(1'b0), .DATA4(1'b0), 
        .DATA5(1'b0), .DATA6(N157), .DATA7(1'b0), .DATA8(1'b0), .CONTROL1(N14), 
        .CONTROL2(N15), .CONTROL3(N16), .CONTROL4(N17), .CONTROL5(N18), 
        .CONTROL6(N19), .CONTROL7(N20), .CONTROL8(N21), .Z(Spinning_Done) );
  SELECT_OP C466 ( .DATA1({1'b0, 1'b1, 1'b0}), .DATA2({1'b0, 1'b1, 1'b1}), 
        .DATA3({1'b1, 1'b0, 1'b0}), .DATA4({1'b0, 1'b1, 1'b0}), .CONTROL1(N22), 
        .CONTROL2(N23), .CONTROL3(N24), .CONTROL4(N25), .Z(WATER_LEVEL) );
  GTECH_BUF B_22 ( .A(N195), .Z(N22) );
  GTECH_BUF B_23 ( .A(N198), .Z(N23) );
  GTECH_BUF B_24 ( .A(N201), .Z(N24) );
  GTECH_BUF B_25 ( .A(N125), .Z(N25) );
  SELECT_OP C467 ( .DATA1({1'b0, 1'b0, 1'b0}), .DATA2({1'b0, 1'b0, 1'b0}), 
        .DATA3({N136, N135, N134}), .CONTROL1(N26), .CONTROL2(N144), 
        .CONTROL3(N133), .Z({N139, N138, N137}) );
  GTECH_BUF B_26 ( .A(N130), .Z(N26) );
  SELECT_OP C468 ( .DATA1({N139, N138, N137}), .DATA2({1'b0, 1'b0, 1'b0}), 
        .CONTROL1(N27), .CONTROL2(N127), .Z({N142, N141, N140}) );
  GTECH_BUF B_27 ( .A(N193), .Z(N27) );
  SELECT_OP C469 ( .DATA1(1'b0), .DATA2(1'b1), .DATA3(1'b1), .CONTROL1(N28), 
        .CONTROL2(N153), .CONTROL3(N147), .Z(N148) );
  GTECH_BUF B_28 ( .A(N169), .Z(N28) );
  SELECT_OP C470 ( .DATA1(Resume_State), .DATA2(Current_State), .DATA3(
        Resume_State), .CONTROL1(N28), .CONTROL2(N153), .CONTROL3(N147), .Z({
        N151, N150, N149}) );
  GTECH_NOT I_20 ( .A(RST_n), .Z(N29) );
  GTECH_NOT I_21 ( .A(Stop), .Z(N30) );
  GTECH_NOT I_22 ( .A(Current_State[2]), .Z(N34) );
  GTECH_NOT I_23 ( .A(Current_State[1]), .Z(N35) );
  GTECH_NOT I_24 ( .A(N39), .Z(N40) );
  GTECH_NOT I_25 ( .A(N42), .Z(N43) );
  GTECH_NOT I_26 ( .A(N45), .Z(N46) );
  GTECH_NOT I_27 ( .A(N48), .Z(N49) );
  GTECH_NOT I_28 ( .A(N53), .Z(N54) );
  GTECH_NOT I_29 ( .A(N56), .Z(N57) );
  GTECH_AND2 C503 ( .A(N205), .B(Clothes_in), .Z(N58) );
  GTECH_AND2 C504 ( .A(Close_Door), .B(Start), .Z(N205) );
  GTECH_BUF B_29 ( .A(N40) );
  GTECH_OR2 C508 ( .A(N59), .B(N77), .Z(N60) );
  GTECH_NOT I_30 ( .A(N60), .Z(N61) );
  GTECH_OR2 C511 ( .A(N204), .B(N77), .Z(N65) );
  GTECH_NOT I_31 ( .A(N65), .Z(N66) );
  GTECH_OR2 C518 ( .A(N188), .B(N77), .Z(N72) );
  GTECH_NOT I_32 ( .A(N72), .Z(N73) );
  GTECH_OR2 C521 ( .A(Operation[1]), .B(Operation[0]), .Z(N206) );
  GTECH_OR2 C526 ( .A(Open_Door), .B(Pause), .Z(N77) );
  GTECH_OR2 C527 ( .A(N185), .B(N77), .Z(N78) );
  GTECH_NOT I_33 ( .A(N78), .Z(N79) );
  GTECH_OR2 C530 ( .A(N191), .B(N77), .Z(N82) );
  GTECH_NOT I_34 ( .A(N82), .Z(N83) );
  GTECH_NOT I_35 ( .A(N77), .Z(N87) );
  GTECH_AND2 C533 ( .A(N59), .B(N97), .Z(N91) );
  GTECH_AND2 C534 ( .A(N204), .B(N97), .Z(N92) );
  GTECH_AND2 C535 ( .A(N188), .B(N97), .Z(N93) );
  GTECH_NOT I_36 ( .A(Pause), .Z(N94) );
  GTECH_AND2 C537 ( .A(Open_Door), .B(N94), .Z(N95) );
  GTECH_NOT I_37 ( .A(Open_Door), .Z(N96) );
  GTECH_AND2 C539 ( .A(N94), .B(N96), .Z(N97) );
  GTECH_AND2 C540 ( .A(N185), .B(N97), .Z(N98) );
  GTECH_AND2 C541 ( .A(N191), .B(N97), .Z(N99) );
  GTECH_NOT I_38 ( .A(N103), .Z(N104) );
  GTECH_NOT I_39 ( .A(N106), .Z(N107) );
  GTECH_NOT I_40 ( .A(N109), .Z(N110) );
  GTECH_NOT I_41 ( .A(N112), .Z(N113) );
  GTECH_NOT I_42 ( .A(N117), .Z(N118) );
  GTECH_NOT I_43 ( .A(N120), .Z(N121) );
  GTECH_BUF B_30 ( .A(N104) );
  GTECH_AND2 C574 ( .A(Weight[1]), .B(Weight[0]), .Z(N125) );
  GTECH_BUF B_31 ( .A(RST_n), .Z(N126) );
  GTECH_NOT I_44 ( .A(N193), .Z(N127) );
  GTECH_AND2 C583 ( .A(N126), .B(N193), .Z(N128) );
  GTECH_AND2 C584 ( .A(N178), .B(N129), .Z(N130) );
  GTECH_AND2 C585 ( .A(N172), .B(N175), .Z(N131) );
  GTECH_OR2 C588 ( .A(N131), .B(N130), .Z(N132) );
  GTECH_NOT I_45 ( .A(N132), .Z(N133) );
  GTECH_AND2 C590 ( .A(N128), .B(N133), .Z(net86) );
  GTECH_NOT I_46 ( .A(N130), .Z(N143) );
  GTECH_AND2 C592 ( .A(N131), .B(N143), .Z(N144) );
  GTECH_AND2 C593 ( .A(Pause), .B(N207), .Z(N145) );
  GTECH_NOT I_47 ( .A(flag), .Z(N207) );
  GTECH_OR2 C597 ( .A(N145), .B(N169), .Z(N146) );
  GTECH_NOT I_48 ( .A(N146), .Z(N147) );
  GTECH_NOT I_49 ( .A(N169), .Z(N152) );
  GTECH_AND2 C600 ( .A(N145), .B(N152), .Z(N153) );
endmodule

