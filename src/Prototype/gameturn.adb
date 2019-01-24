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
   
   function appendPossibleActivations( aPossibleActivations : in out DynamicTableOfButtons; aButton : in out Gtk.Button.Gtk_Button ) return DynamicTableOfButtons is
      aNewPossibleActivations : DynamicTableOfButtons;
   begin
      if( aPossibleActivations'First = 0 and aPossibleActivations'Last = 0 ) then
         aNewPossibleActivations := new TableOfButtons( 1 .. 1 );
         aNewPossibleActivations( aNewPossibleActivations'First ) := aButton;
         aPossibleActivations := aNewPossibleActivations;
         --           Put_Line( "0 .. 0 =>" & aNewPossibleActivations'First'Img & " .. " & aNewPossibleActivations'Last'Img );
      else
         aNewPossibleActivations := new TableOfButtons( aPossibleActivations'First .. aPossibleActivations'Last +1 );
         --           Put_Line( aPossibleActivations'First'Img & " .. " & aPossibleActivations'Last'Img & " => " & aNewPossibleActivations'First'Img & " .. " & aNewPossibleActivations'Last'Img );
         for I in aPossibleActivations'Range loop
            aNewPossibleActivations( I ) := aPossibleActivations( I );
         end loop;
         aNewPossibleActivations( aPossibleActivations'Last +1 ) := aButton;
         aPossibleActivations := aNewPossibleActivations;
      end if;
      --        Put_Line( aPossibleActivations'First'Img & " .. " & aPossibleActivations'Last'Img );
      return aPossibleActivations;
   end appendPossibleActivations;
   
   function resetPossibleActivations return DynamicTableOfButtons is
      aNewPossibleActivations : DynamicTableOfButtons;
   begin
      aNewPossibleActivations := new TableOfButtons( 0 .. 0 );
      return aNewPossibleActivations;
   end resetPossibleActivations;
   
   function clickRandomButton( aPossibleActivations : in out DynamicTableOfButtons; aNaturalGenerator : in out RandomNatural.Generator  ) return Gtk.Button.Gtk_Button is
      aButton : Gtk.Button.Gtk_Button;
      aNatural : Natural := RandomNatural.Random( aNaturalGenerator );
      aRatio : Float := Float( aPossibleActivations'Last -1 )/Float( Natural'Last );
   begin
      if( aPossibleActivations'First = 0 and aPossibleActivations'Last = 0 ) then
         null; -- do nothing
         Put_Line("do nothing");
      else
         aNatural := Natural( Float(aNatural) * aRatio +1.0 );
         Put_Line("                 aPossibleActivations( " & aNatural'Img & " ).Clicked; \/");
         Put_Line( "aPossibleActivations'Last = " & aPossibleActivations'Last'Img  & " vs. aNatural = " & aNatural'Img );
         --
         aNatural := 10;
         Put_Line( "NaturalAndZero( aNatural ) = " & NaturalAndZero( aNatural )'Img );
         --
         aButton := aPossibleActivations( NaturalAndZero( aNatural ) );
         Put_Line( "aButton.Is_Created = " & aButton.Is_Created'Img );
         Put_Line("                 aButton.Clicked \/");
         aButton.Clicked;
         Put_Line("                 aButton.Clicked /\");
         Put_Line("                 aPossibleActivations( " & aNatural'Img & " ).Clicked; /\");
         
         return aButton;
      end if;
   end clickRandomButton;
   
   task body GameTurnMain is
      aTurn : Turn := Player;
      isEnd_of_the_Game : Boolean := False;
      aPossibleActivations : DynamicTableOfButtons := resetPossibleActivations;
      aButtonToReclick : Gtk.Button.Gtk_Button;
      aLastClickedButton : Gtk.Button.Gtk_Button;
      aNaturalGenerator : RandomNatural.Generator;
      Unhandled_GameTurnMain_Exception : exception;
   begin
      accept Start_the_Game;
      
      aTurn := Init_Turn( aTurn );
      Put_Line("Read... Set... Go!");
      Put_Line( aTurn'Img & "'s Turn..." );
      RandomNatural.Reset( aNaturalGenerator );
         
      while( isEnd_of_the_Game = False ) loop
         select            
            accept End_Turn( outTurn : in out Turn ) do
               aTurn := Change_Turn( aTurn );
               outTurn := aTurn;
               Put_Line( aTurn'Img & "'s Turn..." );
         
               -- Skip computer's turn
               --                 if( aTurn = Computer ) then
               --                    Put_Line( "--------------" );
               --                    aTurn := Change_Turn( aTurn );
               --                    outTurn := aTurn;
               --                    Put_Line( aTurn'Img & "'s Turn..." );
               --                 end if;
            end End_Turn;            
         or              
            accept Get_Turn( outTurn : in out Turn ) do
               Put_Line(" outTurn := aTurn; \/" );
               outTurn := aTurn;
               Put_Line(" outTurn := aTurn; /\" );
            end Get_Turn;            
         or            
            accept End_of_the_Game do
               Put_Line("End of the Game");
               isEnd_of_the_Game := True;
            end End_of_the_Game;            
         or
            accept Append_PossibleActivations( aButton : in out Gtk.Button.Gtk_Button ) do
               aPossibleActivations := appendPossibleActivations( aPossibleActivations, aButton );
            end Append_PossibleActivations;
         or
            accept Reset_PossibleActivations do
               aPossibleActivations := resetPossibleActivations;
            end Reset_PossibleActivations;
         or
            accept Get_PossibleActtivations( inoutPossibleActivations : in out DynamicTableOfButtons ) do
               inoutPossibleActivations := aPossibleActivations;
            end Get_PossibleActtivations;   
         or
            accept Click_RandomButton do
               Put_Line("                 procedure clickRandomButton( aPossibleActivations ); \/");
               aLastClickedButton := clickRandomButton( aPossibleActivations, aNaturalGenerator );
               Put_Line("                 procedure clickRandomButton( aPossibleActivations ); /\");
            end Click_RandomButton;
         or
            accept Set_ButtonToReclick( aButton : in out Gtk.Button.Gtk_Button ) do
               aButtonToReclick := aButton;
            end Set_ButtonToReclick;
         or
            accept ReClick_Button do
               Put_Line( "aButtonToReclick.Is_Created = " & aButtonToReclick.Is_Created'Img );
               Put_Line( "aButtonToReclick.Clicked; \/" );
               aButtonToReclick.Clicked;
               Put_Line( "aButtonToReclick.Clicked; /\" );
            end ReClick_Button;
         end select;
      end loop;
      Put_Line(" "); Put_Line(" "); Put_Line(" ");
      Put_Line(" END !!! ### GameTurnMain ### !!! END ");
      Put_Line(" "); Put_Line(" "); Put_Line(" ");
   exception
      when others => 
         Put_Line("Unhandled_GameTurnMain_Exception");
         raise Unhandled_GameTurnMain_Exception;         
   end GameTurnMain;

end GameTurn;
