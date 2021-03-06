#include <stdio.h>
#include <assert.h>

#include "expressions.h"
#include "storage.h"

void evaluate_component(Component v, Bucket *B, int where){
    if(!v.valid) return;
    if(v.var){
        int pos = insert_element(B, v.value);
        printf("ldr r0, =universe\n");
        printf("ldr r%d, [r0, #%d]\n", where, pos * 4);
    }
    else {
        printf("ldr r%d, =#%s\n", where, v.value);
    }
}

void evaluate_expression(Expression e, Bucket *B){
    assert(e.valid);
    if(e.oper == NONE){
        Component v = e.v1;
        evaluate_component(v, B, 1);
    }
    else {
        int x, y;
        x = 2; y = 3; // registros auxiliares para los cómputos...
        switch(e.oper){
            case SUMA: {
                evaluate_component(e.v1, B, x);
                evaluate_component(e.v2, B, y);
                printf("add r1, r%d, r%d\n", x, y);
            }
            case RESTA: {}
            case MULTIPLICACION: {}
            case DIVISION: {}
            case AND: {}
            case OR: {}
            case XOR: {}
            case MENOR: {}
            case MENOR_O_IGUAL: {}
            case IGUAL: {}
            case MAYOR: {}
            case MAYOR_O_IGUAL: {}
            case NONE: {}
        }
    }
}
