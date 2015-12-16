From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 09/11] tty: serial: 8250: Fix multi-line strings
Date: Wed, 16 Dec 2015 16:36:15 +0100
Message-ID: <1450280177-4460-10-git-send-email-anton.wuerfel@fau.de>
References: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Peter Hurley <peter@hurleysoftware.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Anton Wuerfel <anto>
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
CC: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_core.c | 3 +--
 drivers/tty/serial/8250/serial_cs.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8=
250/8250_core.c
index 3c29530..2b3731f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1174,8 +1174,7 @@ MODULE_LICENSE("GPL");
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
index a4bdcf6..65d341d 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -535,8 +535,7 @@ static int multi_config(struct pcmcia_device *link)
 		info->multi =3D 2;
 		if (pcmcia_loop_config(link, multi_config_check_notpicky,
 				       &base2)) {
-			dev_warn(&link->dev, "no usable port range "
-			       "found, giving up\n");
+			dev_warn(&link->dev, "no usable port range found, giving up\n");
 			return -ENODEV;
 		}
 	}
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
