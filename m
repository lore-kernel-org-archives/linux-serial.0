From: =?ISO-8859-15?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
Subject: Re: [PATCH V4] workaround for mpc52xx erratum #364 (serial may not
	be reset in break state)
Date: Thu, 06 Nov 2008 09:11:07 +0100
Message-ID: <4912A69B.6020707@unicontrol.de>
References: <490F51E7.3020309@unicontrol.de>
	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<4910274E.5030305@unicontrol.de>
	<20081104111545.GB17864@pengutronix.de>
	<4910A519.3030701@unicontrol.de>
	<20081104212152.GC28064@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070305050703010104030901"
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20081104212152.GC28064@pengutronix.de>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Wolfram Sang <w.sang@pengutronix.de>, linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------070305050703010104030901
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

This patch is a workaround for bug #364 found in the MPC52xx processor.
The errata document can be found under=20
http://www.freescale.com/files/32bit/doc/errata/MPC5200E.pdf?fpsp=3D1&WT_=
TYPE=3DErrata&WT_VENDOR=3DFREESCALE&WT_FILE_FORMAT=3Dpdf&WT_ASSET=3DDocum=
entation=20


When a device with a low baudrate is connected to the serial port, but=20
the processor "listens" on a higher baudrate, it might falsely receive=20
breaks from the controller. During a break, the serial controller may=20
not be reset. The appended patch provides a workaround for that=20
situation by lowering the baudrate without resetting the controller and=20
waiting until no break is received anymore.

This is v4 if the patch, just reformatted to fit the linux kernel coding=20
style without functional changes.

Wolfram Sang schrieb:
> Hi Ren=E9,
>
> On Tue, Nov 04, 2008 at 08:40:09PM +0100, Ren=E9 B=FCrgel wrote
>> But there's still one thing, that bothers me a bit - if there is REALL=
Y =20
>> a break on the line, closing the driver may take until it's gone. I =20
>> don't know whether this is really satisfying, but i think it's better =
=20
>> than the alternative: no serial connection until the next reboot.
>>    =20
>
> I think we should CC linux-serial to get some opinions about this. At
> least, if it stays like this, it should be mentioned in the source.

What's the opinion from the linux-serial folks about this issue?

--=20
Ren=E9 B=FCrgel
Software Engineer
Unicontrol Systemtechnik GmbH
OT Dittersbach
Sachsenburger Weg 34
09669 Frankenberg
=20
Tel.: 03 72 06/ 88 73 - 19
Fax: 03 72 06/ 88 73 - 60
E-Mail: r.buergel@unicontrol.de
Internet: www.unicontrol.de
=20
Unicontrol Systemtechnik GmbH
Gesch=E4ftsf=FChrer: Dipl.-Ing. Siegfried Heinze
Sitz der Gesellschaft: Frankenberg
Registergericht: Amtsgericht Chemnitz, HRB 15 475
=20
Wichtiger Hinweis: Diese E-Mail und etwaige Anlagen k=F6nnen Betriebs- un=
d Gesch=E4ftsgeheimnisse, dem Anwaltsgeheimnis unterliegende oder sonstig=
e vertrauliche Informationen=20
enthalten. Sollten Sie diese E-Mail irrt=FCmlich erhalten haben, ist Ihne=
n der Status dieser E-Mail bekannt. Bitte benachrichtigen Sie uns in dies=
em Falle sofort durch=20
Antwort-Mail und l=F6schen Sie diese E-Mail nebst etwaigen Anlagen aus Ih=
rem System. Ebenso d=FCrfen Sie diese E-Mail oder ihre Anlagen nicht kopi=
eren oder an Dritte=20
weitergeben. Vielen Dank!
=20
Important Note: This e-mail and any attachments are confidential, may con=
tain trade secrets and may well also be legally privileged or otherwise p=
rotected from disclosure.=20
If you have received it in error, you are on notice of its status. Please=
 notify us immediately by reply e-mail and then delete this e-mail and an=
y attachment from your=20
system. If you are not the intended recipient please understand that you =
must not copy this e-mail or any attachments or disclose the contents to =
any other person. Thank=20
you.



--------------070305050703010104030901
Content-Type: text/plain;
 name="127-mpc52xx_erratum_364.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="127-mpc52xx_erratum_364.patch"

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 6117d3d..ae539b5 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -496,6 +496,74 @@ mpc52xx_uart_break_ctl(struct uart_port *port, int ctl)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+/*
+ * This is a workaround for processor bug #364
+ * described in MPC5200 (L25R) Errata.
+ * The bug is still present in MPC5200B,
+ * but currently not listed in its errata sheet.
+ *
+ * The workaround resets the baudrate to the slowest possible,
+ * waits for a stable state and resets break state repeatedly if necessary.
+ * Optionally it can release the lock while waiting.
+ *
+ * That baudrate is roughly port->uartclk / (1000 * 1000)
+ * The minimum wait time for the first try has to include
+ * the time to wait for stop-bits and a character.
+ * We wait for 2 chars to be sure.
+ * Consecutive waits must just receive one character.
+ */
+
+#ifdef CONFIG_PPC_MPC52xx
+static void reset_errors_and_wait(struct uart_port *port, bool unlock,
+				  unsigned long flags, unsigned int delay)
+{
+	struct mpc52xx_psc __iomem *psc = PSC(port);
+	out_8(&psc->command, MPC52xx_PSC_RST_ERR_STAT);
+	if (unlock) {
+		disable_irq(port->irq);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+	mdelay(delay);
+	if (unlock) {
+		spin_lock_irqsave(&port->lock, flags);
+		enable_irq(port->irq);
+	}
+}
+#endif
+
+static void mpc52xx_uart_reset_rx(struct uart_port *port, bool unlock,
+				  unsigned long flags)
+{
+#ifdef CONFIG_PPC_MPC52xx
+	struct mpc52xx_psc __iomem *psc = PSC(port);
+
+	/*
+	 * One character on the serial port may consist of up to 12 bits.
+	 * So the time to receive one char is
+	 * 12  / (port->uartclk / (1000 * 1000) ) * 1000,
+	 * (bits)                 (MHz -> Hz)      (s -> ms)
+	 */
+	unsigned int one_char_receive_duration =
+			(12 * 1000) / (port->uartclk / (1000 * 1000));
+
+	/*
+	 * CT=0xFFFF sets the serial line to the minimal possible baudrate
+	 * (depending on the uartclk).
+	 */
+	out_8(&psc->ctur, 0xFF);
+	out_8(&psc->ctlr, 0xFF);
+
+	reset_errors_and_wait(port, unlock, flags,
+			      one_char_receive_duration * 2);
+
+	while ((in_be16(&psc->mpc52xx_psc_status)) & MPC52xx_PSC_SR_RB) {
+		reset_errors_and_wait(port, unlock, flags,
+				      one_char_receive_duration);
+	}
+#endif
+	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+}
+
 static int
 mpc52xx_uart_startup(struct uart_port *port)
 {
@@ -510,7 +578,7 @@ mpc52xx_uart_startup(struct uart_port *port)
 		return ret;
 
 	/* Reset/activate the port, clear and enable interrupts */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(port, false, 0);
 	out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
 	out_be32(&psc->sicr, 0);	/* UART mode DCD ignored */
@@ -529,7 +597,7 @@ mpc52xx_uart_shutdown(struct uart_port *port)
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 
 	/* Shut down the port.  Leave TX active if on a console port */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(port, false, 0);
 	if (!uart_console(port))
 		out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
@@ -588,9 +656,6 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	/* Get the lock */
 	spin_lock_irqsave(&port->lock, flags);
 
-	/* Update the per-port timeout */
-	uart_update_timeout(port, new->c_cflag, baud);
-
 	/* Do our best to flush TX & RX, so we don't loose anything */
 	/* But we don't wait indefinitly ! */
 	j = 5000000;	/* Maximum wait */
@@ -607,9 +672,12 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 			"Some chars may have been lost.\n");
 
 	/* Reset the TX & RX */
-	out_8(&psc->command, MPC52xx_PSC_RST_RX);
+	mpc52xx_uart_reset_rx(port, true, flags);
 	out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
+	/* Update the per-port timeout */
+	uart_update_timeout(port, new->c_cflag, baud);
+
 	/* Send new mode settings */
 	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
 	out_8(&psc->mode, mr1);

--------------070305050703010104030901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--------------070305050703010104030901--
