with Gtk.Window;
with Gtk.Button;
with Gtk.Box;
with Gtk.Handlers;
with Ada.Text_IO;
with Gtk.Main;
with Gtk.Enums;
with Gtk.Label;
with Gdk.Color;
with Gtk.Bin;
with Gtk.Container; 
with Gtk.Image;
with Gtk.Css_Provider;
with Glib.Error;
with Gtk.Style_Context;
with Gtk.Style_Provider;
with Gtk.Style;

use Gtk.Css_Provider;
use Glib.Error;
use Gtk.Style_Context;   
use Gtk.Style_Provider;

package body Callback_V2 is

   --     type My_Data3 is record
   --        Button : Gtk_Widget;
   --        Object : Gtk_Widget;
   --        Id     : Handler_Id;
   --     end record;
   --     type My_Data3_Access is access My_Data3;
   
   --     package User_Callback3 is new Gtk.Handlers.User_Callback
   --       (Gtk_Widget_Record, My_Data3_Access);
   
   procedure Main is
      Win              : Gtk.Window.Gtk_Window;
      Button1, Button2, Button3 : Gtk.Button.Gtk_Button;
      Vbox, Hbox       : Gtk.Box.Gtk_Box;
      Id               : Gtk.Handlers.Handler_Id;
      Data3            : My_Data3_Access;
      
      DataPojemnik     : MegaPojemnik_Access;
      IdPojemnik       : Gtk.Handlers.Handler_Id;
   begin
      Init_Elements( Win     => Win,
                     Vbox    => Vbox,
                     Hbox    => Hbox,
                     Button1 => Gtk.Widget.Gtk_Widget( Button1 ),
                     Button2 => Gtk.Widget.Gtk_Widget( Button2 ), 
                     Button3 => Gtk.Widget.Gtk_Widget( Button3 ) );
      
      ----------------------------------------------------------------
      Data3 := new My_Data3' ( Object => Gtk.Widget.Gtk_Widget (Button1),
                               Button => Gtk.Widget.Gtk_Widget (Button2),
                               Id     => ( Gtk.Handlers.Null_Handler_Id, null) );
      
      --        Id := User_Callback3.Connect
      --          (Button1, "clicked",
      --           User_Callback3.To_Marshaller (My_Destroy3'Access),
      --           Data3);
      --        Data3.Id := Id;
      ----------------------------------------------------------------
      Id := User_Callback.Connect
        (Button1, "clicked",
         User_Callback.To_Marshaller (My_Destroy2'Access),
         Gtk.Widget.Gtk_Widget (Button2));
      Gtk.Handlers.Add_Watch (Id, Button2);
      ----------------------------------------------------------------
      DataPojemnik := new MegaPojemnik;
      DataPojemnik.Button1 := Button1;
      DataPojemnik.Button2 := Button2;
      IdPojemnik := User_Callback_Pojemnik.Connect( Button3, "clicked", 
                                                    User_Callback_Pojemnik.To_Marshaller( DestroyRecord'Access ),
                                                    DataPojemnik );
      --        Gtk.Handlers.Add_Watch( IdPojemnik, DataPojemnik );
      ----------------------------------------------------------------
      
      Win.On_Destroy( DestroyObject_And_MainQuit'Access );      
      
      Gtk.Window.Show_All (Win);
      Gtk.Main.Main;
   end Main;
   
   procedure Init_Elements( Win : in out Gtk.Window.Gtk_Window;
                            Vbox : in out Gtk.Box.Gtk_Vbox; 
                            Hbox : in out Gtk.Box.Gtk_Hbox;
                            Button1 : in out Gtk.Widget.Gtk_Widget; 
                            Button2 : in out Gtk.Widget.Gtk_Widget;
                            Button3 : in out Gtk.Widget.Gtk_Widget) is
   begin
      Gtk.Main.Init;

      Gtk.Window.Gtk_New( Window   => Win,
                          The_Type => Gtk.Enums.Window_Toplevel );

      Gtk.Box.Gtk_New_Vbox( Vbox );
      Gtk.Window.Add (Win, Vbox);

      --  Using object_connect.
      --  The callback is automatically destroyed when button2 is destroyed, so
      --  you can press button1 as many times as you want, no problem
      Gtk.Box.Gtk_New_Hbox (Hbox);
      Gtk.Box.Pack_Start (Vbox, Hbox);
      Gtk.Button.Gtk_New ( Gtk.Button.Gtk_Button( Button1 ), "button1, object connect");
      Gtk.Box.Pack_Start (Hbox, Button1);
      Gtk.Button.Gtk_New (Gtk.Button.Gtk_Button( Button2 ), "button2");
      Gtk.Box.Pack_Start (Hbox, Button2);
      Gtk.Button.Gtk_New (Gtk.Button.Gtk_Button( Button3 ), "button#3");
      Gtk.Button.Gtk_New(Button => Gtk.Button.Gtk_Button( Button3 ),
                         Label  => "String");
      
      -- Button3 := ColorButton( Gtk.Button.Gtk_Button( Button3 ) );
      Button3 := ColorButton_v2( Gtk.Button.Gtk_Button( Button3 ) );
      
      declare
         aLabel : Gtk.Label.Gtk_Label;
         aString : String := Gtk.Button.Gtk_Button( Button3 ).Get_Label;
         aChild : Gtk.Widget.Gtk_Widget := Gtk.Bin.Gtk_Bin( Button3 ).Get_Child;
         aImage : Gtk.Image.Gtk_Image := Gtk.Image.Gtk_Image_New_From_File("led_strips_doge.bmp");
      begin
         Gtk.Bin.Gtk_Bin( Button3 ).Remove( aChild );
         aLabel := Gtk.Label.Gtk_Label_New(Str => "aNewLabel");
         -- Gtk.Container.Gtk_Container( Button3 ).Add( Widget => aLabel );
         --           Gtk.Container.Gtk_Container( Button3 ).Get_Children
         Gtk.Bin.Gtk_Bin( Button3 ).Add( Widget => aImage );
           
      end;      
      Button3.Set_Opacity( 0.5 );
      Gtk.Box.Pack_Start (Hbox, Button3);


   end Init_Elements;
   
   function ColorButton_v2( aButton : in out Gtk.Button.Gtk_Button ) return Gtk.Widget.Gtk_Widget is
      aCssData : String := "button { background-color: cyan; background-image: none; } " &
        "button:hover { background-color: green; background-image: none; } " & 
        "button:active { background-color: brown; background-image: none; } ";
      aError : Glib.Error.GError_Access := null;
      isCssProviderSetUp : Boolean := False;
      
      aCssProvider : Gtk.Css_Provider.Gtk_Css_Provider := Gtk.Css_Provider.Gtk_Css_Provider_New;
      aStyleContext : Gtk.Style_Context.Gtk_Style_Context := Gtk.Style_Context.Gtk_Style_Context_New;
--        aStyleProvider : Gtk.Style_Provider.Gtk_Style_Provider := Gtk.Style_Provider.Gtk_Style_Provider( aCssProvider );
   begin
      Ada.Text_IO.Put_Line( "aCssProvider.Is_Created =" & aCssProvider.Is_Created'Img );
      isCssProviderSetUp := Gtk.Css_Provider.Load_From_Data( Self  => aCssProvider,
                                                             Data  => aCssData,
                                                             Error => aError );
      
      Ada.Text_IO.Put_Line( "aStyleContext.Is_Created = " & aStyleContext.Is_Created'Img );
      aStyleContext := Gtk.Style_Context.Get_Style_Context( Widget => Gtk.Widget.Gtk_Widget( aButton ) );
      Ada.Text_IO.Put_Line( "aStyleContext.Is_Created = " & aStyleContext.Is_Created'Img );
      
--        Gtk.Style_Context.Add_Provider( Self     => aStyleContext,
--                                        Provider => aCssProvider,
--                                        Priority => Gtk.Style_Provider.Priority_User );
      
      return Gtk.Widget.Gtk_Widget( aButton );
   end;
   
   function ColorButton( Button3 : in out Gtk.Button.Gtk_Button ) return Gtk.Widget.Gtk_Widget is
      aLabel : Gtk.Label.Gtk_Label := Gtk.Label.Gtk_Label_New(Str => "");
      aColor : Gdk.Color.Gdk_Color;
      aCssProvider : Gtk.Css_Provider.Gtk_Css_Provider;
   begin
      --        Gtk.Label.Gtk_New( Label => aLabel,
      --                           Str   => "aLabel" );
      --        Gdk.Color.Set_Rgb(Color => aColor,
      --                          Red   => 250,
      --                          Green => 250,
      --                          Blue  => 250);
      --        Gtk.Widget.Modify_Base( Widget => Gtk.Widget.Gtk_Widget( Button3 ),
      --                                State  => Gtk.Enums.Gtk_State_Type( Gtk.Enums.State_Normal ),
      --                                Color  => aColor );

      --        Button3.Set_Opacity( 0.5 );
      --        Gtk.Label.Set_Markup( Label => Gtk.Label.Gtk_Label( 
      --                              Gtk.Bin.Get_Child( Gtk.Bin.Gtk_Bin( Button3 ) ) 
      --                             ),
      --                              Str => "<span weight=""bold"" color=""blue"" size=""xx-large"">It Works!!</span>" );

      aCssProvider := Gtk.Css_Provider.Gtk_Css_Provider_New;
      Ada.Text_IO.Put_Line( "aCssProvider.Is_Created =" & aCssProvider.Is_Created'Img );
      -- aCssProvider.Initialize;
      Ada.Text_IO.Put_Line( "aCssProvider.Is_Created =" & aCssProvider.Is_Created'Img );
      declare
         aCssData : String := "button { background-color: cyan; background-image: none; } " &
           "button:hover { background-color: green; background-image: none; } " & 
           "button:active { background-color: brown; background-image: none; } ";
         aError : Glib.Error.GError_Access := null;
         isItDone : Boolean := False;
      begin
         isItDone := Gtk.Css_Provider.Load_From_Data( Self  => aCssProvider,
                                                      Data  => aCssData,
                                                      Error => aError );
      end;
      
      declare 
         -- aCssProvider : Gtk.Css_Provider.Gtk_Css_Provider := Gtk.Css_Provider.Gtk_Css_Provider_New;
         aCssProvider2 : Gtk.Css_Provider.Gtk_Css_Provider := Gtk.Css_Provider.Gtk_Css_Provider_New;
         
         aCssProvider_Access : access Gtk.Css_Provider.Gtk_Css_Provider := new Gtk.Css_Provider.Gtk_Css_Provider;
         
         type CssProvider_AccessAll is access all Gtk.Css_Provider.Gtk_Css_Provider;
         aCssProvider_Access2 : CssProvider_AccessAll := new Gtk.Css_Provider.Gtk_Css_Provider; 
         
         type StyleProvider_AccessAll is access all Gtk.Style_Provider.Gtk_Style_Provider;
         aStyleProvider_Access2 : StyleProvider_AccessAll := new Gtk.Style_Provider.Gtk_Style_Provider; 
      begin
         aCssProvider_Access2.all := aCssProvider;
         aCssProvider_Access.all := aCssProvider;
         -- aStyleProvider_Access2.all := aCssProvider;         
      end;
      
      declare
         Button3_CssProvider : Gtk.Css_Provider.Gtk_Css_Provider := aCssProvider;
         Button3_StyleContext : Gtk.Style_Context.Gtk_Style_Context := Gtk.Style_Context.Get_Style_Context( Widget => Button3 );
         aGtk_Css_Provider_Record : Gtk_Css_Provider_Record;
--           StyleContext1 : Gtk_Style_Context := Gtk_Style_Context( Gtk_Css_Provider_New );
--           Button3_StyleProvider0 : Gtk.Style_Provider.Gtk_Style_Provider := 
--             Gtk.Style_Provider."+"(Button3_CssProvider);
--           Button3_StyleProvider00 : Gtk.Style_Provider.Gtk_Style_Provider := 
--             Button3_CssProvider;
         Button3_StyleProvider : Gtk.Style_Provider.Gtk_Style_Provider;
--           Button3_StyleProvider2 : Gtk.Style_Provider.Gtk_Style_Provider := 
--             Gtk.Style_Provider.Gtk_Style_Provider( Gtk.Css_Provider.Gtk_Css_Provider_New );
--           Button3_StyleProvider3 : Gtk.Style_Provider.Gtk_Style_Provider := 
--             Gtk.Style_Provider.Gtk_Style_Provider( new Gtk.Css_Provider.Gtk_Css_Provider_Record );

         
      begin
         null;
--           Get_Style_Context( Widget => Button3 ).Add_Provider( Provider => Button3_CssProvider,
--                                                                Priority => Priority_User );
--           Gtk.Css_Provider."+"(Button3, Button3_CssProvider);
--           Button3_StyleContext.Add_Provider( Provider => aCssProvider,
--                                              Priority => Gtk.Style_Provider.Priority_User );
--           
--           Button3_StyleContext.Add_Provider( Provider => aCssProvider,
--                                              Priority => Gtk.Style_Provider.Priority_User );
--           Button3_StyleProvider := Gtk.Style_Provider.Gtk_Style_Provider( aCssProvider );
--           Gtk.Style_Context.Add_Provider( Self     => Button3_StyleContext,
--                                           Provider => Button3_StyleProvider,
--                                           Priority => Gtk.Style_Provider.Priority_User );
--           
--           Gtk.Style_Context.Add_Provider( Self     => Button3_StyleContext,
--                                           Provider => aCssProvider,
--                                           Priority => Gtk.Style_Provider.Priority_User );
--           
--           Gtk.Style_Context.Add_Provider( Self     => Button3_StyleContext,
--                                          Provider => aCssProvider,
--                                          Priority => Gtk.Style_Provider.Priority_User );
--           
--           Gtk.Style_Context.Get_Style_Context( Widget => Button3 ).Add_Provider( Provider => Gtk.Style_Provider.Gtk_Style_Provider( aCssProvider ),
--                                                                                  Priority => Gtk.Style_Provider.Priority_User);
--           
--           Gtk.Style_Context.Get_Style_Context( Widget => Button3 ).Get_Font( State => Gtk.Enums.Gtk_State_Flags.Gtk_State_Flag_Normal );
      end;
      
      aColor := Gdk.Color.Parse(Spec => "red");
      
--        Gtk.Widget.Modify_Bg(Widget => Gtk.Widget.Gtk_Widget( Button3 ),
--                             State  => Gtk.Enums.State_Normal,
--                             Color  => aColor );
      
      Gtk.Widget.Modify_Fg(Widget => Gtk.Widget.Gtk_Widget( Button3 ),
                           State  => Gtk.Enums.State_Normal,
                           Color  => aColor);
--        Gtk.Widget.Modify_Base(Widget => Gtk.Widget.Gtk_Widget( Button3 ),
--                             State  => Gtk.Enums.State_Normal,
--                             Color  => aColor);
      Button3.Set_Opacity( 1.0 );
      
      return Gtk.Widget.Gtk_Widget( Button3 );
   end ColorButton;

   
   procedure My_Destroy3( Button : access Gtk.Widget.Gtk_Widget_Record'Class;
                          Data   : My_Data3_Access ) is
   begin
      Ada.Text_IO.Put_Line ("My_Destroy3");
      Gtk.Widget.Destroy( Data.Button );
      Gtk.Handlers.Disconnect (Data.Object, Data.Id);
   end My_Destroy3;
   
   procedure DestroyObject_And_MainQuit( Object: access Gtk.Widget.Gtk_Widget_Record'Class ) is --on event
      -- close main window if Delete_Event return False (it means it's allowed to close);
   begin
      Ada.Text_IO.Put_Line( "X clicked - Destroying object" );
      Gtk.Widget.Destroy( Object );
      Gtk.Main.Main_Quit;
   end DestroyObject_And_MainQuit;
   
   --     package User_Callback is new Gtk.Handlers.User_Callback
   --       (Gtk_Widget_Record, Gtk_Widget);
   procedure My_Destroy2( Button : access Gtk.Widget.Gtk_Widget_Record'Class;
                          Data : Gtk.Widget.Gtk_Widget ) is
   begin
      Gtk.Widget.Destroy (Data);
   end My_Destroy2;
   
   --     package User_Callback_Pojemnik is new Gtk.Handlers.User_Callback( Gtk.Widget.Gtk_Widget_Record, MegaPojemnik_Access );
   --     type MegaPojemnik is record
   --        Button1 : Gtk.Button.Gtk_Button;
   --        Button2 : Gtk.Button.Gtk_Button;
   --     end record;
   --     type MegaPojemnik_Access is access MegaPojemnik;
   procedure DestroyRecord( Button : access Gtk.Widget.Gtk_Widget_Record'Class;
                            Data : MegaPojemnik_Access ) is
   begin
      if( Data.Button1.Is_Created ) then
         Gtk.Widget.Destroy( Gtk.Widget.Gtk_Widget( Data.Button1 ) );
      end if;
      if( Data.Button2.Is_Created ) then
         Gtk.Widget.Destroy( Gtk.Widget.Gtk_Widget( Data.Button2 ) );
      end if;
   end DestroyRecord;
   
end Callback_V2;
