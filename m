From: Dick Hollenbeck <dick@softplc.com>
Subject: PROBLEM: serial port FIONREAD from realtime thread
Date: Tue, 22 Nov 2005 11:03:44 -0600
Message-ID: <43834F70.4010404@softplc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ylpvm25-ext.prodigy.net ([207.115.57.56]:17580 "EHLO
	ylpvm25.prodigy.net") by vger.kernel.org with ESMTP id S964996AbVKVRBx
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Nov 2005 12:01:53 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

Problem Conditions:

1) linux 2.6.11.7, but possibly other kernels too
1) realtime thread
2) serial port open()ed *either* with NON_BLOCKING or not
3) ioctl( FIONREAD ) always returns zero

int ncharin;
ioctl( fd, FIONREAD, &ncharin )

The above lines of code operate incorrectly from a real time thread 
against a normal PC serial port.  The "ncharin" is always set to zero if 
called from a loop.  The work around is to block the calling realtime 
thread with a sleep of some kind.  That workaround is ugly.  We need 
this to work from a realtime thread.

The program below illustrates the problem, but requires two computers.  
On one computer run minicom and connect an RS-232 cross over cable to 
the test box (at COM2, per the test source).  Compile and run the 
program below on the test box.  On the 2nd computer, say a non-test box, 
run minicom at 38400 kbaud to match the baudrate in the test box and 
program below.  Run the test program as root so it can escalate the 
priority to realtime.  Minicom should be used to send chars to the test 
program during the 20 seconds that the test program runs.

Test program will only run for 20 seconds.  While it's running, you 
should send characters from minicom to the test box and you will see the 
buffered count of characters increment by 1.  That is how it is supposed 
to work.  Then comment out the usleep() call and recompile and do the 
same test again.  Here you see the test program does not operate 
properly.  The buffered character count remains at 0.

What causes this?   What is the usleep() enabling?

-----------------------------------

#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/serial.h>
#include <sched.h>
#include <time.h>

int fd;

int openPort();
void setRealtimePriority();


int main( int argc, char** argv )
{
   int         ncharin;
   int         last;
   time_t      start;
     if( openPort() != 0 )
   {
       fprintf( stderr, "unable to open port\n" );
       exit(1);
   }
     setRealtimePriority();
     // poll the FIONREAD and print the number of chars in the recv buffers

   start = time(NULL);  
   // run only for 20 seconds, since realtime priority steals cpu from 
consoles.
   while( time(NULL) - start < 20 )
   {
       if( -1 == ioctl( fd, FIONREAD, &ncharin ) )
       {
           printf( "error from ioctl\n" );
           ncharin = 0;
       }

       // if this line is commented out, then ioctl FIONREAD does not work.
       usleep(1);
         if( last != ncharin )
       {
           // this should show a monotonically increasing number of 
characters.
           printf(" %d", ncharin );
                 fflush(stdout);
                     last = ncharin;
       }
   }
}


int openPort()
{
   struct termios     t;

   /*  The O_NDELAY flag tells UNIX that this program doesn't care what
       state the DCD signal line is in - whether the other end of the port
       is up and running. If you do not specify this flag, your process 
will
       be put to sleep until the DCD signal line is the space voltage.
   */
   fd = open( "/dev/ttyS1", O_RDWR
                           | O_NDELAY
                           | O_NOCTTY );

   if( fd == -1 )
       return -1;

   memset( &t, 0, sizeof(t) );

   cfsetispeed( &t, B38400 );
   cfsetospeed( &t, B38400 );

   // Enable the receiver and set local mode...
   //  CLOCAL  : local connection, no modem contol
   //  CREAD   : enable receiving characters
   t.c_cflag |= (CLOCAL | CREAD);

   t.c_cflag &= ~CSTOPB;

   t.c_cflag &= ~CSIZE;    // Mask the character size bits
   t.c_cflag |= CS8;       // Select 8 data bits

   t.c_cflag &= ~PARENB;
   t.c_cflag &= ~CSTOPB;

   // Raw input is unprocessed.
   // Input characters are passed through exactly as they are received,
   // when they are received. Generally you'll deselect the ICANON, ECHO,
   // ECHOE, and ISIG options when using raw input:
   t.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG);

   // Raw output is selected by resetting the OPOST option in the  
c_oflag member:
   t.c_oflag &= ~OPOST;

   t.c_cc[VMIN]  = 1;
   t.c_cc[VTIME] = 0;

   // Set the new options for the port...
   tcsetattr( fd, TCSANOW, &t );

   return 0;
}



void setRealtimePriority()
{
   int ec;

   printf("setRealtimePriority()\n");
     struct sched_param     p;

   memset( &p, 0, sizeof(p) );

   p.sched_priority = 2;

   ec = sched_setscheduler( 0, SCHED_RR, &p );
   if( ec != 0 )
   {
       fprintf(stderr, "pthread_setschedparam ec=%d, %s\n", ec, 
strerror(ec) );
       fflush(stderr);
       exit(2);
   }
}


