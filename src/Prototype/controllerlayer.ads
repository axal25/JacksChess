with VisualLayer;
with ModelLayer;
with Gtk.Widget;
with Gtk.Handlers;

package ControllerLayer is

   procedure Main;
   function SetPossibleToActivate( aAllData : in out VisualLayer.AllData ) return VisualLayer.AllData;

   package UserCallback_Position is new Gtk.Handlers.User_Callback( Gtk.Widget.Gtk_Widget_Record, ModelLayer.Position );
   procedure Activate_Button( Object: access Gtk.Widget.Gtk_Widget_Record'Class;
                              aPosition : ModelLayer.Position );

end ControllerLayer;
