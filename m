From: Lawrence Rust <lawrence@softsystem.co.uk>
Subject: BUG REPORT: 8250 serial driver tcsetattr / TIOCMIWAIT interaction
Date: Fri, 28 Nov 2008 11:05:26 +0100
Message-ID: <200811281105.26477.lawrence@softsystem.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from asmtp1.iomartmail.com ([62.128.201.248]:47174 "EHLO
	asmtp1.iomartmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbYK1KqJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Nov 2008 05:46:09 -0500
Received: from asmtp1.iomartmail.com (localhost.localdomain [127.0.0.1])
	by asmtp1.iomartmail.com (8.12.11.20060308/8.12.8) with ESMTP id mASA5cLi031760
	for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2008 10:05:39 GMT
Received: from collins.softsystem.co.uk (149.79.193-77.rev.gaoland.net [77.193.79.149])
	(authenticated bits=0)
	by asmtp1.iomartmail.com (8.12.11.20060308/8.12.11) with ESMTP id mASA5c2t031754
	for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2008 10:05:38 GMT
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

[1.] Calling tcsetattr prevents any thread suspended in ioctl TIOCMIWAIT from 
ever resuming.

[2.] If a thread is suspended inside a call to ioctl TIOCMIWAIT, waiting for a 
modem status change, the 8250 driver enables modem status interrupts.  The 
modem status interrupt service routine resumes the suspended thread on the 
next modem status irq.

If in the mean time, another thread calls tcsetattr then the 8250 driver 
disables modem status interrupts (unless CTS/RTS handshaking is enabled).  
This prevents the suspended thread from ever being resumed.

[3.] Keywords serial, 8250

[4.] Kernel 2.6.24-21

[4.1.] cat /proc/version: Linux version 2.6.24-21-lvr (root@Collins) (gcc 
version 4.2.3 (Ubuntu 4.2.3-2ubuntu7)) #2 Wed Oct 22 19:42:04 CEST 2008

[7.] Example C program to demonstrate:
/* gcc -o test test.c -l pthread */
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <pthread.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <linux/serial.h>

static void* monitor( void* pv);
static int s_fd;

int main( void)
  {
  const char kszDev[] = "/dev/ttyS0";
  pthread_t t;
  struct termios tio;

  s_fd = open( kszDev, O_RDWR | O_NONBLOCK);
  if ( s_fd < 0)
    return fprintf( stderr, "Error(%d) opening %s: %s\n", errno, kszDev, 
strerror( errno)), 1;

  pthread_create( &t, NULL, &monitor, NULL);

  /* Modem status changes seen here */
  sleep( 5);

  tcgetattr( s_fd, &tio);
  tio.c_cflag ^= CSTOPB;

  /* But not after here */
  puts( "Main: tcsetattr");
  tcsetattr( s_fd, TCSANOW, &tio);

  for (;;)
    sleep( 1);
  }

static void* monitor( void* pv)
  {
  (void)pv;
  for(;;)
    {
    unsigned uModem;
    struct serial_icounter_struct cnt;

    if ( ioctl( s_fd, TIOCMGET, &uModem) < 0)
      fprintf( stderr, "Error(%d) in TIOCMGET: %s\n", errno, strerror( 
errno));
    printf( "Modem status:%s%s%s%s%s%s\n",
      (uModem & TIOCM_RTS) ? " RTS" : "",
      (uModem & TIOCM_DTR) ? " DTR" : "",
      (uModem & TIOCM_CTS) ? " CTS" : "",
      (uModem & TIOCM_DSR) ? " DSR" : "",
      (uModem & TIOCM_CD) ? " CD" : "",
      (uModem & TIOCM_RI) ? " RI" : ""
    );

    if ( ioctl( s_fd, TIOCGICOUNT, &cnt) < 0)
      fprintf( stderr, "Error(%d) in TIOCGICOUNT: %s\n", errno, strerror( 
errno));
    printf( "Irqs: CTS:%d DSR:%d RNG:%d DCD:%d Rx:%d Tx:%d Frame:%d Orun:%d 
Par:%d Brk:%d Oflow:%d\n",
      cnt.cts, cnt.dsr, cnt.rng, cnt.dcd,
      cnt.rx, cnt.tx, cnt.frame, cnt.overrun, cnt.parity,
      cnt.brk, cnt.buf_overrun
    );

    fputs( "Waiting...", stdout), fflush( stdout);
    if ( 0 > ioctl( s_fd, TIOCMIWAIT, (unsigned long)(TIOCM_CAR | TIOCM_RNG | 
TIOCM_DSR | TIOCM_CTS)))
      fprintf( stderr, "\nError(%d) in TIOCMIWAIT: %s\n", errno, strerror( 
errno));
    fputs( "\n", stdout);
    }
  return NULL;
  }

[8.] 8250.c line 2112:
	/*
	 * CTS flow control flag and modem status interrupts
	 */
	up->ier &= ~UART_IER_MSI;
	if (!(up->bugs & UART_BUG_NOMSR) &&
			UART_ENABLE_MS(&up->port, termios->c_cflag))
		up->ier |= UART_IER_MSI;

This code disables the MS irq.  Should take into account if 
up->port.info->delta_msr_wait is in use.

-- Lawrence Rust
