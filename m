Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57059383C6B;
	Thu, 23 Jul 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788464; cv=none; b=WYcv/KQUnbfunydTW4flRc7BVBKDPLyHxERlWRU+FbcBfVvPpdLGblDDLhmJ2kFz8GrUotBoS3lcFtbkQSGmUz5JS7VFH4Yawnn11SwrD3fx+zB3cKrkZWs647G078WtYsLNsKD4Pwqo5HKknJgtFnRGugVIhLYoI9vDYBFfxlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788464; c=relaxed/simple;
	bh=qp6ISM54pr1vU018Ofp7sK0RoKKpV8R+J67Y6Q/ZTzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N4vrXoRjaBphZu3xG6DELixOLi9T8eeHiOCqcIUuqgi8DX477Re5ADBz5KBntgDyhQDaICq/jQbQuLObroGeTCNU4gAH8OGrXllDwZYy7839uCkHtKN96ez7TJa+rwCL/GUAQEkgZNk+dsf3c1Tuy7NSBCg+DuLbrCqRN81odE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 858a1402866011f1aa26b74ffac11d73-20260723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fb67ebae-8bb3-49ac-aa66-f484d78f2d40,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:ad0ddb55e5061eadf6b171baa33186f8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	16|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 858a1402866011f1aa26b74ffac11d73-20260723
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1679291485; Thu, 23 Jul 2026 14:34:14 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] serial: bcm63xx-uart: silence false positive coccinelle warning on clk_put
Date: Thu, 23 Jul 2026 14:34:09 +0800
Message-Id: <604886147edb67c3ed85b192eb3f7a4a6dd0f0ac.1784788388.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coccinelle warns about missing clk_put on the error path after clk_get,
but the error path returns with an ERR_PTR where clk_put must not be
called.  Restructure into a single if block so the logic is clear to
silence false positive coccinelle warning.

Commit 580d952e44de ("tty: serial: bcm63xx: fix missing clk_put() in
bcm63xx_uart") previously tried to fix this same warning by adding a
clk_put, which was reverted because it was wrong.
Prevent anyone from making the same mistake again.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/tty/serial/bcm63xx_uart.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 544695cb184c..1754cf252b7c 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -838,11 +838,12 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	port->irq = ret;
 
 	clk = clk_get(&pdev->dev, "refclk");
-	if (IS_ERR(clk) && pdev->dev.of_node)
-		clk = of_clk_get(pdev->dev.of_node, 0);
-
-	if (IS_ERR(clk))
-		return -ENODEV;
+	if (IS_ERR(clk)) {
+		if (pdev->dev.of_node)
+			clk = of_clk_get(pdev->dev.of_node, 0);
+		if (IS_ERR(clk))
+			return -ENODEV;
+	}
 
 	port->iotype = UPIO_MEM;
 	port->ops = &bcm_uart_ops;
-- 
2.25.1

