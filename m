From: Bin Liu <b-liu@ti.com>
Subject: [PATCH v2] driver: serial: omap: fix compilation error
Date: Thu, 23 May 2013 12:51:17 -0500
Message-ID: <1369331477-28114-1-git-send-email-b-liu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56175 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757440Ab3EWSLk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 May 2013 14:11:40 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Bin Liu <b-liu@ti.com>

Fix a compilation error when CONFIG_PM_SLEEP is unset.

Signed-off-by: Bin Liu <b-liu@ti.com>
Ack-Tested-by: Sourav Poddar<sourav.poddar@ti.com>
---
 drivers/tty/serial/omap-serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 352fcef..a1d694a 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1327,7 +1327,7 @@ static int serial_omap_resume(struct device *dev)
 }
 #else
 #define serial_omap_prepare NULL
-#define serial_omap_prepare NULL
+#define serial_omap_complete NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static void omap_serial_fill_features_erratas(struct uart_omap_port *up)
-- 
1.7.0.4

