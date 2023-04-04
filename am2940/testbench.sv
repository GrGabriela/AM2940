// Code your testbench here
// or browse Examples

module test_am2940;
  
  reg clkt;
  reg [2:0] instrt;
  reg [7:0] dataint;
  reg cinat,cinwt;
  wire [7:0] addresst;
  wire [7:0] dataoutt;
  wire oedatat;
  wire donet;
  wire conat,conwt;
  
  
  am2940 am2940_inst(.clk(clkt),.instr(instrt),.address(addresst),.datain(dataint),.dataout(dataoutt),.oedata(oedatat),.cina(cinat),.cona(conat),.cinw(cinwt),.conw(conwt),.done(donet));
  
  initial
    begin
      #0 clkt=1'b0;
      forever #5 clkt=~clkt;
    end
  
  //facem un task pentru a da mai usor valori
  
  task stimuli_am2940;
    input [2:0] instr;
    input cina,cinw;
    begin
      instrt=instr;
      cinat=cina;
      cinwt=cinw;
    end
  endtask
  
  //ordinea din task 
  //1-instr,2-cina,3-cinw
  
  initial 
    begin
      
      //luam fiecare valoare din cr si trecem prin fiecare instructiune
      
      //-------------------------------------------
      //1. cr=000 ==> AC INCREMENTEAZA, WC DECREMENTEAZA
      
      
      //se scrie in registrul de control
      #0 stimuli_am2940(3'b000,1'b1,1'b1);dataint=8'h0;
      
      //se citeste din registrul de control
      #20 stimuli_am2940(3'b001,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de adresa 
      #20 dataint=8'b1111_1101; stimuli_am2940(3'b101,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de cuvinte
      #20 dataint=8'b0000_0011; stimuli_am2940(3'b110,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      //se incepe numaratoarea in ambele numaratoare si se poate observa ca la AC o sa se activeze CONA
      #20 stimuli_am2940(3'b111,1'b0,1'b0);
      
      //se stopeaza numaratoarea si se reseteaza valoarea cu cea din registre
      #60 stimuli_am2940(3'b100,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      
      
      //--------------------------------------------
      //2. cr=001 ==> AC INCREMENTEAZA, WC INCREMENTEAZA
      
      
      //se scrie in registrul de control
      #20 stimuli_am2940(3'b000,1'b1,1'b1);dataint=8'h1;
      
      //se citeste din registrul de control
      #20 stimuli_am2940(3'b001,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de adresa 
      #20 dataint=8'b1000_1010; stimuli_am2940(3'b101,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de cuvinte ==>se reseteaza la 0 valoarea de intrare
      #20 dataint=8'b0110_0001; stimuli_am2940(3'b110,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      //se incepe numaratoarea in ambele numaratoare
      #20 stimuli_am2940(3'b111,1'b0,1'b0);
      
      //se stopeaza numaratoarea si se reseteaza valoarea cu cea din registre si la WC o sa se reseteze valoarea la 0
      #60 stimuli_am2940(3'b100,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      
      //---------------------------------------------
      //3. cr=010 ==> AC INCREMENTEAZA, WC HOLD
      
      //se scrie in registrul de control
      #20 stimuli_am2940(3'b000,1'b1,1'b1);dataint=8'h2;
      
      //se citeste din registrul de control
      #20 stimuli_am2940(3'b001,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de adresa 
      #20 dataint=8'b1000_1010; stimuli_am2940(3'b101,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de cuvinte
      #20 dataint=8'b0110_0001; stimuli_am2940(3'b110,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      //se incepe numaratoarea in ambele numaratoare
      #20 stimuli_am2940(3'b111,1'b0,1'b0);
      
      //se stopeaza numaratoarea si se reseteaza valoarea cu cea din registre
      #60 stimuli_am2940(3'b100,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      
      //---------------------------------------------
      //4. cr=011 ==> AC INCREMENTEAZA, WC INCREMENTEAZA
      
      //se scrie in registrul de control
      #20 stimuli_am2940(3'b000,1'b1,1'b1);dataint=8'h3;
      
      //se citeste din registrul de control
      #20 stimuli_am2940(3'b001,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de adresa 
      #20 dataint=8'b1000_1010; stimuli_am2940(3'b101,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de cuvinte
      #20 dataint=8'b1111_1101; stimuli_am2940(3'b110,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      //se incepe numaratoarea in ambele numaratoare si la 	WC se va activa CONW
      #20 stimuli_am2940(3'b111,1'b0,1'b0);
      
      //se stopeaza numaratoarea si se reseteaza valoarea cu cea din registre
      #60 stimuli_am2940(3'b100,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      
      //---------------------------------------------
      //5. cr=100 ==> AC DECREMENTEAZA, WC DECREMENTEAZA
      
      //se scrie in registrul de control
      #20 stimuli_am2940(3'b000,1'b1,1'b1);dataint=8'h4;
      
      //se citeste din registrul de control
      #20 stimuli_am2940(3'b001,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de adresa 
      #20 dataint=8'b1000_1010; stimuli_am2940(3'b101,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de cuvinte
      #20 dataint=8'b0110_0001; stimuli_am2940(3'b110,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      //se incepe numaratoarea in ambele numaratoare
      #20 stimuli_am2940(3'b111,1'b0,1'b0);
      
      //se stopeaza numaratoarea si se reseteaza valoarea cu cea din registre
      #60 stimuli_am2940(3'b100,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      
      //---------------------------------------------
      //6. cr=101 ==> AC DECREMENTEAZA, WC INCREMENTEAZA
      
      //se scrie in registrul de control
      #20 stimuli_am2940(3'b000,1'b1,1'b1);dataint=8'h5;
      
      //se citeste din registrul de control
      #20 stimuli_am2940(3'b001,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de adresa 
      #20 dataint=8'b1000_1010; stimuli_am2940(3'b101,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de cuvinte ==>se reseteaza la 0 valoarea din numarator
      #20 dataint=8'b0110_0001; stimuli_am2940(3'b110,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      //se incepe numaratoarea in ambele numaratoare
      #20 stimuli_am2940(3'b111,1'b0,1'b0);
      
      //se stopeaza numaratoarea si se reseteaza valoarea cu cea din registre si la WC se va reseta(0)
      #60 stimuli_am2940(3'b100,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      
      //---------------------------------------------
      //7. cr=110 ==> AC DECREMENTEAZA, WC HOLD
      
      //se scrie in registrul de control
      #20 stimuli_am2940(3'b000,1'b1,1'b1);dataint=8'h6;
      
      //se citeste din registrul de control
      #20 stimuli_am2940(3'b001,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de adresa 
      #20 dataint=8'b1000_1010; stimuli_am2940(3'b101,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de cuvinte
      #20 dataint=8'b0110_0001; stimuli_am2940(3'b110,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      //se incepe numaratoarea in ambele numaratoare,se observa ca WC face hold
      #20 stimuli_am2940(3'b111,1'b0,1'b0);
      
      //se stopeaza numaratoarea si se reseteaza valoarea cu cea din registre
      #60 stimuli_am2940(3'b100,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      
      //---------------------------------------------
      //8. cr=111 ==> AC DECREMENTEAZA, WC INCREMENTEAZA
      
      //se scrie in registrul de control
      #20 stimuli_am2940(3'b000,1'b1,1'b1);dataint=8'h7;
      
      //se citeste din registrul de control
      #20 stimuli_am2940(3'b001,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de adresa 
      #20 dataint=8'b1000_1010; stimuli_am2940(3'b101,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se scrie in numaratorul/registrul de cuvinte
      #20 dataint=8'b0110_0001; stimuli_am2940(3'b110,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      //se incepe numaratoarea in ambele numaratoare
      #20 stimuli_am2940(3'b111,1'b0,1'b0);
      
      //se stopeaza numaratoarea si se reseteaza valoarea cu cea din registre
      #60 stimuli_am2940(3'b100,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de adrese
      #20 stimuli_am2940(3'b011,1'b1,1'b1);
      
      //se verifica valoarea din numaratorul de cuvinte
      #20 stimuli_am2940(3'b010,1'b1,1'b1);
      
      //-----------------------------------------
      
    end
   initial
    begin
      #2500 $finish;
    end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0,am2940_inst);
    end
endmodule