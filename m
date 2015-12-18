From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v2 11/11] tty: serial: 8250: Fix indentation warnings
Date: Fri, 18 Dec 2015 12:22:03 +0100
Message-ID: <1450437723-2978-12-git-send-email-anton.wuerfel@fau.de>
References: <1450437723-2978-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1450437723-2978-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Peter Hurley <peter@hurleysoftware.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Anton Wuerfel <anto>
List-Id: linux-serial@vger.kernel.org

Checkpatch complains about incorrect indentation of switch/case stateme=
nts.
This patch fixes the corresponding warnings. Additionally some indentat=
ion
is changed to match the correct format specified in the Linux Kernel
Coding Style.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
CC: linux-kernel@i4.cs.fau.de

---
v2: Split patch
---
 drivers/tty/serial/8250/8250_pci.c  | 12 ++++++------
 drivers/tty/serial/8250/8250_pnp.c  |  4 ++--
 drivers/tty/serial/8250/8250_port.c | 12 ++++++------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
index 09157fa..b0b47f9 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -841,12 +841,12 @@ static int pci_netmos_init(struct pci_dev *dev)
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
 		default:
 			if (num_serial =3D=3D 0) {
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/82=
50/8250_pnp.c
index 1ed67e0..3811c67 100644
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
index 343d050..5566c8e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2235,9 +2235,9 @@ static void serial8250_set_divisor(struct uart_po=
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
@@ -2252,9 +2252,9 @@ serial8250_get_baud_rate(struct uart_port *port, =
struct ktermios *termios,
 				  (port->uartclk + tolerance) / 16);
 }
=20
-void
-serial8250_do_set_termios(struct uart_port *port, struct ktermios *ter=
mios,
-			  struct ktermios *old)
+void serial8250_do_set_termios(struct uart_port *port,
+			       struct ktermios *termios,
+			       struct ktermios *old)
 {
 	struct uart_8250_port *up =3D up_to_u8250p(port);
 	unsigned char cval;
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
