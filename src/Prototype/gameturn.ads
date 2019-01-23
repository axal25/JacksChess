package GameTurn is

   type Turn is (Player, Computer);
   function Init_Turn( aTurn : in out Turn ) return Turn;
   function Change_Turn( aTurn : in out Turn ) return Turn;
   task type GameTurnMain is
      entry Start_the_Game;
      entry End_Turn( outTurn : in out Turn );
      entry Get_Turn( outTurn : in out Turn );
      entry End_of_the_Game;
   end GameTurnMain;

end GameTurn;
