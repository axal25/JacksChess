with Ada.Numerics;
with Ada.Numerics.Elementary_Functions;
with Ada.Text_IO;                                            use ADA.Text_IO;
with GtkAdaTest_Animation_Cairo_Canvas;                      use GtkAdaTest_Animation_Cairo_Canvas;
with Cairo;                                                  use Cairo;
with GLib;                                                   use GLib;
with Gdk.Threads;                                            use Gdk.Threads;
with Gtk.Window;                                             use Gtk.Window;
with Gtk.Enums;                                              use Gtk.Enums;
with Gtk.Widget;                                             use Gtk.Widget;
with Gtk.Main;                                               use Gtk.Main;
with Gtk.Handlers;                                           use Gtk.Handlers;

package body GtkAdaTest_Animation is

   package Handler is new GTK.Handlers.Callback (GTK_Window_Record);
   
   -- type Color_Type is (Blue, Black);
   
   X_Center        : Constant := 200.0;
   Y_Center        : Constant := 200.0;
   Rotation_Radius : Constant := 125.0;

   Window   : GTK_Window;
   Canvas   : Canvas_Type;
   Die      : Boolean := False;    
   
   ----------------
   -- On_Destroy --
   ----------------

   procedure On_Destroy (Window : access GTK_Window_Record'class)
   is
      pragma Unreferenced (Window);
   begin
      Die := True;
      Put_Line ("[ON_DESTROY]");
      -- GTK.Main.GTK_Exit (0);
      Gtk.Main.Main_Quit;
   end On_Destroy;
   
   -- /*******************************************************************/
   -------------
   -- Animate --
   -------------

   procedure Animate
   is
      task Animation_Task;

      Frame_Number : Natural := 0;

      -----------------
      -- Draw_Circle --
      -----------------

      procedure Draw_Circle (Context : Cairo_Context;
                             Color   : Color_Type;
                             Offset  : Natural)
      is
         use Ada.Numerics.Elementary_Functions;
      begin
         case Color is
            when Black =>
               Set_Source_RGB(Context, 0.0, 0.0, 0.0);
            when Blue =>
               Set_Source_RGB(Context, 0.2, 0.2, 1.0);
         end case;
         Arc(Context,
             GDouble(X_Center + Rotation_Radius * Sin(Float(Frame_Number + Offset), 300.0)),
             GDouble(Y_Center + Rotation_Radius * Cos(Float(Frame_Number + Offset), 300.0)),
             12.0,
             0.0,
             2.0 * Ada.Numerics.Pi);
         Stroke (Context);
      end Draw_Circle;

      ----------------
      -- Draw_Frame --
      ----------------

      procedure Draw_Frame (Canvas : Canvas_Type)
      is
         Context  : Cairo_Context;
      begin

         Context := Create (Get_Surface (Canvas));

         Set_Source_RGB (Context, 1.0, 1.0, 1.0);
         Paint (Context);

         Draw_Circle (Context, Black,   0);
         Draw_Circle (Context, Black,  25);
         Draw_Circle (Context, Black,  50);
         Draw_Circle (Context, Black,  75);
         Draw_Circle (Context, Black, 100);
         Draw_Circle (Context, Black, 125);
         Draw_Circle (Context, Black, 150);
         Draw_Circle (Context, Black, 175);
         Draw_Circle (Context, Black, 200);
         Draw_Circle (Context, Blue,  225);

         Set_Source_RGB (Context, 0.0, 0.0, 0.0);
         Select_Font_Face (Context,
                           "Monospace",
                           Cairo_Font_Slant_Normal,
                           Cairo_Font_Weight_Normal);
         Set_Font_Size(Context, 20.0);
         Set_Line_Width(Context, 0.5);
         Move_To (Context, 10.0, 20.0);
         Show_Text (Context, "Frame Number: " &
                      Natural'Image (Frame_Number));

         Canvas.Queue_Draw;
         Destroy (Context);
      end Draw_Frame;

      task body Animation_Task is
      begin
         loop
            GDK.Threads.Enter;
            Draw_Frame (Canvas);
            GDK.Threads.Leave;
            delay 0.01666;
            Frame_Number := Frame_Number + 1;
            exit when Die = True;
         end loop;
         -- GTK.Main.GTK_Exit(0);
         Gtk.Main.Main_Quit;
      end Animation_Task;
   begin
      GDK.Threads.Enter;
      GTK.Main.Main;
      GDK.Threads.Leave;
   end Animate;
   -- /*******************************************************************/
   
   procedure Animation_Template is
   begin
      GDK.Threads.G_Init;
      GDK.Threads.Init;
      GTK.Main.Init;
      GTK_New (Window, Window_Toplevel);
      GTK_New (Canvas);
      Handler.Connect (Window, "destroy", Handler.To_Marshaller (On_Destroy'Access));
      Set_Title (Window, "Animation Demonstration");
      -- Set_USize (Canvas, 400, 400);
      Add (Window, Canvas);
      Show_All (Window);
      Animate;
   end Animation_Template;
   
end GtkAdaTest_Animation;
