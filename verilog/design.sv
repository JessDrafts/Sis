module MorraCinese (
  input clk,
  input [1:0] PRIMO,
  input [1:0] SECONDO,
  input INIZIA,
  output reg [1:0] MANCHE,
  output reg [1:0] PARTITA
);
    
  // Dichiarazione dei segnali di stato e output, Altri registri e logica della FSM
  reg [2:0] stato = 3'b000;
  reg [2:0] stato_prossimo = 3'b000;
  reg pobbligatorio, fine, move1ok, move2ok;
  reg [4:0] total_games,manche_counter;
  reg [1:0] last_move1, last_move2, victory, move1, move2;
  
/*-------------------------------------DATAPATH-----------------------------------------*/  
   always @(INIZIA) begin//GESTIONE PARTITA
    if (INIZIA == 1'b1) begin
      total_games = {PRIMO,SECONDO} + 5'b00100;
    end 
  end
 
  always @(posedge clk, total_games, manche_counter) begin//GESTIONE SEGNALI pobbligatorio e fine
    if(total_games == manche_counter) begin
          fine = 1'b1;
       end else begin
          fine = 1'b0;
       end
    if((manche_counter > 5'b00100) || (manche_counter == 5'b00100)) begin
          pobbligatorio = 1'b1;
       end else begin
          pobbligatorio = 1'b0;
       end
  end
   
  always @(posedge clk) begin: DATAPATH
      if(((PRIMO == 2'b01 && SECONDO == 2'b11) || (PRIMO == 2'b10 && SECONDO == 2'b01) || (PRIMO == 2'b11 && SECONDO == 2'b10)) && INIZIA == 1'b0) begin
          victory = 2'b01;
      end else if(((PRIMO == 2'b11 && SECONDO == 2'b01) || (PRIMO == 2'b01 && SECONDO == 2'b10) || (PRIMO == 2'b10 && SECONDO == 2'b11)) && INIZIA == 1'b0) begin
          victory = 2'b10;
      end else if(PRIMO == SECONDO) begin
          victory = 2'b11;
      end else if(PRIMO == 2'b00 || SECONDO == 2'b00) begin
          victory = 'b00;
        end

        if(PRIMO == last_move1)begin
          move1ok = 1'b0;
        end else begin
          move1ok = 1'b1;
        end
        if(SECONDO == last_move2) begin	
          move2ok = 1'b0;
        end else begin
          move2ok = 1'b1;
        end
    end
    
  always @(clk, INIZIA, victory) begin
    if(victory == 2'b00 && INIZIA == 1'b0) begin
      last_move1 = PRIMO;
      last_move2 = SECONDO;
    end else if(victory == 2'b01 && INIZIA == 1'b0)begin
      last_move1 = PRIMO;
      last_move2 = 2'b00;
    end else if(victory == 2'b10 && INIZIA == 1'b0)begin
      last_move1 = 2'b00;
      last_move2 = SECONDO;
    end else if(victory == 2'b11 && INIZIA == 1'b0)begin
      last_move1 = 2'b00;
      last_move2 = 2'b00;
    end else if(INIZIA) begin
      last_move1 = 2'b00;
      last_move2 = 2'b00;
    end
  end

  always @(posedge clk, INIZIA, MANCHE) begin//GESTIONE CONTATORE
    if(MANCHE == 2'b01 && INIZIA == 1'b0) begin
          manche_counter <= manche_counter + 5'b00001;
       end else if (MANCHE == 2'b10 && INIZIA == 1'b0) begin
          manche_counter <= manche_counter + 5'b00001;
       end else if(MANCHE == 2'b11 && INIZIA == 1'b0) begin
         manche_counter <= manche_counter + 5'b00001;
       end else if(MANCHE == 2'b00 && INIZIA == 1'b0) begin
         manche_counter <= manche_counter;
       end else if(INIZIA) begin
         manche_counter <= 5'b00000;
       end
  end
  
  always @(clk, victory, move1ok, move2ok, INIZIA) begin//GESTIONE MANCHE
    if((move1ok == 1'b0 || move2ok == 1'b0) && INIZIA == 1'b0) begin
        MANCHE = 2'b00;
    end else if((victory == 2'b01 && INIZIA == 1'b0) && (move1ok && move2ok))begin
      MANCHE = 2'b01;
    end else if((victory == 2'b10 && INIZIA == 1'b0) && (move1ok && move2ok))begin
      MANCHE = 2'b10;
    end else if((victory == 2'b11 && INIZIA == 1'b0) && (move1ok && move2ok))begin
      MANCHE = 2'b11;
    end else if(INIZIA)begin
      MANCHE = 2'b00;
    end
  end
  
  
 /*----------------------------FSM-------------------------------------------------------------------*/ 

  always@(posedge clk) begin: UPDATE
      stato = stato_prossimo;  // Aggiornamento dello stato
end
  
  always @(stato, MANCHE, pobbligatorio, fine, INIZIA) begin: FSM // Logica della FSM
      case (stato)
        3'b000: //DRAW
          if (INIZIA) begin
            stato_prossimo = 3'b000; //DRAW
            PARTITA = 2'b00;//PARTITA NON TERMINATA
          end else begin//INIZIA VALE 0 ORA IN AVANTI
            if(MANCHE == 2'b00) begin
              stato_prossimo = 3'b000; //DRAW
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if((MANCHE == 2'b11) && (fine == 1'b0)) begin
              stato_prossimo = 3'b000; //DRAW
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if((MANCHE == 2'b01) &&(fine == 1'b0))begin
              stato_prossimo = 3'b001; //P1P1
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if((MANCHE == 2'b10) &&(fine == 1'b0))begin
              stato_prossimo = 3'b011; //P2P1
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if((MANCHE == 2'b01) && (pobbligatorio && fine))begin
              stato_prossimo = 3'b110; //END
              PARTITA = 2'b01;//PARTITA TERMINATA - VINCE 1°
            end else if((MANCHE == 2'b10) && (pobbligatorio && fine))begin
              stato_prossimo = 3'b110; //END
              PARTITA = 2'b10;//PARTITA TERMINATA - VINCE 2°
            end else if((MANCHE == 2'b11) && (pobbligatorio && fine))begin
              stato_prossimo = 3'b110; //END
              PARTITA = 2'b11;//PARTITA TERMINATA - PAREGGIO
            end
          end

        3'b001://P1P1
          if (INIZIA) begin
            stato_prossimo = 3'b000; //DRAW
            PARTITA = 2'b00;//PARTITA NON TERMINATA
          end else begin//INIZIA VALE 0 ORA IN AVANTI
            if(MANCHE == 2'b00) begin
              stato_prossimo = 3'b001; //P1P1
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if((MANCHE == 2'b11) && (fine == 1'b0)) begin
              stato_prossimo = 3'b001; //P1P1
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if((MANCHE == 2'b01) && (pobbligatorio == 1'b0 && fine == 1'b0))begin
              stato_prossimo = 3'b010; //P1P2
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if((MANCHE == 2'b01) && (pobbligatorio) && (fine == 1'b0))begin
              stato_prossimo = 3'b101; //GAME
              PARTITA = 2'b01;//PARTITA TERMINATA - VINCE 1°
            end else if((MANCHE == 2'b01) && (pobbligatorio) && (fine))begin
              stato_prossimo = 3'b110; //END
              PARTITA = 2'b01;//PARTITA TERMINATA - VINCE 1°
            end else if((MANCHE == 2'b11) && (pobbligatorio) && (fine))begin
              stato_prossimo = 3'b110; //END
              PARTITA = 2'b01;//PARTITA TERMINATA - VINCE 1°
            end else if((MANCHE == 2'b10) && (pobbligatorio) && (fine))begin
              stato_prossimo = 3'b110; //END
              PARTITA = 2'b11;//PARTITA TERMINATA - PAREGGIO
            end else if((MANCHE == 2'b10) && (fine == 1'b0))begin
              stato_prossimo = 3'b000; //DRAW
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end
          end

        3'b010://P1P2
          if (INIZIA) begin
            stato_prossimo = 3'b000; //DRAW
            PARTITA = 2'b00;//PARTITA NON TERMINATA
          end else begin//INIZIA VALE 0 ORA IN AVANTI
            if (MANCHE == 2'b00) begin
              stato_prossimo = 3'b010;//P1P2
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if (MANCHE == 2'b11 && (pobbligatorio == 1'b0 && fine == 1'b0)) begin
              stato_prossimo = 3'b010;//P1P2
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if (MANCHE == 2'b11 && (pobbligatorio) && (fine == 1'b0)) begin
              stato_prossimo = 3'b101;//GAME
              PARTITA = 2'b01;//PARTITA TERMINATA - VINCE 1°
            end else if (MANCHE == 2'b01 && (pobbligatorio) && (fine == 1'b0)) begin
              stato_prossimo = 3'b101;//GAME
              PARTITA = 2'b01;//PARTITA TERMINATA - VINCE 1°
            end else if (MANCHE == 2'b10 && (pobbligatorio == 1'b0 && fine == 1'b0)) begin
              stato_prossimo = 3'b001;//P1P1
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end 
          end

        3'b011://P2P1
          if (INIZIA) begin
            stato_prossimo = 3'b000; //DRAW
            PARTITA = 2'b00;//PARTITA NON TERMINATA
          end else begin//INIZIA VALE 0 ORA IN AVANTI
            if(MANCHE == 2'b00) begin
              stato_prossimo = 3'b011; //P2P1
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if((MANCHE == 2'b11) && (fine == 1'b0)) begin
              stato_prossimo = 3'b011; //P2P1
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if((MANCHE == 2'b10) && (pobbligatorio == 1'b0 && fine == 1'b0))begin
              stato_prossimo = 3'b100; //P2P2
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if((MANCHE == 2'b10) && (pobbligatorio) && (fine == 1'b0))begin
              stato_prossimo = 3'b101; //GAME
              PARTITA = 2'b10;//PARTITA TERMINATA - VINCE 2°
            end else if((MANCHE == 2'b01) && (pobbligatorio) && (fine))begin
              stato_prossimo = 3'b110; //END
              PARTITA = 2'b11;//PARTITA TERMINATA - PAREGGIO
            end else if((MANCHE == 2'b11) && (pobbligatorio) && (fine))begin
              stato_prossimo = 3'b110; //END
              PARTITA = 2'b10;//PARTITA TERMINATA - VINCE 2°
            end else if((MANCHE == 2'b10) && (pobbligatorio) && (fine))begin
              stato_prossimo = 3'b110; //END
              PARTITA = 2'b10;//PARTITA TERMINATA - VINCE 2°
            end else if((MANCHE == 2'b01) && (fine == 1'b0))begin
              stato_prossimo = 3'b000; //DRAW
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end
          end

        3'b100://P2P2
          if (INIZIA) begin
            stato_prossimo = 3'b000; //DRAW
            PARTITA = 2'b00;//PARTITA NON TERMINATA
          end else begin//INIZIA VALE 0 ORA IN AVANTI
            if (MANCHE == 2'b00) begin
              stato_prossimo = 3'b100;//P2P2
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if (MANCHE == 2'b11 && (pobbligatorio == 1'b0 && fine == 1'b0)) begin
              stato_prossimo = 3'b100;//P2P2
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end else if (MANCHE == 2'b11 && (pobbligatorio == 1'b1) && (fine == 1'b0)) begin
              stato_prossimo = 3'b101;//GAME
              PARTITA = 2'b10;//PARTITA TERMINATA - VINCE 2°
            end else if (MANCHE == 2'b10 && (pobbligatorio == 1'b1) && (fine == 1'b0)) begin
              stato_prossimo = 3'b101;//GAME
              PARTITA = 2'b10;//PARTITA TERMINATA - VINCE 2°
            end else if (MANCHE == 2'b01 && (pobbligatorio == 1'b0 && fine == 1'b0)) begin
              stato_prossimo = 3'b011;//P2P1
              PARTITA = 2'b00;//PARTITA NON TERMINATA
            end 
          end

        3'b101://GAME
          if (INIZIA) begin
            stato_prossimo = 3'b000; //DRAW
            PARTITA = 2'b00;//PARTITA NON TERMINATA
          end 

        3'b110://END
          if (INIZIA) begin
            stato_prossimo = 3'b000; //DRAW
            PARTITA = 2'b00;//PARTITA NON TERMINATA
          end
      endcase
  end

endmodule