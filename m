Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBDC376496;
	Thu, 23 Apr 2026 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776925441; cv=none; b=ndkbFsRiPo+8JUUZIJhAbu4ZV8ptjDnvvTForkvRRmgO9FfqeFMUX70+HXymJPqPx9Y8Z0HnYcBJL2UA5QIsggw3K3w9v1vS2yT+vEXAEb3hZOp+lvDdRsn2TyEv3tG1wu0IigOZroZIf3kGjMtnxMb0N64vj2MRYFoi+dzgDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776925441; c=relaxed/simple;
	bh=rfcgibu0c4SNaJIOPHTylvWuJbZHlSROZbCEeQYTDQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om3AunXks/BY7KKw20zloirA0jnubfQZHoVMbLGyA8JxUwo7B/n2qHJ3lQ1r5lEwXl1vtN4fCQi8B+be52d1x8y4CLt3qyQbfnVEyFCBWWEqDYnNbCjNdthyK7qOn5byx4KHkhfKMRFm/kZwY9kBjRpmLeF/MSISYozR/RPFh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JVJNIgra; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JVJNIgra"
X-UUID: fd416fde3edc11f19a16598d5ca7f8ec-20260423
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kJAGLINp/Pud7AOgEdry/ygDJXpxw4I0iRZZy5NIKXY=;
	b=JVJNIgraYtQvraC4r6eCDrv9Byqv/4MAnHDM2lTxTD5diH66CNOqRO+SpEGP6eMcQpTizg+UpyBebadpF3MUgGmKbstgiiWE6RbYkoHyjVXJYdEULxOw2696pavtulaPLp7e7zSlA2baXiLacetdHM13RdlTE2+jED7fGomPZEw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:41437f65-f73e-44f7-a8fc-6485720d9d02,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:9363c88f-6df4-4a3d-a7a4-fbdc42d669ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fd416fde3edc11f19a16598d5ca7f8ec-20260423
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <mtk07317@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1131951406; Thu, 23 Apr 2026 14:23:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 23 Apr 2026 14:23:47 +0800
Received: from mediatek.com (10.233.130.16) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Thu, 23 Apr 2026 14:23:47 +0800
Received: by mediatek.com (Postfix, from userid 10007317)
	id 7FD3B200C6; Thu, 23 Apr 2026 14:23:47 +0800 (CST)
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Digits_Upstream_Group@mediatek.com>,
	<zhiyong.tao@mediatek.com>, <liguo.zhang@mediatek.com>,
	<Vasanth.Reddy@mediatek.com>, Yenchia Chen <yenchia.chen@mediatek.com>
Subject: [PATCH] MEDIATEK: serial: 8250_mtk: Add ACPI support
Date: Thu, 23 Apr 2026 14:22:45 +0800
Message-ID: <20260423062345.2473300-2-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260423062345.2473300-1-zhiyong.tao@mediatek.com>
References: <20260423062345.2473300-1-zhiyong.tao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add ACPI support to 8250_mtk driver. This makes it possible to
use UART on ARM-based desktops with EDK2 UEFI firmware.

Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 5875a7b9b4b10..e6a56cf54ae0c 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/units.h>
 
 #include "8250.h"
 
@@ -521,6 +522,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 	struct mtk8250_data *data;
 	struct resource *regs;
 	int irq, err;
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -543,12 +545,13 @@ static int mtk8250_probe(struct platform_device *pdev)
 
 	data->clk_count = 0;
 
-	if (pdev->dev.of_node) {
+	if (is_of_node(fwnode)) {
 		err = mtk8250_probe_of(pdev, &uart.port, data);
 		if (err)
 			return err;
-	} else
+	} else if (!fwnode) {
 		return -ENODEV;
+	}
 
 	spin_lock_init(&uart.port.lock);
 	uart.port.mapbase = regs->start;
@@ -564,14 +567,18 @@ static int mtk8250_probe(struct platform_device *pdev)
 	uart.port.startup = mtk8250_startup;
 	uart.port.set_termios = mtk8250_set_termios;
 	uart.port.uartclk = clk_get_rate(data->uart_clk);
+	if (!uart.port.uartclk)
+		uart.port.uartclk = 26 * HZ_PER_MHZ;
 #ifdef CONFIG_SERIAL_8250_DMA
 	if (data->dma)
 		uart.dma = data->dma;
 #endif
 
-	/* Disable Rate Fix function */
-	writel(0x0, uart.port.membase +
+	if (is_of_node(fwnode)) {
+		/* Disable Rate Fix function */
+		writel(0x0, uart.port.membase +
 			(MTK_UART_RATE_FIX << uart.port.regshift));
+	}
 
 	platform_set_drvdata(pdev, data);
 
@@ -649,11 +656,19 @@ static const struct of_device_id mtk8250_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk8250_of_match);
 
+static const struct acpi_device_id mtk8250_acpi_match[] = {
+	{ "MTKI0511" },
+	{ "NVDA0240" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mtk8250_acpi_match);
+
 static struct platform_driver mtk8250_platform_driver = {
 	.driver = {
 		.name		= "mt6577-uart",
 		.pm		= &mtk8250_pm_ops,
 		.of_match_table	= mtk8250_of_match,
+		.acpi_match_table = mtk8250_acpi_match,
 	},
 	.probe			= mtk8250_probe,
 	.remove			= mtk8250_remove,
-- 
2.45.2

