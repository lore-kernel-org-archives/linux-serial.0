From: Chuck Messenger <chuckm@rochester.rr.com>
Subject: Trouble reading from my serial device (a microcontroller)
Date: Thu, 20 Nov 2003 14:22:52 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <bpj3mo$6th$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:957 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261773AbTKTTkM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2003 14:40:12 -0500
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1AMuew-0001gO-00
	for <linux-serial@vger.kernel.org>; Thu, 20 Nov 2003 20:40:10 +0100
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm unable to read from a serial device under Linux (Mandrake 9.1, 
2.4.21-0.13mdk kernel), but the device works find in Windows.  I'm 
hoping someone can offer me suggestions.

My device is a Basic Stamp microcontroller, which I've programmed to 
spit out a certain byte continuously -- 0x40 -- at 38400 baud,n,8,1. The 
device loops RTS back to DSR (i.e. it connects pins 6 and 7 of the 9-pin 
serial connector -- DSR and RTS).  Other than that, only Rx and Tx are 
connected (and ground, of course).

I know the hardware works (both controller and PC), because I can boot 
Win2k on the same machine and run a short program I wrote which 
continuously dumps to the console whatever comes in.

Also, I know that things are _basically_ configured right, in my Linux 
boot, since I can run "statserial /dev/tts/0", which shows, in real 
time, the status of the DSR line.  When I unplug from my device, DSR 
goes low; when I plug it back in, DSR goes high.

I tried writing a simple port-dumping program on Linux, based on Peter 
Baumann's sample in his Serial Programming Howto:

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <stdio.h>

#define BAUDRATE B38400
#define MODEMDEVICE "/dev/tts/0"
#define _POSIX_SOURCE 1 /* POSIX compliant source */

int
main()
{
     int fd,c, res;
     struct termios oldtio,newtio;

     fd = open(MODEMDEVICE, O_RDWR | O_NOCTTY );

     if (fd < 0) {
         perror(MODEMDEVICE);
         exit(-1);
     }

     tcgetattr(fd, &oldtio); /* save current port settings */

     memset(&newtio, 0, sizeof(newtio));

     newtio.c_cflag = BAUDRATE | /*CRTSCTS |*/ CS8 | CLOCAL | CREAD;
     newtio.c_iflag = IGNPAR   // ignore parity errors
                    | IGNBRK;  // ignore BREAK characters
     newtio.c_oflag = 0;

     /* set input mode (non-canonical, no echo,...) */

     newtio.c_lflag = 0;

     newtio.c_cc[VTIME]    = 0;   /* inter-character timer unused */
     newtio.c_cc[VMIN]     = 1;   /* blocking read until 1 chars received */

     tcflush(fd, TCIFLUSH);       // Flush an data received by not read
     tcsetattr(fd,TCSANOW,&newtio);

     while (1) {       /* loop for input */
         char buf[1];
         res = read(fd,buf,1);   /* returns after 1 chars have been input */
         printf("%02x ", buf[0]);
         fflush(stdout);
     }

     tcsetattr(fd,TCSANOW,&oldtio);

     return 0;
}


However, the program fails to read any bytes -- it hangs at the read().

I've tried running serlook, but that, too, failed to see any bytes.

Any suggestions?

I've tried 9600 baud instead of 38400 -- still no luck (although it 
works under Win2k).

Poking around, I've seen mention of the DCD control line -- could that 
be the problem (i.e. does the Linux serial driver require it, somehow? 
I don't have it hooked up.)


     - Chuck Messenger


