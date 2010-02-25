From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH V2 12/14] Serial: sc26xx - Use ttySC0 instead of ttySC205
Date: Thu, 25 Feb 2010 14:35:46 +0100
Message-ID: <20100225133546.12331.17859.stgit@srv002.fuzzey.net>
References: <20100225133450.12331.94240.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f212.google.com ([209.85.219.212]:34503 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932504Ab0BYNft (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 08:35:49 -0500
Received: by mail-ew0-f212.google.com with SMTP id 4so1510191ewy.28
        for <linux-serial@vger.kernel.org>; Thu, 25 Feb 2010 05:35:48 -0800 (PST)
In-Reply-To: <20100225133450.12331.94240.stgit@srv002.fuzzey.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, tsbogend@alpha.franken.de

Use device name ttySC0 as per Documentation/devices.txt

Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/sc26xx.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index 2e17bbc..9b0ede0 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -918,8 +918,6 @@ static int __devinit sc26xx_probe(struct platform_device *dev)
 	if (err)
 		goto out_free_port;
 
-	sc26xx_reg.tty_driver->name_base = sc26xx_reg.minor;
-
 	err = uart_add_one_port(&sc26xx_reg, &up->port[0]);
 	if (err)
 		goto out_unregister_driver;

