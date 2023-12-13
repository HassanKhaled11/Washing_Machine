module Washing_Machine
(
  ////////////// INPUTS ////////////
  input                  CLK       					        ,
  input                  RST_n     					        ,
  input                  Open_Door                  ,
  input                  Close_Door                 ,
  input                  Clothes_in                 ,
  input                  Start     					        ,
  input         [1 : 0]  Weight    					        ,
  input  		             Pause       		            ,
  input  		             Stop        		            ,
  input         [1 : 0]  Operation 					        ,

  ///////////// OUTPUTS /////////////
  output  reg            Finish    					        ,
  output  reg            Failure   					        ,
  output  reg            Filling_Water_Done         ,
  output  reg            Heating_Water_Done         ,
  output  reg            Washing_Done               ,
  output  reg            Rinsing_Done               ,
  output  reg            Spinning_Done 

);

//////////// INTERNALS ///////////////

reg [2:0] Current_State                          ;
reg [2:0] Next_State                             ;
reg [2:0] Resume_State                           ;

reg [2:0] Counter                                ; 
reg [2:0] WATER_LEVEL                            ;

reg       flag                                   ;



/////////// PARAMETERS ///////////////

localparam   WAITING      =  3'b000              ;
localparam   FILL_WATER   =  3'b001              ;   
localparam   HEAT_WATER   =  3'b011              ;
localparam   WASHING      =  3'b010              ;
localparam   RINSING      =  3'b110              ;
localparam   SPINNING     =  3'b111              ;
localparam   FAILURE      =  3'b101              ;   
localparam   PAUSE        =  3'b100              ;   

/////////////////////////////////////////

always @(posedge CLK or negedge RST_n) begin
	if (!RST_n) begin
		Current_State <= WAITING    ;
	end

	else if(Stop) begin
       Current_State <= WAITING ;
	end

	else  begin
		Current_State <= Next_State ;
	end
end

//////// NEXT_STATE_SELECTION ///////////

always @(*) begin

 case(Current_State)
 
  WAITING       : begin

  					if(Close_Door && Start && Clothes_in) begin
 						Next_State  = FILL_WATER  ;
  					end

  					else begin
                        Next_State  = WAITING    ;
  					end

                  end  
  



  FILL_WATER    : begin
  	               
                   if(Pause)
                       Next_State = PAUSE ;

                   else if(Open_Door) 
                       Next_State = FAILURE ;


  	               else if(Counter == WATER_LEVEL) 
  	               	   Next_State = HEAT_WATER ;

  	               else        
                       Next_State = FILL_WATER ;
                  end  
  



  HEAT_WATER    : begin

                   if(Pause)
                       Next_State = PAUSE ;

                   else if(Open_Door) Next_State = FAILURE ;

  	               else if(Counter == 2) begin

                        if(Operation == 2)
                            Next_State = RINSING ;         //RINSING -> SPINNING  

  	                    else if(Operation == 3)
  	                    	Next_State = SPINNING;         //SPINNING ONLY

                        else 
                        	Next_State = WASHING ;         //NORMAL OPERATION OR WASHING ONLY 
  	               
  	                end


  	                else
  	                	Next_State = HEAT_WATER  ;

 				  end




  WASHING       :begin

                   if(Pause)
                      Next_State = PAUSE ;  

                  else if(Open_Door) Next_State = FAILURE ;


  	              else if(Counter == 2) begin
                  	
                     if(!Operation) 
                       Next_State = RINSING  ;

                     else
                        Next_State = SPINNING ;   
                  
                  end


                  else begin
                  	Next_State = WASHING   ;
                  end
                
 				 end



  RINSING       :begin

                   if(Pause)
                    Next_State = PAUSE ;

                  else if(Open_Door) Next_State = FAILURE ;

                  else if(Counter == 2) 
                  	Next_State = SPINNING ; 

                   else
                   	Next_State = RINSING  ;

 				 end



  SPINNING      :begin

                  if(Pause)
                       Next_State = PAUSE ;

                  else if(Open_Door) Next_State = FAILURE ;

                  else if(Counter == 2) 
                  	Next_State = WAITING  ;

                  else 
                  	Next_State = SPINNING ;

 				 end  



  PAUSE         :begin

                  if(Pause) 
                   	Next_State = PAUSE ;

                  else if(Open_Door) Next_State = FAILURE ;


                  else 
                   	Next_State = Resume_State ;

 				 end



  FAILURE       :begin
  	               Next_State = WAITING ;
 				 end  

 endcase 

end

//////////////// OUTPUTS_BLOCK //////////////

always@(*) begin

 case(Current_State)

 
    WAITING       : begin

                      Finish               = 0 ;
                      Failure              = 0 ;
                      Filling_Water_Done   = 0 ;
                      Heating_Water_Done   = 0 ;
                      Washing_Done         = 0 ;
                      Rinsing_Done         = 0 ;
                      Spinning_Done        = 0 ;

                    end  
    



    FILL_WATER    : begin

                      Finish               = 0 ;
                      Failure              = 0 ;
                      Heating_Water_Done   = 0 ;
                      Washing_Done         = 0 ;
                      Rinsing_Done         = 0 ;
                      Spinning_Done        = 0 ;
                      
                      if(Counter == WATER_LEVEL)
                      Filling_Water_Done   = 1 ;

                      else
                      Filling_Water_Done   = 0 ;	

                    end  



    
    HEAT_WATER    : begin

                      Finish               = 0 ;
                      Failure              = 0 ;
                      Washing_Done         = 0 ;
                      Rinsing_Done         = 0 ;
                      Spinning_Done        = 0 ;
                      Filling_Water_Done   = 0 ;
                      
                      if(Counter == 2)
                      Heating_Water_Done   = 1 ;

                      else
                      Heating_Water_Done   = 0 ;	

   				    end  



  
    WASHING       : begin

                      Finish               = 0 ;
                      Failure              = 0 ;
                      Rinsing_Done         = 0 ;
                      Spinning_Done        = 0 ;
                      Heating_Water_Done   = 0 ;
                      Filling_Water_Done   = 0 ;
                      
                      if(Counter == 2)
                      Washing_Done         = 1 ;

                      else
                      Washing_Done         = 0 ;	

   				    end  
  



    RINSING       : begin

                      Finish               = 0 ;
                      Failure              = 0 ;
                      Washing_Done         = 0 ;
                      Spinning_Done        = 0 ;
                      Heating_Water_Done   = 0 ;
                      
                      if(Counter == 2)
                      Rinsing_Done         = 1 ;

                      else
                      Rinsing_Done         = 0 ;	

   				    end
  



    SPINNING      : begin

                      Failure              = 0 ;
                      Rinsing_Done         = 0 ;
                      Washing_Done         = 0 ;
                      Heating_Water_Done   = 0 ;
                      
                      if(Counter == 2) begin
                      Spinning_Done        = 1 ;
                      Finish               = 1 ;	
                      end

                      else begin
                      Spinning_Done        = 0 ;	
                      Finish               = 0 ;	
                      end
               
   				    end
  



    PAUSE         : begin

                      Finish               = 0 ;
                      Failure              = 0 ;
                      Rinsing_Done         = 0 ;
                      Spinning_Done        = 0 ;
                      Heating_Water_Done   = 0 ;
                      Washing_Done         = 0 ;	
   		
   				    end
  



    FAILURE       : begin

                      Finish               = 0 ;
                      Failure              = 1 ;
                      Rinsing_Done         = 0 ;
                      Spinning_Done        = 0 ;
                      Heating_Water_Done   = 0 ;
                      Washing_Done         = 0 ;	

 				    end  

 endcase 

end



/////// LEVEL OF WATER HANDLING  ///////

always @(*) begin

if(Weight == 0) begin
  WATER_LEVEL = 3'b010;                  // LIGHT WEIGHT
end

else if(Weight == 1) begin               // MEDIUM WEIGHT
  WATER_LEVEL = 3'b011;
end

else if(Weight == 2) begin               // HEAVY WEIGHT 
  WATER_LEVEL = 3'b100; 
end 

else 
  WATER_LEVEL = 3'b010;
   
end 


///////////// COUNTER HANDLING ////////////////

always @(posedge CLK or negedge RST_n)
begin

  if(!RST_n) Counter <= 0 ;

  else if(Current_State != WAITING) begin


      if(Current_State == FILL_WATER && Counter == WATER_LEVEL) begin
        Counter <= 0 ;
      end
    
      else if(Counter == 2 && Current_State != FILL_WATER) begin
        Counter <= 0 ;
      end
       
      else begin
        Counter <= Counter + 1 ; 
      end

    end 
    

    else begin
       Counter <= 0 ;
    end 
    
end

//////////// PAUSE STATE HANDLING //////////

always @(posedge CLK or negedge RST_n)
begin

if(!RST_n) begin
  Resume_State <= WAITING           ;
  flag         <= 1'b0              ;
end

else if(Next_State != PAUSE) begin
  flag         <= 1'b0              ;
  Resume_State <= Resume_State      ; 
end

else begin

  if(Pause &&  !flag ) begin 
    Resume_State <= Current_State   ;
    flag <= 1'b1                    ;
  end


  else begin 
    Resume_State <= Resume_State    ;
    flag         <= 1'b1            ;
  end

end


end

endmodule