From: Matteo Croce <technoboy85@gmail.com>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Date: Fri, 14 Mar 2008 16:46:09 +0100
Message-ID: <200803141646.09645.technoboy85@gmail.com>
References: <200803120221.25044.technoboy85@gmail.com> <200803130138.55582.technoboy85@gmail.com> <20080313084526.GA6012@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out114.alice.it ([85.37.17.114]:2761 "EHLO
	smtp-out114.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbYCNPqS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Mar 2008 11:46:18 -0400
In-Reply-To: <20080313084526.GA6012@alpha.franken.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>, Felix Fietkau <nbd@openwrt.org>, Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Il Thursday 13 March 2008 09:45:26 Thomas Bogendoerfer ha scritto:
> On Thu, Mar 13, 2008 at 01:38:55AM +0100, Matteo Croce wrote:
> > Il Wednesday 12 March 2008 10:31:46 Thomas Bogendoerfer ha scritto:
> > > > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > > > index 289942f..869b6df 100644
> > > > --- a/include/linux/serial_core.h
> > > > +++ b/include/linux/serial_core.h
> > > > @@ -40,6 +40,7 @@
> > > >  #define PORT_NS16550A	14
> > > >  #define PORT_XSCALE	15
> > > >  #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
> > > > +#define PORT_AR7	16
> > > 
> > > this doesn't look correct.
> > > 
> > > Thomas.
> > > 
> > 
> > Isn't it 16?
> 
> PORT_RM9000 is 16, how could PORT_AR7 be 16 as well ? And the 16 for 
> PORT_RM9000 is correct in my counting.
> 
> Thomas.
> 

This is a bit better

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 77f7a7f..a3a271d 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -267,6 +267,13 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_AR7] = {
+		.name		= "TI-AR7",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
+	},
 };
 
 #if defined (CONFIG_SERIAL_8250_AU1X00)
@@ -2455,7 +2462,11 @@ static void serial8250_console_putchar(struct uart_port *port, int ch)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 
+#ifdef CONFIG_AR7
+	wait_for_xmitr(up, BOTH_EMPTY);
+#else
 	wait_for_xmitr(up, UART_LSR_THRE);
+#endif
 	serial_out(up, UART_TX, ch);
 }
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 289942f..15e76c8 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -40,7 +40,8 @@
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
 #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
-#define PORT_MAX_8250	16	/* max port ID */
+#define PORT_AR7	17
+#define PORT_MAX_8250	17	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed

