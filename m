From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [RFC PATCH 7/9] Serial: sc26xx - simplify port initialisation.
Date: Sat, 21 Nov 2009 14:40:19 +0100
Message-ID: <20091121134019.16090.69797.stgit@srv002.fuzzey.net>
References: <20091121133951.16090.74411.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41031 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985AbZKUNkP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Nov 2009 08:40:15 -0500
In-Reply-To: <20091121133951.16090.74411.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: tsbogend@alpha.franken.de, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

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
 

