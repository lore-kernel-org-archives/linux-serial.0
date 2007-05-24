From: kees <kees@schoen.mine.nu>
Subject: [PATCH]  drivers/serial
Date: Thu, 24 May 2007 20:31:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705242019320.16298@schoen3.schoen.mine.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp14.wxs.nl ([195.121.247.5]:65287 "EHLO smtp14.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbXEXSbv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 May 2007 14:31:51 -0400
Received: from schoen3.schoen.mine.nu
 (ip5457f49a.direct-adsl.nl [84.87.244.154])
 by smtp14.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14
 2006)) with ESMTP id <0JIK00CD9652BU@smtp14.wxs.nl> for
 linux-serial@vger.kernel.org; Thu, 24 May 2007 20:31:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by schoen3.schoen.mine.nu
 (Postfix on SuSE Linux 7.2 (i386)) with ESMTP id 9C5972CEDE	for
 <linux-serial@vger.kernel.org>; Thu, 24 May 2007 20:31:59 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I have been hit by bugs in the serialdriver _and_ some chipsets
Some chips (NETMOS 9835) hold their TEMT bit in the LSR somewhat longer
after data is written in the THR. This patch solves that for all.

Furthermore the setserial does not pass tx_loadsz properly the the driver
settings. This patch solves that for the 8250/165xx type devices.

There is still a serious problem in serial_core.c with respect to the 
setserial functionality. It does not properly update the tx_loadsz and the 
fifosize parameters for the new setting. It _does_ update the type 
correctly.


ioctl(hartfd.fd,TIOCSERGETLSR , &parm);

return the proper status.



--- drivers/serial/8250.c.org   2007-05-11 13:24: 42.000000000 +0200
+++ drivers/serial/8250.c       2007-05-16 13:37:57.000000000 +0200
@@ -108,6 +108,7 @@ static const struct old_serial_port old_
  };

  #define UART_NR        CONFIG_SERIAL_8250_NR_UARTS
+#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)

  #ifdef CONFIG_SERIAL_8250_RSA

@@ -1139,7 +1140,7 @@ static void serial8250_start_tx(struct u
                         unsigned char lsr, iir;
                         lsr = serial_in(up, UART_LSR);
                         iir = serial_in(up, UART_IIR);
-                       if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT)
+                       if (((lsr & BOTH_EMPTY) == BOTH_EMPTY) && iir & 
UART_IIR
_NO_INT)
                                 transmit_chars(up);
                 }
         }
@@ -1267,7 +1268,7 @@ static void transmit_chars(struct uart_8
                 return;
         }

-       count = up->tx_loadsz;
+       count = uart_config[up->port.type].tx_loadsz;
         do {
                 serial_out(up, UART_TX, xmit->buf[xmit->tail]);
                 xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -1475,7 +1476,7 @@ static unsigned int serial8250_tx_empty(
         unsigned int ret;

         spin_lock_irqsave(&up-> port.lock, flags);
-       ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+       ret = ((serial_in(up, UART_LSR) & BOTH_EMPTY) == BOTH_EMPTY) ? 
TIOCSER_T
EMT : 0;
         spin_unlock_irqrestore(&up-> port.lock, flags);

         return ret;
@@ -1654,7 +1655,7 @@ static int serial8250_startup(struct uar
         iir = serial_in(up, UART_IIR);
         serial_outp(up, UART_IER, 0);

-       if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
+       if (((lsr & BOTH_EMPTY) == BOTH_EMPTY) && iir & UART_IIR_NO_INT) {
                 if (!(up->bugs & UART_BUG_TXEN)) {
                         up->bugs |= UART_BUG_TXEN;
                         pr_debug("ttyS%d - enabling bad tx status 
workarounds\n"
,
@@ -1810,7 +1811,8 @@ serial8250_set_termios(struct uart_port
         if (up->bugs & UART_BUG_QUOT && (quot & 0xff) == 0)
                 quot ++;

-       if (up->capabilities & UART_CAP_FIFO && up-> port.fifosize > 1) {
+       if (up->capabilities & UART_CAP_FIFO &&
+               uart_config[up->port.type].fifo_size > 1) {
                 if (baud < 2400)
                         fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
                 else
@@ -1825,7 +1827,8 @@ serial8250_set_termios(struct uart_port
          * have sufficient FIFO entries for the latency of the remote
          * UART to respond.  IOW, at least 32 bytes of FIFO.
          */
-       if (up->capabilities & UART_CAP_AFE && up->port.fifosize >= 32) {
+       if (up->capabilities & UART_CAP_AFE &&
+               uart_config[up->port.type ].fifo_size >= 32) {
                 up->mcr &= ~UART_MCR_AFE;
                 if (termios->c_cflag & CRTSCTS)
                         up->mcr |= UART_MCR_AFE;
@@ -2208,7 +2211,6 @@ serial8250_register_ports(struct uart_dr

  #ifdef CONFIG_SERIAL_8250_CONSOLE

-#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)

  /*
   *     Wait for transmitter & holding register to empty



regards

Kees
