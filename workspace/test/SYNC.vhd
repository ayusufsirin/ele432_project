library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my.all;

ENTITY SYNC IS
PORT(
CLK: IN STD_LOGIC;
HSYNC: OUT STD_LOGIC;
VSYNC: OUT STD_LOGIC;
R: OUT STD_LOGIC_VECTOR(7 downto 0);
G: OUT STD_LOGIC_VECTOR(7 downto 0);
B: OUT STD_LOGIC_VECTOR(7 downto 0);
S: IN STD_LOGIC_VECTOR(7 downto 0)
);
END SYNC;


ARCHITECTURE MAIN OF SYNC IS
-----1280x1024 @ 60 Hz pixel clock 108 MHz
SIGNAL RGB: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL y1: INTEGER RANGE 0 TO 525:=325;
SIGNAL y2: INTEGER RANGE 0 TO 525:=125;
SIGNAL s1: INTEGER RANGE 0 TO 800:=185;
SIGNAL s2: INTEGER RANGE 0 TO 800:=240;
SIGNAL s3: INTEGER RANGE 0 TO 800:=295;
SIGNAL s4: INTEGER RANGE 0 TO 800:=350;
SIGNAL s5: INTEGER RANGE 0 TO 800:=405;
SIGNAL s6: INTEGER RANGE 0 TO 800:=460;
SIGNAL s7: INTEGER RANGE 0 TO 800:=515;
SIGNAL s8: INTEGER RANGE 0 TO 800:=570;
SIGNAL s9: INTEGER RANGE 0 TO 800:=625;
SIGNAL s10: INTEGER RANGE 0 TO 800:=680;
SIGNAL s11: INTEGER RANGE 0 TO 800:=735;
SIGNAL s12: INTEGER RANGE 0 TO 800:=222;
SIGNAL s13: INTEGER RANGE 0 TO 800:=277;
SIGNAL s14: INTEGER RANGE 0 TO 800:=387;
SIGNAL s15: INTEGER RANGE 0 TO 800:=442;
SIGNAL s16: INTEGER RANGE 0 TO 800:=497;
SIGNAL s17: INTEGER RANGE 0 TO 800:=607;
SIGNAL s18: INTEGER RANGE 0 TO 800:=662;



SIGNAL DRAW1,DRAW2,DRAW3,DRAW4,DRAW5,DRAW6,DRAW7,DRAW8,DRAW9,DRAW10,DRAW11,DRAW12,DRAW13,DRAW14,DRAW15,DRAW16,DRAW17,DRAW18:STD_LOGIC:='0';
SIGNAL HPOS: INTEGER RANGE 0 TO 800:=0;
SIGNAL VPOS: INTEGER RANGE 0 TO 525:=0;


BEGIN
STICK(HPOS,VPOS,s1,y1,RGB,DRAW1);
STICK(HPOS,VPOS,s2,y1,RGB,DRAW2);
STICK(HPOS,VPOS,s3,y1,RGB,DRAW3);
STICK(HPOS,VPOS,s4,y1,RGB,DRAW4);
STICK(HPOS,VPOS,s5,y1,RGB,DRAW5);
STICK(HPOS,VPOS,s6,y1,RGB,DRAW6);
STICK(HPOS,VPOS,s7,y1,RGB,DRAW7);
STICK(HPOS,VPOS,s8,y1,RGB,DRAW8);
STICK(HPOS,VPOS,s9,y1,RGB,DRAW9);
STICK(HPOS,VPOS,s10,y1,RGB,DRAW10);
STICK(HPOS,VPOS,s11,y1,RGB,DRAW11);
STICK(HPOS,VPOS,s12,y2,RGB,DRAW12);
STICK(HPOS,VPOS,s13,y2,RGB,DRAW13);
STICK(HPOS,VPOS,s14,y2,RGB,DRAW14);
STICK(HPOS,VPOS,s15,y2,RGB,DRAW15);
STICK(HPOS,VPOS,s16,y2,RGB,DRAW16);
STICK(HPOS,VPOS,s17,y2,RGB,DRAW17);
STICK(HPOS,VPOS,s18,y2,RGB,DRAW18);



 PROCESS(CLK)
 BEGIN
IF(CLK'EVENT AND CLK='1')THEN
      IF(DRAW1='1')THEN
			IF(S="00011100")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;
      IF(DRAW2='1')THEN
			IF(S="00011011")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;
      IF(DRAW3='1')THEN
			IF(S="00100011")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;
      IF(DRAW4='1')THEN
			IF(S="00101011")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;
      IF(DRAW5='1')THEN
			IF(S="00110100")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;
      IF(DRAW6='1')THEN
			IF(S="00110011")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;
      IF(DRAW7='1')THEN
			IF(S="00111011")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;
      IF(DRAW8='1')THEN
			IF(S="01000010")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;
      IF(DRAW9='1')THEN
			IF(S="01001011")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;
      IF(DRAW10='1')THEN
			IF(S="01001100")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;
      IF(DRAW11='1')THEN
			IF(S="01010010")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;

      IF(DRAW12='1')THEN
			IF(S="00011101")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;

      IF(DRAW13='1')THEN
			IF(S="00100100")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;

      IF(DRAW14='1')THEN
			IF(S="00101100")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;

      IF(DRAW15='1')THEN
			IF(S="00110101")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;

      IF(DRAW16='1')THEN
			IF(S="00111100")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;

      IF(DRAW17='1')THEN
			IF(S="01000100")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;

      IF(DRAW18='1')THEN
			IF(S="01001101")THEN
			R<=(others=>'1');
			G<=(others=>'0');
			B<=(others=>'0');
				ELSE
			R<=(others=>'1');
			G<=(others=>'1');
			B<=(others=>'1');
			END IF;
      END IF;
IF (DRAW1='0' AND DRAW2='0' AND DRAW3='0' AND DRAW4='0' AND DRAW5='0' AND DRAW6='0' AND DRAW7='0' AND DRAW8='0' AND DRAW9='0' AND DRAW10='0' AND DRAW11='0' AND DRAW12='0' AND DRAW13='0' AND DRAW14='0' AND DRAW15='0' AND DRAW16='0' AND DRAW17='0'AND DRAW18='0')THEN
		   R<=(others=>'0');
	      G<=(others=>'0');
	      B<=(others=>'0');
		END IF;
		
		IF(HPOS<800)THEN
			HPOS<=HPOS+1;
			ELSE
			HPOS<=0;
		  IF(VPOS<525)THEN
			  VPOS<=VPOS+1;
			  ELSE
			  VPOS<=0;
		  END IF;
		END IF;
		
   IF((HPOS>0 AND HPOS<160) OR (VPOS>0 AND VPOS<45))THEN
	R<=(others=>'0');
	G<=(others=>'0');
	B<=(others=>'0');
	END IF;
   IF(HPOS>16 AND HPOS<112)THEN----HSYNC
	   HSYNC<='0';
	ELSE
	   HSYNC<='1';
	END IF;
   IF(VPOS>10 AND VPOS<12)THEN----------vsync
	   VSYNC<='0';
	ELSE
	   VSYNC<='1';
	END IF;
 END IF;
 END PROCESS;
 END MAIN;