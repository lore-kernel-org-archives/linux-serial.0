From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v2 04/11] tty: serial: 8250: Fix multiline comment style
Date: Fri, 18 Dec 2015 12:21:56 +0100
Message-ID: <1450437723-2978-5-git-send-email-anton.wuerfel@fau.de>
References: <1450437723-2978-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450437723-2978-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Peter Hurley <peter@hurleysoftware.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Anton Wuerfel <anto>
List-Id: linux-serial@vger.kernel.org

Checkpatch outputs some warnings about incorrect comment style,
which is fixed by this patch.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
CC: linux-kernel@i4.cs.fau.de
---
v2: Changed to consistent comment style
---
 drivers/tty/serial/8250/8250_ingenic.c | 12 ++++++++----
 drivers/tty/serial/8250/8250_pnp.c     |  6 ++++--
 drivers/tty/serial/8250/8250_port.c    | 31 ++++++++++++++++----------=
-----
 drivers/tty/serial/8250/serial_cs.c    | 26 +++++++++++++++++---------
 4 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/seria=
l/8250/8250_ingenic.c
index 49394b4..086bd00 100644
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
+		 * Enable receive timeout interrupt with the
+		 * receive line status interrupt
+		 */
 		value |=3D (value & 0x4) << 2;
 		break;
=20
 	case UART_MCR:
-		/* If we have enabled modem status IRQs we should enable modem
-		 * mode. */
+		/*
+		 * If we have enabled modem status IRQs we should enable modem
+		 * mode.
+		 */
 		ier =3D p->serial_in(p, UART_IER);
=20
 		if (ier & UART_IER_MSI)
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/82=
50/8250_pnp.c
index 658b392..ffa7354 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -367,8 +367,10 @@ static const struct pnp_device_id pnp_dev_table[] =
=3D {
 	{	"PNPCXXX",		UNKNOWN_DEV	},
 	/* More unknown PnP modems */
 	{	"PNPDXXX",		UNKNOWN_DEV	},
-	/* Winbond CIR port, should not be probed. We should keep track
-	   of it to prevent the legacy serial driver from probing it */
+	/*
+	 * Winbond CIR port, should not be probed. We should keep track
+	 * of it to prevent the legacy serial driver from probing it
+	 */
 	{	"WEC1022",		CIR_PORT	},
 	/*
 	 * SMSC IrCC SIR/FIR port, should not be probed by serial driver
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
index f2e588e..99f709c 100644
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
+	 * workaround of errata A-008006 which states that tx_loadsz should b=
e
+	 * configured less than Maximum supported fifo bytes
+	 */
 	[PORT_16550A_FSL64] =3D {
 		.name		=3D "16550A_FSL64",
 		.fifo_size	=3D 64,
@@ -1969,23 +1971,22 @@ int serial8250_do_startup(struct uart_port *por=
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
+	 * Intel 8257x Gigabit ethernet chips have a 16550 emulation, to be u=
sed
+	 * for Serial Over Lan.  Those chips take a longer time than a normal
+	 * serial device to signalize that a transmission data was queued. Du=
e
+	 * to that, the above test generally fails. One solution would be to
+	 * delay the reading of iir. However, this is not reliable, since the
+	 * timeout is variable. So, let's just don't test if we receive TX ir=
q.
+	 * This way, we'll never enable UART_BUG_TXEN.
 	 */
 	if (up->port.flags & UPF_NO_TXEN_TEST)
 		goto dont_test_tx_en;
=20
 	/*
-	 * Do a quick test to see if we receive an
-	 * interrupt when we enable the TX irq.
+	 * Do a quick test to see if we receive an interrupt when we enable t=
he
+	 * TX irq.
 	 */
 	serial_port_out(port, UART_IER, UART_IER_THRI);
 	lsr =3D serial_port_in(port, UART_LSR);
diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8=
250/serial_cs.c
index 6d7a801..1f34867 100644
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
+	 * Two tries: without IO aliases, then with aliases
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
+	 * window larger than 8 ports and assume it will be right
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
+	 * multifunction cards that ask for appropriate IO port ranges
+	 */
 	if ((info->multi =3D=3D 0) &&
 	    (link->has_func_id) &&
 	    (link->socket->pcmcia_pfc =3D=3D 0) &&
--=20
1.9.1
