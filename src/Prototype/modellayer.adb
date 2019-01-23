with Ada.Text_IO;

package body ModelLayer is

   function Main return ChessBoard is 
      aChessBoard : ChessBoard;
   begin
      aChessBoard.aAliveFigures := Init_aliveFigures( aChessBoard.aAliveFigures );
      aChessBoard.aGrid := Init_Grid( aChessBoard.aGrid, aChessBoard.aAliveFigures );
      
      --        Ada.Text_IO.Put_Line(" aChessBoard.aAliveFigures /= null "); 
      --        if( aChessBoard.aAliveFigures.aDynamicTable /= null ) then
      --           Ada.Text_IO.Put_Line(" aChessBoard.aAliveFigures.aDynamicTable /= null ");
      --           if( aChessBoard.aAliveFigures.aDynamicTable( 1, 1).aColor = White  ) then
      --              Ada.Text_IO.Put_Line(" aChessBoard.aAliveFigures.aDynamicTable(1,1).aColor = White ");
      --           else
      --              Ada.Text_IO.Put_Line(" aChessBoard.aAliveFigures.aDynamicTable(1,1).aColor = Black ");
      --           end if;
      --        end if;
      return aChessBoard;
   end Main;
   
   function Init_aliveFigures( aAliveFigures : in out AliveFigures ) return AliveFigures is
   begin
      aAliveFigures := Init_Structure_AliveFigures( First1 => 1,
                                                    Last1  => 2,
                                                    First2 => 1,
                                                    Last2  => 16 );
      for figureIndex2 in aAliveFigures.First(2) .. aAliveFigures.Last(2) loop
         aAliveFigures.aDynamicTable( 1, figureIndex2 ).aColor := White;
         aAliveFigures.aDynamicTable( 2, figureIndex2 ).aColor := Black;
      end loop;
      
      aAliveFigures.aDynamicTable( 1, 1 ).aType := King;   aAliveFigures.aDynamicTable( 1, 1 ).aPosition := ( 8, D );
      aAliveFigures.aDynamicTable( 2, 1 ).aType := King;   aAliveFigures.aDynamicTable( 2, 1 ).aPosition := ( 1, D );
      
      aAliveFigures.aDynamicTable( 1, 2 ).aType := Queen;   aAliveFigures.aDynamicTable( 1, 2 ).aPosition := ( 8, E );
      aAliveFigures.aDynamicTable( 2, 2 ).aType := Queen;   aAliveFigures.aDynamicTable( 2, 2 ).aPosition := ( 1, E );
      
      aAliveFigures.aDynamicTable( 1, 3 ).aType := Rook;   aAliveFigures.aDynamicTable( 1, 3 ).aPosition := ( 8, A );
      aAliveFigures.aDynamicTable( 1, 4 ).aType := Rook;   aAliveFigures.aDynamicTable( 1, 4 ).aPosition := ( 8, H );
      aAliveFigures.aDynamicTable( 2, 3 ).aType := Rook;   aAliveFigures.aDynamicTable( 2, 3 ).aPosition := ( 1, A );
      aAliveFigures.aDynamicTable( 2, 4 ).aType := Rook;   aAliveFigures.aDynamicTable( 2, 4 ).aPosition := ( 1, H );
      
      aAliveFigures.aDynamicTable( 1, 5 ).aType := Bishop;   aAliveFigures.aDynamicTable( 1, 5 ).aPosition := ( 8, C );
      aAliveFigures.aDynamicTable( 1, 6 ).aType := Bishop;   aAliveFigures.aDynamicTable( 1, 6 ).aPosition := ( 8, F );
      aAliveFigures.aDynamicTable( 2, 5 ).aType := Bishop;   aAliveFigures.aDynamicTable( 2, 5 ).aPosition := ( 1, C );
      aAliveFigures.aDynamicTable( 2, 6 ).aType := Bishop;   aAliveFigures.aDynamicTable( 2, 6 ).aPosition := ( 1, F );
      
      aAliveFigures.aDynamicTable( 1, 7 ).aType := Knight;   aAliveFigures.aDynamicTable( 1, 7 ).aPosition := ( 8, B );
      aAliveFigures.aDynamicTable( 1, 8 ).aType := Knight;   aAliveFigures.aDynamicTable( 1, 8 ).aPosition := ( 8, G );
      aAliveFigures.aDynamicTable( 2, 7 ).aType := Knight;   aAliveFigures.aDynamicTable( 2, 7 ).aPosition := ( 1, B );
      aAliveFigures.aDynamicTable( 2, 8 ).aType := Knight;   aAliveFigures.aDynamicTable( 2, 8 ).aPosition := ( 1, G );
      
      aAliveFigures.aDynamicTable( 1, 9 ).aType := Pawn;   aAliveFigures.aDynamicTable( 1, 9 ).aPosition := ( 7, A );
      aAliveFigures.aDynamicTable( 1, 10 ).aType := Pawn;   aAliveFigures.aDynamicTable( 1, 10 ).aPosition := ( 7, B );
      aAliveFigures.aDynamicTable( 1, 11 ).aType := Pawn;   aAliveFigures.aDynamicTable( 1, 11 ).aPosition := ( 7, C );
      aAliveFigures.aDynamicTable( 1, 12 ).aType := Pawn;   aAliveFigures.aDynamicTable( 1, 12 ).aPosition := ( 7, D );
      aAliveFigures.aDynamicTable( 1, 13 ).aType := Pawn;   aAliveFigures.aDynamicTable( 1, 13 ).aPosition := ( 7, E );
      aAliveFigures.aDynamicTable( 1, 14 ).aType := Pawn;   aAliveFigures.aDynamicTable( 1, 14 ).aPosition := ( 7, F );
      aAliveFigures.aDynamicTable( 1, 15 ).aType := Pawn;   aAliveFigures.aDynamicTable( 1, 15 ).aPosition := ( 7, G );
      aAliveFigures.aDynamicTable( 1, 16 ).aType := Pawn;   aAliveFigures.aDynamicTable( 1, 16 ).aPosition := ( 7, H );
      
      aAliveFigures.aDynamicTable( 2, 9 ).aType := Pawn;   aAliveFigures.aDynamicTable( 2, 9 ).aPosition := ( 2, A );
      aAliveFigures.aDynamicTable( 2, 10 ).aType := Pawn;   aAliveFigures.aDynamicTable( 2, 10 ).aPosition := ( 2, B );
      aAliveFigures.aDynamicTable( 2, 11 ).aType := Pawn;   aAliveFigures.aDynamicTable( 2, 11 ).aPosition := ( 2, C );
      aAliveFigures.aDynamicTable( 2, 12 ).aType := Pawn;   aAliveFigures.aDynamicTable( 2, 12 ).aPosition := ( 2, D );
      aAliveFigures.aDynamicTable( 2, 13 ).aType := Pawn;   aAliveFigures.aDynamicTable( 2, 13 ).aPosition := ( 2, E );
      aAliveFigures.aDynamicTable( 2, 14 ).aType := Pawn;   aAliveFigures.aDynamicTable( 2, 14 ).aPosition := ( 2, F );
      aAliveFigures.aDynamicTable( 2, 15 ).aType := Pawn;   aAliveFigures.aDynamicTable( 2, 15 ).aPosition := ( 2, G );
      aAliveFigures.aDynamicTable( 2, 16 ).aType := Pawn;   aAliveFigures.aDynamicTable( 2, 16 ).aPosition := ( 2, H );
      
      return aAliveFigures;
   end Init_aliveFigures;
   
   function Init_Grid( aGrid : in out Grid; aAliveFigures : AliveFigures ) return Grid is
      tmpPosition : Position;
   begin
      for row in aGrid'Range(1) loop
         for col in aGrid'Range(2) loop
            
            aGrid( row, col ).isTaken := false;
            aGrid( row, col ).isActivated := false;
            aGrid( row, col ).isPossibleMove := false;
            if( row mod 2 = 0 ) then
               if( AxisX_to_Integer( col ) mod 2 = 0 ) then
                  aGrid( row, col ).aColor := White;
               else
                  aGrid( row, col ).aColor := Black;
               end if;
            else
               if( AxisX_to_Integer( col ) mod 2 = 1 ) then
                  aGrid( row, col ).aColor := White;
               else
                  aGrid( row, col ).aColor := Black;
               end if;
            end if;
            
         end loop;
      end loop;
      
      for whiteOrBlack in aAliveFigures.First(1) .. aAliveFigures.Last(1) loop
         for difFigures in aAliveFigures.First(2) .. aAliveFigures.Last(2) loop
            tmpPosition := aAliveFigures.aDynamicTable( whiteOrBlack, difFigures ).aPosition;
            aGrid( tmpPosition.aYPosition, tmpPosition.aXPosition ).isTaken := True;
            aGrid( tmpPosition.aYPosition, tmpPosition.aXPosition ).aAccessFigure := new Figure;
            aGrid( tmpPosition.aYPosition, tmpPosition.aXPosition ).aAccessFigure.all := aAliveFigures.aDynamicTable( whiteOrBlack, difFigures );
            --              Ada.Text_IO.Put_Line( "{ {" & aAliveFigures.aDynamicTable( whiteOrBlack, difFigures ).aPosition.aYPosition'Img & ", " & 
            --                                      aAliveFigures.aDynamicTable( whiteOrBlack, difFigures ).aPosition.aXPosition'Img & " } } =?= { {" &
            --                                      aGrid( tmpPosition.aYPosition, tmpPosition.aXPosition ).aAccessFigure.all.aPosition.aYPosition'Img & ", " &
            --                                      aGrid( tmpPosition.aYPosition, tmpPosition.aXPosition ).aAccessFigure.all.aPosition.aXPosition'Img & " } }"
            --                                   );
         end loop;
      end loop;
      
      return aGrid;
   end Init_Grid;
   
   --     function FindFigure( aPosition : Position ) is
   --     begin
   --     end FindFigure;
   
   function Init_Structure_AliveFigures( First1 : Integer; Last1 : Integer; 
                                         First2 : Integer; Last2 : Integer ) 
                                        return AliveFigures is
      aAliveFigures : AliveFigures;
   begin
      aAliveFigures.First(1) := First1;
      aAliveFigures.Last(1) := Last1;
      aAliveFigures.First(2) := First2;
      aAliveFigures.Last(2) := Last2;
      aAliveFigures.aDynamicTable := new TableOfFigures( aAliveFigures.First(1) .. aAliveFigures.Last(1),
                                                         aAliveFigures.First(2) .. aAliveFigures.Last(2) );
      return aAliveFigures;
   end Init_Structure_AliveFigures;
      
   -- type AxisX is ( A, B, C, D, E, F, G, H );
   function AxisX_to_Integer( aX : AxisX ) return Integer is
   begin
      case aX is
         when A => return 1;
         when B  => return 2;
         when C => return 3;
         when D => return 4;
         when E => return 5;
         when F => return 6;
         when G => return 7;
         when others => return 8;
      end case;
   end AxisX_to_Integer;
   
   function Integer_to_AxisX( aRowNo : Integer ) return AxisX is
   begin
      case aRowNo is
         when 1 => return A;
         when 2 => return B;
         when 3 => return C;
         when 4 => return D;
         when 5 => return E;
         when 6 => return F;
         when 7 => return G;
         when others => return H;
      end case;
   end Integer_to_AxisX;
   
   function isWhite( aColor : Color ) return Boolean is
   begin
      if( aColor = White ) then
         return True;
      else
         return False;
      end if;
   end isWhite;
   
   function isBlack( aColor : Color ) return Boolean is
   begin
      if( aColor = Black ) then
         return True;
      else
         return False;
      end if;
   end isBlack;
   
   function MoveFigure( aFromPosition : in Position; aToPosition : in Position; aChessBoard : in out ChessBoard ) return ChessBoard is
   begin
      aChessBoard.aGrid( aToPosition.aYPosition, aToPosition.aXPosition ).aAccessFigure := new ModelLayer.Figure;
      aChessBoard.aGrid( aToPosition.aYPosition, aToPosition.aXPosition ).aAccessFigure.all :=
        aChessBoard.aGrid( aFromPosition.aYPosition, aFromPosition.aXPosition ).aAccessFigure.all;
      aChessBoard.aGrid( aToPosition.aYPosition, aToPosition.aXPosition ).aAccessFigure.all.aPosition.aYPosition :=  aToPosition.aYPosition;
      aChessBoard.aGrid( aToPosition.aYPosition, aToPosition.aXPosition ).aAccessFigure.all.aPosition.aXPosition :=  aToPosition.aXPosition;
      aChessBoard.aGrid( aFromPosition.aYPosition, aFromPosition.aXPosition ).aAccessFigure := null;
      aChessBoard.aGrid( aFromPosition.aYPosition, aFromPosition.aXPosition ).isTaken := False;
      
      return aChessBoard;
   end MoveFigure;

end ModelLayer;
