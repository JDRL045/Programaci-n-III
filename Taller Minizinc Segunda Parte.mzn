
% Ejercicio N°1.

/*

enum Transporte = {coche, avion, otro};


array[1..6] of var Transporte: transporte;


int: Alejandro = 1;
int: Benito = 2;
int: Andres = 3;
int: Carlos = 4;
int: Dario = 5;
int: Tomas = 6;

constraint transporte[Alejandro] != coche;
constraint transporte[Alejandro] == transporte[Benito];
constraint transporte[Benito] != avion;    
constraint transporte[Andres] == avion;     
constraint transporte[Carlos] != transporte[Dario];  
constraint transporte[Carlos] != avion;   
  
solve satisfy;


output ["Alejandro: ", show(transporte[Alejandro]), "\n",
        "Benito: ", show(transporte[Benito]), "\n",
        "Andrés: ", show(transporte[Andres]), "\n",
        "Carlos: ", show(transporte[Carlos]), "\n",
        "Darío: ", show(transporte[Dario]), "\n",
        "Tomás: ", show(transporte[Tomas]), "\n"];
*/







% Ejercicio N°2.

/*
int: capacidad_mochila = 15;

int: n = 6;

array[1..n] of int: pesos = [3, 5, 1, 4, 2, 1];

array[1..n] of int: valores = [15, 20, 5, 10, 2, 8];

array[1..n] of var 0..1: llevar;

constraint sum(i in 1..n)(pesos[i] * llevar[i]) <= capacidad_mochila;

solve maximize sum(i in 1..n)(valores[i] * llevar[i]);

output [
    "Artículos llevados: ", show(llevar), "\n",
    "Valor total: ", show(sum(i in 1..n)(valores[i] * llevar[i])), "\n",
    "Peso total: ", show(sum(i in 1..n)(pesos[i] * llevar[i]))
];
*/








% Ejercicio N°3.

/*
int: a_minimo = 15;
int: b_minimo = 15;

int: precio_X = 10;
int: precio_Y = 25;

var 0..precio_X: cantidad_X;
var 0..precio_Y: cantidad_Y;

constraint cantidad_X + 5 * cantidad_Y >= b_minimo;
constraint 5 * cantidad_X + cantidad_Y >= a_minimo;

solve minimize (precio_X * cantidad_X + precio_Y * cantidad_Y);

output [
    "Cantidad de compuesto X: ", show(cantidad_X), "\n",
    "Cantidad de compuesto Y: ", show(cantidad_Y), "\n",
    "Costo total: ", show(precio_X * cantidad_X + precio_Y * cantidad_Y)
];

*/







% Ejercicio N°4.

/*
var 0..15: grandes;
var 0..20: pequenas;

const int: peso_grande = 40;
const int: peso_pequeno = 30;
const int: total_peso = 600;
const int: beneficio_grande = 2;
const int: beneficio_pequeno = 1;

constraint grandes >= 3;
constraint pequenas >= 2 * grandes;
constraint grandes * peso_grande + pequenas * peso_pequeno <= total_peso;

solve maximize (grandes * beneficio_grande + pequenas * beneficio_pequeno); 

output ["Grandes: ", show(grandes), "\n", "Pequenas: ", show(pequenas), "\n", 
        "Beneficio total: ", show(grandes * beneficio_grande + pequenas * beneficio_pequeno)];

*/







% Ejercicio N°5.

/*
int: total_farmaco = 600;
int: peso_grande = 40;
int: peso_pequena = 30;

var int: x;
var int: y;

constraint 40 * x + 30 * y <= total_farmaco;
constraint x >= 3;
constraint y >= 2 * x;

var int: beneficio = 2 * x + y;
solve maximize beneficio;

output ["Pastillas grandes: ", show(x), "\nPastillas pequeñas: ", show(y), "\nBeneficio: ", show(beneficio)];

*/







% Ejercicio N°6.

/*

int: clases = 7;
int: espacios = 4;

set of int: Cursos = 1..clases;
set of int: Espacios = 1..espacios;

array[Cursos] of var Espacios: c;

constraint c[4] < c[6];
constraint c[5] < c[7];
constraint c[6] < c[2];
constraint c[1] != c[2] /\ c[1] != c[3] /\ c[1] != c[4] /\ c[1] != c[7];
constraint c[2] != c[3] /\ c[2] != c[6];
constraint c[3] != c[4] /\ c[3] != c[5] /\ c[3] != c[6];
constraint c[4] != c[5] /\ c[4] != c[6]; 
constraint c[5] != c[7];
constraint forall(e in Espacios) (
    sum([bool2int(c[i] = e) | i in Cursos]) <= 2
);

solve satisfy;

output ["Cursos asignados a espacios:\n"] ++ [ show(i) ++ " -> Espacio " ++ show(c[i]) ++ "\n" | i in Cursos];

*/







% Ejercicio N°7.

/*

int: N;

set of int: Valores = 1..N*N;

array[1..N, 1..N] of var Valores: cuadrado;

int: S = (N * (N*N + 1)) div 2;

constraint forall(i in 1..N)(
    sum(j in 1..N)(cuadrado[i,j]) = S);

constraint forall(j in 1..N)(
    sum(i in 1..N)(cuadrado[i,j]) = S
);

constraint sum(i in 1..N)(cuadrado[i,i]) = S;
constraint sum(i in 1..N)(cuadrado[i,N-i+1]) = S;

array[Valores] of var bool: used;

constraint forall(k in Valores)(
    sum(i in 1..N, j in 1..N)(bool2int(cuadrado[i,j] = k)) = 1
);

solve satisfy;

output [ if j = 1 then "\n" else "" endif ++ show(cuadrado[i,j]) ++ " " | i in 1..N, j in 1..N ];


*/








% Ejercicio N°8.

/*
int: M;
array[1..M, 1..M] of var 1..M: matriz;

constraint
  forall(f in 2..M, c in 1..M)(matriz[f,c] = M -> matriz[f-1,c] = 1) /\
  forall(f in 1..M, c in 2..M-1)(matriz[f,c] mod 2 = 0 -> matriz[f,c-1] = matriz[f,c] - 1 /\ matriz[f,c+1] = matriz[f,c] + 1) /\
  forall(v in 1..M)(sum(f in 1..M, c in 1..M)(matriz[f,c] = v) >= 2);

solve satisfy;

*/










