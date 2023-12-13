////////////////////////////////////////////////////////////////
//////////////////////// TESTBENCH /////////////////////////////
////////////////////////////////////////////////////////////////


module Washing_Machine_Tb ;

parameter CLOCK_PERIOD     =   10            ;

///////// CONNECTIONS /////////
     
reg             CLK       					 ;
reg             RST_n     					 ;
reg             Open_Door                    ;
reg             Close_Door                   ;
reg             Clothes_in                   ;
reg             Start     					 ;
reg    [1 : 0]  Weight    					 ;
reg 	        Pause     					 ;
reg 	        Stop      					 ;
reg    [1 : 0]  Operation 					 ;
    
wire            Finish    			         ;
wire            Failure   			         ;
wire            Filling_Water_Done           ;
wire            Heating_Water_Done           ;
wire            Washing_Done                 ;
wire            Rinsing_Done                 ;
wire            Spinning_Done                ;


reg             flag                         ;

reg    [1 : 0]  Weight_r                     ;    
reg    [1 : 0]  Operation_r                  ;


integer         i                            ;


////// DUT INSTANTIATION /////////

Washing_Machine DUT(.*);


////// CLOCK GENERATION //////////

always #(CLOCK_PERIOD/2) CLK = ~CLK ;


///// STIMULUS GENERATION ///////

initial begin

CLK        = 0 ;
Open_Door  = 0 ;
Close_Door = 0 ;
Clothes_in = 0 ;
Start      = 0 ;
Weight     = 0 ;
Pause      = 0 ;
Stop       = 0 ;
Operation  = 0 ; 
flag       = 0 ;


//....... STARTING_TEST.......

INTIALIZE();

//.....  DIRECT_TESTING........

SEND_STIMULUS(1,0,1,1,1,0,0,0,0);               // TESTING LIGHT WEIGHT - NORMAL OPERATION
CHECKING_RESULT(0,0);

#(CLOCK_PERIOD);


SEND_STIMULUS(1,0,1,1,1,0,0,0,1);               // TESTING LIGHT WEIGHT - WASHING OPERATION ONLY
CHECKING_RESULT(0,1); 


#(CLOCK_PERIOD);

SEND_STIMULUS(1,0,1,1,1,0,0,0,2);               // TESTING LIGHT WEIGHT - RINSING OPERATION ONLY
CHECKING_RESULT(0,2);


#(CLOCK_PERIOD);

SEND_STIMULUS(1,0,1,1,1,0,0,0,3);               // TESTING LIGHT WEIGHT - SPINNING OPERATION
CHECKING_RESULT(0,3);



#(CLOCK_PERIOD);

SEND_STIMULUS(1,0,1,1,1,1,0,0,0);               // TESTING MEDIUM WEIGHT - NORMAL OPERATION
CHECKING_RESULT(1,0);



#(CLOCK_PERIOD);

SEND_STIMULUS(1,0,1,1,1,1,0,0,1);              // TESTING MEDIUM WEIGHT - WASHING OPERATION ONLY
CHECKING_RESULT(1,1);


#(CLOCK_PERIOD);

SEND_STIMULUS(1,0,1,1,1,1,0,0,2);               // TESTING MEDIUM WEIGHT - RINSING OPERATION ONLY
CHECKING_RESULT(1,2);


#(CLOCK_PERIOD);

SEND_STIMULUS(1,0,1,1,1,1,0,0,3);               // TESTING MEDIUM WEIGHT - SPINNING OPERATION
CHECKING_RESULT(1,3);



#(CLOCK_PERIOD);

SEND_STIMULUS(1,0,1,1,1,2,0,0,0);              // TESTING HEAVY WEIGHT - NORMAL OPERATION
CHECKING_RESULT(2,0);



#(CLOCK_PERIOD);

SEND_STIMULUS(1,0,1,1,1,2,0,0,1);				// TESTING HEAVY WEIGHT - WASHING OPERATION ONLY
CHECKING_RESULT(2,1);


#(CLOCK_PERIOD);

SEND_STIMULUS(1,0,1,1,1,2,0,0,2);               // TESTING HEAVY WEIGHT - RINSING OPERATION ONLY
CHECKING_RESULT(2,2);


#(CLOCK_PERIOD);

SEND_STIMULUS(1,0,1,1,1,2,0,0,3);               // TESTING HEAVY WEIGHT - SPINNING OPERATION
CHECKING_RESULT(2,3);



#(CLOCK_PERIOD);


SEND_STIMULUS(0,0,1,1,1,2,0,0,3);               // TESTING RESETING
CHECKING_RESULT(2,3);



#(CLOCK_PERIOD);


SEND_STIMULUS(1,0,1,1,1,2,0,1,3);               // TESTING STOPPING
CHECKING_RESULT(2,3);



SEND_STIMULUS(1,1,0,1,1,0,0,0,0);               // TESTING OPEN DOOR CASE
CHECKING_RESULT(0,0);

#(CLOCK_PERIOD);



SEND_STIMULUS(1,0,1,1,1,0,0,0,0);               // TESTING FAILURE OPEN DOOR CASE
#(3*CLOCK_PERIOD);
SEND_STIMULUS(1,1,0,1,1,0,0,0,0);
#(CLOCK_PERIOD);
CHECKING_RESULT(0,0);


//....RANDOM_TESTING......

for (i = 0 ; i < 1000 ; i = i + 1) begin
#(CLOCK_PERIOD);

Weight_r     = $urandom_range(2) ; 
Operation_r  = $urandom_range(3) ;

if(Weight_r != 3) begin
  SEND_STIMULUS(1,0,1,1,1,Weight_r,0,0,Operation_r);
  CHECKING_RESULT(Weight_r , Operation_r) ;
end  

end




// #(CLOCK_PERIOD);


// SEND_STIMULUS(1,0,1,1,1,2,1,0,3);               // TESTING PAUSING
// CHECKING_RESULT(2,3);

// #(CLOCK_PERIOD);

// SEND_STIMULUS(1,0,1,1,1,2,0,0,3);              
// CHECKING_RESULT(2,3);


$stop ;

end



/////////////////////////////////////////////////////
//////////////// INITIALIZATION TASK ////////////////
/////////////////////////////////////////////////////


task INTIALIZE();
begin
//....... RESETING..........
RST_n      = 0 ;
#(2 * CLOCK_PERIOD);
RST_n      = 1 ;
#(CLOCK_PERIOD);

end
endtask




/////////////////////////////////////////////////////
//////////////// SENDING STIMULUS TASK //////////////
/////////////////////////////////////////////////////



task SEND_STIMULUS(input Rst_n_in , input Open_Door_in , input Close_Door_in , input Clothes_in_in 
	               , input Start_in , input [1:0] Weight_in , input Pause_in , input Stop_in , input [1:0] Operation_in);

begin

@(negedge CLK);

RST_n      = Rst_n_in       ;
Open_Door  = Open_Door_in   ;
Close_Door = Close_Door_in  ;
Clothes_in = Clothes_in_in  ;
Start      = Start_in       ;
Weight     = Weight_in      ;
Pause      = Pause_in       ;
Stop       = Stop_in        ;
Operation  = Operation_in   ; 


$display("/////////////////////////////////////////////////////");
$display("/////////////////////////////////////////////////////");
$display("/////////////////////////////////////////////////////");

end
endtask





/////////////////////////////////////////////////////
//////////////// CHECKING TASK //////////////////////
/////////////////////////////////////////////////////




task CHECKING_RESULT(input [1:0] Weight_in , input [1:0] Operation_in);
begin


if(Stop || !RST_n) begin

if(!RST_n)
  $display("------------ RESET TEST ----------");
   
else 
  $display("------------ STOP TEST ----------");


if(!Finish && !Failure && !Filling_Water_Done && !Heating_Water_Done && !Washing_Done && !Rinsing_Done && !Spinning_Done)
  PRINT_SECCEEDED();

else 
  PRINT_FAILED();  

end


else if(Open_Door) begin
  $display("------------ OPEN DOOR TEST / FAILURE CASE ----------");
@(posedge CLK)
  if(DUT.Next_State == DUT.WAITING)
    PRINT_SECCEEDED();
  else
    PRINT_FAILED();
end


else if(!Clothes_in) begin
  $display("------------ CLOTHES EMPTY TEST ----------");
@(posedge CLK)
  if(DUT.Next_State == DUT.WAITING)
    PRINT_SECCEEDED();
  else
    PRINT_FAILED();
end




else if(Clothes_in && Start && Close_Door) begin

case({Weight_in,Operation_in})


4'b0000: begin 

$display("////////////// LIGHT WEIGHT - NORMAL OPERATION TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(2) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");


repeat(3) @(posedge CLK);
#1;
flag = 0;
  if(DUT.Next_State == DUT.WASHING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: WASHING STATE ----------");  
   end

  else $display("---------WRONG_STATE : NOT WASHING ----------");


repeat(3) @(posedge CLK);
 #1; 
 flag = 1;
  if(DUT.Next_State == DUT.RINSING) begin
     if (Washing_Done) #1 $display("Washing_Done");
     else                    $display("Washing_Done_Error");
     $display("---------RIGHT_STATE: RINSING STATE ----------");  
   end
  else $display("---------WRONG_STATE : NOT RINSING ----------");


repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Rinsing_Done) #1 $display("Rinsing_Done");
     else                    $display("Rinsing_Done_Error");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");


end         








4'b0001: begin

$display("////////////// LIGHT WEIGHT - WASHING OPERATION ONLY TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(2) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");


repeat(3) @(posedge CLK);
#1;
flag = 0;
  if(DUT.Next_State == DUT.WASHING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: WASHING STATE ----------");  
   end

  else $display("---------WRONG_STATE : NOT WASHING ----------");




repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Washing_Done) #1 $display("Washing_Done");
     else                    $display("Washing_Done_Error");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");


end







4'b0010: begin

$display("////////////// LIGHT WEIGHT - RINSING OPERATION ONLY TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(2) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");



repeat(3) @(posedge CLK);
 #1; 
 flag = 1;
  if(DUT.Next_State == DUT.RINSING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: RINSING STATE ----------");  
   end
  else $display("---------WRONG_STATE : NOT RINSING ----------");


repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Rinsing_Done) #1 $display("Rinsing_Done");
     else                    $display("Rinsing_Done_Error");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");


end                                  







4'b0011: begin

$display("////////////// LIGHT WEIGHT - SPINNING OPERATION ONLY TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(2) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");




repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");

end





4'b0100: begin

$display("////////////// MEDIUM WEIGHT - NORMAL OPERATION TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(3) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");


repeat(3) @(posedge CLK);
#1;
flag = 0;
  if(DUT.Next_State == DUT.WASHING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: WASHING STATE ----------");  
   end

  else $display("---------WRONG_STATE : NOT WASHING ----------");


repeat(3) @(posedge CLK);
 #1; 
 flag = 1;
  if(DUT.Next_State == DUT.RINSING) begin
     if (Washing_Done) #1 $display("Washing_Done");
     else                    $display("Washing_Done_Error");
     $display("---------RIGHT_STATE: RINSING STATE ----------");  
   end
  else $display("---------WRONG_STATE : NOT RINSING ----------");


repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Rinsing_Done) #1 $display("Rinsing_Done");
     else                    $display("Rinsing_Done_Error");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");




end                                 



4'b0101: begin


$display("////////////// MEDIUM WEIGHT - WASHING OPERATION ONLY TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(3) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");


repeat(3) @(posedge CLK);
#1;
flag = 0;
  if(DUT.Next_State == DUT.WASHING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: WASHING STATE ----------");  
   end

  else $display("---------WRONG_STATE : NOT WASHING ----------");




repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Washing_Done) #1 $display("Washing_Done");
     else                    $display("Washing_Done_Error");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");


end                                     



4'b0110: begin

$display("////////////// MEDIUM WEIGHT - RINSING OPERATION ONLY TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(3) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");



repeat(3) @(posedge CLK);
 #1; 
 flag = 1;
  if(DUT.Next_State == DUT.RINSING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: RINSING STATE ----------");  
   end
  else $display("---------WRONG_STATE : NOT RINSING ----------");


repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Rinsing_Done) #1 $display("Rinsing_Done");
     else                    $display("Rinsing_Done_Error");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");



end                                  



4'b0111: begin

$display("////////////// MEDIUM WEIGHT - SPINNING OPERATION ONLY TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(3) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");




repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");




end                                 








4'b1000: begin

$display("////////////// HEAVY WEIGHT - NORMAL OPERATION TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(4) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");


repeat(3) @(posedge CLK);
#1;
flag = 0;
  if(DUT.Next_State == DUT.WASHING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: WASHING STATE ----------");  
   end

  else $display("---------WRONG_STATE : NOT WASHING ----------");


repeat(3) @(posedge CLK);
 #1; 
 flag = 1;
  if(DUT.Next_State == DUT.RINSING) begin
     if (Washing_Done) #1 $display("Washing_Done");
     else                    $display("Washing_Done_Error");
     $display("---------RIGHT_STATE: RINSING STATE ----------");  
   end
  else $display("---------WRONG_STATE : NOT RINSING ----------");


repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Rinsing_Done) #1 $display("Rinsing_Done");
     else                    $display("Rinsing_Done_Error");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");




end


4'b1001: begin

$display("////////////// HEAVY WEIGHT - WASHING OPERATION ONLY TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(4) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");


repeat(3) @(posedge CLK);
#1;
flag = 0;
  if(DUT.Next_State == DUT.WASHING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: WASHING STATE ----------");  
   end

  else $display("---------WRONG_STATE : NOT WASHING ----------");




repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Washing_Done) #1 $display("Washing_Done");
     else                    $display("Washing_Done_Error");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");


end                                     



4'b1010: begin

$display("////////////// HEAVY WEIGHT - RINSING OPERATION ONLY TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(4) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");



repeat(3) @(posedge CLK);
 #1; 
 flag = 1;
  if(DUT.Next_State == DUT.RINSING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: RINSING STATE ----------");  
   end
  else $display("---------WRONG_STATE : NOT RINSING ----------");


repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Rinsing_Done) #1 $display("Rinsing_Done");
     else                    $display("Rinsing_Done_Error");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");



end                                  





4'b1011: begin

$display("////////////// HEAVY WEIGHT - SPINNING OPERATION ONLY TEST ////////////////");

@(posedge CLK);
  if(DUT.Next_State == DUT.FILL_WATER) $display("---------RIGHT_STATE: FILLNG WATER STATE ----------");
  else $display("---------WRONG_STATE : NOT FILLING----------");


repeat(4) @(posedge CLK);
#1;
flag = 1 ;
  if(DUT.Next_State == DUT.HEAT_WATER) begin
     if (Filling_Water_Done) $display("Filling_Water_Done");
     else                    $display("Filling_Water_ERROR");
     $display("---------RIGHT_STATE: HEAT_WATER STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT HEATEING ----------");




repeat(3) @(posedge CLK);
#1
flag = 0;
  if(DUT.Next_State == DUT.SPINNING) begin
     if (Heating_Water_Done) #1 $display("Heating_Water_Done");
     else                    $display("Heating_Water_ERROR");
     $display("---------RIGHT_STATE: SPINNING STATE ----------");  
  end
  else $display("---------WRONG_STATE : NOT SPINNING ----------");


end                                 


endcase

repeat(3) @(posedge CLK);
#1
 if(Finish == 1'b1 && Failure == 0  && Filling_Water_Done == 0  && Heating_Water_Done == 0  && Washing_Done == 0  && Rinsing_Done == 0  && Spinning_Done == 1'b1)
  PRINT_SECCEEDED();

 else 
  PRINT_FAILED();
end




else begin

if(DUT.Current_State == DUT.WAITING)
  PRINT_SECCEEDED();

else
  PRINT_FAILED();  

end





end
endtask



  

/////////////////////////////////////////////////////
///////////////// PRINTING TASKS ////////////////////
/////////////////////////////////////////////////////

task PRINT_SECCEEDED();
begin

$display("SECCEDED TEST , Finish = %b , Failure = %b , Filling_Water_Done = %b , Heating_Water_Done = %b , Washing_Done = %b, Rinsing_Done = %b , Spinning_Done = %b " , Finish , Failure , Filling_Water_Done , Heating_Water_Done , Washing_Done , Rinsing_Done , Spinning_Done );

end
endtask



task PRINT_FAILED();
begin

$display("FAILED TEST , Finish = %b , Failure = %b , Filling_Water_Done = %b , Heating_Water_Done = %b , Washing_Done = %b, Rinsing_Done = %b , Spinning_Done = %b " , Finish , Failure , Filling_Water_Done , Heating_Water_Done , Washing_Done , Rinsing_Done , Spinning_Done );

end
endtask



/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////


endmodule
