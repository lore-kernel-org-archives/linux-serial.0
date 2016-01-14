From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v7 02/15] tty: serial: 8250: Replace spaces with tabs
Date: Thu, 14 Jan 2016 16:08:11 +0100
Message-ID: <1452784104-30840-3-git-send-email-anton.wuerfel@fau.de>
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

Indentation is changed to match the correct format of using tabs instea=
d
of spaces wherever possible.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_pci.c  | 12 ++++++------
 drivers/tty/serial/8250/8250_port.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
index ecd5a32..534ca18 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -721,7 +721,7 @@ static int pci_ni8430_init(struct pci_dev *dev)
 	 */
 	pcibios_resource_to_bus(dev->bus, &region, &dev->resource[bar]);
 	device_window =3D ((region.start + MITE_IOWBSR1_WIN_OFFSET) & 0xfffff=
f00)
-	                | MITE_IOWBSR1_WENAB | MITE_IOWBSR1_WSIZE;
+			| MITE_IOWBSR1_WENAB | MITE_IOWBSR1_WSIZE;
 	writel(device_window, p + MITE_IOWBSR1);
=20
 	/* Set window access to go to RAMSEL IO address space */
@@ -1763,7 +1763,7 @@ xr17v35x_has_slave(struct serial_private *priv)
 	const int dev_id =3D priv->dev->device;
=20
 	return ((dev_id =3D=3D PCI_DEVICE_ID_EXAR_XR17V4358) ||
-	        (dev_id =3D=3D PCI_DEVICE_ID_EXAR_XR17V8358));
+		(dev_id =3D=3D PCI_DEVICE_ID_EXAR_XR17V8358));
 }
=20
 static int
@@ -1863,8 +1863,8 @@ pci_fastcom335_setup(struct serial_private *priv,
=20
 static int
 pci_wch_ch353_setup(struct serial_private *priv,
-                    const struct pciserial_board *board,
-                    struct uart_8250_port *port, int idx)
+		    const struct pciserial_board *board,
+		    struct uart_8250_port *port, int idx)
 {
 	port->port.flags |=3D UPF_FIXED_TYPE;
 	port->port.type =3D PORT_16550A;
@@ -1873,8 +1873,8 @@ pci_wch_ch353_setup(struct serial_private *priv,
=20
 static int
 pci_wch_ch38x_setup(struct serial_private *priv,
-                    const struct pciserial_board *board,
-                    struct uart_8250_port *port, int idx)
+		    const struct pciserial_board *board,
+		    struct uart_8250_port *port, int idx)
 {
 	port->port.flags |=3D UPF_FIXED_TYPE;
 	port->port.type =3D PORT_16850;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
index 7f3bd7b..f2e588e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -52,7 +52,7 @@
 #define DEBUG_AUTOCONF(fmt...)	do { } while (0)
 #endif
=20
-#define BOTH_EMPTY 	(UART_LSR_TEMT | UART_LSR_THRE)
+#define BOTH_EMPTY	(UART_LSR_TEMT | UART_LSR_THRE)
=20
 /*
  * Here we define the default xmit fifo size used for each type of UAR=
T.
@@ -2254,7 +2254,7 @@ serial8250_get_baud_rate(struct uart_port *port, =
struct ktermios *termios,
=20
 void
 serial8250_do_set_termios(struct uart_port *port, struct ktermios *ter=
mios,
-		          struct ktermios *old)
+			  struct ktermios *old)
 {
 	struct uart_8250_port *up =3D up_to_u8250p(port);
 	unsigned char cval;
--=20
1.9.1
