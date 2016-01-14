From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH v7 09/15] tty: serial: 8250: Fix multi-line strings
Date: Thu, 14 Jan 2016 16:08:18 +0100
Message-ID: <1452784104-30840-10-git-send-email-anton.wuerfel@fau.de>
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

Merged user-visible multi-line strings into a single line according to =
the
Linux Kernel Coding Style, which allows user-visible strings to exceed =
the
maximum line length of 80 characters. The main reason for this is to
facilitate grepping for these strings.
However, some strings were ignored in this patch, because the use of
format specifiers breaks the ability to grep anyway.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_core.c | 3 +--
 drivers/tty/serial/8250/serial_cs.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8=
250/8250_core.c
index d042ad5..b60b58b 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1173,8 +1173,7 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 serial driver");
=20
 module_param(share_irqs, uint, 0644);
-MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 dev=
ices"
-	" (unsafe)");
+MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 dev=
ices (unsafe)");
=20
 module_param(nr_uarts, uint, 0644);
 MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __=
MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8=
250/serial_cs.c
index 2b7309d..933c268 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -533,8 +533,8 @@ static int multi_config(struct pcmcia_device *link)
 		info->multi =3D 2;
 		if (pcmcia_loop_config(link, multi_config_check_notpicky,
 				       &base2)) {
-			dev_warn(&link->dev, "no usable port range "
-			       "found, giving up\n");
+			dev_warn(&link->dev,
+				 "no usable port range found, giving up\n");
 			return -ENODEV;
 		}
 	}
--=20
1.9.1
