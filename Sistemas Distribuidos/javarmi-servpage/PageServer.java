// Programa Java com RMI
// PageServer.java - Classe servidora de paginas (implementacao do objeto servidor)
//-------------------------------------------------------------

import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;


// Classe servidora de metodos remotos
public class PageServer implements Page { 
  static final int MAXPAG = 5;

  int[] pages = new int[MAXPAG]; // Vetor de paginas
  int free = MAXPAG;

  // Construtor
  public PageServer() {
    int i;
    for (i=0; i<MAXPAG; i++)
      pages[i] = i+1; // Inicia o vetor de paginas
  }

  // Requisicao de uma pagina
  public synchronized int request () {
     try {
       while (free==0)
         wait();
     }
     catch (InterruptedException e) {
       System.out.println ("Erro na obtencao de pagina!");
       return -1;
     }
     free--;
     return (pages[free]);
  }

  // Liberaracao de uma pagina
  public synchronized void release (int id) {
     pages[free] = id;
     free++;
     notify();
  }

  // Funcao principal
  public static void main(String args[]) {
     try {
        PageServer obj = new PageServer();
        Page stub = (Page) UnicastRemoteObject.exportObject(obj, 0);

        // Vincula o stub do objeto remoto ao servico de registro
        Registry registry = LocateRegistry.getRegistry();
        registry.bind("Page", stub);

        System.err.println("Servidor de paginas pronto!");
     } catch (Exception e) {
        System.err.println("Erro servidor de paginas!: " + e.toString());
        e.printStackTrace();
     }
  }
}

