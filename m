Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A453363;
	Tue, 14 Jan 2025 03:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825622; cv=none; b=C8BMzjDKQV16c6Y0Q5d9yq6/ocQF+UwbyUq5P3/dLsMfvmocHIAT5/fUosf+pitcPyxwr6QIuRz4clHdMglpnWD7k1ZI85I4vzbNR+Z80y1uuqWAIP2mtk8N9WG0zixrYJIlGo1p1AcAWoTrWvbdfFzx1jM9ykFUB4GXgF7/u2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825622; c=relaxed/simple;
	bh=5/dE7Q6Ys5McJRkvotj6rBANCWfxZjFwqhJy18FZRJE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t+7dqTzYA/IgPSGwuzlCRIFtq1pqGgEtgPy/zjLHNrwr/TBmgYsJ9DvwcUhSQVDb8V+pjgyLMi8k5V26ZJ/FADjiIZdrGKRwtNoGDkkG8R44J894yuXb7IFSrzEtp9WYJoHLIWFXUxBnZOgCaprQkCEmImVJZ0nTp5Ajw4lXK4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=s67+htHC; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s67+htHC"
X-UUID: 52bfc69ad22811efbd192953cf12861f-20250114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9y9THO3YGyTevXlUAOQxK2U1NAtOu/fcfdt10LFF+wI=;
	b=s67+htHC/VRh5hdl4uDuYTP34L6SdZ5yYzs6KSFOPHVvQmHjbWbIS81pihr/amGQwuzmvdCuA/NueDfVDjKVbxhZBO8PudNX1HrRinAy4J+m9L9jBOt9mW5Vndgj0nCPwc5L6/wSXR4IJtF2k6UaTAk4aCfIr1gwMAWmssGRJIA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:980b05b1-9390-4fc6-a5f7-f9f1e0c09248,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:fff6d637-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 52bfc69ad22811efbd192953cf12861f-20250114
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 977970291; Tue, 14 Jan 2025 11:33:30 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 14 Jan 2025 11:33:28 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 14 Jan 2025 11:33:28 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC: <yenchia.chen@mediatek.com>, <yj.chiang@mediatek.com>,
	<tbergstrom@nvidia.com>, <yujiaoliang@vivo.com>,
	<u.kleine-koenig@baylibre.com>, <treapking@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] serial: 8250_mtk: Add ACPI support
Date: Tue, 14 Jan 2025 11:33:21 +0800
Message-ID: <20250114033324.3533292-1-yenchia.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add ACPI support to 8250_mtk driver. This makes it possible to
use uart with edk2 UEFI firmware.

Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 31 ++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index b44de2ed7413..a4f1c30f77b0 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/acpi.h>
 
 #include "8250.h"
 
@@ -519,6 +520,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 	struct mtk8250_data *data;
 	struct resource *regs;
 	int irq, err;
+	acpi_handle hdl = ACPI_HANDLE(&pdev->dev);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -545,8 +547,12 @@ static int mtk8250_probe(struct platform_device *pdev)
 		err = mtk8250_probe_of(pdev, &uart.port, data);
 		if (err)
 			return err;
-	} else
-		return -ENODEV;
+	} else {
+		if (!hdl) {
+			dev_err(&pdev->dev, "no device\n");
+			return -ENODEV;
+		}
+	}
 
 	spin_lock_init(&uart.port.lock);
 	uart.port.mapbase = regs->start;
@@ -560,16 +566,22 @@ static int mtk8250_probe(struct platform_device *pdev)
 	uart.port.private_data = data;
 	uart.port.shutdown = mtk8250_shutdown;
 	uart.port.startup = mtk8250_startup;
-	uart.port.set_termios = mtk8250_set_termios;
-	uart.port.uartclk = clk_get_rate(data->uart_clk);
+	if (hdl) {
+		uart.port.uartclk = 26000000;
+	} else {
+		uart.port.set_termios = mtk8250_set_termios;
+		uart.port.uartclk = clk_get_rate(data->uart_clk);
+	}
 #ifdef CONFIG_SERIAL_8250_DMA
 	if (data->dma)
 		uart.dma = data->dma;
 #endif
 
-	/* Disable Rate Fix function */
-	writel(0x0, uart.port.membase +
+	if (!hdl) {
+		/* Disable Rate Fix function */
+		writel(0x0, uart.port.membase +
 			(MTK_UART_RATE_FIX << uart.port.regshift));
+	}
 
 	platform_set_drvdata(pdev, data);
 
@@ -647,11 +659,18 @@ static const struct of_device_id mtk8250_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk8250_of_match);
 
+static const struct acpi_device_id mtk8250_acpi_match[] = {
+	{ "MTKI0511", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, mtk8250_acpi_match);
+
 static struct platform_driver mtk8250_platform_driver = {
 	.driver = {
 		.name		= "mt6577-uart",
 		.pm		= &mtk8250_pm_ops,
 		.of_match_table	= mtk8250_of_match,
+		.acpi_match_table = ACPI_PTR(mtk8250_acpi_match),
 	},
 	.probe			= mtk8250_probe,
 	.remove			= mtk8250_remove,
-- 
2.45.2

