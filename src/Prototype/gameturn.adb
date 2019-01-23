with Ada.Text_IO;
use Ada.Text_IO;

package body GameTurn is

   function Init_Turn( aTurn : in out Turn ) return Turn is
   begin
      aTurn := Player;
      return aTurn;
   end;
   
   function Change_Turn( aTurn : in out Turn ) return Turn is
   begin
      if( aTurn = Player ) then
         aTurn := Computer;
      else
         aTurn := Player;
      end if;
      return aTurn;
   end;
   
   task body GameTurnMain is
      aTurn : Turn := Player;
      isEnd_of_the_Game : Boolean := False;
   begin
      accept Start_the_Game;
      
      aTurn := Init_Turn( aTurn );
      Put_Line("Read... Set... Go!");
      Put_Line( aTurn'Img & "'s Turn..." );
         
      while( isEnd_of_the_Game = False ) loop
         select
            
            accept End_Turn( outTurn : in out Turn ) do
               aTurn := Change_Turn( aTurn );
               outTurn := aTurn;
               Put_Line( aTurn'Img & "'s Turn..." );
         
               -- Skip computer's turn
               if( aTurn = Computer ) then
                  Put_Line( "--------------" );
                  aTurn := Change_Turn( aTurn );
                  outTurn := aTurn;
                  Put_Line( aTurn'Img & "'s Turn..." );
               end if;
            end End_Turn;
            
         or
              
            accept Get_Turn( outTurn : in out Turn ) do
               outTurn := aTurn;
            end Get_Turn;
            
         or
            
            accept End_of_the_Game do
               Put_Line("End of the Game");
               isEnd_of_the_Game := True;
            end End_of_the_Game;
            
         end select;
      end loop;   
   end GameTurnMain;

end GameTurn;
