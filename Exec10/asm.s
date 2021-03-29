        PUBLIC  __iar_program_start
        PUBLIC  __vector_table

        SECTION .text:CODE:REORDER(1)
        
        ;; Keep vector table even if it's not referenced
        REQUIRE __vector_table
        
        THUMB
        
__iar_program_start
        
main    
        MOV     R0,#4
        MOV     R1,#5
        PUSH     {R0,R1}     
        BL      Mul16b
        POP    {R0,R1}
        B       fim
Mul16b
        CBZ     R1,Desloc
        CMP     R1,#2           //A primeira parte efetua a operação R1=2*R2+R3
        ITTEE   CS              //Com R2=número_de_iterações  e R3=0 ou 1 
        SUBCS   R1,#2
        ADDCS   R2,#1
        MOVCC   R3,R1
        MOVCC   R1,#0
        B       Mul16b
Desloc
        MOV     R4,R0
        LSL     R0,R2           //R0 é multiplicado por 2, R2 vezes, através de deslocamentos
        CBZ     R3,retorno      //Verifica se R3=0 e volta para main, ou se R3=1 soma em R0 seu valor inicial uma vez e volta para main
        ADD     R0,R4           
        B       retorno
retorno
        MOV     R2,R0
        BX      LR
fim
        nop

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)
        SECTION .intvec:CODE:NOROOT(2)
        
        DATA

__vector_table
        DCD     sfe(CSTACK)
        DCD     __iar_program_start

        DCD     NMI_Handler
        DCD     HardFault_Handler
        DCD     MemManage_Handler
        DCD     BusFault_Handler
        DCD     UsageFault_Handler
        DCD     0
        DCD     0
        DCD     0
        DCD     0
        DCD     SVC_Handler
        DCD     DebugMon_Handler
        DCD     0
        DCD     PendSV_Handler
        DCD     SysTick_Handler

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;

        PUBWEAK NMI_Handler
        PUBWEAK HardFault_Handler
        PUBWEAK MemManage_Handler
        PUBWEAK BusFault_Handler
        PUBWEAK UsageFault_Handler
        PUBWEAK SVC_Handler
        PUBWEAK DebugMon_Handler
        PUBWEAK PendSV_Handler
        PUBWEAK SysTick_Handler

        SECTION .text:CODE:REORDER:NOROOT(1)
        THUMB

NMI_Handler
HardFault_Handler
MemManage_Handler
BusFault_Handler
UsageFault_Handler
SVC_Handler
DebugMon_Handler
PendSV_Handler
SysTick_Handler
Default_Handler
__default_handler
        CALL_GRAPH_ROOT __default_handler, "interrupt"
        NOCALL __default_handler
        B __default_handler

        END
