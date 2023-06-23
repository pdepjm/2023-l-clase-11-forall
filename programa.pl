% Enunciado de clase
%pariente(Padre, Hijo) -> aridad 2 -> relaciona a un/a padre/madre con un/a hijo/a
pariente(homero, bart).
pariente(homero, lisa).
pariente(homero, maggie).
pariente(marge, bart).
pariente(marge, lisa).
pariente(marge, maggie).
pariente(ned, tod).
pariente(ned, rod).
pariente(abe, homero).
pariente(abe, herbert).

%hermanos(Hermano1, Hermano2).
hermanos(Hermano1, Hermano2):-
    pariente(Pariente, Hermano1),
    pariente(Pariente, Hermano2).

%tio(Tio, Sobrino).
tio(Tio, Sobrino):-
    pariente(Pariente, Sobrino),
    hermanos(Pariente, Tio).

tio(ned, maggie).

%unicoPadre(Hijo) -> no tiene más de uno
unicoPadre(Hijo):-
    pariente(_, Hijo),
    not(tieneMasDeUnPariente(Hijo)).


tieneMasDeUnPariente(Hijo):-
    pariente(Pariente1, Hijo),
    pariente(Pariente2, Hijo),
    Pariente1 \= Pariente2.

% No necesitamos cambiar nada porque por el principio de Universo Cerrado al consultar ya nos daria false.

%quilombero(Persona)
quilombero(bart).
quilombero(homero).

%deportista(Persona)

deportista(rod).
deportista(tod).
deportista(lisa).

%tranqui(Persona).
tranqui(Persona):-
    persona(Persona),
    not(quilombero(Persona)),
    not(deportista(Persona)).

%persona(Persona)
persona(Hijo):-
    pariente(_,Hijo).

persona(Pariente):-
    pariente(Pariente, _).

%esFanDelDeporte(Pariente).
esFanDelDeporte(Pariente):-
    pariente(Pariente, _),
    not(noTieneHijosDeportistas(Pariente)).

noTieneHijosDeportistas(Pariente):-
    pariente(Pariente, Hijo),
    not(deportista(Hijo)).

%Para todo hijo del padre, el hijo es deportista
esFanDelDeporte2(Persona):-
    pariente(Persona, _),
    forall(pariente(Persona, Hijo), deportista(Hijo)).

%noSeBancaHermanos(Persona)
noSeBancaHermanos(Persona):-
    hermanos(Persona, _),
    not(tranqui(Persona)),
    forall(hermanos(Persona, Hermano), tranqui(Hermano)).

%parejaSoniada(Persona, OtraPersona).
%Para todo hijo de UnaPersona -> que sea hijo de OtraPersona
parejaSoniada(UnaPersona, OtraPersona):-
    pariente(UnaPersona, _),
    pariente(OtraPersona, _),
    UnaPersona \= OtraPersona,
    forall(pariente(UnaPersona, Hijo), pariente(OtraPersona, Hijo)).

%forall(Antecedente, Consecuente)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Posible resolución de TP4

viveEnDreadbury(agatha).
viveEnDreadbury(mayordomo).
viveEnDreadbury(charles).

matoA(Asesino, Victima):-
    esOdiadoPor(Asesino, Victima),
    not(esMasRicoQue(Victima, Asesino)),
    viveEnDreadbury(Asesino).

%esOdiadoPor(Odiador, Odiado)
esOdiadoPor(charles, Odiado):-
    viveEnDreadbury(Odiado),
    not(esOdiadoPor(agatha, Odiado)).

esOdiadoPor(agatha, Odiado):-
    viveEnDreadbury(Odiado),
    Odiado \= mayordomo.

esOdiadoPor(mayordomo, Odiado):-
    esOdiadoPor(agatha, Odiado).

%esMasRicoQue(MenosRico, MasRico)
esMasRicoQue(agatha, Alguien):-
    viveEnDreadbury(Alguien),
    not(esOdiadoPor(agatha, Alguien)).

/*
Consultas:

1. ¿Quién mató a la tía Agatha? 
?- matoA(Quien, agatha). 
Quien = agatha

2. ¿Existe alguien que odie a milhouse?
?- esOdiadoPor(_, milhouse).
false

¿A quién odia charles?
?- esOdiadoPor(charles, Quien).
Quien = mayordomo

Nombre de quién odia a tía Agatha
?- esOdiadoPor(Quien, agatha).
Quien = agatha ;
Quien = mayordomo.

Todos los odiadores y sus odiados
?- esOdiadoPor(Odiador, Odiado).
Odiador = charles,
Odiado = mayordomo ;
Odiador = Odiado,
Odiado = agatha ;
Odiador = agatha,
Odiado = charles ;
Odiador = mayordomo,
Odiado = agatha ;
Odiador = mayordomo,
Odiado = charles.

¿Es cierto que el mayordomo odia a alguien?
?- esOdiadoPor(mayordomo, _).
true
*/
