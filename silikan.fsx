open System

let igiEnSilikanDato(dato: DateTime): int * int * int =
   let diferenco =
      let egalpunkto = DateTime(2018, 1, 1)
      (dato - egalpunkto).Days
   let tagoNombro =
      let egalpunktoNombro = 12018 * 364 + 7 * ((12018 / 5) - (12018 / 40) + (12018 / 400))
      egalpunktoNombro + diferenco

   let jaroj400, restantaj400 =
      let tagojEn400Jaroj = 400 * 364 + 7 * (400 / 5 - 400 / 40 + 1)
      tagoNombro / tagojEn400Jaroj, tagoNombro % tagojEn400Jaroj
   let jaroj40, restantaj40 =
      let tagojEn40Jaroj = 40 * 364 + 7 * (40 / 5 - 1)
      restantaj400 / tagojEn40Jaroj, restantaj400 % tagojEn40Jaroj
   let jaroj5, restantaj5 =
      let tagojEn5Jaroj = 5 * 364 + 7
      restantaj40 / tagojEn5Jaroj, restantaj40 % tagojEn5Jaroj
   let restantaj = restantaj5 / 364
   let tagoj = restantaj5 % 364
   let jaro = jaroj400 * 400 + jaroj40 * 40 + jaroj5 * 5 + Math.Min(restantaj, 5)
   let tagoEnJaro = if restantaj = 6 then 364 + tagoj else tagoj
   let monato = tagoEnJaro / 28
   let tago = tagoEnJaro % 28 + 1
   jaro, Math.Min(monato + 1, 13), if monato = 13 then tago + 28 else tago

let hodiaŭ = DateTime.Today
let jaro, monato, tago = igiEnSilikanDato hodiaŭ
printfn "Hodiaŭ estas %d/%d/%d" jaro monato tago