---------------------------------------------------------------------
----                                                             ----
---- Company:  University of Bonn                                ----
---- Engineer: John Bieling                                      ----
----                                                             ----
---------------------------------------------------------------------
----                                                             ----
---- Copyright (C) 2015 John Bieling                             ----
----                                                             ----
---- This source file may be used and distributed without        ----
---- restriction provided that this copyright statement is not   ----
---- removed from the file and that any derivative work contains ----
---- the original copyright notice and the associated disclaimer.----
----                                                             ----
----     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ----
---- EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ----
---- TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ----
---- FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ----
---- OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ----
---- INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ----
---- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ----
---- GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ----
---- BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ----
---- LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ----
---- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ----
---- OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ----
---- POSSIBILITY OF SUCH DAMAGE.                                 ----
----                                                             ----
---------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use ieee.numeric_std.all;

entity readonly_register_with_readtrigger is
   Generic (myaddress: natural := 16#FFFF#);
   Port ( databus : out  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
           addressbus : in  STD_LOGIC_VECTOR (15 downto 0);
           readsignal : in  STD_LOGIC;
           readtrigger : out  STD_LOGIC;
           CLK : in  STD_LOGIC;
           registerbits : in  STD_LOGIC_VECTOR (31 downto 0));
end readonly_register_with_readtrigger;

architecture Behavioral of readonly_register_with_readtrigger is
begin
   
	process (CLK) begin
		if (rising_edge(CLK)) then

			if (addressbus = myaddress and readsignal='1') then
				databus <= registerbits;
				readtrigger <= '1';
			else	
				databus <= (others => 'Z');
				readtrigger <= '0';
			end if;
		end if;
	end process;

end Behavioral;

