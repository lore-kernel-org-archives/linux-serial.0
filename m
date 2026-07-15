Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C9B3C2B95;
	Wed, 15 Jul 2026 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100968; cv=none; b=pouTf3Thz2qLOP3MoNW0ZRDgya24vrbwJPujD30iC0spaFukqPG5JE1Ocm1dTziFi010SP7PRqUWuTnTrjKfUxGflb0qsj+SRqqWTZ9qd7hXsVwF1PkFDK8YCZXvl6rP1JdORutSfX5aYCLO9UdoFt4UIyBYT3/xZ7ARmDfHqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100968; c=relaxed/simple;
	bh=HJh2sB0wqVfOhsBQsrkDngxgFoxU2+s1fHXP2FNCyx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FrBYP4GH9wLogyt0HqfQlftwjAFcXwcepxdI4FpLodv/JuiA0HAIuokR1NAnQkMNYZCKlyZZM40F18DDvgSOStFWGDf57QZvNf/hJao5s20i2+CawbKa2OlYupLYOaOctmb3G/iD2BLl0TVly5j49oVuN9lYxfNU60SXuDR42vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d08a44dc801f11f1aa26b74ffac11d73-20260715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:72b1edc7-2231-4f34-8cc7-05d9a7021e6c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-45
X-CID-META: VersionHash:e7bac3a,CLOUDID:8050d2deb3e17248bd1f4c6148146919,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d08a44dc801f11f1aa26b74ffac11d73-20260715
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1420405809; Wed, 15 Jul 2026 15:35:55 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: andy@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@kernel.org
Subject: [PATCH v2] serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms
Date: Wed, 15 Jul 2026 15:35:46 +0800
Message-Id: <20260715073546.1875083-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b1b4efea05a5 ("serial: 8250_mid: Disable DMA for selected
platforms") replaced the dnv_board setup and exit callbacks with
PTR_IF(false, ...), which evaluates to NULL. However, the three call
sites in mid8250_probe() and mid8250_remove() unconditionally dereference
these function pointers without NULL checks, causing a NULL pointer
dereference (kernel oops) on any Denverton (DNV), Ice Lake Xeon D
(ICX-D/CDF), or Snowridge (SNR) platform.

Fix this by adding the missing NULL checks before calling the setup
and exit callbacks.

Fixes: b1b4efea05a5 ("serial: 8250_mid: Disable DMA for selected platforms")
Cc: stable@kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
v2:
 - Changed the setup call from a ternary expression to an if-block as suggested.
 - Removed the redundant Cc lines from the commit message body.
v1: 
 - initial submission

 drivers/tty/serial/8250/8250_mid.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index f88809ff370b..82656645b8a6 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -318,9 +318,11 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-	ret = mid->board->setup(mid, &uart.port);
-	if (ret)
-		return ret;
+	if (mid->board->setup) {
+		ret = mid->board->setup(mid, &uart.port);
+		if (ret)
+			return ret;
+	}
 
 	ret = mid8250_dma_setup(mid, &uart);
 	if (ret)
@@ -336,7 +338,8 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err:
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 	return ret;
 }
 
@@ -346,7 +349,8 @@ static void mid8250_remove(struct pci_dev *pdev)
 
 	serial8250_unregister_port(mid->line);
 
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 }
 
 static const struct mid8250_board pnw_board = {
-- 
2.25.1

