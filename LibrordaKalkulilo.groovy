class Ejo {
   private LinkedList<Integer> nombroj = new LinkedList()
   private LinkedList<String> agoj = new LinkedList()

   public Ejo(Iterator<String> partoj) {
      while (partoj.hasNext()) {
         final sekva = partoj.next()
         if (sekva == "(") {
            final interna = new Ejo(partoj)
            final rezulto = interna.kalkuli()
            nombroj.add(rezulto)
            continue
         } else if (sekva == ")") {
            break
         }

         try {
            final nombro = sekva as int
            nombroj.add(nombro)
         } catch (Exception e) {
            agoj.add(sekva)
         }
      }
   }

   public int kalkuli() {
      var rezulto = nombroj.poll()
      agoj.each { ago ->
         switch (ago) {
            case "+":
               final sekva = nombroj.poll()
               rezulto += sekva
               break
            case "-":
               final sekva = nombroj.poll()
               rezulto -= sekva
               break
         }
      }
      return rezulto
   }
}

final input = System.console().readLine("Eniro: ")
final partoj = input.split(' ')

println(new Ejo(partoj.iterator()).kalkuli())