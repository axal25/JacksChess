with VisualLayer;
with ModelLayer;
with Gtk.Widget;
with Gtk.Handlers;

package ControllerLayer is

   procedure SetDeactive_aActivatedPosition;
   procedure SetActive_aActivatedPosition( aPosition : in ModelLayer.Position );

   procedure Main;
   procedure SetPossibleToActivate;

   package UserCallback_Position is new Gtk.Handlers.User_Callback( Gtk.Widget.Gtk_Widget_Record, ModelLayer.Position );
   procedure Activate_Button( aPosition : in ModelLayer.Position );
   procedure Activate_Button_Call( Object : access Gtk.Widget.Gtk_Widget_Record'Class; aPosition : in ModelLayer.Position );
   procedure Deactivate_Button;
   procedure Deactivate_Button_Call( Object : access Gtk.Widget.Gtk_Widget_Record'Class; aPosition : in ModelLayer.Position );

end ControllerLayer;
