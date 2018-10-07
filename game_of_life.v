module game_of_life;

  reg [14:0] state [14:0];         //next state
  reg [14:0] state_const [14:0];  //previous state

  task new_generation;
    integer i;
    integer j;
    integer neighbours_count;
    begin  
      for(i = 0;i <=14;i = i + 1)         //copying previous state
        for(j = 0;j <= 14;j = j + 1)
          begin
            state_const[i][j] = state[i][j];
          end
          
      for(i = 0;i <= 14;i = i + 1)   //applying the game rules for next generation
        for(j = 0;j <= 14;j = j + 1)
          begin
            neighbours_count = neighbours_count + is_alive(i + 1, j + 1);   //cheking number of alive neighbours
            neighbours_count = neighbours_count + is_alive(i + 1, j - 1);
            neighbours_count = neighbours_count + is_alive(i - 1, j + 1);
            neighbours_count = neighbours_count + is_alive(i - 1, j - 1);
            neighbours_count = neighbours_count + is_alive(i + 1, j);
            neighbours_count = neighbours_count + is_alive(i - 1, j);
            neighbours_count = neighbours_count + is_alive(i, j + 1);
            neighbours_count = neighbours_count + is_alive(i, j - 1);
          
            if ((state[i][j] == 1) && (neighbours_count<2 || neighbours_count > 3))  // 1st and 3rd rules
              state[i][j] = 0;
            else 
              if (neighbours_count == 3)     //4th rule
                state[i][j] = 1;
          end
    end
  endtask
  
  function is_alive;
    input i, j;
    begin
      if (i < 0 || i > 14 || j < 0 || j > 14)
        is_alive = 0;
      else
        is_alive = state_const[i][j];
    end
  endfunction


endmodule