From: Culos Alain <Alain.Culos@IAA.ie>
Subject: OT // select
Date: Thu, 22 Aug 2002 18:02:03 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <35AB4BE0295ED411BF4C00508B69B6239D1262@NTMX1BCY>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ntmx1hq.iaa.ie (unverified) by ntserver.iaa.ie
 (Content Technologies SMTPRS 4.2.10) with ESMTP id <T5cdf8c5b0ec27d6b6e110@ntserver.iaa.ie> for <linux-serial@vger.kernel.org>;
 Thu, 22 Aug 2002 18:05:08 +0100
List-Id: linux-serial@vger.kernel.org
To: "'linux-serial@vger.kernel.org'" <linux-serial@vger.kernel.org>

If you are in any doubt about the authenticity of this 
message please contact +353 1 6718655.

Hi All,

This is really off topic, but since I'm doing this in relation to a sample I
got for serial programming, I thought some good souls might be able to help
me out.

My problem is that I compiled and used the stuff below (without all the
unnecessary printf and uncommenting some of the stuff) under Slackware 3.6
(real old stuff) and it worked, but ...
Now I got ahold of RedHat 7.3 and it does not work.

The stuff is supposed to be simple but I can't even understand why it does
not work with RedHat.

I do a select on two fd's for reading and one for exceptions.
I test FD sets and deal with what has to be done.

With RedHat, FD_SET does its job, but apparently select leaves all bits to
1's instead of clearing those non relevant ones like Slackware used to do
and like one would expect.

Anyway, here's the little proggy and an example session (output redirected
to file, comment inserted within parenthesis).

Any comments/help welcome.

Regards,
Alain.

================================

/*
  Compile with :	cc inoutserial.c -o inoutserial
*/

//#include <sys/select.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <stdio.h>

#define BPS B9600
#define SERIALPORT "/dev/ttyS0"		/* COM1 */
#define _POSIX_SOURCE 1			/* POSIX compliant source */
#define FALSE 0
#define TRUE 1


int	CSN = 1;
char	LastDay [3];
char	CurDay [3];


transmit_check_message (int fd)
{
  char CH[]="CH\n\0";

  write (fd, CH, strlen (CH));
}


handle_input_from_stdin (int fd)
{
  int  length;
  char buf[256];

printf("Handle input from stdin\n");
  length	= read (0, buf, 255);
  buf [length]	= 0;
  write (fd, buf, length);
}


handle_input_from_serial (int fd)
{
  int  length;
  char buf[256];

printf("Handle input from serial\nignore serial...\n");
  //length	= read (fd, buf, 255);
  //buf [length]	= 0;
  // normally the two lines above are not commented out
  /*
    we ignore messages otherwise we could print them to a file or something

    printf ("%s", buf);
  */ 
}


main (int argc, char** argv)
{
  int    fd_com;
  fd_set readfs;	/* file descriptor set */
  fd_set exceptfs;	/* file descriptor set */
  int    maxfd;		/* maximum file desciptor used */
  struct termios oldtio, newtio;
  struct timeval timeout;
  //struct timespec timeout;
  time_t now, next_CH;
  int	 interval;
  char*  LINE;


  /* Check number of parameters.
  */
  if (argc < 3)
  {
    fprintf (stderr, "inoutserial must be called with three arguments :\n");
    fprintf (stderr, "\tserial port device name,\n");
    fprintf (stderr, "\tdelay (in seconds).\n");
    fprintf (stderr, "\tLine id.\n");
    fprintf (stderr, "\n");
    exit (-1);
  }


  /* open_input_source opens a device, sets the port correctly, and
     returns a file descriptor
  */
  fd_com = open (argv[1], O_RDWR | O_NOCTTY );
  if (fd_com < 0)
  {
    perror (SERIALPORT);
    exit (-1);
  }


  if (sscanf (argv[2], "%d", &interval) < 1)
  {
    fprintf (stderr, "inoutserial must be called with three arguments :\n");
    fprintf (stderr, "\tserial port device name,\n");
    fprintf (stderr, "\tdelay (in seconds).\n");
    fprintf (stderr, "\tLine id.\n");
    fprintf (stderr, "\n");
    exit (-1);
  }


  CurDay [0]	= ' ';
  CurDay [1]	= ' ';
  CurDay [2]	= 0;
  LastDay [2]	= 0;


  now = time(NULL);
  next_CH = now - (now % interval) - 1;


  /* set port parameters */
  tcgetattr (fd_com,&oldtio); /* save current port settings */

  bzero (&newtio, sizeof (newtio));
  newtio.c_cflag = BPS | CRTSCTS | CS8 | CLOCAL | CREAD;
  newtio.c_iflag = IGNPAR;
  newtio.c_oflag = 0;


  /* set input mode (non-canonical, no echo,...) */
  newtio.c_lflag = 0;

  newtio.c_cc[VTIME]    = 0;   /* inter-character timer unused */
  newtio.c_cc[VMIN]     = 0;   /* non blocking read */

  tcflush (fd_com, TCIFLUSH);
  tcsetattr (fd_com,TCSANOW,&newtio);


  /* prepare Select */
  maxfd = fd_com + 1;  /* maximum bit entry (fd) to test */


  /* loop for input */
  /*
    while (! feof(stdin))
  */
  FD_ZERO (&readfs);
  FD_ZERO (&exceptfs);

  while (! FD_ISSET (0, &exceptfs))
  {
    FD_SET (0, &exceptfs);     /* set testing for exceptions on stdin */
    FD_SET (0, &readfs);       /* set testing for stdin        */
    FD_SET (fd_com, &readfs);  /* set testing for serial input */

    timeout.tv_sec	= next_CH - now;
    //timeout.tv_nsec	= 0;
    timeout.tv_usec	= 0;

    /* block until input becomes available */
printf("select 1 -- reada %d -- readb %d -- except %d\n", FD_ISSET (0,
&readfs), FD_ISSET (fd_com, &readfs), FD_ISSET (0, &exceptfs));

    select (maxfd, &readfs, NULL, &exceptfs, &timeout);
    //pselect (maxfd, &readfs, NULL, &exceptfs, &timeout, NULL);

printf("select 2 -- reada %d -- readb %d -- except %d\n", FD_ISSET (0,
&readfs), FD_ISSET (fd_com, &readfs), FD_ISSET (0, &exceptfs));


    if (FD_ISSET (0, &readfs))		handle_input_from_stdin (fd_com);
    if (FD_ISSET (fd_com, &readfs))	handle_input_from_serial (fd_com);

printf("post FD_ISSET tests\n");
    now = time (NULL);
    if (now >= next_CH)
    {
      transmit_check_message (fd_com);
      next_CH += interval;
    }
printf("Loop\n");
  }
printf("End loop\n");

  tcsetattr (fd_com,TCSANOW,&oldtio);
printf("End program\n");
}

================================
./inoutserial /dev/ttyS0 0 aaa

select 1 -- reada 1 -- readb 1 -- except 1
select 2 -- reada 1 -- readb 1 -- except 1
Handle input from stdin
-- (waits for input ...
--  type new line and here it goes
--  not supposed to do that, Slackware only enters
--  this function if there is input to be read.
-- )
Handle input from serial
ignore serial...
post FD_ISSET tests
Loop
End loop
End program
-- (
--  hangs there waiting forever
--  Slackware also hangs, but that's another matter
-- )
