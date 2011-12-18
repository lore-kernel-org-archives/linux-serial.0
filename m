From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH 2/2 v2] imx: add polled io uart methods
Date: Sun, 18 Dec 2011 18:34:15 +0100
Message-ID: <1324229655-5538-2-git-send-email-dirk.behme@gmail.com>
References: <1324229655-5538-1-git-send-email-dirk.behme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49011 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab1LRRet (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 18 Dec 2011 12:34:49 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so4740887eek.19
        for <linux-serial@vger.kernel.org>; Sun, 18 Dec 2011 09:34:48 -0800 (PST)
In-Reply-To: <1324229655-5538-1-git-send-email-dirk.behme@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Saleem Abdulrasool <compnerd@compnerd.org>, Dirk Behme <dirk.behme@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org

=46rom: Saleem Abdulrasool <compnerd@compnerd.org>

These methods are invoked if the iMX uart is used in conjuction with kg=
db during
early boot.  In order to access the UART without the interrupts, the ke=
rnel uses
the basic polling methods for IO with the device.  With these methods
implemented, it is now possible to enable kgdb during early boot over s=
erial.

Signed-off-by: Saleem Abdulrasool <compnerd@compnerd.org>
Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
CC: linux-serial@vger.kernel.org
---
Note: Changes in the v2 compared to Saleem's original version:
       * Remove volatile form status variable
       * Remove blank line
       * Factor out imx_console_mode/restore()

 drivers/tty/serial/imx.c |   66 ++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 6a01c2a..cd81ac0 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -102,6 +102,7 @@
 #define  UCR2_STPB       (1<<6)	 /* Stop */
 #define  UCR2_WS         (1<<5)	 /* Word size */
 #define  UCR2_RTSEN      (1<<4)	 /* Request to send interrupt enable *=
/
+#define  UCR2_ATEN       (1<<3)  /* Aging Timer Enable */
 #define  UCR2_TXEN       (1<<2)	 /* Transmitter enabled */
 #define  UCR2_RXEN       (1<<1)	 /* Receiver enabled */
 #define  UCR2_SRST 	 (1<<0)	 /* SW reset */
@@ -1104,6 +1105,66 @@ imx_verify_port(struct uart_port *port, struct s=
erial_struct *ser)
 	return ret;
 }
=20
+#if defined(CONFIG_CONSOLE_POLL)
+static int imx_poll_get_char(struct uart_port *port)
+{
+	unsigned int status, cr1, cr2, cr3;
+	unsigned char c;
+
+	/* save control registers */
+	imx_console_mode(port, &cr1, &cr2, &cr3);
+
+	/* disable interrupts */
+	writel(UCR1_UARTEN, port->membase + UCR1);
+	writel(cr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
+	       port->membase + UCR2);
+	writel(cr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UCR3=
);
+
+	/* poll */
+	do {
+		status =3D readl(port->membase + USR2);
+	} while (~status & USR2_RDR);
+
+	/* read */
+	c =3D readl(port->membase + URXD0);
+
+	/* restore control registers */
+	imx_console_restore(port, cr1, cr2, cr3);
+
+	return c & 0xff;
+}
+
+static void imx_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	unsigned int status, cr1, cr2, cr3;
+
+	/* save control registers */
+	imx_console_mode(port, &cr1, &cr2, &cr3);
+
+	/* disable interrupts */
+	writel(UCR1_UARTEN, port->membase + UCR1);
+	writel(cr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
+	       port->membase + UCR2);
+	writel(cr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UCR3=
);
+
+	/* drain */
+	do {
+		status =3D readl(port->membase + USR1);
+	} while (~status & USR1_TRDY);
+
+	/* write */
+	writel(c, port->membase + URTX0);
+
+	/* flush */
+	do {
+		status =3D readl(port->membase + USR2);
+	} while (~status & USR2_TXDC);
+
+	/* restore control registers */
+	imx_console_restore(port, cr1, cr2, cr3);
+}
+#endif
+
 static struct uart_ops imx_pops =3D {
 	.tx_empty	=3D imx_tx_empty,
 	.set_mctrl	=3D imx_set_mctrl,
@@ -1121,6 +1182,11 @@ static struct uart_ops imx_pops =3D {
 	.request_port	=3D imx_request_port,
 	.config_port	=3D imx_config_port,
 	.verify_port	=3D imx_verify_port,
+
+#if defined(CONFIG_CONSOLE_POLL)
+	.poll_get_char  =3D imx_poll_get_char,
+	.poll_put_char  =3D imx_poll_put_char,
+#endif
 };
=20
 static struct imx_port *imx_ports[UART_NR];
--=20
1.7.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
