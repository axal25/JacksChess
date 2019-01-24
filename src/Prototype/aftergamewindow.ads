with GameTurn;
with Gtk.Widget;

package AfterGameWindow is

   procedure Main( aWinner : in GameTurn.Turn );
   procedure DestroyObject_And_MainQuit( Object: access Gtk.Widget.Gtk_Widget_Record'Class );

end AfterGameWindow;
