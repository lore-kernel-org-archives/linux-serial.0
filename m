From: =?iso-8859-1?q?S=F8ren_holm?= <sgh@sgh.dk>
Subject: Hardware flowcontrol on XR17D154
Date: Tue, 30 Aug 2011 12:17:07 +0200
Message-ID: <201108301217.07468.sgh@sgh.dk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jiLXO361mXr+IJ1"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cpe.ge-0-2-0-951.faaqnqu1.customer.tele.dk ([93.167.193.22]:28716
	"EHLO mail.mikrofyn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab1H3KWs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Aug 2011 06:22:48 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

--Boundary-00=_jiLXO361mXr+IJ1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

I have hacked hardware flowcontrol into 8250.c for the XR17D154. I have=20
attached the patch. The fix just uses another address for the EFR-register.

I would like to have some adwise as to how to do this the right way.=20

Thanks.
=2D-=20
S=F8ren Holm

--Boundary-00=_jiLXO361mXr+IJ1
Content-Type: text/x-patch;
  charset="UTF-8";
  name="xr17d154_hwflow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xr17d154_hwflow.patch"

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index b3b881b..ba28eb8 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -301,7 +301,7 @@ static const struct serial8250_config uart_config[] = {
 		.fifo_size	= 64,
 		.tx_loadsz	= 64,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
-		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR,
 	},
 };
 
@@ -2420,7 +2420,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 			efr |= UART_EFR_CTS;
 
 		serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		serial_outp(up, UART_EFR, efr);
+		serial_outp(up, UART_EFR2, efr);
 	}
 
 #ifdef CONFIG_ARCH_OMAP
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 3ecb71a..56b2569 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -150,6 +150,7 @@
  * LCR=0xBF (or DLAB=1 for 16C660)
  */
 #define UART_EFR	2	/* I/O: Extended Features Register */
+#define UART_EFR2	9	/* I/O: Extended Features Register for Exari XR17D154 */
 #define UART_EFR_CTS		0x80 /* CTS flow control */
 #define UART_EFR_RTS		0x40 /* RTS flow control */
 #define UART_EFR_SCD		0x20 /* Special character detect */

--Boundary-00=_jiLXO361mXr+IJ1--
