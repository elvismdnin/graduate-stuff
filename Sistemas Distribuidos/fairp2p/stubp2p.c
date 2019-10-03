/* Application to experiment the FairP2P module */

#include "fairp2p.h"

#define SENDPORT 3000
#define RECVPORT 4000

// !!! Must be implemented to handle the indication event !!!
void fp2pDelivery (char *src, char *msg) {
  sbp2pDelivery (src, msg);
}   

int main(int argc, char **argv) {
  char msg[BUFSIZE];
  pthread_t tid; 
 
  if(argc < 2) 
     error("Digite <p1> <ip dest>");

  tid = fp2pInit(SENDPORT, RECVPORT);

  for(int i=0;i<20; i++) {
     sprintf(msg, "Msg: %d", i);
     fp2pSend(argv[1], msg);
  }

  pthread_join(tid, NULL);
}

// !!! Must be implemented to handle the indication event !!!
void fp2pDelivery (char *src, char *msg) {
  printf("Recebi: %s %s\n", src, msg);
  fp2pSend(src, msg);
}

// main function
int main(int argc, char **argv) {
  pthread_t tid;
  tid = fp2pInit(SENDPORT, RECVPORT);
  pthread_join(tid, NULL);
}
