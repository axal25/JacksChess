-- przycisk.adb
--
-- Przemyslaw Kobylanski <przemko@mac.com>
--
-- 1. utworzenie okienka
-- 2. zwiazanie ze zdarzeniem Destroy okienka zakonczenia programu
-- 3. stworzenie przycisku
-- 4. zwiazanie z kliknieciem przycisku drukowanie komunikatu
-- 5. umieszczenie przycisku w okienku
-- 6. wyswietlenie okienka
-- 7. oczekiwanie na zdarzenia
--

with Gtk.Main;
with Gtk.Enums;
with Gtk.Window;
with Gtk.Widget;
with Gtk.Button;

with Exit_Main;
with Button_Clicked;

package body ButtonDemo is

   Main_Window : Gtk.Window.Gtk_Window;
   ButtonNo1 : Gtk.Button.Gtk_Button;
   
   procedure Main is
      temp : Gtk.Widget.Gtk_Widget_Record;
   begin
      Gtk.Main.Init;

      Gtk.Window.Gtk_New (Main_Window, Gtk.Enums.Window_Toplevel);
      Gtk.Window.Set_Title (Main_Window, "Okienko z przyciskiem");
      
      Main_Window.On_Destroy( Exit_Main.DestoryAndQuit'Access );
      
      Gtk.Button.Gtk_New (ButtonNo1, "Hello");
      ButtonNo1.On_Clicked( Button_Clicked.HiThere'Access );
      Main_Window.Add( ButtonNo1 );
      Gtk.Window.Show_All (Main_Window);
      Gtk.Main.Main;
   end Main;
   
end ButtonDemo;
