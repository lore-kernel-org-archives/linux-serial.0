From: Zhenwen Xu <helight.xu@gmail.com>
Subject: [PATCH]some cleanup drivers/serial/serial_core.c and serial_cs.c
Date: Thu, 5 Mar 2009 16:46:56 +0800
Message-ID: <20090305084656.GA5931@helight>
Reply-To: Zhenwen Xu <helight.xu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:24925 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287AbZCEIra (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Mar 2009 03:47:30 -0500
Received: by ti-out-0910.google.com with SMTP id d10so3730432tib.23
        for <linux-serial@vger.kernel.org>; Thu, 05 Mar 2009 00:47:27 -0800 (PST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-serial@vger.kernel.org


The file should be "linux/drivers/serial/serial_core.c",
but "linux/drivers/char/core.c".

And the words "Based on drivers/char/serial.c," make people 
confused, because there is no file named "serial.c" in "drivers/char/"

And the line is over 80.
-- 
---------------------------------
Zhenwen Xu - Open and Free
Home Page:	http://zhwen.org
My Studio:	http://dim4.cn

>From 47dd82dfec448a6a76593479858f5020e00c34d9 Mon Sep 17 00:00:00 2001
From: Zhenwen Xu<helight.xu@gmail.com>
Date: Thu, 5 Mar 2009 16:32:18 +0800
Subject: [PATCH] some cleanup drivers/serial/serial_core.c and serial_cs.c


Signed-off-by: Zhenwen Xu<helight.xu@gmail.com>
---
 drivers/serial/serial_core.c |    5 +++--
 drivers/serial/serial_cs.c   |    3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 42f4e66..6aaa2cf 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1,9 +1,10 @@
 /*
- *  linux/drivers/char/core.c
+ *  linux/drivers/serial/serial_core.c
  *
  *  Driver core for serial ports
  *
- *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
+ *  Based on drivers/char/serial.c which was contained in earlier kernel,
+ *  by Linus Torvalds, Theodore Ts'o.
  *
  *  Copyright 1999 ARM Limited
  *  Copyright (C) 2000-2001 Deep Blue Solutions Ltd.
diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index 7546aa8..629b0d1 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -113,7 +113,8 @@ struct serial_cfg_mem {
  * manfid 0x0160, 0x0104
  * This card appears to have a 14.7456MHz clock.
  */
-static void quirk_setup_brainboxes_0104(struct pcmcia_device *link, struct uart_port *port)
+static void
+quirk_setup_brainboxes_0104(struct pcmcia_device *link, struct uart_port *port)
 {
 	port->uartclk = 14745600;
 }
-- 
1.5.6.5

