From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] serial/8250_hp300: Missing 8250 register interface conversion bits
Date: Mon, 15 Oct 2012 22:13:12 +0200
Message-ID: <1350331992-15119-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philip Blundell <philb@gnu.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

commit 2655a2c76f80d91da34faa8f4e114d1793435ed3 ("8250: use the 8250
register interface not the legacy one") forgot to fully switch one
instance of struct uart_port to struct uart_8250_port, causing the
following compile failure:

drivers/tty/serial/8250/8250_hp300.c: In function =E2=80=98hpdca_init_o=
ne=E2=80=99:
drivers/tty/serial/8250/8250_hp300.c:174: error: =E2=80=98uart=E2=80=99=
 undeclared (first use in this function)
drivers/tty/serial/8250/8250_hp300.c:174: error: (Each undeclared ident=
ifier is reported only once
drivers/tty/serial/8250/8250_hp300.c:174: error: for each function it a=
ppears in.)

This went unnoticed in -next, as CONFIG_HPDCA is not set to y by
allmodconfig.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Only compile-tested, due to lack of hardware

 drivers/tty/serial/8250/8250_hp300.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/=
8250/8250_hp300.c
index 8f1dd2c..f3d0edf 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -162,7 +162,7 @@ int __init hp300_setup_serial_console(void)
 static int __devinit hpdca_init_one(struct dio_dev *d,
 				const struct dio_device_id *ent)
 {
-	struct uart_port port;
+	struct uart_8250_port uart;
 	int line;
=20
 #ifdef CONFIG_SERIAL_8250_CONSOLE
@@ -174,19 +174,19 @@ static int __devinit hpdca_init_one(struct dio_de=
v *d,
 	memset(&uart, 0, sizeof(uart));
=20
 	/* Memory mapped I/O */
-	port.iotype =3D UPIO_MEM;
-	port.flags =3D UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF;
-	port.irq =3D d->ipl;
-	port.uartclk =3D HPDCA_BAUD_BASE * 16;
-	port.mapbase =3D (d->resource.start + UART_OFFSET);
-	port.membase =3D (char *)(port.mapbase + DIO_VIRADDRBASE);
-	port.regshift =3D 1;
-	port.dev =3D &d->dev;
+	uart.port.iotype =3D UPIO_MEM;
+	uart.port.flags =3D UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF=
;
+	uart.port.irq =3D d->ipl;
+	uart.port.uartclk =3D HPDCA_BAUD_BASE * 16;
+	uart.port.mapbase =3D (d->resource.start + UART_OFFSET);
+	uart.port.membase =3D (char *)(uart.port.mapbase + DIO_VIRADDRBASE);
+	uart.port.regshift =3D 1;
+	uart.port.dev =3D &d->dev;
 	line =3D serial8250_register_8250_port(&uart);
=20
 	if (line < 0) {
 		printk(KERN_NOTICE "8250_hp300: register_serial() DCA scode %d"
-		       " irq %d failed\n", d->scode, port.irq);
+		       " irq %d failed\n", d->scode, uart.port.irq);
 		return -ENOMEM;
 	}
=20
--=20
1.7.0.4
