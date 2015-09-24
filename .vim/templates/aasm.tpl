@CS@
@CM@ @FILE-NAME@ for Project in @PWD@
@CM@
@CM@ Made by @USER-NAME@
@CM@ @LOGIN-STRING@   <@USER-MAIL@>
@CM@
@CM@ Started on  @DATE-STAMP@ @USER-NAME@
@CM@ Last update @DATE-STAMP@ @USER-NAME@
@CE@

.mod_load asm-sparc
.mod_load out-elf32

.include sparc/v8.def

.section data .data
	.section_align 4
.ends

.section code .text
	.section_align 4
	.mod_asm opcodes v8
	.export main
        
	.proc main
                .define argc	%i0
                .define argv	%i1

		save		sp, -112, sp	; prolog
		ret				; epilog
		restore
	.endp
.ends
