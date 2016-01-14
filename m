From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v7 14/15] tty: serial: 8250: Fix indentation warnings
Date: Thu, 14 Jan 2016 16:08:23 +0100
Message-ID: <1452784104-30840-15-git-send-email-anton.wuerfel@fau.de>
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

Checkpatch complains about incorrect indentation of switch/case stateme=
nts.
This patch fixes the corresponding warnings. Additionally some indentat=
ion
is changed to match the correct format specified in the Linux Kernel
Coding Style.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_pci.c  | 16 ++++++++--------
 drivers/tty/serial/8250/8250_pnp.c  |  4 ++--
 drivers/tty/serial/8250/8250_port.c |  6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
index b22e5a5..40aa5e7 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -842,15 +842,15 @@ static int pci_netmos_init(struct pci_dev *dev)
 		return 0;
=20
 	switch (dev->device) { /* FALLTHROUGH on all */
-		case PCI_DEVICE_ID_NETMOS_9904:
-		case PCI_DEVICE_ID_NETMOS_9912:
-		case PCI_DEVICE_ID_NETMOS_9922:
-		case PCI_DEVICE_ID_NETMOS_9900:
-			num_serial =3D pci_netmos_9900_numports(dev);
-			break;
+	case PCI_DEVICE_ID_NETMOS_9904:
+	case PCI_DEVICE_ID_NETMOS_9912:
+	case PCI_DEVICE_ID_NETMOS_9922:
+	case PCI_DEVICE_ID_NETMOS_9900:
+		num_serial =3D pci_netmos_9900_numports(dev);
+		break;
=20
-		default:
-			break;
+	default:
+		break;
 	}
=20
 	if (num_serial =3D=3D 0) {
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/82=
50/8250_pnp.c
index b2d163c..2c757b0 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -427,8 +427,8 @@ static int check_resources(struct pnp_dev *dev)
 static int serial_pnp_guess_board(struct pnp_dev *dev)
 {
 	if (!(check_name(pnp_dev_name(dev)) ||
-		(dev->card && check_name(dev->card->name))))
-			return -ENODEV;
+	    (dev->card && check_name(dev->card->name))))
+		return -ENODEV;
=20
 	if (check_resources(dev))
 		return 0;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
index 25fd6b4..9fe814f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2236,9 +2236,9 @@ static void serial8250_set_divisor(struct uart_po=
rt *port, unsigned int baud,
 		serial_port_out(port, 0x2, quot_frac);
 }
=20
-static unsigned int
-serial8250_get_baud_rate(struct uart_port *port, struct ktermios *term=
ios,
-			 struct ktermios *old)
+static unsigned int serial8250_get_baud_rate(struct uart_port *port,
+					     struct ktermios *termios,
+					     struct ktermios *old)
 {
 	unsigned int tolerance =3D port->uartclk / 100;
=20
--=20
1.9.1
