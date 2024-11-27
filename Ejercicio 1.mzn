int: n_disciplinas = 4;
int: n_participantes = 6;
int: n_lugares = 2;
array[1..n_disciplinas] of int: duracion = [2, 3, 1, 2];

% Variables
array[1..n_disciplinas] of var 0..10: D;    % Horarios de inicio
array[1..n_disciplinas] of var 1..n_lugares: L;   % Lugares
array[1..n_disciplinas, 1..n_participantes] of var 0..1: P;  % Asignación de participantes

% Restricciones

% Las disciplinas no pueden superponerse en el mismo lugar o para el mismo participante
constraint forall(i, j in 1..n_disciplinas where i != j) (
    (D[i] + duracion[i] <= D[j] \/ D[j] + duracion[j] <= D[i]) \/ (L[i] != L[j])
);

% Los participantes no pueden estar en dos disciplinas simultáneamente
constraint forall(p in 1..n_participantes, i, j in 1..n_disciplinas where i != j) (
    (D[i] + duracion[i] <= D[j] \/ D[j] + duracion[j] <= D[i]) \/ (P[i,p] == 0 \/ P[j,p] == 0)
);

% Capacidad de los lugares
constraint sum([duracion[i] | i in 1..n_disciplinas where L[i] == 1]) <= 5;  % Capacidad de L1
constraint sum([duracion[i] | i in 1..n_disciplinas where L[i] == 2]) <= 6;  % Capacidad de L2

% Asegurar que todos los participantes estén asignados a alguna disciplina
constraint forall(p in 1..n_participantes) (
    sum([P[i, p] | i in 1..n_disciplinas]) == 1
);

% Asegurar que cada disciplina tenga al menos un participante
constraint forall(i in 1..n_disciplinas) (
    sum([P[i, j] | j in 1..n_participantes]) >= 1
);

% Los horarios deben ir en orden creciente (las disciplinas no se solapan)
constraint forall(i in 1..n_disciplinas-1)(
    D[i] + duracion[i] <= D[i+1]
);


var int: makespan = max([D[i] + duracion[i] | i in 1..n_disciplinas]);


% Minimizar el makespan
solve minimize makespan;

% Salida
output ["Horarios: \(D)\n", "Lugares: \(L)\n", "Participantes: \(P)\n", "Makespan: \(makespan)\n"];
