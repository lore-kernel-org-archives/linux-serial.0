From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v7 04/15] tty: serial: 8250: Fix multiline comment style
Date: Thu, 14 Jan 2016 16:08:13 +0100
Message-ID: <1452784104-30840-5-git-send-email-anton.wuerfel@fau.de>
References: <1452784104-30840-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452784104-30840-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Joachim Eastwood <manabian@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phillip Raffeck <phillip.raffeck@fau.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hung <hpeter@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Anton Wuerfel <anton.wuerfel@fau.de>
List-Id: linux-serial@vger.kernel.org

Checkpatch outputs some warnings about incorrect comment style,
which is fixed by this patch.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_ingenic.c | 12 ++++++++----
 drivers/tty/serial/8250/8250_pnp.c     | 14 ++++++++------
 drivers/tty/serial/8250/8250_port.c    | 32 +++++++++++++++++---------=
------
 drivers/tty/serial/8250/serial_cs.c    | 26 +++++++++++++++++---------
 4 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/seria=
l/8250/8250_ingenic.c
index 49394b4..4d9dc10 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -152,14 +152,18 @@ static void ingenic_uart_serial_out(struct uart_p=
ort *p, int offset, int value)
 		break;
=20
 	case UART_IER:
-		/* Enable receive timeout interrupt with the
-		 * receive line status interrupt */
+		/*
+		 * Enable receive timeout interrupt with the receive line
+		 * status interrupt.
+		 */
 		value |=3D (value & 0x4) << 2;
 		break;
=20
 	case UART_MCR:
-		/* If we have enabled modem status IRQs we should enable modem
-		 * mode. */
+		/*
+		 * If we have enabled modem status IRQs we should enable
+		 * modem mode.
+		 */
 		ier =3D p->serial_in(p, UART_IER);
=20
 		if (ier & UART_IER_MSI)
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/82=
50/8250_pnp.c
index 658b392..00846a7 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -357,8 +357,8 @@ static const struct pnp_device_id pnp_dev_table[] =3D=
 {
 	/* Fujitsu Wacom 1FGT Tablet PC device */
 	{	"FUJ02E9",		0	},
 	/*
-	 * LG C1 EXPRESS DUAL (C1-PB11A3) touch screen (actually a FUJ02E6 in
-	 * disguise)
+	 * LG C1 EXPRESS DUAL (C1-PB11A3) touch screen (actually a FUJ02E6
+	 * in disguise).
 	 */
 	{	"LTS0001",		0       },
 	/* Rockwell's (PORALiNK) 33600 INT PNP */
@@ -367,12 +367,14 @@ static const struct pnp_device_id pnp_dev_table[]=
 =3D {
 	{	"PNPCXXX",		UNKNOWN_DEV	},
 	/* More unknown PnP modems */
 	{	"PNPDXXX",		UNKNOWN_DEV	},
-	/* Winbond CIR port, should not be probed. We should keep track
-	   of it to prevent the legacy serial driver from probing it */
+	/*
+	 * Winbond CIR port, should not be probed. We should keep track of
+	 * it to prevent the legacy serial driver from probing it.
+	 */
 	{	"WEC1022",		CIR_PORT	},
 	/*
-	 * SMSC IrCC SIR/FIR port, should not be probed by serial driver
-	 * as well so its own driver can bind to it.
+	 * SMSC IrCC SIR/FIR port, should not be probed by serial driver as
+	 * well so its own driver can bind to it.
 	 */
 	{	"SMCF010",		CIR_PORT	},
 	{	"",			0	}
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
index f2e588e..5375c24 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -250,9 +250,11 @@ static const struct serial8250_config uart_config[=
] =3D {
 		.fcr		=3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		=3D UART_CAP_FIFO | UART_CAP_AFE,
 	},
-/* tx_loadsz is set to 63-bytes instead of 64-bytes to implement
-workaround of errata A-008006 which states that tx_loadsz should  be
-configured less than Maximum supported fifo bytes */
+	/*
+	 * tx_loadsz is set to 63-bytes instead of 64-bytes to implement
+	 * workaround of errata A-008006 which states that tx_loadsz should
+	 * be configured less than Maximum supported fifo bytes.
+	 */
 	[PORT_16550A_FSL64] =3D {
 		.name		=3D "16550A_FSL64",
 		.fifo_size	=3D 64,
@@ -1969,23 +1971,23 @@ int serial8250_do_startup(struct uart_port *por=
t)
=20
 	serial8250_set_mctrl(port, port->mctrl);
=20
-	/* Serial over Lan (SoL) hack:
-	   Intel 8257x Gigabit ethernet chips have a
-	   16550 emulation, to be used for Serial Over Lan.
-	   Those chips take a longer time than a normal
-	   serial device to signalize that a transmission
-	   data was queued. Due to that, the above test generally
-	   fails. One solution would be to delay the reading of
-	   iir. However, this is not reliable, since the timeout
-	   is variable. So, let's just don't test if we receive
-	   TX irq. This way, we'll never enable UART_BUG_TXEN.
+	/*
+	 * Serial over Lan (SoL) hack:
+	 * Intel 8257x Gigabit ethernet chips have a 16550 emulation, to be
+	 * used for Serial Over Lan.  Those chips take a longer time than a
+	 * normal serial device to signalize that a transmission data was
+	 * queued. Due to that, the above test generally fails. One solution
+	 * would be to delay the reading of iir. However, this is not
+	 * reliable, since the timeout is variable. So, let's just don't
+	 * test if we receive TX irq.  This way, we'll never enable
+	 * UART_BUG_TXEN.
 	 */
 	if (up->port.flags & UPF_NO_TXEN_TEST)
 		goto dont_test_tx_en;
=20
 	/*
-	 * Do a quick test to see if we receive an
-	 * interrupt when we enable the TX irq.
+	 * Do a quick test to see if we receive an interrupt when we enable
+	 * the TX irq.
 	 */
 	serial_port_out(port, UART_IER, UART_IER_THRI);
 	lsr =3D serial_port_in(port, UART_LSR);
diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8=
250/serial_cs.c
index 6d7a801..2b7309d 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -441,16 +441,20 @@ static int simple_config(struct pcmcia_device *li=
nk)
 	struct serial_info *info =3D link->priv;
 	int i =3D -ENODEV, try;
=20
-	/* First pass: look for a config entry that looks normal.
-	 * Two tries: without IO aliases, then with aliases */
+	/*
+	 * First pass: look for a config entry that looks normal.
+	 * Two tries: without IO aliases, then with aliases.
+	 */
 	link->config_flags |=3D CONF_AUTO_SET_VPP;
 	for (try =3D 0; try < 4; try++)
 		if (!pcmcia_loop_config(link, simple_config_check, &try))
 			goto found_port;
=20
-	/* Second pass: try to find an entry that isn't picky about
-	   its base address, then try to grab any standard serial port
-	   address, and finally try to get any free port. */
+	/*
+	 * Second pass: try to find an entry that isn't picky about
+	 * its base address, then try to grab any standard serial port
+	 * address, and finally try to get any free port.
+	 */
 	if (!pcmcia_loop_config(link, simple_config_check_notpicky, NULL))
 		goto found_port;
=20
@@ -480,8 +484,10 @@ static int multi_config_check(struct pcmcia_device=
 *p_dev, void *priv_data)
 	if (p_dev->resource[1]->end)
 		return -EINVAL;
=20
-	/* The quad port cards have bad CIS's, so just look for a
-	   window larger than 8 ports and assume it will be right */
+	/*
+	 * The quad port cards have bad CIS's, so just look for a
+	 * window larger than 8 ports and assume it will be right.
+	 */
 	if (p_dev->resource[0]->end <=3D 8)
 		return -EINVAL;
=20
@@ -623,8 +629,10 @@ static int serial_config(struct pcmcia_device *lin=
k)
 			break;
 		}
=20
-	/* Another check for dual-serial cards: look for either serial or
-	   multifunction cards that ask for appropriate IO port ranges */
+	/*
+	 * Another check for dual-serial cards: look for either serial or
+	 * multifunction cards that ask for appropriate IO port ranges.
+	 */
 	if ((info->multi =3D=3D 0) &&
 	    (link->has_func_id) &&
 	    (link->socket->pcmcia_pfc =3D=3D 0) &&
--=20
1.9.1
