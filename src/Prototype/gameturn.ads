with Gtk.Button;
with ControllerLayer;

package GameTurn is

   type NaturalAndZero is new ControllerLayer.NaturalAndZero;
   type TableOfButtons is array (NaturalAndZero range <>) of Gtk.Button.Gtk_Button;
   type DynamicTableOfButtons is access all TableOfButtons;
   function appendPossibleActivations( aPossibleActivations : in out DynamicTableOfButtons; aButton : in out Gtk.Button.Gtk_Button ) return DynamicTableOfButtons;
   function resetPossibleActivations return DynamicTableOfButtons;
   procedure clickRandomButton( aPossibleActivations : DynamicTableOfButtons );

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
      entry End_of_the_Game;
   end GameTurnMain;

end GameTurn;
