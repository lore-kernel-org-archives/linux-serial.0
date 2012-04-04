From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH] serial: samsung: fix omission initialize ulcon in reset port fn()
Date: Tue,  3 Apr 2012 18:14:24 -0700
Message-ID: <1333502064-8006-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:47080 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab2DDBUu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Apr 2012 21:20:50 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, Kukjin Kim <kgene.kim@samsung.com>

Fix omission initialize ulcon in s3c24xx_serial_resetport(),
reset port function in drivers/tty/serial/samsung.c. It has
been happened from commit 0dfb3b41("serial: samsung: merge
all SoC specific port reset functions")

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/tty/serial/samsung.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index de249d2..d8b0aee 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -982,6 +982,7 @@ static void s3c24xx_serial_resetport(struct uart_port *port,
 
 	ucon &= ucon_mask;
 	wr_regl(port, S3C2410_UCON,  ucon | cfg->ucon);
+	wr_regl(port, S3C2410_ULCON, cfg->ulcon);
 
 	/* reset both fifos */
 	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
-- 
1.7.2.3

