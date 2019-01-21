package body ModelLayer is

   function Main return ChessBoard is 
      aChessBoard : ChessBoard;
   begin
      aChessBoard.aGrid := Init_Grid( aChessBoard.aGrid );
      return aChessBoard;
   end Main;
   
   function Init_Grid( aGrid : in out Grid ) return Grid is
   begin
      for row in aGrid'Range(1) loop
         for col in aGrid'Range(2) loop
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
      
      return aGrid;
   end Init_Grid;
   
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

end ModelLayer;
