From: <gregkh@suse.de>
Subject: patch serial-imx.c-fix-cts-trigger-level-lower-to-avoid-lost-chars.patch added to gregkh-2.6 tree
Date: Wed, 05 May 2010 16:48:15 -0700
Message-ID: <12731032952456@kroah.org>
References: <4BE13E9B.6050406@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:60446 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755155Ab0EEXsw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 May 2010 19:48:52 -0400
In-Reply-To: <4BE13E9B.6050406@epfl.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: valentin.longchamp@epfl.ch, alan@linux.intel.com, gregkh@suse.de, linux-serial@vger.kernel.org, philippe.retornaz@epfl.ch, s.hauer@pengutronix.de, stable@kernel.org, w.sang@pengutronix.de


This is a note to let you know that I've just added the patch titled

    Subject: serial: imx.c: fix CTS trigger level lower to avoid lost c=
hars

to my gregkh-2.6 tree.  Its filename is

    serial-imx.c-fix-cts-trigger-level-lower-to-avoid-lost-chars.patch

This tree can be found at=20
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/pat=
ches/


=46rom valentin.longchamp@epfl.ch  Wed May  5 11:15:04 2010
=46rom: Valentin Longchamp <valentin.longchamp@epfl.ch>
Date: Wed, 05 May 2010 11:47:07 +0200
Subject: serial: imx.c: fix CTS trigger level lower to avoid lost chars
To: Alan Cox <alan@linux.intel.com>
Cc: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "w.sang@pengutro=
nix.de" <w.sang@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-=
serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
Message-ID: <4BE13E9B.6050406@epfl.ch>


The imx CTS trigger level is left at its reset value that is 32
chars. Since the RX FIFO has 32 entries, when CTS is raised, the
=46IFO already is full. However, some serial port devices first empty
their TX FIFO before stopping when CTS is raised, resulting in lost
chars.

This patch sets the trigger level lower so that other chars arrive
after CTS is raised, there is still room for 16 of them.

Signed-off-by: Valentin Longchamp<valentin.longchamp@epfl.ch>
Tested-by: Philippe R=C3=A9tornaz<philippe.retornaz@epfl.ch>
Acked-by: Wolfram Sang<w.sang@pengutronix.de>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/serial/imx.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -120,7 +120,8 @@
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
@@ -591,6 +592,9 @@ static int imx_setup_ufcr(struct imx_por
 	return 0;
 }
=20
+/* half the RX buffer size */
+#define CTSTL 16
+
 static int imx_startup(struct uart_port *port)
 {
 	struct imx_port *sport =3D (struct imx_port *)port;
@@ -607,6 +611,10 @@ static int imx_startup(struct uart_port
 	if (USE_IRDA(sport))
 		temp |=3D UCR4_IRSC;
=20
+	/* set the trigger level for CTS */
+	temp &=3D ~(UCR4_CTSTL_MASK<<  UCR4_CTSTL_SHF);
+	temp |=3D CTSTL<<  UCR4_CTSTL_SHF;
+
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
=20
 	if (USE_IRDA(sport)) {

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
