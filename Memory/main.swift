//
//  main.swift
//  Memory
//
//  Created by Oscar Blanco Castan on 1/1/15.
//  Copyright (c) 2015 Oscar Blanco Castan. All rights reserved.
//

import Foundation
import Cocoa

struct CartaSeleccionada{
    var valor:Int = 0
    var fila:Int = 0
    var columna:Int = 0
}

struct Carta{
    var valor:Int = 0
    var encertat:Bool = false
    var escollida:Bool = false
}

struct Jugador{
    var alias:String
    var acerts:Int
    init(alias:String, acerts:Int) {
        self.alias = "Name"
        self.acerts = 0
    }
}

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Carta]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: Carta())
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Carta {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

func getInputString() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    return NSString(data: inputData, encoding:NSUTF8StringEncoding)!
}

func getInputInt() -> Int {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    var string = NSString(data: inputData, encoding:NSUTF8StringEncoding)!
    var number:Int = string.integerValue
    return number
}

func memory(){
    system("clear");
    
    println("        _\\|/_ ");
    println("        (o o) ");
    println("+----oOO-{_}-OOo-------------------------------------------------------------+");
    println("|     /////  /////  ///////  /////  /////  ///////////  ////////   ///   /// |");
    println("|    /// //// ///  ///      /// //// ///  ///     ///  ///   ///  ///   ///  |");
    println("|   ///  //  ///  //////   ///  //  ///  ///     ///  ////////    /// ///    |");
    println("|  ///      ///  ///      ///      ///  ///     ///  /// ///       ///       |");
    println("| ///      ///  ///////  ///      ///  ///////////  ///   ///     ///        |");
    println("+----------------------------------------------------------------------------+");
}

func mostraMarcador(jugador1:Jugador, jugador2:Jugador){
    println("\(jugador1.alias) Acerts: \(jugador1.acerts)")
    println("\(jugador2.alias) Acerts: \(jugador2.acerts)")
}

func mostraTaula(taulell:Matrix, files:Int, columnes:Int, mostrarTot:Bool){
    var i, e :Int
    
    println("    |")
    for (i = 0; i < columnes; ++i){
        print("  \(i) |")
    }
    println("\n");
    for (e = 0; e < columnes+1; ++e){
        print("----*")
    }
    println("\n");
    
    for (i = 0; i < files; ++i){
        for (e = 0; e < columnes; ++e){
            if (e == 0){
                print("  \(i) |")
            }
            if (taulell[i, e].encertat || mostrarTot){
                print(" \(taulell[i, e].valor) |")
            }else if(taulell[i, e].escollida){
                print(" \(taulell[i, e].valor) |")
            }else{
                print("  X |")
            }
        }
        println("\n");
        for (e = 0; e < columnes+1; ++e){
            print("----*")
        }
        println("\n")
    }
}

func mostraPantalla(taulell:Matrix, jugador1:Jugador, jugador2:Jugador, files:Int, columnes:Int, mostrarTot:Bool){
    memory()
    mostraMarcador(jugador1, jugador2)
    mostraTaula(taulell, files, columnes, mostrarTot)
}

func escollirCartes(taulell:Matrix, carta1:CartaSeleccionada, carta2:CartaSeleccionada){
    println("Escolli carta 1")
    print("Linia: ")
    carta1.fila = getInputInt()
    print("Columna: ")
    carta1.columna = getInputInt()
    
    println("Escolli carta 2")
    print("Linia: ")
    carta2.fila = getInputInt()
    print("Columna: ")
    carta2.columna = getInputInt()
    
    carta1.valor = taulell[carta1.fila, carta1.columna]
    carta2.valor = taulell[carta2.fila, carta2.columna]
}

func compararCartes(carta1:CartaSeleccionada, carta2:CartaSeleccionada) -> Bool{
    var encertat:Bool = false
    if(carta1.valor == carta2.valor){
        encertat = true
    }
    return encertat
}

func mostrarGuanyador(jugador1:Jugador, jugador2:Jugador){
    if(jugador1.acerts>jugador2.acerts){
        println("\(jugador1.alias) Has guanyat!!!")
    }
    else if(jugador1.acerts<jugador2.acerts){
        println("\(jugador2.alias) Has guanyat!!!")
    }
    else{
        println("Eu empatat!")
    }
}
func calcularDimensio(numeroParelles:Int) -> (files:Int, columnes:Int){
    var numeroCartes = numeroParelles * 2
    var diferencia = 99
    var files = Int(sqrtf(Float(numeroCartes)))
    var columnes = numeroCartes / files
    
    if (files*columnes != numeroCartes){
        for var i = 0; i < numeroCartes; ++i {
            for var e = 0; e < numeroCartes; ++e {
                if (i*e == numeroCartes){
                    if (diferencia > abs(e-i)){
                        diferencia = abs(e-i)
                        files = i
                        columnes = e
                    }
                }
            }
        }
    }
    
    return (files, columnes)
}

func barrejarCartes(taulell:Matrix, files:Int, columnes:Int, numeroParelles:Int){
    var comptador = 0;
    for j in 0..<files{
        for k in 0..<columnes{
            taulell[j, k].valor == comptador
            taulell[0, 0].valor
            if (comptador==(numeroParelles-1)){
                comptador = -1;
            }
            comptador++;
        }
    }
}

var jugador1:Jugador
var jugador2:Jugador
var numeroParelles:Int

print("Escriu el nom del jugador 1: ")
jugador1.alias = getInputString()

print("Escriu el nom del jugador 2: ")
jugador2.alias = getInputString()

println("\n");
print("Introdueix el numero de parelles: ")
numeroParelles = getInputInt()

while(numeroParelles>51||numeroParelles<3){
    println("Reintrodueix el numero de parelles(Max:50 Min:3): ");
    numeroParelles = getInputInt()
}

let dimensions = calcularDimensio(numeroParelles)
var taulell = Matrix(rows: dimensions.files, columns: dimensions.columnes)
println("Number: \(taulell[0, 0].valor) Encertat: \(taulell[0, 0].encertat) Seleccionat: \(taulell[0, 0].escollida)")
barrejarCartes(taulell, dimensions.files, dimensions.columnes, numeroParelles);

for var j = 0; j < dimensions.files; ++j {
    for var k = 0; k < dimensions.columnes; ++k {
        println("Fila: \(j) Columna: \(k) Number: \(taulell[0, 0].valor) Encertat: \(taulell[0, 0].encertat) Seleccionat: \(taulell[0, 0].escollida)")
    }
}

println("\nA continuacio es mostrara el taullel destapat.\n");
println("\nRecorda que tindras 8 segons per memoritzar les parelles.\n");
system( "read -n 1 -s -p \"\nPrem qualsevol tecla per continuar...\"" );
mostraPantalla(taulell, jugador1, jugador2, dimensions.files, dimensions.columnes, true)
sleep(8);

var torn:Int = 0
while((jugador1.acerts+jugador2.acerts)<numeroParelles){
    memory();
    if (torn == 0){
        println("Es el torn de \(jugador1.alias)")
    }else{
        println("Es el torn de \(jugador2.alias)")
    }
    
    var carta1:CartaSeleccionada
    var carta2:CartaSeleccionada

    mostraPantalla(taulell, jugador1, jugador2, dimensions.files, dimensions.columnes, false)
    escollirCartes(taulell, carta1, carta2);
    
    if(compararCartes(carta1, carta2)){
        println("Encertada!!!");
        taulell[carta1.fila, carta1.columna].encertat = true
        taulell[carta2.fila, carta2.columna].encertat = true
        if (torn == 0){
            jugador1.acerts++
        }else{
            jugador2.acerts++
        }
    }else{
        println("Error!!!");
        taulell[carta1.fila, carta1.columna].escollida = false
        taulell[carta2.fila, carta2.columna].escollida = false
        if(torn == 0){
            torn = 1
        }else{
            torn = 0
        }
    }
    system( "read -n 1 -s -p \"\nPrem qualsevol tecla per continuar...\"" );
}

memory();
mostrarGuanyador(jugador1, jugador2);