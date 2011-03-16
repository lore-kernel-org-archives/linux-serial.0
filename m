From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/76] tty: serial: bfin_sport_uart: fix signedness error
Date: Wed, 16 Mar 2011 14:11:31 -0700
Message-ID: <1300309966-5745-1-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:60952 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab1CPVMt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:12:49 -0400
In-Reply-To: <20110316205746.GA2938@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Vasiliy Kulikov <segoon@openwall.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Vasiliy Kulikov <segoon@openwall.com>

sport->port.irq is unsigned, check for <0 doesn't make sense.
Explicitly cast it to int to check for error.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/bfin_sport_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index e95c524..c3ec0a6 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -788,7 +788,7 @@ static int __devinit sport_uart_probe(struct platform_device *pdev)
 		sport->port.mapbase = res->start;
 
 		sport->port.irq = platform_get_irq(pdev, 0);
-		if (sport->port.irq < 0) {
+		if ((int)sport->port.irq < 0) {
 			dev_err(&pdev->dev, "No sport RX/TX IRQ specified\n");
 			ret = -ENOENT;
 			goto out_error_unmap;
-- 
1.7.4.1

