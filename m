From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 2/6] pcmcia: handle error in serial_cs config calls
Date: Wed, 17 Feb 2010 18:32:50 +0100
Message-ID: <1266427974-32176-2-git-send-email-linux@dominikbrodowski.net>
References: <1266427974-32176-1-git-send-email-linux@dominikbrodowski.net>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:47781 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751597Ab0BQRdS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Feb 2010 12:33:18 -0500
In-Reply-To: <1266427974-32176-1-git-send-email-linux@dominikbrodowski.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-serial@vger.kernel.org

Do not ignore the error returned by simple_config() / multi_config().

CC: linux-serial@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/serial/serial_cs.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
index 0ee7239..8d38eab 100644
--- a/drivers/serial/serial_cs.c
+++ b/drivers/serial/serial_cs.c
@@ -695,11 +695,11 @@ static int serial_config(struct pcmcia_device * link)
 		info->multi = info->quirk->multi;
 
 	if (info->multi > 1)
-		multi_config(link);
+		i = multi_config(link);
 	else
-		simple_config(link);
+		i = simple_config(link);
 
-	if (info->ndev == 0)
+	if (i || info->ndev == 0)
 		goto failed;
 
 	/*
@@ -714,6 +714,7 @@ static int serial_config(struct pcmcia_device * link)
 	return 0;
 
 failed:
+	dev_warn(&link->dev, "serial_cs: failed to initialize\n");
 	serial_remove(link);
 	return -ENODEV;
 }
-- 
1.6.3.3

