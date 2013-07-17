From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] serial/efm32-uart: use COMPILE_TEST symbol to extend compile test coverage
Date: Wed, 17 Jul 2013 08:48:41 +0200
Message-ID: <1374043721-30677-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1374043721-30677-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38563 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3GQGsz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Jul 2013 02:48:55 -0400
In-Reply-To: <1374043721-30677-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

The driver fails to build on x86 because writel_relaxed isn't available
there. That function exists on arm, arm64, avr32, hexagon, mips and sh,
but adding all these is overkill so stick to arm only.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 5e3d689..1e31d7d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1424,8 +1424,8 @@ config SERIAL_AR933X_NR_UARTS
 	  to support.
=20
 config SERIAL_EFM32_UART
-	tristate "EFM32 UART/USART port."
-	depends on ARCH_EFM32
+	tristate "EFM32 UART/USART port"
+	depends on ARM && (ARCH_EFM32 || COMPILE_TEST)
 	select SERIAL_CORE
 	help
 	  This driver support the USART and UART ports on
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
