with GtkAda, Ada.Text_IO, VisualLayer, ModelLayer, ControllerLayer;
use Ada.Text_IO;

procedure Main is
   Unhandled_Exception : exception;

   procedure Spam is
   begin
      Put_Line("▒▒▒▒▒▒▒▒▄▄▄▄▄▄▄▄▒▒▒▒▒▒▒▒");
      Put_Line("▒▒▒▒▒▄█▀▀░░░░░░▀▀█▄▒▒▒▒▒");
      Put_Line("▒▒▒▄█▀▄██▄░░░░░░░░▀█▄▒▒▒");
      Put_Line("▒▒█▀░▀░░▄▀░░░░▄▀▀▀▀░▀█▒▒");
      Put_Line("▒█▀░░░░███░░░░▄█▄░░░░▀█▒");
      Put_Line("▒█░░░░░░▀░░░░░▀█▀░░░░░█▒");
      Put_Line("▒█░░░░░░░░░░░░░░░░░░░░█▒");
      Put_Line("▒█░░██▄░░▀▀▀▀▄▄░░░░░░░█▒");
      Put_Line("▒▀█░█░█░░░▄▄▄▄▄░░░░░░█▀▒");
      Put_Line("▒▒▀█▀░▀▀▀▀░▄▄▄▀░░░░▄█▀▒▒");
      Put_Line("▒▒▒█░░░░░░▀█░░░░░▄█▀▒▒▒▒");
      Put_Line("▒▒▒█▄░░░░░▀█▄▄▄█▀▀▒▒▒▒▒▒");
      Put_Line("▒▒▒▒▀▀▀▀▀▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒");
   end Spam;

begin
   Spam;
   Put_Line("Da BIG Main - Start");
   ControllerLayer.Main;


   Put_Line("Da BIG Main - Finish");
   Spam;
exception
   when others => raise Unhandled_Exception;
end Main;
