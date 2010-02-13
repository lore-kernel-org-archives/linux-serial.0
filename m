From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH 09/12] Serial: sc26xx - add support for SC2892 chips
Date: Sat, 13 Feb 2010 17:10:25 +0100
Message-ID: <20100213161025.22311.69085.stgit@srv002.fuzzey.net>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45000 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700Ab0BMQK2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Feb 2010 11:10:28 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2648139ewy.28
        for <linux-serial@vger.kernel.org>; Sat, 13 Feb 2010 08:10:27 -0800 (PST)
In-Reply-To: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tsbogend@alpha.franken.de



Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/sc26xx.c |  238 ++++++++++++++++++++++++++++++++++++++-=
--------
 1 files changed, 193 insertions(+), 45 deletions(-)

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index bc466ac..053520d 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -1,7 +1,8 @@
 /*
- * SC268xx.c: Serial driver for Philiphs SC2681/SC2692 devices.
+ * SC26xx.c: Serial driver for Philips SC2681/SC2692/SC2892 devices.
  *
  * Copyright (C) 2006,2007 Thomas Bogend=C3=B6rfer (tsbogend@alpha.fra=
nken.de)
+ * SC2892 support by Martin Fuzzey (mfuzzey@gmail.com)
  */
=20
 #include <linux/module.h>
@@ -32,15 +33,29 @@
 #define SC26XX_MINOR_START   205
 #define SC26XX_NR            2
=20
+struct chip_def {
+	u8	has_mr0;
+	u8	init_mr0;
+	u8	init_mr1;
+	u8	max_baud_mode;
+	u8	default_baud_mode;
+	u8	default_baud_group;
+	const char *name;
+};
+
 struct uart_sc26xx_port {
 	struct uart_port      port[2];
-	u8     dsr_mask[2];
-	u8     cts_mask[2];
-	u8     dcd_mask[2];
-	u8     ri_mask[2];
-	u8     dtr_mask[2];
-	u8     rts_mask[2];
-	u8     imr;
+	u8	dsr_mask[2];
+	u8	cts_mask[2];
+	u8	dcd_mask[2];
+	u8	ri_mask[2];
+	u8	dtr_mask[2];
+	u8	rts_mask[2];
+	u8	imr;
+	u8	acr;
+	u8	mr0_baud;
+	const unsigned int *baud_rates;
+	const struct chip_def *chip;
 };
=20
 /* register common to both ports */
@@ -81,6 +96,7 @@ struct uart_sc26xx_port {
 #define CR_RES_TX   (3 << 4)
 #define CR_STRT_BRK (6 << 4)
 #define CR_STOP_BRK (7 << 4)
+#define CR_SEL_MR0  (11 << 4)
 #define CR_DIS_TX   (1 << 3)
 #define CR_ENA_TX   (1 << 2)
 #define CR_DIS_RX   (1 << 1)
@@ -96,6 +112,66 @@ struct uart_sc26xx_port {
 #define IMR_RXRDY   (1 << 1)
 #define IMR_TXRDY   (1 << 0)
=20
+/* MR0 bits (>=3D 28L92 only */
+#define MR0_WATCHDOG	(1 << 7)
+#define MR0_RXINT2	(1 << 6)
+#define MR0_TXINT(x)	((x) << 4)
+#define MR0_FIFO_SIZE	(1 << 3)
+#define MR0_BAUD_MODE	((1 << 2) + (1 << 0))
+
+
+#define NR_BAUD_GROUPS 2
+#define NR_BAUD_MODES 3
+#define NR_BAUDS 13
+#define DEFAULT_BAUD_INDEX 11
+static const unsigned baud_rates[NR_BAUD_MODES][NR_BAUD_GROUPS][NR_BAU=
DS] =3D {
+	{
+		/* Normal mode ACR[7] =3D 0 */
+		{50, 110, 134, 200, 300, 600, 1200, 1050,
+			2400, 4800, 7200, 9600, 38400},
+
+		/* Normal mode ACR[7] =3D 1 */
+		{75, 110, 134, 150, 300, 600, 1200, 2000,
+			2400, 4800, 1800, 9600, 19200},
+	}, {
+		/* Extended mode 1 ACR[7] =3D 0 */
+		{300, 110, 134, 1200, 1800, 3600, 7200, 1050,
+			14400, 28800, 7200, 57600, 230400},
+
+		/* Extended mode 1 ACR[7] =3D 1 */
+		{450, 110, 134, 900, 1800, 3600, 72000, 2000,
+			14400, 28800, 1800, 57600, 115200},
+	}, {
+		/* Extended mode 2 ACR[7] =3D 0 */
+		{4800, 880, 1076, 19200, 28800, 57600, 115200, 1050,
+			57600, 4800, 57600, 9600, 38400},
+
+		/* Extended mode 2 ACR[7] =3D 1 */
+		{7200, 880, 1076, 14400, 28800, 57600, 115200, 2000,
+			57600, 4800, 14400, 9600, 19200},
+	}
+};
+
+static struct chip_def chip_26xx =3D {
+	.name =3D "SC26XX",
+	.max_baud_mode =3D 0,
+	.default_baud_mode =3D 0,
+	.default_baud_group =3D 1,
+	.has_mr0 =3D 0,
+	.init_mr1 =3D 0,
+};
+
+static struct chip_def chip_2892 =3D {
+	.name =3D "SC2892",
+	.max_baud_mode =3D 2,
+	.default_baud_mode =3D 2,
+	.default_baud_group =3D 0,
+	.has_mr0 =3D 1,
+	.init_mr0 =3D  MR0_WATCHDOG | MR0_FIFO_SIZE | MR0_TXINT(1),
+	.init_mr1 =3D (1 << 6),
+};
+
+
 static struct uart_sc26xx_port *driver_info(struct uart_port *port)
 {
 	port -=3D port->line;
@@ -142,6 +218,19 @@ static inline void write_cmd_port(struct uart_port=
 *port, u8 cmd)
 	write_cmd_line(port, port->line, cmd);
 }
=20
+
+static u8 read_mr0(struct uart_port *port, int line)
+{
+	write_cmd_line(port, line, CR_SEL_MR0);
+	return read_sc_line(port, line, RD_PORT_MRx);
+}
+
+static void write_mr0(struct uart_port *port, int line, u8 val)
+{
+	write_cmd_line(port, line, CR_SEL_MR0);
+	write_sc_line(port, line, WR_PORT_MRx, val);
+}
+
 static void sc26xx_enable_irq(struct uart_port *port, int mask)
 {
 	struct uart_sc26xx_port *up =3D driver_info(port);
@@ -372,6 +461,8 @@ static void sc26xx_break_ctl(struct uart_port *port=
, int break_state)
 /* port->lock is not held.  */
 static int sc26xx_startup(struct uart_port *port)
 {
+	struct uart_sc26xx_port *up =3D driver_info(port);
+
 	sc26xx_disable_irq(port, IMR_TXRDY | IMR_RXRDY);
 	WRITE_SC(port, OPCR, 0);
=20
@@ -379,6 +470,9 @@ static int sc26xx_startup(struct uart_port *port)
 	write_cmd_port(port, CR_RES_RX);
 	write_cmd_port(port, CR_RES_TX);
=20
+	if (up->chip->has_mr0)
+		write_mr0(port, port->line, up->chip->init_mr0);
+
 	/* start rx/tx */
 	WRITE_SC_PORT(port, CR, CR_ENA_TX | CR_ENA_RX);
=20
@@ -413,10 +507,32 @@ static int wait_tx_empty(struct uart_port *port)
 	return -1;
 }
=20
+static u8 find_csr(struct uart_sc26xx_port *up, unsigned int baud)
+{
+	int i, found =3D -1;
+
+	for (i =3D 0; i < NR_BAUDS; i++) {
+		if (up->baud_rates[i] =3D=3D baud) {
+			found =3D i;
+			break;
+		}
+	}
+
+	if (found =3D=3D -1) {
+		found =3D DEFAULT_BAUD_INDEX;
+		dev_warn(up->port[0].dev,
+			"%d baud not available using %d\n",
+			baud, up->baud_rates[found]);
+	}
+
+	return (u8)found | ((u8)found << 4);
+}
+
 /* port->lock is not held.  */
 static void sc26xx_set_termios(struct uart_port *port, struct ktermios=
 *termios,
 			      struct ktermios *old)
 {
+	struct uart_sc26xx_port *up =3D driver_info(port);
 	unsigned int baud =3D uart_get_baud_rate(port, termios, old, 0, 40000=
00);
 	unsigned int iflag, cflag;
 	unsigned long flags;
@@ -469,48 +585,21 @@ static void sc26xx_set_termios(struct uart_port *=
port, struct ktermios *termios,
 	} else
 		mr1 |=3D (2 << 3);
=20
-	switch (baud) {
-	case 50:
-		csr =3D 0x00;
-		break;
-	case 110:
-		csr =3D 0x11;
-		break;
-	case 134:
-		csr =3D 0x22;
-		break;
-	case 200:
-		csr =3D 0x33;
-		break;
-	case 300:
-		csr =3D 0x44;
-		break;
-	case 600:
-		csr =3D 0x55;
-		break;
-	case 1200:
-		csr =3D 0x66;
-		break;
-	case 2400:
-		csr =3D 0x88;
-		break;
-	case 4800:
-		csr =3D 0x99;
-		break;
-	default:
-	case 9600:
-		csr =3D 0xbb;
-		break;
-	case 19200:
-		csr =3D 0xcc;
-		break;
+	mr1 |=3D up->chip->init_mr1;
+	csr =3D find_csr(up, baud);
+
+	if (up->chip->has_mr0) {
+		u8 mr0a =3D read_mr0(port, 0);
+		mr0a &=3D ~MR0_BAUD_MODE;
+		mr0a |=3D up->mr0_baud;
+		write_mr0(port, 0, mr0a);
 	}
=20
 	write_cmd_port(port, CR_RES_MR);
 	WRITE_SC_PORT(port, MRx, mr1);
 	WRITE_SC_PORT(port, MRx, mr2);
=20
-	WRITE_SC(port, ACR, 0x80);
+	WRITE_SC(port, ACR, up->acr);
 	WRITE_SC_PORT(port, CSR, csr);
=20
 	/* reset tx and rx */
@@ -528,7 +617,7 @@ out:
=20
 static const char *sc26xx_type(struct uart_port *port)
 {
-	return "SC26XX";
+	return driver_info(port)->chip->name;
 }
=20
 static void sc26xx_release_port(struct uart_port *port)
@@ -662,6 +751,60 @@ static void __devinit sc26xx_init_masks(struct uar=
t_sc26xx_port *up,
 	up->ri_mask[line]  =3D sc26xx_flags2mask(data, 20);
 }
=20
+static int __devinit init_baudgroup(struct uart_sc26xx_port *up)
+{
+	u8 baud_mode =3D up->chip->default_baud_mode;
+	u8 baud_group =3D up->chip->default_baud_group;
+
+	if (baud_mode > up->chip->max_baud_mode) {
+		printk(KERN_ERR "Baud mode %d not supported for %s\n",
+			baud_mode, up->chip->name);
+		return -EINVAL;
+	}
+
+	up->acr =3D baud_group ? 0x80 : 0;
+	up->baud_rates =3D baud_rates[baud_mode][baud_group];
+
+	switch (baud_mode) {
+	case 0:
+		up->mr0_baud =3D 0;
+		break;
+	case 1:
+		up->mr0_baud =3D 1;
+		break;
+	case 2:
+		up->mr0_baud =3D 4;
+		break;
+	}
+	return 0;
+}
+
+static const struct chip_def * __devinit detect_chip_type(
+	struct uart_sc26xx_port *up)
+{
+	struct uart_port *port =3D &up->port[0];
+	struct chip_def *chip;
+	int i;
+	u8 mrx[3];
+
+	/* Code below needs to be tested on 26xx hardware
+	 * Idea is that 26xx will ignore SEL_MR0 so 2nd and 3rd reads
+	 * will return same data.*/
+	write_cmd_port(port, CR_RES_MR); /* MR1 */
+	write_cmd_port(port, CR_SEL_MR0); /* Ignored on 26xx */
+
+	for (i =3D 0; i < 3; i++)
+		mrx[i] =3D READ_SC_PORT(port, MRx);
+
+	if (mrx[1] =3D=3D mrx[2])
+		chip =3D &chip_26xx;
+	else
+		chip =3D &chip_2892;
+
+	dev_info(port->dev, "Autodetected %s\n", chip->name);
+	return chip;
+}
+
 static int __devinit sc26xx_probe(struct platform_device *dev)
 {
 	struct resource *res, *irq_res;
@@ -702,6 +845,11 @@ static int __devinit sc26xx_probe(struct platform_=
device *dev)
=20
 	sc26xx_init_masks(up, 1, sc26xx_data[1]);
=20
+	up->chip =3D detect_chip_type(up);
+	err =3D init_baudgroup(up);
+	if (err)
+		goto out_free_port;
+
 	err =3D uart_register_driver(&sc26xx_reg);
 	if (err)
 		goto out_free_port;

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
