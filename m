From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/3] serial: DC21285: depend on ARCH_FOOTBRIDGE instead of FOOTBRIDGE
Date: Tue,  1 Jul 2014 22:37:04 +0200
Message-ID: <1404247026-379-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39433 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbaGAUhg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Jul 2014 16:37:36 -0400
In-Reply-To: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

The Kconfig symbol FOOTBRIDGE is only defined if ARCH_FOOTBRIDGE is
enabled and the latter unconditionally selects the former. So they are
either both selected or none and so they are equivalent. To allow
removing FOOTBRIDGE switch the dependency of SERIAL_21285 to
ARCH_FOOTBRIDGE.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fb57159bad3a..570ca2ff55d1 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -380,7 +380,7 @@ config SERIAL_ZS_CONSOLE
=20
 config SERIAL_21285
 	tristate "DC21285 serial port support"
-	depends on FOOTBRIDGE
+	depends on ARCH_FOOTBRIDGE
 	select SERIAL_CORE
 	help
 	  If you have a machine based on a 21285 (Footbridge) StrongARM(R)/
--=20
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
