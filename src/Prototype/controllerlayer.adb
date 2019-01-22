with VisualLayer; use VisualLayer;
with ModelLayer; use ModelLayer;
with Gtk.Main;
with Gtk.Widget;
with Gtk.Window;
with Gtk.Button;
with Gtk.Bin;
with Ada.Text_IO; use Ada.Text_IO;

package body ControllerLayer is

   aAllData : VisualLayer.AllData;
   procedure Main is 
   begin
      aAllData := VisualLayer.Main;
      aAllData := SetPossibleToActivate( aAllData );
        
      aAllData.aMainWindow.aWindow.Show_All;
      Gtk.Main.Main;
   end Main;
   
   function SetPossibleToActivate( aAllData : in out VisualLayer.AllData ) return VisualLayer.AllData is
      aAliveFigures : ModelLayer.AliveFigures := aAllData.aChessBoard.aAliveFigures;      
      aTmpFigurePosition : ModelLayer.Position;
      aButton : Gtk.Button.Gtk_Button;
      IdPosition : Gtk.Handlers.Handler_Id;
   begin
      for row in aAliveFigures.First(1) .. aAliveFigures.Last(1) loop
         for col in aAliveFigures.First(2) .. aAliveFigures.Last(2) loop
            aTmpFigurePosition := aAllData.aChessBoard.aAliveFigures.aDynamicTable( row, col ).aPosition;
            aButton := aAllData.aMainWindow.aButtonGrid( VisualLayer.AxisY( aTmpFigurePosition.aYPosition), 
                                                         VisualLayer.AxisX( aTmpFigurePosition.aXPosition ) );
            
            IdPosition := UserCallback_Position.Connect( aButton, "clicked", 
                                                         UserCallback_Position.To_Marshaller( Activate_Button'Access ),
                                                         aTmpFigurePosition );
            
            Put_Line( "[" & aTmpFigurePosition.aYPosition'Img & ", " & aTmpFigurePosition.aXPosition'Img & " ] is to SetPossibleToActivate " );
         end loop;
      end loop;
      
      return aAllData;
   end SetPossibleToActivate;
   
   procedure Activate_Button( Object: access Gtk.Widget.Gtk_Widget_Record'Class; aPosition : ModelLayer.Position ) is
      aYPosition : ModelLayer.AxisY := aPosition.aYPosition;
      aXPosition : ModelLayer.AxisX := aPosition.aXPosition;
   begin
      aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isActivated := True;
      VisualLayer.Update_Button( aRowNo      => aYPosition,
                                 aColNo      => aXPosition,
                                 aMainWindow => aAllData.aMainWindow,
                                 aChessBoard => aAllData.aChessBoard );
      aAllData.aMainWindow.aWindow.Show_All;
   end Activate_Button;

end ControllerLayer;
