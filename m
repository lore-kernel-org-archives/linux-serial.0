From: Christian Pellegrin <chripell@gmail.com>
Subject: [PATCH] max3100 driver
Date: Fri, 10 Oct 2008 14:08:58 +0200
Message-ID: <12236405383272-git-send-email-chripell@gmail.com>
References: <20080920012454.e40f03cc.akpm@linux-foundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:16209 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbYJJMI7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2008 08:08:59 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1276295ugf.37
        for <linux-serial@vger.kernel.org>; Fri, 10 Oct 2008 05:08:57 -0700 (PDT)
In-Reply-To: <20080920012454.e40f03cc.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org


Hi,

This patch fixes a problem about PM in my code that I found when testing
patches that went in -mm. The full patch against the Linus tree can be
found at http://www.evolware.org/chri/paciugo/

---
diff --git a/drivers/serial/max3100.c b/drivers/serial/max3100.c
index 7a269a6..462d6a4 100644
--- a/drivers/serial/max3100.c
+++ b/drivers/serial/max3100.c
@@ -566,6 +566,7 @@ static void max3100_shutdown(struct uart_port *port)
 	if (s->workqueue) {
 		flush_workqueue(s->workqueue);
 		destroy_workqueue(s->workqueue);
+		s->workqueue = NULL;
 	}
 	if (s->irq)
 		free_irq(s->irq, s);
@@ -614,6 +615,7 @@ static int max3100_startup(struct uart_port *port)
 		dev_warn(&s->spi->dev, "cannot allocate irq %d\n", s->irq);
 		s->irq = 0;
 		destroy_workqueue(s->workqueue);
+		s->workqueue = NULL;
 		return -EBUSY;
 	}
 
@@ -884,7 +886,8 @@ static int max3100_resume(struct spi_device *spi)
 	enable_irq(s->irq);
 
 	s->conf_commit = 1;
-	max3100_dowork(s);
+	if (s->workqueue)
+		max3100_dowork(s);
 
 	return 0;
 }
