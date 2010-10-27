From: Lawrence Rust <lvr@softsystem.co.uk>
Subject: [PATCH] 8250: Fix tcsetattr to avoid ioctl(TIOCMIWAIT) hang
Date: Wed, 27 Oct 2010 14:41:02 +0200
Message-ID: <1288183262.1359.59.camel@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp23.services.sfr.fr ([93.17.128.22]:6715 "EHLO
	smtp23.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846Ab0J0MlF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Oct 2010 08:41:05 -0400
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2301.sfr.fr (SMTP Server) with ESMTP id 7E6127000092
	for <linux-serial@vger.kernel.org>; Wed, 27 Oct 2010 14:41:03 +0200 (CEST)
Received: from smtp-in.softsystem.co.uk (174.116.200-77.rev.gaoland.net [77.200.116.174])
	by msfrf2301.sfr.fr (SMTP Server) with SMTP id 2DC667000091
	for <linux-serial@vger.kernel.org>; Wed, 27 Oct 2010 14:41:03 +0200 (CEST)
Received: FROM [192.168.1.62] (gagarin [192.168.1.62])
	BY smtp-in.softsystem.co.uk [77.200.116.174] (SoftMail 1.0.5, www.softsystem.co.uk) WITH ESMTP
	FOR <linux-serial@vger.kernel.org>; Wed, 27 Oct 2010 14:41:02 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Calling tcsetattr prevents any thread(s) currently suspended in ioctl
TIOCMIWAIT for the same device from ever resuming.

If a thread is suspended inside a call to ioctl TIOCMIWAIT, waiting for
a modem status change, then the 8250 driver enables modem status
interrupts (MSI).  The device interrupt service routine resumes the
suspended thread(s) on the next MSI.

If while the thread(s) are suspended, another thread calls tcsetattr
then the 8250 driver disables MSI (unless CTS/RTS handshaking is
enabled) thus preventing the suspended thread(s) from ever being
resumed.

This patch only disables MSI in tcsetattr handling if there are no
suspended threads.

Signed-off by Lawrence Rust <lawrence (at) softsystem.co.uk>

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 09ef570..3ce92fc 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2336,8 +2336,11 @@ serial8250_set_termios(struct uart_port *port,
struct ktermios *termios,
 
 	/*
 	 * CTS flow control flag and modem status interrupts
+	 * NB Only disable MSI if no threads are waiting in
+	 * serial_core::uart_wait_modem_status
 	 */
-	up->ier &= ~UART_IER_MSI;
+	if (!waitqueue_active(&up->port.state->port.delta_msr_wait))
+		up->ier &= ~UART_IER_MSI;
 	if (!(up->bugs & UART_BUG_NOMSR) &&
 			UART_ENABLE_MS(&up->port, termios->c_cflag))
 		up->ier |= UART_IER_MSI;


Program to demonstrate bug & fix:

/* gcc miwait.c -o miwait -l pthread */
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
    return fprintf( stderr, "Error(%d) opening %s: %s\n", errno, kszDev, strerror( errno)), 1;

  pthread_create( &t, NULL, &monitor, NULL);

  /* Modem status changes seen here */
  puts( "Main: awaiting status changes");
  sleep( 5);

  tcgetattr( s_fd, &tio);
  tio.c_cflag ^= CSTOPB;

  /* But not after here */
  puts( "Main: tcsetattr called");
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
      fprintf( stderr, "Error(%d) in TIOCMGET: %s\n", errno, strerror( errno));
    printf( "Modem status:%s%s%s%s%s%s\n",
      (uModem & TIOCM_RTS) ? " RTS" : "",
      (uModem & TIOCM_DTR) ? " DTR" : "",
      (uModem & TIOCM_CTS) ? " CTS" : "",
      (uModem & TIOCM_DSR) ? " DSR" : "",
      (uModem & TIOCM_CD) ? " CD" : "",
      (uModem & TIOCM_RI) ? " RI" : ""
    );

    if ( ioctl( s_fd, TIOCGICOUNT, &cnt) < 0)
      fprintf( stderr, "Error(%d) in TIOCGICOUNT: %s\n", errno, strerror( errno));
    printf( "Irqs: CTS:%d DSR:%d RNG:%d DCD:%d Rx:%d Tx:%d Frame:%d Orun:%d Par:%d Brk:%d Oflow:%d\n",
      cnt.cts, cnt.dsr, cnt.rng, cnt.dcd,
      cnt.rx, cnt.tx, cnt.frame, cnt.overrun, cnt.parity,
      cnt.brk, cnt.buf_overrun
    );

    fputs( "Waiting...", stdout), fflush( stdout);
    if ( 0 > ioctl( s_fd, TIOCMIWAIT, (unsigned long)(TIOCM_CAR | TIOCM_RNG | TIOCM_DSR | TIOCM_CTS)))
      fprintf( stderr, "\nError(%d) in TIOCMIWAIT: %s\n", errno, strerror( errno));
    fputs( "\n", stdout);
    }
  return NULL;
  }




