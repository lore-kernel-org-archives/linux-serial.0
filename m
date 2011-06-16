From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] serial: bfin_5xx: fix off-by-one with resource size
Date: Thu, 16 Jun 2011 18:31:42 -0400
Message-ID: <1308263502-22647-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:40546 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180Ab1FPWbM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jun 2011 18:31:12 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org

This doesn't cause any real bugs, but it should still be fixed.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/tty/serial/bfin_5xx.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/bfin_5xx.c b/drivers/tty/serial/bfin_5xx.c
index 9b1ff2b..957135a 100644
--- a/drivers/tty/serial/bfin_5xx.c
+++ b/drivers/tty/serial/bfin_5xx.c
@@ -1304,8 +1304,7 @@ static int bfin_serial_probe(struct platform_device *pdev)
 			goto out_error_free_peripherals;
 		}
 
-		uart->port.membase = ioremap(res->start,
-			res->end - res->start);
+		uart->port.membase = ioremap(res->start, resource_size(res));
 		if (!uart->port.membase) {
 			dev_err(&pdev->dev, "Cannot map uart IO\n");
 			ret = -ENXIO;
-- 
1.7.5.3

