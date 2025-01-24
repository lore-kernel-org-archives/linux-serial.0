Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C082AD0C;
	Fri, 24 Jan 2025 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737688730; cv=none; b=jBlOzYQ02Nutp44ynYRUzh7akEEJgUvry6qxyIJcZ3MDHgr4LK+ncr12D+wEMBQcQ3RWigfYlo4En4UJWwBZSTGHznkMkVa+bZu1shKMwpCvrT5J/kwboHeq13jqv5ZtNer3kbCUFVuwfvopNgEHs1jgPGaVhC2hfrqz0laikz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737688730; c=relaxed/simple;
	bh=c1Is96VXlIrdgec/wQwqmSbzvrrq4p5FN+nF/yTu4O4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VUNQVdsdDlPEOWFYCfeEZVjpoNqKBGSXhGVXqq4xEbLjhWODsVeYbcIKsS7rLYErc1Z1SmKp/mPdDDcS80YiA+Oav5ogmY03OIe3AIa7b3Awu84RjSJbHchVrm7fUuo7WR4q0JnLNOoCOnLhBu7VOw4tokeoQwJUn3Cjnm6zBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lj5869yk; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lj5869yk"
X-UUID: e91920bada0111ef99858b75a2457dd9-20250124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hr2q/zEtH+pKoNV7Cfvrk2hAQt7KerJaGg3/YZVmNBc=;
	b=lj5869yk+EjoNmLbvS3O66wRPTd8/36VP1Aw6QgzDe4wN6MDNT73R2OoGxMlTB1e7AwQjj3XyyvvG5hqqKCQGGO4ebbHnpkpWlGNbsxO52ARt/nfiusZGzFNmah0KJT8lDOQBs+33TCVGL6Ogn4H72eJv5djvLU82h3tyt1JyDY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:444482b5-9148-4b87-b67c-d525d18af00f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:7189a47e-427a-4311-9df4-bfaeeacd8532,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e91920bada0111ef99858b75a2457dd9-20250124
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 866849983; Fri, 24 Jan 2025 11:18:41 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 24 Jan 2025 11:18:39 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 24 Jan 2025 11:18:39 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>
CC: <yenchia.chen@mediatek.com>, <yj.chiang@mediatek.com>,
	<tbergstrom@nvidia.com>, <treapking@chromium.org>,
	<andriy.shevchenko@linux.intel.com>, <u.kleine-koenig@baylibre.com>,
	<yujiaoliang@vivo.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] serial: 8250_mtk: Add ACPI support
Date: Fri, 24 Jan 2025 11:18:32 +0800
Message-ID: <20250124031835.1788995-1-yenchia.chen@mediatek.com>
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
use UART on ARM-based desktops with EDK2 UEFI firmware.

Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index b44de2ed7413..d06952081191 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2014 MundoReader S.L.
  * Author: Matthias Brugger <matthias.bgg@gmail.com>
  */
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -15,6 +16,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
+#include <linux/units.h>
 #include <linux/console.h>
 #include <linux/dma-mapping.h>
 #include <linux/tty.h>
@@ -519,6 +521,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 	struct mtk8250_data *data;
 	struct resource *regs;
 	int irq, err;
+	acpi_handle acpi_dev_handle = ACPI_HANDLE(&pdev->dev);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -545,8 +548,9 @@ static int mtk8250_probe(struct platform_device *pdev)
 		err = mtk8250_probe_of(pdev, &uart.port, data);
 		if (err)
 			return err;
-	} else
+	} else if (!acpi_dev_handle) {
 		return -ENODEV;
+	}
 
 	spin_lock_init(&uart.port.lock);
 	uart.port.mapbase = regs->start;
@@ -562,14 +566,18 @@ static int mtk8250_probe(struct platform_device *pdev)
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
+	if (!acpi_dev_handle) {
+		/* Disable Rate Fix function */
+		writel(0x0, uart.port.membase +
 			(MTK_UART_RATE_FIX << uart.port.regshift));
+	}
 
 	platform_set_drvdata(pdev, data);
 
@@ -647,11 +655,18 @@ static const struct of_device_id mtk8250_of_match[] = {
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
+		.acpi_match_table = mtk8250_acpi_match,
 	},
 	.probe			= mtk8250_probe,
 	.remove			= mtk8250_remove,
-- 
2.45.2

