package ModelLayer is

   type FigureType is ( Pawn, Knight, Bishop, Rook, Queen, King );
   type Color is (White, Black);
   type AxisY is new Integer range 1..8;
   type AxisX is ( A, B, C, D, E, F, G, H );
   type Position is record
      aYPosition : AxisY := 5;
      aXPosition : AxisX := D;
   end record;
   type Figure is record
      aType : FigureType := Pawn;
      aColor : Color := White;
      aPosition : Position;
      isAlive : Boolean := True;
   end record;
   
   type AccessFigure is access all Figure;
   type Square is record
      aColor : Color := White;
      isTaken : Boolean := False;
      isActivated : Boolean := False;
      isPossibleMove : Boolean := False;
      aAccessFigure : AccessFigure := null;
   end record;
   
   type TableOfFigures is array (natural range<>, natural range<>) of Figure;
   type DynamicTableOfFigures is access all TableOfFigures;
   type IntegerArrayOf2 is array ( 1..2 ) of Integer;
   type AliveFigures is record
      aDynamicTable : DynamicTableOfFigures := null;
      First : IntegerArrayOf2 := (0,0);
      Last : IntegerArrayOf2 := (0,0);
   end record;
   type Grid is array (AxisY range 1..8, AxisX range A..H) of Square;
   
   type ChessBoard is record 
      aGrid : Grid;
      aAliveFigures : AliveFigures;
   end record;
   
   function Main return ChessBoard;
   function Init_AliveFigures( aAliveFigures : in out AliveFigures ) return AliveFigures;
   function Init_Grid( aGrid : in out Grid; aAliveFigures : AliveFigures ) return Grid;
   function Init_Structure_AliveFigures( First1 : Integer; Last1 : Integer; 
                                         First2 : Integer; Last2 : Integer ) 
                                        return AliveFigures;
   function isAliveFiguresEmpty( aAliveFigures : in AliveFigures ) return Boolean;
   function AliveFigures_To_String( aAliveFigures : in AliveFigures ) return String;
   
   function Kill_Figure( aAliveFigures : in out AliveFigures; aPosition : in Position ) return AliveFigures;
   function Kill_Figure( aGrid : in out Grid; aPosition : in Position ) return Grid;
   
   function AxisX_to_Integer( aX : AxisX ) return Integer;
   function Integer_to_AxisX( aRowNo : Integer ) return AxisX;
   
   function isWhite( aColor : Color ) return Boolean;
   function isBlack( aColor : Color ) return Boolean;
   
--     function Set_Position( aAccessFigure : in out AccessFigure; aPosition : Position ) return AccessFigure;
--     function Set_isAlive( aAccessFigure : in out AccessFigure; aIsAlive : Boolean ) return AccessFigure;
--     function Set_isAlive( aFigure : in out Figure; aIsAlive : Boolean ) return Figure;

end ModelLayer;
