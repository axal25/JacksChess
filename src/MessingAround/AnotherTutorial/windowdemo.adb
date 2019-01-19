-- okienko.adb
--
-- Przemyslaw Kobylanski <przemko@mac.com>
--
-- 1. utworzenie okienka
-- 2. zwiazanie ze zdarzeniem Destroy okienka zakonczenia programu
-- 3. wyswietlenie okienka
-- 4. oczekiwanie na zdarzenia
--

with Gtk.Main;
with Gtk.Enums;
with Gtk.Window;
with Gtk.Widget;

with Exit_Main;

package body WindowDemo is
   Main_Window : Gtk.Window.Gtk_Window;

   procedure Main is
   begin
      Gtk.Main.Init;

      Gtk.Window.Gtk_New (Main_Window, Gtk.Enums.Window_Toplevel);
      Gtk.Window.Set_Title (Main_Window, "Glowne okienko");
      Main_Window.On_Destroy (Exit_Main.DestoryAndQuit'Access);
      Gtk.Window.Show_All (Main_Window);

      Gtk.Main.Main;
   end Main;
end WindowDemo;
