From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH] tty/serial: fix config dependencies for samsung serial
Date: Tue, 02 Sep 2014 20:52:00 +0530
Message-ID: <1409671320-7604-1-git-send-email-ch.naveen@samsung.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60788 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbaIBP0q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Sep 2014 11:26:46 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Pankaj Dubey <pankaj.dubey@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Pankaj Dubey <pankaj.dubey@samsung.com>

Make the config symbols SERIAL_SAMSUNG_UARTS_4 and
SERIAL_SAMSUNG_UARTS depend on SERIAL_SAMSUNG rather than
PLAT_SAMSUNG.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 26cec64..4f27f0c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -230,14 +230,14 @@ config SERIAL_SAMSUNG
 
 config SERIAL_SAMSUNG_UARTS_4
 	bool
-	depends on PLAT_SAMSUNG
+	depends on SERIAL_SAMSUNG
 	default y if !(CPU_S3C2410 || CPU_S3C2412 || CPU_S3C2440 || CPU_S3C2442)
 	help
 	  Internal node for the common case of 4 Samsung compatible UARTs
 
 config SERIAL_SAMSUNG_UARTS
 	int
-	depends on PLAT_SAMSUNG
+	depends on SERIAL_SAMSUNG
 	default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
 	default 3
 	help
-- 
1.7.9.5

