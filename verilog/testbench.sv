
module MorraCinese_Testbench;

  reg clk;
  reg [1:0] PRIMO, SECONDO;
  reg INIZIA;
  reg [1:0] MANCHE, PARTITA;

  MorraCinese uut (clk, PRIMO, SECONDO, INIZIA, MANCHE, PARTITA);

  integer tbf, outf;
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
    tbf = $fopen("testbench.script", "w");
    outf = $fopen("output_verilog.txt", "w");
    $fdisplay(tbf, "read_blif FSMD.blif");
    
    clk = 1'b1;
/////*INIZIALIZZO PARTITA - MAX MANCHE:17*/
	PRIMO = 2'b11; SECONDO = 2'b01; INIZIA = 1'b1;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*MANCHE PAREGGIATA, PARTITA NON TERMINATA*/
	PRIMO = 2'b01; SECONDO = 2'b01; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*MANCHE PAREGGIATA, PARTITA NON TERMINATA*/
	PRIMO = 2'b11; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
/////*LA PARTITA VIENE INTERROTTA. INIZIALIZZO NUOVA PARTITA - MAX MANCHE:4*/
	PRIMO = 2'b00; SECONDO = 2'b00; INIZIA = 1'b1;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    $display(" stato: %d, statoprox: %d -- pobb:%d, fine:%d", uut.stato, uut.stato_prossimo, uut.pobbligatorio, uut.fine);
    
    /*VINCE 2° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b11; SECONDO = 2'b01; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    $display(" stato: %d, statoprox: %d -- pobb:%d, fine:%d", uut.stato, uut.stato_prossimo, uut.pobbligatorio, uut.fine);
    
    /*VINCE 1° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b11; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    $display(" stato: %d, statoprox: %d -- pobb:%d, fine:%d", uut.stato, uut.stato_prossimo, uut.pobbligatorio, uut.fine);
    
    /*VINCE 2° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b01; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    $display(" stato: %d, statoprox: %d -- pobb:%d, fine:%d", uut.stato, uut.stato_prossimo, uut.pobbligatorio, uut.fine);
    
    /*VINCE 2° GIOCATORE, PARTITA TERMINATA CON DIFFERENZA DI 2 PUNTI PER IL 2°*/
	PRIMO = 2'b10; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    $display(" stato: %d, statoprox: %d -- pobb:%d, fine:%d", uut.stato, uut.stato_prossimo, uut.pobbligatorio, uut.fine);
    
/////*INIZIALIZZO NUOVA PARTITA - MAX MANCHE:6*/
	PRIMO = 2'b00; SECONDO = 2'b10; INIZIA = 1'b1;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b10; SECONDO = 2'b01; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 2° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b11; SECONDO = 2'b01; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b11; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*MANCHE PAREGGIATA, PARTITA NON TERMINATA*/
	PRIMO = 2'b01; SECONDO = 2'b01; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 2° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b11; SECONDO = 2'b01; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1° GIOCATORE, PARTITA TERMINATA. VINCE IL PRIMO SENZA DIFFERENZA DI 2 PUNTI*/
	PRIMO = 2'b11; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
/////*INIZIALIZZO NUOVA PARTITA - MAX MANCHE:4*/
	PRIMO = 2'b00; SECONDO = 2'b00; INIZIA = 1'b1;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b01; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*MANCHE NON VALIDA, PARTITA NON TERMINATA*/
	PRIMO = 2'b01; SECONDO = 2'b01; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*MANCHE RIPETUTA - VINCE 2°, PARTITA NON TERMINATA*/
	PRIMO = 2'b10; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b10; SECONDO = 2'b01; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1° GIOCATORE, PARTITA TERMINATA CON DIFFERENZA DI 2 PUNTI PER IL 1°*/
	PRIMO = 2'b11; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
/////*INIZIALIZZO NUOVA PARTITA - MAX MANCHE:4*/
	PRIMO = 2'b00; SECONDO = 2'b00; INIZIA = 1'b1;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b11; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 2° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b01; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b01; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 2° GIOCATORE, PARTITA TERMINATA IN PAREGGIO*/
	PRIMO = 2'b10; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
/////*INIZIALIZZO NUOVA PARTITA - MAX MANCHE:8*/
	PRIMO = 2'b01; SECONDO = 2'b00; INIZIA = 1'b1;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 2°GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b01; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 2°GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b10; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1°GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b11; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1°GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b01; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 2°GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b10; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 2°GIOCATORE, PARTITA TERMINATA PER 2 PUNTI DI DIFFERENZA PER IL 2°*/
	PRIMO = 2'b01; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*LE ULTIME DUE MANCHE NON VENGONO GIOCATE IN QUANTO LA PARTITA É GIÀ TERMINATA*/
    
/////*INIZIALIZZO NUOVA PARTITA - MAX MANCHE:6*/
	PRIMO = 2'b00; SECONDO = 2'b10; INIZIA = 1'b1;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*MANCHE PAREGGIATA, PARTITA NON TERMINATA*/
	PRIMO = 2'b11; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b01; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 2° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b11; SECONDO = 2'b01; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 1° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b11; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*VINCE 2° GIOCATORE, PARTITA NON TERMINATA*/
	PRIMO = 2'b01; SECONDO = 2'b10; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
    
    /*MANCHE PAREGGIATA, PARTITA TERMINATA IN PAREGGIO*/
	PRIMO = 2'b11; SECONDO = 2'b11; INIZIA = 1'b0;
    $fdisplay(tbf, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    #10
    $fdisplay(outf, "Outputs: %b %b %b %b", MANCHE[1], MANCHE[0], PARTITA[1], PARTITA[0]);
        
    $fclose(tbf);
    $fclose(outf);
    $finish;
  end
endmodule