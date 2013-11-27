From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] tty: atmel_serial: include <mach/hardware.h> explicitly
Date: Wed, 27 Nov 2013 10:38:31 +0100
Message-ID: <1385545111-1256-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50595 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab3K0Jim (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 04:38:42 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Andrew Victor <linux@maxim.org.za>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

When compiled for at91rm9200 (i.e. ARM) the driver needs among others
the symbol AT91RM9200_BASE_US0 which is defined in
arch/arm/mach-at91/include/mach/at91rm9200.h. This file is included
implicitly via several steps. As ARM's <asm/timex.h> will stop includin=
g
<mach/hardware.h> later in this series explicitly include
<mach/hardware.h>

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---

Notes:
    Hello,
   =20
    I want to send this patch as part of a series dropping <mach/timex.=
h>
    altogether. So please don't take this patch but only give your Ack =
if
    you're OK with me sending this patch via arm-soc.
   =20
    Thanks
    Uwe

 drivers/tty/serial/atmel_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atm=
el_serial.c
index c7d99af..de51964 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -47,6 +47,7 @@
=20
 #ifdef CONFIG_ARM
 #include <mach/cpu.h>
+#include <mach/hardware.h>
 #include <asm/gpio.h>
 #endif
=20
--=20
1.8.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
