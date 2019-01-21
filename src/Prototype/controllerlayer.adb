with VisualLayer; use VisualLayer;
with ModelLayer; use ModelLayer;
with Gtk.Main;
with Gtk.Widget;
with Gtk.Window;
with Ada.Text_IO; use Ada.Text_IO;
with System.Address_Image;

package body ControllerLayer is

   aAllData : VisualLayer.AllData;
   procedure Main is 
   begin
      aAllData := VisualLayer.Main;
         
      aAllData.aMainWindow.aWindow.Show_All;
      Gtk.Main.Main;
   end Main;

end ControllerLayer;
