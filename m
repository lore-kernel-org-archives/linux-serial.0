From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/12] tty: Add "spi:" prefix for spi modalias
Date: Fri, 26 Aug 2011 13:58:15 -0700
Message-ID: <1314392301-25140-6-git-send-email-gregkh@suse.de>
References: <20110826191143.GC5557@kroah.com>
 <1314392301-25140-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37780 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149Ab1HZU6y (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 16:58:54 -0400
In-Reply-To: <1314392301-25140-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Axel Lin <axel.lin@gmail.com>, stable <stable@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Axel Lin <axel.lin@gmail.com>

Since commit e0626e38 (spi: prefix modalias with "spi:"),
the spi modalias is prefixed with "spi:".

This patch adds "spi:" prefix and removes "-spi" suffix in the modalias.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/max3107-aava.c |    2 +-
 drivers/tty/serial/max3107.c      |    2 +-
 drivers/tty/serial/mrst_max3110.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max3107-aava.c b/drivers/tty/serial/max3107-aava.c
index a1fe304..d73aadd 100644
--- a/drivers/tty/serial/max3107-aava.c
+++ b/drivers/tty/serial/max3107-aava.c
@@ -340,5 +340,5 @@ module_exit(max3107_exit);
 
 MODULE_DESCRIPTION("MAX3107 driver");
 MODULE_AUTHOR("Aavamobile");
-MODULE_ALIAS("aava-max3107-spi");
+MODULE_ALIAS("spi:aava-max3107");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/serial/max3107.c b/drivers/tty/serial/max3107.c
index 750b4f6..a816460 100644
--- a/drivers/tty/serial/max3107.c
+++ b/drivers/tty/serial/max3107.c
@@ -1209,5 +1209,5 @@ module_exit(max3107_exit);
 
 MODULE_DESCRIPTION("MAX3107 driver");
 MODULE_AUTHOR("Aavamobile");
-MODULE_ALIAS("max3107-spi");
+MODULE_ALIAS("spi:max3107");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index a764bf9..23bc743 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -917,4 +917,4 @@ module_init(serial_m3110_init);
 module_exit(serial_m3110_exit);
 
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("max3110-uart");
+MODULE_ALIAS("spi:max3110-uart");
-- 
1.7.6.1

