with Ada.Text_IO;
use Ada.Text_IO;
with Gtk.Button; use Gtk.Button;

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
      aButtonToReclick : Gtk.Button.Gtk_Button := null;
   begin
      if( aPossibleActivations'First = 0 and aPossibleActivations'Last = 0 ) then
         null; -- do nothing
         Put_Line("do nothing");
      else
         aNatural := Natural( Float(aNatural) * aRatio +1.0 );
         Put_Line("                 aPossibleActivations( " & aNatural'Img & " ).Clicked; \/");
         Put_Line( "aPossibleActivations'Last = " & aPossibleActivations'Last'Img  & " vs. aNatural = " & aNatural'Img );
         --
         Put_Line( "NaturalAndZero( aNatural ) = " & NaturalAndZero( aNatural )'Img );
         --
         aButton := aPossibleActivations( NaturalAndZero( aNatural ) );
         Put_Line( "aButton.Is_Created = " & aButton.Is_Created'Img );
         Put_Line("                 aButton.Clicked \/");
         aButton.Clicked;
         Put_Line("                 aButton.Clicked /\");
         Put_Line("                 aPossibleActivations( " & aNatural'Img & " ).Clicked; /\");
      end if;
      
      return aButtonToReclick;
   end clickRandomButton;
   
   task body GameTurnMain is
      isReady : Boolean := False;
      aTurn : Turn := Player;
      isEnd_of_the_Game : Boolean := False;
      aPossibleActivations : DynamicTableOfButtons := resetPossibleActivations;
      aButtonToReclick : Gtk.Button.Gtk_Button;
      aNaturalGenerator : RandomNatural.Generator;
      Unhandled_GameTurnMain_Exception : exception;
      aButtonToReclick_isNull_Exception : exception;
   begin
      accept Start_the_Game;
      
      aTurn := Init_Turn( aTurn );
      Put_Line("Read... Set... Go!");
      Put_Line( aTurn'Img & "'s Turn..." );
      RandomNatural.Reset( aNaturalGenerator );
      isReady := True;
         
      while( isEnd_of_the_Game = False ) loop
         select
            when isReady = True =>
               accept End_of_the_Game do
                  isReady := False;
                  Put_Line("End of the Game");
                  isEnd_of_the_Game := True;
                  isReady := True;
               end End_of_the_Game;
         or
            when isReady = True =>
               accept Append_PossibleActivations( aButton : in out Gtk.Button.Gtk_Button ) do
                  isReady := False;
                  aPossibleActivations := appendPossibleActivations( aPossibleActivations, aButton );
                  isReady := True;
               end Append_PossibleActivations;
         or
            when isReady = True =>
               accept Reset_PossibleActivations do
                  isReady := False;
                  aPossibleActivations := resetPossibleActivations;
                  isReady := True;
               end Reset_PossibleActivations;
         or
            when isReady = True =>
               accept Get_PossibleActtivations( inoutPossibleActivations : in out DynamicTableOfButtons ) do
                  isReady := False;
                  inoutPossibleActivations := aPossibleActivations;
                  isReady := True;
               end Get_PossibleActtivations;   
         or
            when isReady = True =>
               accept Click_RandomButton do
                  isReady := False;
                  Put_Line("                 procedure clickRandomButton( aPossibleActivations ); \/");
                  aButtonToReclick := clickRandomButton( aPossibleActivations, aNaturalGenerator );
                  Put_Line("                 procedure clickRandomButton( aPossibleActivations ); /\");
                  isReady := True;
               end Click_RandomButton;
         or
            when isReady = True =>
               accept Set_ButtonToReclick( aButton : in out Gtk.Button.Gtk_Button ) do
                  isReady := False;
                  aButtonToReclick := aButton;
                  isReady := True;
               end Set_ButtonToReclick;
         or
            when isReady = True =>
               accept ReClick_Button do
                  isReady := False;
                  if( aButtonToReclick = null ) then
                     raise aButtonToReclick_isNull_Exception;
                  else
                     Put_Line( "aButtonToReclick.Is_Created = " & aButtonToReclick.Is_Created'Img );
                     Put_Line( "aButtonToReclick.Clicked; \/" );
                     aButtonToReclick.Clicked;
                     Put_Line( "aButtonToReclick.Clicked; /\" );
                  end if;
                  isReady := True;
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
