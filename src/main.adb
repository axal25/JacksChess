with GtkAda, Ada.Text_IO, GtkAdaTest1, GtkAdaTest2, GtkAdaTest_Animation, GtkAdaTest_Clock, GtkAdaTest_AdaCore, AnotherTutorial, Minesweeper, FirstApplication, CallBack_V1, CallBack_V2, MyCallback, VisualLayer, ModelLayer, ControllerLayer;
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
   --     GtkAdaTest1.Test1;
   --     GtkAdaTest1.Test2;
   --     GtkAdaTest1.Test3;
   --     GtkAdaTest1.Test4_Window;
   --     GtkAdaTest1.Test4;

   --     GtkAdaTest2.Button;
   --     GtkAdaTest2.Test1;

   --     GtkAdaTest_Animation.Animation_Template; --NOT_WORKING
   --     GtkAdaTest_Clock.ClockMain; --NOT_WORKING

   --     GtkAdaTest_AdaCore.Main;
   --     FirstApplication.Application;

   --     AnotherTutorial.Main;
   --     Minesweeper.Main;

   --     CallBack_V1.Main;
   CallBack_V2.Main;
   --     MyCallback.Main;
   ControllerLayer.Main;


   Put_Line("Da BIG Main - Finish");
   Spam;
--  exception
--     when GtkAdaTest1.GtkMainInitError => Put_Line("Couldn't Innitiate Gtk.Main.Init");
--     when others => raise Unhandled_Exception;
end Main;
