with Gtk.Button;

package GameTurn is

   type NaturalAndZero is new Integer range 0..Integer'Last;
   type TableOfButtons is array (NaturalAndZero range <>) of Gtk.Button.Gtk_Button;
   type DynamicTableOfButtons is access all TableOfButtons;
   function appendPossibleActivations( aPossibleActivations : in out DynamicTableOfButtons; aButton : in out Gtk.Button.Gtk_Button ) return DynamicTableOfButtons;
   function resetPossibleActivations return DynamicTableOfButtons;
   function clickRandomButton( aPossibleActivations : DynamicTableOfButtons ) return Gtk.Button.Gtk_Button;

   type Turn is (Player, Computer);
   function Init_Turn( aTurn : in out Turn ) return Turn;
   function Change_Turn( aTurn : in out Turn ) return Turn;

   task type GameTurnMain is
      entry Start_the_Game;
      entry End_Turn( outTurn : in out Turn );
      entry Get_Turn( outTurn : in out Turn );
      entry Append_PossibleActivations( aButton : in out Gtk.Button.Gtk_Button );
      entry Reset_PossibleActivations;
      entry Get_PossibleActtivations( inoutPossibleActivations : in out DynamicTableOfButtons );
      entry Click_RandomButton;
      entry ReClick_Button;
      entry End_of_the_Game;
   end GameTurnMain;

end GameTurn;
