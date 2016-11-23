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
`include "src/proc_flags_defines.svinc"

////initial
////begin
////	//$display(`__LINE__);
////end

module alu_test_bench;
	logic master_clk, ready;
	
	logic dummy;
	// ALU inputs and outputs
	logic [`const_alu_oper_msb_pos:0] alu_oper;
	logic [`const_alu_inout_msb_pos:0] alu_a_in, alu_b_in;
	logic [`const_proc_flags_msb_pos:0] alu_proc_flags_in;
	logic [`const_alu_inout_msb_pos:0] alu_out;
	logic [`const_proc_flags_msb_pos:0] alu_proc_flags_out;
	
	alu test_alu( .oper(alu_oper), .a_in(alu_a_in), .b_in(alu_b_in),
		.proc_flags_in(alu_proc_flags_in), .out(alu_out),
		.proc_flags_out(alu_proc_flags_out) );
	
	logic alu_oper_type;
	
	assign alu_oper_type = ( ( alu_oper == `enum_alu_oper_adc )
		|| ( alu_oper == `enum_alu_oper_sbc )
		|| ( alu_oper == `enum_alu_oper_rolc )
		|| ( alu_oper == `enum_alu_oper_rorc ) );
	
	initial
	begin
		alu_oper = `const_alu_oper_width'h0;
		
		master_clk = 1'b0;
		ready = 1'b0;
		dummy = 1'b0;
		
		//alu_oper = `enum_alu_oper_add;
		//alu_oper = `enum_alu_oper_adc;
		//alu_oper = `enum_alu_oper_sub;
		//alu_oper = `enum_alu_oper_sbc;
		//alu_oper = `enum_alu_oper_cmp;
		
		//alu_oper = `enum_alu_oper_and;
		//alu_oper = `enum_alu_oper_orr;
		//alu_oper = `enum_alu_oper_xor;
		//alu_oper = `enum_alu_oper_lsl;
		//alu_oper = `enum_alu_oper_lsr;
		//alu_oper = `enum_alu_oper_asr;
		//alu_oper = `enum_alu_oper_rol;
		//alu_oper = `enum_alu_oper_ror;
		alu_oper = `enum_alu_oper_rolc;
		//alu_oper = `enum_alu_oper_rorc;
		
		
		{ alu_a_in, alu_b_in } = { `const_alu_inout_width'h0,
			`const_alu_inout_width'h0 };
		alu_proc_flags_in = `const_proc_flags_width'h0;
		
		#1
		ready = 1'b1;
	end
	
	// Clock generation
	always
	begin
		#1
		
		if (ready)
		begin
			master_clk = !master_clk;
		end
	end
	
	always @ ( posedge master_clk )
	begin
		if (!alu_oper_type)
		begin
			//$display( "%d %d\t\t%d %b", alu_a_in, alu_b_in, alu_out,
			//	alu_proc_flags_out );
			//$display( "%h %h\t\t%h %b", alu_a_in, alu_b_in, alu_out,
			//	alu_proc_flags_out );
			//$display( "%b %b\t\t%b %b", alu_a_in, alu_b_in, alu_out,
			//	alu_proc_flags_out );
			$display( "%b %d\t\t%b %b", alu_a_in, alu_b_in[1:0], alu_out,
				alu_proc_flags_out );
			//{ dummy, alu_a_in, alu_b_in } = { dummy, alu_a_in, alu_b_in } 
			//	+ 1;
			{ dummy, alu_a_in, alu_b_in[1:0] } 
				= { dummy, alu_a_in, alu_b_in[1:0] } + 1;
		end
		
		else // if (alu_oper_type)
		begin
			//$display( "%d %b %d\t\t%d %b", alu_a_in, 
			//	alu_proc_flags_in[pf_slot_c], alu_b_in, alu_out,
			//	alu_proc_flags_out );
			//$display( "%h %b %d\t\t%h %b", alu_a_in, 
			//	alu_proc_flags_in[pf_slot_c], alu_b_in, alu_out,
			//	alu_proc_flags_out );
			//$display( "%b %b %d\t\t%b %b", alu_a_in, 
			//	alu_proc_flags_in[pf_slot_c], alu_b_in, alu_out,
			//	alu_proc_flags_out );
			$display( "%b %b %d\t\t%b %b", alu_a_in, 
				alu_proc_flags_in[pf_slot_c], alu_b_in[1:0],
				alu_out, alu_proc_flags_out );
			
			//{ dummy, alu_a_in, alu_b_in, 
			//	alu_proc_flags_in[pf_slot_c] } 
			//	= { dummy, alu_a_in, alu_proc_flags_in[pf_slot_c],
			//	alu_b_in } + 1;
			{ dummy, alu_a_in, alu_proc_flags_in[pf_slot_c], 
				alu_b_in[1:0] }
				= { dummy, alu_a_in, alu_proc_flags_in[pf_slot_c],
				alu_b_in[1:0] } + 1;
		end
		
		if (dummy)
		begin
			$finish;
		end
	end
	
endmodule
