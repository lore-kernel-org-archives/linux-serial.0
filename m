From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] tty: 8250, remove shadow and unused variables
Date: Mon, 20 Jun 2016 12:57:43 +0200
Message-ID: <20160620105743.8280-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Matt Schulte <matts@commtech-fastcom.com>
List-Id: linux-serial@vger.kernel.org

The compiler complains about variables that are set, but never used:
* intX variables in exar_handle_irq
  drivers/tty/serial/8250/8250_port.c:1864:34: warning: variable =E2=80=
=98int3=E2=80=99 set but not used [-Wunused-but-set-variable]
* val variable in pci_quatech_wqopr
  drivers/tty/serial/8250/8250_pci.c:1139:10: warning: variable =E2=80=98=
val=E2=80=99 set but not used [-Wunused-but-set-variable]

And about a shadow variable:
* tmout in wait_for_xmitr is defined twice with the same type. Both of
  them are also initialized before use.

Remove all of them.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Matt Schulte <matts@commtech-fastcom.com>
---
 drivers/tty/serial/8250/8250_pci.c  |  4 ++--
 drivers/tty/serial/8250/8250_port.c | 11 ++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
index 8dd250fbd367..3d6287a8981e 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1136,11 +1136,11 @@ static int pci_quatech_rqopr(struct uart_8250_p=
ort *port)
 static void pci_quatech_wqopr(struct uart_8250_port *port, u8 qopr)
 {
 	unsigned long base =3D port->port.iobase;
-	u8 LCR, val;
+	u8 LCR;
=20
 	LCR =3D inb(base + UART_LCR);
 	outb(0xBF, base + UART_LCR);
-	val =3D inb(base + UART_SCR);
+	inb(base + UART_SCR);
 	outb(qopr, base + UART_SCR);
 	outb(LCR, base + UART_LCR);
 }
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
index b10d05f2004b..c8d8d245350b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1861,7 +1861,6 @@ static int serial8250_default_handle_irq(struct u=
art_port *port)
  */
 static int exar_handle_irq(struct uart_port *port)
 {
-	unsigned char int0, int1, int2, int3;
 	unsigned int iir =3D serial_port_in(port, UART_IIR);
 	int ret;
=20
@@ -1869,10 +1868,10 @@ static int exar_handle_irq(struct uart_port *po=
rt)
=20
 	if ((port->type =3D=3D PORT_XR17V35X) ||
 	   (port->type =3D=3D PORT_XR17D15X)) {
-		int0 =3D serial_port_in(port, 0x80);
-		int1 =3D serial_port_in(port, 0x81);
-		int2 =3D serial_port_in(port, 0x82);
-		int3 =3D serial_port_in(port, 0x83);
+		serial_port_in(port, 0x80);
+		serial_port_in(port, 0x81);
+		serial_port_in(port, 0x82);
+		serial_port_in(port, 0x83);
 	}
=20
 	return ret;
@@ -1994,8 +1993,6 @@ static void wait_for_xmitr(struct uart_8250_port =
*up, int bits)
=20
 	/* Wait up to 1s for flow control if necessary */
 	if (up->port.flags & UPF_CONS_FLOW) {
-		unsigned int tmout;
-
 		for (tmout =3D 1000000; tmout; tmout--) {
 			unsigned int msr =3D serial_in(up, UART_MSR);
 			up->msr_saved_flags |=3D msr & MSR_SAVE_FLAGS;
--=20
2.9.0
