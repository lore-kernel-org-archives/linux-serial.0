From: Bahadir Karuv <bahkar@bcacademies.bergen.org>
Subject: Newbie problem
Date: Thu, 25 Apr 2002 11:58:39 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3CC827AE.F7650476@bcacademies.bergen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello All,

I am trying to have to computers communicate over the serial port.
The program below is modified from "Serial Programming Guide for Posix
operating Systems"
I am geting the following output when I send "Testing123" over the
serial port from the second computer


opened 3
just sent Hello
got back - Hello
just sent Hello
got back - HelloTesting123
just sent Hello
got back - Hello

First computer is getting the string echoed back to itself after it
sends "Hello".

What am I doing wrong?

Thanks and regards!




#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <string.h>

int main(void)   /* Serial port */
       {
 time_t tsec;
 int fd;
 struct termios options;
 char buffer[255];
 char *bufptr;
 int  nbytes;
 char *message="Hello";

 /* open the port */
 fd = open("/dev/ttyS0", O_RDWR | O_NOCTTY | O_NDELAY);
 //fcntl(fd, F_SETFL, FNDELAY);
 printf("opened %u\n",fd);
 /* options */
 tcgetattr(fd, &options);
 options.c_cflag     |= (CLOCAL | CREAD);
 options.c_lflag     &= ~(ICANON | ECHO | ECHOE | ISIG);
 options.c_oflag     &= ~OPOST;
 options.c_cc[VMIN]  = 0;
 options.c_cc[VTIME] = 10;
 tcsetattr(fd, TCSANOW, &options);
 /* read characters into our string buffer until CR or NL */
 while(1){
 write(fd, message,strlen(message));
 printf("just sent %s\n",message);
 tsec=time(NULL);
 while(time(NULL)-tsec<1);

 bufptr = buffer;
 buffer[0]='\0';
 while ((nbytes = read(fd, bufptr, bufptr-buffer + sizeof(buffer)-1)) >
0)
 {
  bufptr += nbytes;
  if (bufptr[-1] == '\n' || bufptr[-1] == '\r')
   { printf("break\n");break;}
 }
 if (buffer!=bufptr){
   *(bufptr) = '\0';
   printf("got back - %s\n",buffer);
 }
    }
    close(fd);
}



