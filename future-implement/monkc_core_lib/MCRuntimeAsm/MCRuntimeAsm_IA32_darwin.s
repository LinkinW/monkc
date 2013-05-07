/*
Copyright (c) <2013>, <Sun Yuli>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <Monk-C> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#;void* _push_jump(id const obj, MCMessage msg, ...);
#;esp+4->obj
#;esp+8->msg.object
#;esp+12->msg.addr

.text
.globl __push_jump
.p2align 4, 0x90
__push_jump:
	cmpl $0, 8(%esp)
	je 0f					#; confirm return address not nil
	jmp *8(%esp)
0:
	ret


.text
.globl __clean_jump1
.p2align 4, 0x90
__clean_jump1:
	pushl %esp				#; align to make the same offset as BP
	#;movl 4(%esp), %eax	#; no need to change address
	#;movl %eax, 4(%ebp)	#;
	movl 8(%esp), %eax		#; this ptr = msg.object
	movl %eax, 8(%ebp)		#;
	movl 12(%esp), %ecx		#; entry addr = msg.addr
	movl %ecx, 12(%ebp)		#; 
	movl 16(%esp), %eax		#; arg1
	movl %eax, 16(%ebp)		#;
	movl %ebp, %esp			#; unwind the current start frame
	popl %ebp				#;
	cmpl $0, %ecx		
	je 0f
	jmp *%ecx
0:
	ret


.text
.globl __clean_jump2
.p2align 4, 0x90
__clean_jump2:
	pushl %esp				#; align to make the same offset as BP
	#;movl 4(%esp), %eax	#; no need to change address
	#;movl %eax, 4(%ebp)	#;
	movl 8(%esp), %eax		#; this ptr = msg.object
	movl %eax, 8(%ebp)		#;
	movl 12(%esp), %ecx		#; entry addr = msg.addr
	movl %ecx, 12(%ebp)		#; 
	movl 16(%esp), %eax		#; arg1
	movl %eax, 16(%ebp)		#;
	movl 20(%esp), %eax		#; arg2
	movl %eax, 20(%ebp)		#;
	movl %ebp, %esp			#; unwind the current start frame
	popl %ebp				#;
	cmpl $0, %ecx
	je 0f
	jmp *%ecx
0:
	ret


.text
.globl __clean_jump3
.p2align 4, 0x90
__clean_jump3:
	pushl %esp				#; align to make the same offset as BP
	#;movl 4(%esp), %eax	#; no need to change address
	#;movl %eax, 4(%ebp)	#;
	movl 8(%esp), %eax		#; this ptr = msg.object
	movl %eax, 8(%ebp)		#;
	movl 12(%esp), %ecx		#; entry addr = msg.addr
	movl %ecx, 12(%ebp)		#; 
	movl 16(%esp), %eax		#; arg1
	movl %eax, 16(%ebp)		#;
	movl 20(%esp), %eax		#; arg2
	movl %eax, 20(%ebp)		#;
	movl 24(%esp), %eax		#; arg3
	movl %eax, 24(%ebp)		#;
	movl %ebp, %esp			#; unwind the current start frame
	popl %ebp				#;
	cmpl $0, %ecx		
	je 0f
	jmp *%ecx
0:
	ret


.text
.globl __clean_jump4
.p2align 4, 0x90
__clean_jump4:
	pushl %esp				#; align to make the same offset as BP
	#;movl 4(%esp), %eax	#; no need to change address
	#;movl %eax, 4(%ebp)	#;
	movl 8(%esp), %eax		#; this ptr = msg.object
	movl %eax, 8(%ebp)		#;
	movl 12(%esp), %ecx		#; entry addr = msg.object
	movl %ecx, 12(%ebp)		#; 
	movl 16(%esp), %eax		#; arg1
	movl %eax, 16(%ebp)		#;
	movl 20(%esp), %eax		#; arg2
	movl %eax, 20(%ebp)		#;
	movl 24(%esp), %eax		#; arg3
	movl %eax, 24(%ebp)		#;
	movl 28(%esp), %eax		#; arg4
	movl %eax, 28(%ebp)		#;
	movl %ebp, %esp			#; unwind the current start frame
	popl %ebp				#;
	cmpl $0, %ecx		
	je 0f
	jmp *%ecx
0:
	ret


#;void mc_atomic_set_integer(int* target, int value);
#;void mc_atomic_set_pointer(void** target, void* value);

.text
.globl	_mc_atomic_set_integer
.p2align 4, 0x90
_mc_atomic_set_integer:
	pushl %ebp				
	movl %esp, %ebp
	 						#; 8(%ebp)  addr
							#; 12(%ebp) newval
0:
	movl 8(%ebp), %edx		#; dest addr in edx
	movl 0(%edx), %eax		#; old value in eax
	movl 12(%ebp), %ecx		#; new value in ecx

	lock cmpxchgl %ecx, (%edx) 	#; atomic compare and swap
	xorl %eax, %eax
	jne	0b

	movl %ebp, %esp
	popl %ebp
	ret


.text
.globl	_mc_atomic_set_pointer
.p2align 4, 0x90
_mc_atomic_set_pointer:
	pushl %ebp				
	movl %esp, %ebp
	 						#; 8(%ebp)  addr
							#; 12(%ebp) newval
0:
	movl 8(%ebp), %edx		#; dest addr in edx
	movl 0(%edx), %eax		#; old value in eax
	movl 12(%ebp), %ecx		#; new value in ecx

	lock cmpxchgl %ecx, (%edx) 	#; atomic compare and swap
	xorl %eax, %eax
	jne	0b

	movl %ebp, %esp
	popl %ebp
	ret