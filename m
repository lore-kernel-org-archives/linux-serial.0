From: Noam Camus <noamc@ezchip.com>
Subject: RE: 8250_early for big-endian
Date: Mon, 29 Oct 2012 17:38:07 +0200
Message-ID: <264C179F799EF24AB26D5319053335E80CC3001B83@ezexch.ezchip.com>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
	<20121012195102.5781c7d4@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
	<20121012220604.3f99d003@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
	<20121013145212.27f6fcbd@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC3001073@ezexch.ezchip.com>
	<20121014133216.686277e1@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC300184F@ezexch.ezchip.com>
 <20121025121815.0689c196@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ezexch.ezchip.com ([212.179.42.101]:25352 "EHLO
	ezexch.ezchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab2J2Pis convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Oct 2012 11:38:48 -0400
In-Reply-To: <20121025121815.0689c196@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Gilad Ben Yossef <giladb@ezchip.com>

>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
>Sent: Thursday, October 25, 2012 1:18 PM

>If you make the symbols global then they need a prefix to avoid clashes - just rename them something like serial8250_early_in/serial8250_early_out

> and of course they ought to be in the header files somewhere...

Thanks for your comments. I polished my patch and below is the updated.
Please comment on this patch.

>From 0ebe0d2d39d76a1d2983321599e138474f5e96d3 Mon Sep 17 00:00:00 2001
From: Noam Camus <noamc@ezchip.com>
Date: Mon, 29 Oct 2012 17:16:58 +0200
Subject: [PATCH] tty/8250_early: Turn serial_in/serial_out to weak symbols to allow platforms to override them.

Now one can replace default methods with similar fit to its needs.
e.g. choose other regshift, register offset, or any other manipulation.

This is useful for big endian platforms wishing to use the early serial driver.
Platform that needs to swab bytes before the register accesses.

Signed-off-by: Noam Camus <noamc@ezchip.com>
---
 drivers/tty/serial/8250/8250_early.c |    4 ++--
 include/linux/serial_8250.h          |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index eaafb98..a359504 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -48,7 +48,7 @@ struct early_serial8250_device {

 static struct early_serial8250_device early_device;

-static unsigned int __init serial_in(struct uart_port *port, int offset)
+unsigned int __weak __init serial8250_early_in(struct uart_port *port, int offset)
 {
        switch (port->iotype) {
        case UPIO_MEM:
@@ -62,7 +62,7 @@ static unsigned int __init serial_in(struct uart_port *port, int offset)
        }
 }

-static void __init serial_out(struct uart_port *port, int offset, int value)
+void __weak __init serial8250_early_out(struct uart_port *port, int offset, int value)
 {
        switch (port->iotype) {
        case UPIO_MEM:
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index c174c90..c490d20 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -105,6 +105,8 @@ extern int early_serial_setup(struct uart_port *port);

 extern int serial8250_find_port(struct uart_port *p);
 extern int serial8250_find_port_for_earlycon(void);
+extern unsigned int serial8250_early_in(struct uart_port *port, int offset);
+extern void serial8250_early_out(struct uart_port *port, int offset, int value);
 extern int setup_early_serial8250_console(char *cmdline);
 extern void serial8250_do_set_termios(struct uart_port *port,
                struct ktermios *termios, struct ktermios *old);
-- 
1.7.1

Regards,
Noam
