// This file is part of Small Practice CPU.
// 
// Copyright 2016 by Andrew Clark (FL4SHK).
// 
// Small Practice CPU is free software: you can redistribute it and/or
// modify it under the terms of the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
// 
// Small Practice CPU is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
// 
// You should have received a copy of the GNU General Public License along
// with Small Practice CPU.  If not, see <http://www.gnu.org/licenses/>.


`include "src/alu_defines.svinc"


package pkg_alu;
	// ALU operation enum values
	typedef enum logic [`alu_op_msb_pos:0]
	{
		// Arithmetic operations
		// Addition operations
		alu_op_add,
		alu_op_adc,
		
		
		// Subtraction operations
		alu_op_sub,
		alu_op_sbc,
		alu_op_cmp,
		
		// Bitwise operations
		
		// Operations analogous to logic gates (none of these affect carry)
		alu_op_and,
		alu_op_orr,
		alu_op_xor,
		
		// Complement operations
		alu_op_inv,
		alu_op_invp,
		alu_op_neg,
		alu_op_negp,
		
		
		// 8-bit Bitshifting operations (number of bits specified by b_in)
		alu_op_lsl,
		alu_op_lsr,
		alu_op_asr,
		
		// 8-bit Bit rotation operations (number of bits specified by
		// [b_in % inout_width])
		alu_op_rol,
		alu_op_ror,
		
		
		// 8-bit Bit rotating operations (with carry as bit 8 or bit 0)
		// that rotate by [b_in % inout_width] bits
		alu_op_rolc,
		alu_op_rorc,
		
		
		
		// 16-bit Bitshifting operations that shift { a_in_hi, a_in_lo }
		// by b_in bits
		alu_op_lslp,
		alu_op_lsrp,
		alu_op_asrp,
		
		
		// 16-bit Bit rotation operations that rotate { a_in_hi, a_in_lo }
		// by [b_in % inout_width] bits
		alu_op_rolp,
		alu_op_rorp,
		
		
		// 16-bit Bit rotating operations that rotate { a_in_hi, a_in_lo }
		// (with carry as bit 16 or bit 0) by [b_in % inout_width] bits
		alu_op_rolcp,
		alu_op_rorcp
		
		
	} alu_oper;
	
	typedef enum logic [1:0]
	{
		// 8-bit operation with no carry in
		alu_op_cat_8_no_ci,
		
		// 8-bit operation with carry in
		alu_op_cat_8_ci,
		
		// 16-bit operation with no carry in
		alu_op_cat_16_no_ci,
		alu_op_cat_16_ci
	} alu_oper_cat;
	
	task get_alu_oper_cat( input alu_oper to_check, 
		output alu_oper_cat to_get );
		
		// Arithmetic operations
			// Addition operations
		if ( ( to_check == alu_op_add ) 
			
			// Subtraction operations
			|| ( to_check == alu_op_sub ) 
			|| ( to_check == alu_op_cmp ) 
			
		// Bitwise operations
			// Operations analogous to logic gates (none of these affect
			// carry)
			|| ( to_check == alu_op_and ) 
			|| ( to_check == alu_op_orr )
			|| ( to_check == alu_op_xor )
			
			// Complement operations
			|| ( to_check == alu_op_inv )
			|| ( to_check == alu_op_neg ) 
			
			// 8-bit Bitshifting operations (number of bits specified by
			// b_in)
			|| ( to_check == alu_op_lsl )
			|| ( to_check == alu_op_lsr )
			|| ( to_check == alu_op_asr )
			
			// 8-bit Bit rotation operations (number of bits specified by
			// [b_in % inout_width])
			|| ( to_check == alu_op_rol )
			|| ( to_check == alu_op_ror ) )
		begin
			to_get = alu_op_cat_8_no_ci;
		end
		
		
		
		// Arithmetic operations
			// Addition operations
		else if ( ( to_check == alu_op_adc )
			
			// Subtraction operations
			|| ( to_check == alu_op_sbc )
			
		// Bitwise operations
			// 8-bit Bit rotating operations (with carry as bit 8 or bit 0)
			// that rotate by [b_in % inout_width] bits
			|| ( to_check == alu_op_rolc )
			|| ( to_check == alu_op_rorc ) )
		begin
			to_get = alu_op_cat_8_ci;
		end
		
		
		
		// Bitwise operations
			// Complement operations
		else if ( ( to_check == alu_op_invp )
			|| ( to_check == alu_op_negp )
			
			// 16-bit Bitshifting operations that shift { a_in_hi, a_in_lo }
			// by b_in bits
			|| ( to_check == alu_op_lslp )
			|| ( to_check == alu_op_lsrp )
			|| ( to_check == alu_op_asrp )
			
			// 16-bit Bit rotation operations that rotate { a_in_hi,
			// a_in_lo } by [b_in % inout_width] bits
			|| ( to_check == alu_op_rolp )
			|| ( to_check == alu_op_rorp ) )
		begin
			to_get = alu_op_cat_16_no_ci;
		end
		
		else
		begin
			to_get = alu_op_cat_16_ci;
		end
		
	endtask
	
endpackage
