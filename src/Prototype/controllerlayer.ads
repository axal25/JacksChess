with VisualLayer;
with ModelLayer;
with Gtk.Widget;
with Gtk.Handlers;

package ControllerLayer is
   type NaturalAndZero is new Integer range 0..Integer'Last;
   type TableOfPositions is array (NaturalAndZero range <>) of ModelLayer.Position;
   type DynamicTableOfPositions is access all TableOfPositions;
   type PossibleMoves is record
      aDynamicTable : DynamicTableOfPositions;
      First : NaturalAndZero := 0;
      Last : NaturalAndZero := 0;
   end record;
   function newPossibleMoves( outterPossibleMoves : in out PossibleMoves; newSize : in NaturalAndZero ) return PossibleMoves;
   function appendPossibleMoves( outterPossibleMoves : in out PossibleMoves; newPosition : in ModelLayer.Position ) return PossibleMoves;
   function appendPossibleMoves( outterPossibleMoves : in out PossibleMoves;
                                 aY : ModelLayer.AxisY; ax : ModelLayer.AxisX )
                                return PossibleMoves;
   function removePossibleMoves( outterPossibleMoves : in out PossibleMoves; aPosition : in ModelLayer.Position ) return PossibleMoves;
   function PossibleMovesToString( outterPossibleMoves : in out PossibleMoves ) return String;

   procedure ShowPossibleMoves;
   procedure ShowPossibleMove( aPosition : in out ModelLayer.Position );

   procedure HidePossibleMoves;
   procedure HidePossibleMove( aPosition : in out ModelLayer.Position );

   procedure SetDeactive_aActivatedPosition;
   procedure SetActive_aActivatedPosition( aPosition : in ModelLayer.Position );

   procedure Main;
   procedure SetPossibleToActivate;

   package UserCallback_Position is new Gtk.Handlers.User_Callback( Gtk.Widget.Gtk_Widget_Record, ModelLayer.Position );
   procedure Activate_Button( aPosition : in ModelLayer.Position );
   procedure Activate_Button_Call( Object : access Gtk.Widget.Gtk_Widget_Record'Class; aPosition : in ModelLayer.Position );

   procedure Deactivate_Button;
   procedure Deactivate_Button_Call( Object : access Gtk.Widget.Gtk_Widget_Record'Class; aPosition : in ModelLayer.Position );

   procedure FindPossibleMoves( aPosition : in ModelLayer.Position );
   procedure FindPossibleMovesPawn( aPosition : in ModelLayer.Position );
   procedure FindPossibleMovesKnight( aPosition : in ModelLayer.Position );
   procedure FindPossibleMovesBishop( aPosition : in ModelLayer.Position );

   function isEnemyOrEmpty( row : in out ModelLayer.AxisY; col : in out ModelLayer.AxisX; aColor : in out ModelLayer.Color ) return Boolean;

end ControllerLayer;
