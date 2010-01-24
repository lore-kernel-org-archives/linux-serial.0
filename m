From: Valentin Longchamp <valentin.longchamp@epfl.ch>
Subject: [PATCH] serial imx.c: fix CTS trigger level lower to avoid lost chars
Date: Sun, 24 Jan 2010 11:48:15 +0100
Message-ID: <1264330095-32225-1-git-send-email-valentin.longchamp@epfl.ch>
References: <20100122115853.GF4782@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.219]:41275 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752517Ab0AXKsY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 24 Jan 2010 05:48:24 -0500
In-Reply-To: <20100122115853.GF4782@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: s.hauer@pengutronix.de, w.sang@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Valentin Longchamp <valentin.longchamp@epfl.ch>

The imx CTS trigger level is left at its reset value that is 32
chars. Since the RX FIFO has 32 entries, when CTS is raised, the
=46IFO already is full. However, some serial port devices first empty
their TX FIFO before stopping when CTS is raised, resulting in lost
chars.

This patch sets the trigger level lower so that other chars arrive
after CTS is raised, there is still room for 16 of them.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
Tested-by: Philippe R=C3=A9tornaz <philippe.retornaz@epfl.ch>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/serial/imx.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
index 60d665a..071c614 100644
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -119,7 +119,8 @@
 #define  MX2_UCR3_RXDMUXSEL	 (1<<2)  /* RXD Muxed Input Select, on mx2=
/mx3 */
 #define  UCR3_INVT  	 (1<<1)  /* Inverted Infrared transmission */
 #define  UCR3_BPEN  	 (1<<0)  /* Preset registers enable */
-#define  UCR4_CTSTL_32   (32<<10) /* CTS trigger level (32 chars) */
+#define  UCR4_CTSTL_SHF  10      /* CTS trigger level shift */
+#define  UCR4_CTSTL_MASK 0x3F    /* CTS trigger is 6 bits wide */
 #define  UCR4_INVR  	 (1<<9)  /* Inverted infrared reception */
 #define  UCR4_ENIRI 	 (1<<8)  /* Serial infrared interrupt enable */
 #define  UCR4_WKEN  	 (1<<7)  /* Wake interrupt enable */
@@ -590,6 +591,9 @@ static int imx_setup_ufcr(struct imx_port *sport, u=
nsigned int mode)
 	return 0;
 }
=20
+/* half the RX buffer size */
+#define CTSTL 16
+
 static int imx_startup(struct uart_port *port)
 {
 	struct imx_port *sport =3D (struct imx_port *)port;
@@ -606,6 +610,10 @@ static int imx_startup(struct uart_port *port)
 	if (USE_IRDA(sport))
 		temp |=3D UCR4_IRSC;
=20
+	/* set the trigger level for CTS */
+	temp &=3D ~(UCR4_CTSTL_MASK << UCR4_CTSTL_SHF);
+	temp |=3D CTSTL << UCR4_CTSTL_SHF;
+
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
=20
 	if (USE_IRDA(sport)) {
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
