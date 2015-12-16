From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 08/11] tty: serial: 8250: Add parentheses to macro
Date: Wed, 16 Dec 2015 16:36:14 +0100
Message-ID: <1450280177-4460-9-git-send-email-anton.wuerfel@fau.de>
References: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Peter Hurley <peter@hurleysoftware.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Anton Wuerfel <anto>
List-Id: linux-serial@vger.kernel.org

This patch fixes a checkpatch warning caused by missing parentheses
in the definition of a macro.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
CC: linux-kernel@i4.cs.fau.de
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8=
250/8250_core.c
index 67147b2..3c29530 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -686,7 +686,7 @@ static int __init univ8250_console_init(void)
 }
 console_initcall(univ8250_console_init);
=20
-#define SERIAL8250_CONSOLE	&univ8250_console
+#define SERIAL8250_CONSOLE	(&univ8250_console)
 #else
 #define SERIAL8250_CONSOLE	NULL
 #endif
--=20
1.9.1
