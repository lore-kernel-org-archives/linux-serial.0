From: =?iso-8859-1?q?Felix=20Theodor?= <felix_theodor@yahoo.de>
Subject: serial programming
Date: Mon, 19 Jan 2004 09:08:06 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040119080806.72608.qmail@web86103.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web86103.mail.ukl.yahoo.com ([217.12.12.48]:10130 "HELO
	web86103.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264452AbUASIIH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Jan 2004 03:08:07 -0500
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

hello,

can someone help me?
I try to write a programm to read Datas from the
serial port.
But some how it doesnt read all the datas in one time.
So I'm very confusing. 

Please help me.

Thank you in advance.

felix

--------------------------------------------------------------


here is my source:

#include <signal.h>
#include <sys/time.h>

#include <stdlib.h> 
#include <unistd.h> 
#include <fcntl.h> 
#include <termios.h> 
#include <stdio.h>
#include <time.h>
#include <errno.h>
#include <string.h>

#include <assert.h>

#include <sys/stat.h>
#include <sys/types.h>

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#include <sys/wait.h>
#include <syslog.h>


unsigned char buffer[256];	// Receive buffer

int fdResult=0;			// COM file descriptor

int sResultE=0;			// Receive result


//
-------------------------------------------------------------------------
// COM Port oeffnen   
//
-------------------------------------------------------------------------
//
//
int open_port () 
{ 

 struct termios options, oldtio; 
  
 int fd; 
   
 fd = open ("/dev/ttyS0",O_RDWR | O_NOCTTY |
O_NONBLOCK ); 
   

 if (fd < 0)  
 { 
  fprintf(stderr, "Open_port: unable to open
/dev/ttyS0\n"); 
  exit (1);  
 } 
 else
   fcntl (fd, F_SETFL, 0);   
 
 tcgetattr (fd, &options); 	
 
 cfsetispeed (&options, B19200); 	
 cfsetospeed (&options, B19200); 	
   
 options.c_cflag |= CSTOPB; 		
 
 options.c_cflag &= ~CSIZE;
 options.c_cflag |= CS8;   

 options.c_cflag &= ~PARENB;
 
 options.c_iflag = IGNPAR;
 options.c_oflag = 0;
 options.c_lflag = 0;
 
 options.c_cc[VMIN]=3;
 options.c_cc[VTIME]=0;
 
 tcflush(fd, TCIFLUSH);
 tcsetattr (fd, TCSAFLUSH, &options);
  
 return fd; 
}

//
-------------------------------------------------------------------------
//    
//
-------------------------------------------------------------------------
//
//
unsigned char receive_datas (unsigned char * buffer) 
{ 
  int iInput=0;
  
  memset(buffer,0,256);
  
  iInput=read(fdResult, buffer,256);   
     
  return iInput; 
}

//
-------------------------------------------------------------------------
//    
//
-------------------------------------------------------------------------
//
//
int writeData (unsigned char *wert, int laenge) 
{ 
 
    int iOut,i;    
    unsigned char *p;
    
    p=wert;
    
    printf("WERTE: ");
    for(i=0;i<laenge;i++)    
    {         
	 printf(" (%d)%X ",i,*p);
	 p++;
    } 
    printf("\n\n");
    
        
    // wert=p;            
    
    iOut = write(fdResult, wert, laenge);

    if (iOut < 0)
    {
        printf("write error %d %s\n", errno,
strerror(errno));
    }
        
  return iOut; 
}



//
-------------------------------------------------------------------------
// 
//
-------------------------------------------------------------------------
//
//
int main()
{

  int i=0;
  
  system("clear");
  
  fdResult=open_port();		// open COM port
  
  while(1)
  {
     sResultE=receive_datas(&buffer[0]);
   
     if(sResultE>0)
     {      
      printf("\nReceive (%d): ",sResultE);
      for(i=0;i<sResultE;i++)
      { 
        printf(" %X ",buffer[i]);
      }
      printf("<-\n");
     }     

  }
  
}



.....Runing.....

Receive (8):  2  FF  11  FA  1  31  5  1 <-

Receive (24):  4  0  0  0  0  0  0  B  10  7  1  1  10
 13  15  10  15  10  15  10  15  10  10  1 <-

Receive (16):  10  13  1F  2  0  0  0  0  0  0  0  0 
0  0  0  0 <-

Receive (10):  0  0  0  0  0  0  0  3  C  72 <-




__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Mit Yahoo! Suche finden Sie alles: http://suche.yahoo.de
