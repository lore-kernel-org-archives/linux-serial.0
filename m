From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH V2 07/14] Serial: sc26xx - simplify port initialisation.
Date: Thu, 25 Feb 2010 14:35:25 +0100
Message-ID: <20100225133525.12331.9445.stgit@srv002.fuzzey.net>
References: <20100225133450.12331.94240.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f212.google.com ([209.85.219.212]:34503 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932550Ab0BYNfb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 08:35:31 -0500
Received: by mail-ew0-f212.google.com with SMTP id 4so1510191ewy.28
        for <linux-serial@vger.kernel.org>; Thu, 25 Feb 2010 05:35:30 -0800 (PST)
In-Reply-To: <20100225133450.12331.94240.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, tsbogend@alpha.franken.de

Just use a memcpy

Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/sc26xx.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index 316d110..69b7ae7 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -680,17 +680,8 @@ static int __devinit sc26xx_probe(struct platform_device *dev)
 
 	sc26xx_port = &up->port[0];
 
+	memcpy(&up->port[1], &up->port[0], sizeof(up->port[0]));
 	up->port[1].line = 1;
-	up->port[1].ops = &sc26xx_ops;
-	up->port[1].type = PORT_SC26XX;
-	up->port[1].uartclk = (29491200 / 16); /* arbitrary */
-
-	up->port[1].mapbase = up->port[0].mapbase;
-	up->port[1].membase = up->port[0].membase;
-	up->port[1].iotype = UPIO_MEM;
-	up->port[1].irq = up->port[0].irq;
-
-	up->port[1].dev = &dev->dev;
 
 	sc26xx_init_masks(up, 1, sc26xx_data[1]);
 

