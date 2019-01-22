with VisualLayer;
with ModelLayer;
with Gtk.Widget;
with Gtk.Handlers;

package ControllerLayer is

   type TableOfPositions is array (natural range <>) of ModelLayer.Position;
   type DynamicTableOfPositions is access all TableOfPositions;
   type PossibleMoves is record
      aDynamicTable : DynamicTableOfPositions;
      First : Integer := 0;
      Last : Integer := 0;
   end record;
   function newPossibleMoves( outterPossibleMoves : in out PossibleMoves; newSize : in Natural ) return PossibleMoves;
   function appendPossibleMoves( outterPossibleMoves : in out PossibleMoves; newPosition : in ModelLayer.Position ) return PossibleMoves;
   function PossibleMovesToString( outterPossibleMoves : in out PossibleMoves ) return String;

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

end ControllerLayer;
