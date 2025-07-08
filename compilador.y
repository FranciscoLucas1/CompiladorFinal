%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h> 


extern FILE *yyin;
int yylex(void);
void yyerror(char *s);


#define TYPE_NUM 1
#define TYPE_STR 2
#define TYPE_ARRAY 3
    
typedef struct vars{
    int nodetype;
    char name[256];
    union {
        double d_val;
        char s_val[256];
    } value;
    double *vet;
    struct vars * prox;
}VARI;
    
typedef struct ast { int nodetype; struct ast *l; struct ast *r; } Ast;
typedef struct numval { int nodetype; double number; } Numval;
typedef struct varval { int nodetype; char var[256]; int size; } Varval;
typedef struct texto { int nodetype; char txt[256]; } TXT;  
typedef struct flow { int nodetype; Ast *cond; Ast *tl; Ast *el; } Flow;
typedef struct symasgn { int nodetype; char s[256]; Ast *v; int pos; } Symasgn;


double eval(Ast *a);
void print_eval(Ast *a);

VARI *l1;

VARI *ins(VARI*l,char n[]){ VARI*new =(VARI*)malloc(sizeof(VARI)); strcpy(new->name,n); new->prox = l; new->nodetype = TYPE_NUM; new->value.d_val = 0.0; return new; }
VARI *ins_a(VARI*l,char n[], int tamanho){ VARI*new =(VARI*)malloc(sizeof(VARI)); strcpy(new->name,n); new->vet = (double*)malloc(tamanho * sizeof(double)); new->prox = l; new->nodetype = TYPE_ARRAY; return new;}
VARI *srch(VARI*l,char n[]){ VARI*aux = l; while(aux != NULL){ if(strcmp(n,aux->name)==0) return aux; aux = aux->prox; } return aux; }
Ast * newast(int nodetype, Ast *l, Ast *r){ Ast *a = (Ast*) malloc(sizeof(Ast)); a->nodetype = nodetype; a->l = l; a->r = r; return a; }
Ast * newvari(int nodetype, char nome[256]) { Varval *a = (Varval*) malloc(sizeof(Varval)); a->nodetype = nodetype; strcpy(a->var,nome); return (Ast*)a; }
Ast * newtext(int nodetype, char txt[256]) { TXT *a = (TXT*) malloc(sizeof(TXT)); a->nodetype = nodetype; strcpy(a->txt,txt); return (Ast*)a; } 
Ast * newnum(double d) { Numval *a = (Numval*) malloc(sizeof(Numval)); a->nodetype = 'K'; a->number = d; return (Ast*)a; }  
Ast * newasgn(char s[256], Ast *v) { Symasgn *a = (Symasgn*)malloc(sizeof(Symasgn)); a->nodetype = '='; strcpy(a->s,s); a->v = v; return (Ast *)a; }
Ast * newflow(int nodetype, Ast *cond, Ast *tl, Ast *el){ Flow *a = (Flow*)malloc(sizeof(Flow)); a->nodetype = nodetype; a->cond = cond; a->tl = tl; a->el = el; return (Ast *)a;}
Ast * newcmp(int cmptype, Ast *l, Ast *r){ Ast *a = (Ast*)malloc(sizeof(Ast)); a->nodetype = '0' + cmptype; a->l = l; a->r = r; return a;}
Ast * newasgn_a(char s[256], Ast *v, int indice) { Symasgn *a = (Symasgn*)malloc(sizeof(Symasgn)); a->nodetype = 'A'; strcpy(a->s,s); a->v = v; a->pos = indice; return (Ast *)a;}
Ast * newValorVal(char s[]) { Varval *a = (Varval*) malloc(sizeof(Varval)); a->nodetype = 'N'; strcpy(a->var,s); return (Ast*)a; }
Ast * newValorVal_a(char s[], int indice) { Varval *a = (Varval*) malloc(sizeof(Varval)); a->nodetype = 'n'; strcpy(a->var,s); a->size = indice; return (Ast*)a;}
Ast * newarray(int nodetype, char nome[256], int tam) { Varval *a = (Varval*) malloc(sizeof(Varval)); a->nodetype = nodetype; strcpy(a->var,nome); a->size = tam; return (Ast*)a;}


void print_eval(Ast *a) {
    if (!a) return;
    
    if (a->nodetype == 'L') {
        print_eval(a->l);
        printf(" ");
        print_eval(a->r);
        return;
    }
    
    if (a->nodetype == 's') { printf("%s", ((TXT*)a)->txt); } 
    else if (a->nodetype == 'N') {
        VARI *var = srch(l1, ((Varval *)a)->var);
        if (var) {
            if (var->nodetype == TYPE_STR) { printf("%s", var->value.s_val); }
            else { printf("%.2f", var->value.d_val); }
        }
    }
    else { printf("%.2f", eval(a)); }
}


double eval(Ast *a) {
    double v = 0.0;
    VARI *aux;

    if(!a) { return 0.0; }

    switch(a->nodetype) {
        case 'K': v = ((Numval *)a)->number; break;
        case 'N': 
            aux = srch(l1,((Varval *)a)->var);
            if (!aux) { yyerror("variavel nao encontrada"); v = 0.0; }
            else { v = aux->value.d_val; }
            break;
        case 'n':
            aux = srch(l1,((Varval *)a)->var);
            if (!aux) { yyerror("vetor nao encontrado"); v = 0.0; }
            else { v = aux->vet[((Varval *)a)->size]; }
            break;
        
        case '+': v = eval(a->l) + eval(a->r); break;
        case '-': v = eval(a->l) - eval(a->r); break;
        case '*': v = eval(a->l) * eval(a->r); break;
        case '/': v = eval(a->l) / eval(a->r); break;
        case 'M': v = -eval(a->l); break;
    
        case '1': v = (eval(a->l) > eval(a->r))? 1 : 0; break;
        case '2': v = (eval(a->l) < eval(a->r))? 1 : 0; break;
        case '3': v = (eval(a->l) != eval(a->r))? 1 : 0; break;
        case '4': v = (eval(a->l) == eval(a->r))? 1 : 0; break;
        case '5': v = (eval(a->l) >= eval(a->r))? 1 : 0; break;
        case '6': v = (eval(a->l) <= eval(a->r))? 1 : 0; break;
        
        case '=': { 
            Symasgn *sa = (Symasgn *)a;
            aux = srch(l1, sa->s);
            if(!aux) { yyerror("variavel nao declarada"); break; }
            
            Ast* rhs_node = sa->v;
            if (rhs_node->nodetype == 's') {
                strncpy(aux->value.s_val, ((TXT*)rhs_node)->txt, 255);
                aux->nodetype = TYPE_STR;
            }
            else if (rhs_node->nodetype == 'N') {
                VARI* rhs_var = srch(l1, ((Varval*)rhs_node)->var);
                if(rhs_var) {
                    aux->nodetype = rhs_var->nodetype;
                    aux->value = rhs_var->value;
                }
            }
            else {
                aux->value.d_val = eval(rhs_node);
                aux->nodetype = TYPE_NUM;
            }
            break;
        }
        case 'A':
            v = eval(((Symasgn*)a)->v);
            aux = srch(l1, ((Symasgn*)a)->s);
            if(!aux) { yyerror("vetor nao encontrado"); }
            else { aux->vet[((Symasgn*)a)->pos] = v; }
            break;

        case 'I':
            if (eval(((Flow *)a)->cond) != 0) {
                if (((Flow *)a)->tl) eval(((Flow *)a)->tl);
            } else {
                if( ((Flow *)a)->el) eval(((Flow *)a)->el);
            }
            break;
        case 'W':
            if( ((Flow *)a)->tl) {
                while( eval(((Flow *)a)->cond) != 0){
                    eval(((Flow *)a)->tl);
                }
            }
            break;
            
        case 'L': eval(a->l); eval(a->r); break;
        case 'V': l1 = ins(l1, ((Varval*)a)->var); break;
        case 'a': l1 = ins_a(l1, ((Varval*)a)->var, ((Varval*)a)->size); break;
        case 'P':
            print_eval(a->l);
            printf("\n");
            break;
        case 'R': {
            char input_buffer[256]; char *endptr;
            aux = srch(l1,((Varval *)a)->var);
            if (!aux) { yyerror("variavel nao declarada"); break; }
            scanf("%255s", input_buffer);
            double num_val = strtod(input_buffer, &endptr);
            if (*endptr == '\0' && endptr != input_buffer) {
                aux->value.d_val = num_val; aux->nodetype = TYPE_NUM;
            } else {
                strcpy(aux->value.s_val, input_buffer); aux->nodetype = TYPE_STR;
            }
            break;
        }
        default: printf("internal error: bad node %c\n", a->nodetype); break;
    }
    return v;
}

void yyerror (char *s){ fprintf(stderr, "Erro de sintaxe: %s\n", s); }

%}

%union{ double flo; int fn; char str[256]; struct ast *a; }
%token <flo> NUM
%token <str> VARS STRING
%token FIM IF ELSE WHILE PRINT DECL SCAN
%token <fn> CMP
%right '='
%left '+' '-'
%left '*' '/'
%left CMP
%type <a> exp list stmt prog print_list
%nonassoc IFX ELSE NEG
    
%%

prog: /*  */ { $$ = NULL; }
    | prog stmt { if($2) eval($2); }
    ;
    
stmt: exp { $$ = $1; }
    | PRINT '(' print_list ')'  { $$ = newast('P', $3, NULL); }
    | SCAN '(' VARS ')'     { $$ = newvari('R', $3); }
    | DECL VARS         { $$ = newvari('V', $2); }
    | DECL VARS '[' NUM ']'  { $$ = newarray('a', $2, (int)$4); }
    | VARS '=' exp       { $$ = newasgn($1, $3); }
    | VARS '[' NUM ']' '=' exp  { $$ = newasgn_a($1, $6, (int)$3); }
    | IF '(' exp ')' '{' list '}' { $$ = newflow('I', $3, $6, NULL); }
    | IF '(' exp ')' '{' list '}' ELSE '{' list '}' { $$ = newflow('I', $3, $6, $10); }
    | WHILE '(' exp ')' '{' list '}' { $$ = newflow('W', $3, $6, NULL); }
    | FIM { printf("Execucao finalizada.\n"); exit(0); }
    ;

list: /*  */ { $$ = NULL; }
    | list stmt { if($1 && $2) $$ = newast('L', $1, $2); else if ($2) $$ = $2; else $$ = $1; }
    ;

print_list: exp { $$ = $1; }
          | print_list ',' exp { $$ = newast('L', $1, $3); }
          ;
    
exp: exp '+' exp {$$ = newast('+',$1,$3);}
    | exp '-' exp {$$ = newast('-',$1,$3);}
    | exp '*' exp {$$ = newast('*',$1,$3);}
    | exp '/' exp {$$ = newast('/',$1,$3);}
    | exp CMP exp {$$ = newcmp($2,$1,$3);}
    | '(' exp ')' {$$ = $2;}
    | '-' exp %prec NEG {$$ = newast('M',$2,NULL);}
    | NUM   {$$ = newnum($1);}
    | VARS  {$$ = newValorVal($1);}
    | VARS '[' NUM ']' {$$ = newValorVal_a($1,(int)$3);}
    | STRING {$$ = newtext('s', $1);}
    ;

%%

int main(){
    l1 = NULL;
    yyin=fopen("entrada.txt","r");
    if(!yyin) {
        printf("Nao foi possivel abrir o arquivo 'entrada.txt'\n");
        return 1;
    }
    yyparse();
    fclose(yyin);
    return 0;
}