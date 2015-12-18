From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v2 02/11] tty: serial: 8250: Replace spaces with tabs
Date: Fri, 18 Dec 2015 12:21:54 +0100
Message-ID: <1450437723-2978-3-git-send-email-anton.wuerfel@fau.de>
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

Indentation is changed to match the correct format of using tabs instea=
d
of spaces wherever possible.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
CC: linux-kernel@i4.cs.fau.de
---
v2: Split patch
---
 drivers/tty/serial/8250/8250_pci.c  | 12 ++++++------
 drivers/tty/serial/8250/8250_port.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
index ccf43cb..7f9f245 100644
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

--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
