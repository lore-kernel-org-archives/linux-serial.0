From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v7 07/15] tty: serial: 8250: Fix line continuation warning
Date: Thu, 14 Jan 2016 16:08:16 +0100
Message-ID: <1452784104-30840-8-git-send-email-anton.wuerfel@fau.de>
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

=46ixed checkpatch warning about an unnecessary line continuation in a
multi-line variable assignment.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_hp300.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/=
8250/8250_hp300.c
index 5e1b464..cf566bb 100644
--- a/drivers/tty/serial/8250/8250_hp300.c
+++ b/drivers/tty/serial/8250/8250_hp300.c
@@ -248,8 +248,8 @@ static int __init hp300_8250_init(void)
=20
 		/* Memory mapped I/O */
 		uart.port.iotype =3D UPIO_MEM;
-		uart.port.flags =3D UPF_SKIP_TEST | UPF_SHARE_IRQ \
-			      | UPF_BOOT_AUTOCONF;
+		uart.port.flags =3D UPF_SKIP_TEST | UPF_SHARE_IRQ
+				| UPF_BOOT_AUTOCONF;
 		/* XXX - no interrupt support yet */
 		uart.port.irq =3D 0;
 		uart.port.uartclk =3D HPAPCI_BAUD_BASE * 16;
--=20
1.9.1
