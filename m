From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH 07/12] Serial: sc26xx - simplify port initialisation.
Date: Sat, 13 Feb 2010 17:10:17 +0100
Message-ID: <20100213161017.22311.87554.stgit@srv002.fuzzey.net>
References: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:45000 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab0BMQKT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Feb 2010 11:10:19 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2648139ewy.28
        for <linux-serial@vger.kernel.org>; Sat, 13 Feb 2010 08:10:19 -0800 (PST)
In-Reply-To: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tsbogend@alpha.franken.de

Just use a memcpy

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
 

