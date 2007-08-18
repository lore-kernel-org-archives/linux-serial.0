From: "Keith Bannister" <keith.bannister@gmail.com>
Subject: TIOCMIWAIT doesn't release on RNG interrupts (16550A)
Date: Sat, 18 Aug 2007 17:32:15 +0100
Message-ID: <e44ae5e0708180932h18e7f952u8b7ef5f9d89f603b@mail.gmail.com>
Reply-To: k.bannister@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:22405 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545AbXHRQcS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 18 Aug 2007 12:32:18 -0400
Received: by nf-out-0910.google.com with SMTP id g13so440132nfb
        for <linux-serial@vger.kernel.org>; Sat, 18 Aug 2007 09:32:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi there,

I'm a bit new to serial programming, so here goes.

I'm trying to count the number of times the RNG line gets asserted.
I'm using an 16550A UART and have written the program below to wait
for an interrupt on the RNG using TIOCMIWAIT line, and query the
interrupt count using TIOCGICOUNT.

When I cat /proc/tty/driver/serial I can see the RNG line being
asserted (with a signal generator, once per second) on ttyS1 on IRQ3.
So my hardware seems fine.

I'm not interested in transmitting or receiving data.

The problem is:
1. When I start my program it hangs waiting on the ioctl(TIOCMIWAIT)
even when the RNG line is asserted and de-asserted.

2. When I cat /proc/tty/driver/serial my program comes out
ioctl(TIOCMIWAIT) immediately, if there has been an assertion on the
hardware. The RNG interrupt count returned by ioctl(TIOCGICOUNT)
increases by one every time my program comes out of the
ioctl(TIOCMIWAIT) and *NOT* what i expected: I.e. the number of times
RNG has been asserted.

How do I get my program to come out of the ioctl(TIOCMIWAIT) whenever
the hardware is asserted?

How do I get ioctl(TIOCGICOUNT) to return the number of hardware interrupts?

What have I done wrong?

It's an FC5 distribution (2.6.16)

Program below:

counter.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/serial.h>
#include <sys/ioctl.h>
#include <time.h>
#include <unistd.h>
#include <linux/tty.h>


int dev;

int wait_for_interrupt()
{
	unsigned long flags = TIOCM_RNG|TIOCM_SR|TIOCM_CD|TIOCM_CTS;

	if ((ioctl(dev, TIOCMIWAIT, flags)) < 0) {
		perror("Could not wait for interrupt");
		return -1;
	}
	
	return 0;
}

int setup_port() {
	struct termios tio
	
	bzero(&tio, sizeof(struct termios));
	
	tio.c_cflag = B9600 | CS8 | CRTSCTS | CREAD ;	
	tio.c_iflag = IGNPAR | ICRNL;	
	tio.c_oflag = 0;	
	tio.c_lflag = ICANON;
	
	if (tcflush(dev, TCIFLUSH) < 0) {
		perror("Couldn't flush");
	}
	if (tcsetattr(dev, TCSANOW, &tio) < 0) {
		perror("Couldn't set attr");
	}	
	
	return 0;
}

int main(int argc, char *argv[])
{
	const char devname[] = "/dev/ttyS1";
	
	if ((dev = open(devname, O_RDWR | O_NOCTTY)) < 0) {
			perror("Could not open device\n");
			exit(1);
	}

	setup_port();
	
	while(1) {
		
		struct serial_icounter_struct icount;
		wait_for_interrupt();
		
		bzero(&icount, sizeof (struct serial_icounter_struct));
		if (ioctl(dev, TIOCGICOUNT, &icount) < 0) {
			perror("Could not get icount");
		}			
			
		printf("cts %d, dsr %d, rng %d, dcd %d\n",
			icount.cts, icount.dsr, icount.rng, icount.dcd);
		
	}
	
	close(dev);
	
	return 0;	
}

-- 
Keith Bannister
