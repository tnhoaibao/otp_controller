////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// TSMC Library/IP Product
/// Filename: tcbn65gplus.v
/// Technology: CLN65GP
/// Product Type: Standard Cell
/// Product Name: tcbn65gplus
/// Version: 200a
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
///  STATEMENT OF USE
///
///  This information contains confidential and proprietary information of TSMC.
///  No part of this information may be reproduced, transmitted, transcribed,
///  stored in a retrieval system, or translated into any human or computer
///  language, in any form or by any means, electronic, mechanical, magnetic,
///  optical, chemical, manual, or otherwise, without the prior written permission
///  of TSMC.  This information was prepared for informational purpose and is for
///  use by TSMC's customers only.  TSMC reserves the right to make changes in the
///  information at any time and without notice.
///
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/10ps
`celldefine
module AN2D0 (A1, A2, Z);
    input A1, A2;
    output Z;
    and		(Z, A1, A2);

  specify
    (A1 => Z) = (0, 0);
    (A2 => Z) = (0, 0);
  endspecify
endmodule
`endcelldefine

`celldefine
module CKLNQD8 (TE, E, CP, Q);
    input TE, E, CP;
    output Q;
    reg notifier;
  `ifdef NTC 	// Reserve for NTC.
    wire TE_d, E_d, CP_d ;
    pullup	(CDN);
    pullup	(SDN);
    or		(D_i, E_d, TE_d);
    not		(CPB, CP_d);
    tsmc_dla 	(Q_buf, D_i, CPB, CDN, SDN, notifier);
    and         (Q, Q_buf, CP_d);
  `else 	// Reserve for non NTC.
    pullup	(CDN);
    pullup	(SDN);
    or		(D_i, E, TE);
    not		(CPB, CP);
    tsmc_dla 	(Q_buf, D_i, CPB, CDN, SDN, notifier);
    and         (Q, Q_buf, CP);
  `endif
  `ifdef NTC
  `else
  `endif

`celldefine
module CKLHQD8 ( Q, TE, CPN, E );
    input TE, CPN, E;
    output Q;
    reg notifier;
    // Dummy Buffer
  `ifdef NTC 	// Reserve for NTC.
    wire TE_d, CPN_d, E_d ;
    buf ( _TE, TE_d );
    buf ( _CPN, CPN_d );
    buf ( _E, E_d );
    or ( _G001, _E, _TE );
    tsmc_dla ( _enl, _G001, _CPN, 1'b1, 1'b1, notifier );
    not ( _enlb, _enl );
    or ( Q, _enlb, _CPN );
  `else 	// Reserve for non NTC.
    buf ( _TE, TE );
    buf ( _CPN, CPN );
    buf ( _E, E );
    or ( _G001, _E, _TE );
    tsmc_dla ( _enl, _G001, _CPN, 1'b1, 1'b1, notifier );
    not ( _enlb, _enl );
    or ( Q, _enlb, _CPN );
  `endif
  `ifdef NTC
  `else
  `endif



  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (E_int_not, E_d);
    not  (TE_int_not, TE_d);
  `else
    not  (E_int_not, E);
    not  (TE_int_not, TE);
  `endif
    buf  (E_check, TE_int_not);
  buf  (TE_check, E_int_not);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (E_DEFCHK, E_check, 1'b1);
    tsmc_xbuf (TE_DEFCHK, TE_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (E == 1'b0 && TE == 1'b0)
    (posedge CPN => (Q+:1'b1)) = (0, 0);
    if (E == 1'b1 && TE == 1'b1)
    (CPN => Q) = (0, 0);
    if (E == 1'b1 && TE == 1'b0)
    (CPN => Q) = (0, 0);
    if (E == 1'b0 && TE == 1'b1)
    (CPN => Q) = (0, 0);
    ifnone (CPN => Q) = (0, 0);
    $width (posedge CPN, 0, 0, notifier);
    $width (negedge CPN, 0, 0, notifier);
  `ifdef NTC
    $setuphold (negedge CPN &&& E_DEFCHK, posedge E, 0, 0, notifier,,, CPN_d, E_d);
    $setuphold (negedge CPN &&& E_DEFCHK, negedge E, 0, 0, notifier,,, CPN_d, E_d);
    $setuphold (negedge CPN &&& TE_DEFCHK, posedge TE, 0, 0, notifier,,, CPN_d, TE_d);
    $setuphold (negedge CPN &&& TE_DEFCHK, negedge TE, 0, 0, notifier,,, CPN_d, TE_d);
  `else
    $setuphold (negedge CPN &&& E_DEFCHK, posedge E, 0, 0, notifier);
    $setuphold (negedge CPN &&& E_DEFCHK, negedge E, 0, 0, notifier);
    $setuphold (negedge CPN &&& TE_DEFCHK, posedge TE, 0, 0, notifier);
    $setuphold (negedge CPN &&& TE_DEFCHK, negedge TE, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule
`endcelldefine

  // Timing logics defined for default constraint check
  `ifdef NTC
    not  (E_int_not, E_d);
    not  (TE_int_not, TE_d);
  `else
    not  (E_int_not, E);
    not  (TE_int_not, TE);
  `endif
    buf  (E_check, TE_int_not);
  buf  (TE_check, E_int_not);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (E_DEFCHK, E_check, 1'b1);
    tsmc_xbuf (TE_DEFCHK, TE_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (E == 1'b1 && TE == 1'b1)
    (CP => Q) = (0, 0);
    if (E == 1'b1 && TE == 1'b0)
    (CP => Q) = (0, 0);
    if (E == 1'b0 && TE == 1'b1)
    (CP => Q) = (0, 0);
    if (E == 1'b0 && TE == 1'b0)
    (negedge CP => (Q+:1'b0)) = (0, 0);
    ifnone (CP => Q) = (0, 0);
    $width (posedge CP, 0, 0, notifier);
    $width (negedge CP, 0, 0, notifier);
  `ifdef NTC
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier,,, CP_d, E_d);
    $setuphold (posedge CP &&& TE_DEFCHK, posedge TE, 0, 0, notifier,,, CP_d, TE_d);
    $setuphold (posedge CP &&& TE_DEFCHK, negedge TE, 0, 0, notifier,,, CP_d, TE_d);
  `else
    $setuphold (posedge CP &&& E_DEFCHK, posedge E, 0, 0, notifier);
    $setuphold (posedge CP &&& E_DEFCHK, negedge E, 0, 0, notifier);
    $setuphold (posedge CP &&& TE_DEFCHK, posedge TE, 0, 0, notifier);
    $setuphold (posedge CP &&& TE_DEFCHK, negedge TE, 0, 0, notifier);
  `endif
  endspecify
  `endif
endmodule
`endcelldefine

`celldefine
module OR2D4 (A1, A2, Z);
    input A1, A2;
    output Z;
    or		(Z, A1, A2);

  specify
    (A1 => Z) = (0, 0);
    (A2 => Z) = (0, 0);
  endspecify
endmodule
`endcelldefine

`celldefine
module MUX2D2 (I0, I1, S, Z);
  input		I0, I1, S;
  output	Z;
  tsmc_mux	(Z_buf, I0, I1, S);
  buf  		(Z, Z_buf);

  specify
    if (I1 == 1'b1 && S == 1'b0)
    (I0 => Z) = (0, 0);
    if (I1 == 1'b0 && S == 1'b0)
    (I0 => Z) = (0, 0);
    ifnone (I0 => Z) = (0, 0);
    if (I0 == 1'b1 && S == 1'b1)
    (I1 => Z) = (0, 0);
    if (I0 == 1'b0 && S == 1'b1)
    (I1 => Z) = (0, 0);
    ifnone (I1 => Z) = (0, 0);
    if (I0 == 1'b0 && I1 == 1'b1)
    (S => Z) = (0, 0);
    if (I0 == 1'b1 && I1 == 1'b0)
    (S => Z) = (0, 0);
    ifnone (S => Z) = (0, 0);
  endspecify
endmodule
`endcelldefine

`celldefine
module CKMUX2D2 (I0, I1, S, Z);
  input		I0, I1, S;
  output	Z;
  tsmc_mux	(Z_buf, I0, I1, S);
  buf  		(Z, Z_buf);

  specify
    if (I1 == 1'b1 && S == 1'b0)
    (I0 => Z) = (0, 0);
    if (I1 == 1'b0 && S == 1'b0)
    (I0 => Z) = (0, 0);
    ifnone (I0 => Z) = (0, 0);
    if (I0 == 1'b1 && S == 1'b1)
    (I1 => Z) = (0, 0);
    if (I0 == 1'b0 && S == 1'b1)
    (I1 => Z) = (0, 0);
    ifnone (I1 => Z) = (0, 0);
    if (I0 == 1'b0 && I1 == 1'b1)
    (S => Z) = (0, 0);
    if (I0 == 1'b1 && I1 == 1'b0)
    (S => Z) = (0, 0);
    ifnone (S => Z) = (0, 0);
  endspecify
endmodule
`endcelldefine

primitive tsmc_dff (q, d, cp, cdn, sdn, notifier);
   output q;
   input d, cp, cdn, sdn, notifier;
   reg q;
   table
      ?   ?   0   ?   ? : ? : 0 ; // CDN dominate SDN
      ?   ?   1   0   ? : ? : 1 ; // SDN is set   
      ?   ?   1   x   ? : 0 : x ; // SDN affect Q
      ?   ?   1   x   ? : 1 : 1 ; // Q=1,preset=X
      ?   ?   x   1   ? : 0 : 0 ; // Q=0,clear=X
      0 (01)  ?   1   ? : ? : 0 ; // Latch 0
      0   *   ?   1   ? : 0 : 0 ; // Keep 0 (D==Q)
      1 (01)  1   ?   ? : ? : 1 ; // Latch 1   
      1   *   1   ?   ? : 1 : 1 ; // Keep 1 (D==Q)
      ? (1?)  1   1   ? : ? : - ; // ignore negative edge of clock
      ? (?0)  1   1   ? : ? : - ; // ignore negative edge of clock
      ?   ? (?1)  1   ? : ? : - ; // ignore positive edge of CDN
      ?   ?   1 (?1)  ? : ? : - ; // ignore posative edge of SDN
      *   ?   1   1   ? : ? : - ; // ignore data change on steady clock
      ?   ?   ?   ?   * : ? : x ; // timing check violation
   endtable
endprimitive

primitive tsmc_dla (q, d, e, cdn, sdn, notifier);
   output q;
   reg q;
   input d, e, cdn, sdn, notifier;
   table
   1  1   1   ?   ?   : ?  :  1  ; // Latch 1
   0  1   ?   1   ?   : ?  :  0  ; // Latch 0
   0 (10) 1   1   ?   : ?  :  0  ; // Latch 0 after falling edge
   1 (10) 1   1   ?   : ?  :  1  ; // Latch 1 after falling edge
   *  0   ?   ?   ?   : ?  :  -  ; // no changes
   ?  ?   ?   0   ?   : ?  :  1  ; // preset to 1
   ?  0   1   *   ?   : 1  :  1  ;
   1  ?   1   *   ?   : 1  :  1  ;
   1  *   1   ?   ?   : 1  :  1  ;
   ?  ?   0   1   ?   : ?  :  0  ; // reset to 0
   ?  0   *   1   ?   : 0  :  0  ;
   0  ?   *   1   ?   : 0  :  0  ;
   0  *   ?   1   ?   : 0  :  0  ;
   ?  ?   ?   ?   *   : ?  :  x  ; // toggle notifier
   endtable
endprimitive

primitive tsmc_mux (q, d0, d1, s);
   output q;
   input s, d0, d1;

   table
   // d0  d1  s   : q 
      0   ?   0   : 0 ;
      1   ?   0   : 1 ;
      ?   0   1   : 0 ;
      ?   1   1   : 1 ;
      0   0   x   : 0 ;
      1   1   x   : 1 ;
   endtable
endprimitive

primitive tsmc_xbuf (o, i, dummy);
   output o;     
   input i, dummy;
   table         
   // i dummy : o
      0   1   : 0 ;
      1   1   : 1 ;
      x   1   : 1 ;
   endtable      
endprimitive 