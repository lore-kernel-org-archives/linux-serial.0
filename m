Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24AA1A8F97
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024928; cv=none; b=sCnEzagT1wJpg8Cz+NdXgov3Ho6OFMrAPXQRUIbePIvLs3bPMtJNXHM7tQO6KgzqVguJI33L5Yrl4l59h/dTPXHQ7CcG+5xIFIBkPO8DcNBu9zcawmA9kw2l6+jhdxuVenor6ELXTlO8dUQbgdwUHk4oscbsfR7PLpGylKYNmxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024928; c=relaxed/simple;
	bh=8OjXBOUx0f05cZLENr4Y3TK8cbaUmcac4eRNWrA1vAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=AhYqLE/lF6T0qIGQiPLvg0/4maV2edS1UojAkETp0umZSxXs3n7tITwC90Po/2ZknSCTfp1kJJzRF84uGYsIIqtuZMd5pte4McUHGKUfc5aFkJNCYPuZYrYxb9Tdli+u657kZiDTYBFoue5dFeEbxJgjXLLPiV3U5yt0HS9yPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QEBoxdjJ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QEBoxdjJ"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260424100203epoutp0155537835c62e9aa97e24810689c179f6~pQsCm9zck1064210642epoutp01M
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 10:02:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260424100203epoutp0155537835c62e9aa97e24810689c179f6~pQsCm9zck1064210642epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777024923;
	bh=xQbZBR0vcMfkcL0qLiKFtePlkHLiiXiaHsbOVpj2MhY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QEBoxdjJj9N808jXyo1DW1Wu2I15V4J1JzBg4JhuWWTa7VVcPo09XXHum9WLtar1H
	 96TJu6zX3fQu8H5NnFK2MRPRSmUOCrZlt7Ld30s7Zqya19KvJdfpTk171E4iig5E8h
	 PzQwDxVKpC+CXcJDCSzGtRAcb5290Fzubl6XZqxs=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260424100202epcas5p2fea86ef12b376a5469ced37ed505f434~pQsCLYnRq0299002990epcas5p2v;
	Fri, 24 Apr 2026 10:02:02 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.90]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4g27m96VKYz3hhT3; Fri, 24 Apr
	2026 10:02:01 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260424100201epcas5p371dd69955076938ee41ed0d823433056~pQsA91Xsb2843628436epcas5p3y;
	Fri, 24 Apr 2026 10:02:01 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260424100200epsmtip194a9725c822bdfeaa1bb1d55b9338331~pQr--u-mZ2777227772epsmtip1L;
	Fri, 24 Apr 2026 10:02:00 +0000 (GMT)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: krzk@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] tty: serial: samsung: add dedicated compatible for
 exynosauto SoCs
Date: Fri, 24 Apr 2026 15:48:35 +0530
Message-Id: <20260424101835.2125970-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260424100201epcas5p371dd69955076938ee41ed0d823433056
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260424100201epcas5p371dd69955076938ee41ed0d823433056
References: <CGME20260424100201epcas5p371dd69955076938ee41ed0d823433056@epcas5p3.samsung.com>

Currently Exynosautov-{9,920} getting probed based on exynos850
fallback. It is recommended to have a dedicated compatible for
proper driver binding.

Add specific platfrom_device_id and of_device_id for
unique identification and proper driver binding.

While at it, also declare earlycon for these SoC which is helpful
in debugging early kernel crashes which might occures before
serial driver initialization.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index e27806bf2cf3..49409cb6fd25 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2500,6 +2500,12 @@ static const struct s3c24xx_serial_drv_data exynos8895_serial_drv_data = {
 	.fifosize = { 0 },
 };
 
+static const struct s3c24xx_serial_drv_data exynosauto_serial_drv_data = {
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
+	/* samsung,uart-fifosize must be specified in the device tree. */
+	.fifosize = { 0 },
+};
+
 static const struct s3c24xx_serial_drv_data gs101_serial_drv_data = {
 	.info = {
 		.name		= "Google GS101 UART",
@@ -2531,6 +2537,7 @@ static const struct s3c24xx_serial_drv_data gs101_serial_drv_data = {
 #define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
 #define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
 #define EXYNOS8895_SERIAL_DRV_DATA (&exynos8895_serial_drv_data)
+#define EXYNOSAUTO_SERIAL_DRV_DATA (&exynosauto_serial_drv_data)
 #define GS101_SERIAL_DRV_DATA (&gs101_serial_drv_data)
 
 #else
@@ -2538,6 +2545,7 @@ static const struct s3c24xx_serial_drv_data gs101_serial_drv_data = {
 #define EXYNOS5433_SERIAL_DRV_DATA NULL
 #define EXYNOS850_SERIAL_DRV_DATA NULL
 #define EXYNOS8895_SERIAL_DRV_DATA NULL
+#define EXYNOSAUTO_SERIAL_DRV_DATA NULL
 #define GS101_SERIAL_DRV_DATA NULL
 #endif
 
@@ -2621,6 +2629,12 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	}, {
 		.name		= "exynos850-uart",
 		.driver_data	= (kernel_ulong_t)EXYNOS850_SERIAL_DRV_DATA,
+	}, {
+		.name		= "exynosautov9-uart",
+		.driver_data	= (kernel_ulong_t)EXYNOSAUTO_SERIAL_DRV_DATA,
+	}, {
+		.name		= "exynosautov920-uart",
+		.driver_data	= (kernel_ulong_t)EXYNOSAUTO_SERIAL_DRV_DATA,
 	}, {
 		.name		= "artpec8-uart",
 		.driver_data	= (kernel_ulong_t)ARTPEC8_SERIAL_DRV_DATA,
@@ -2649,6 +2663,10 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 		.data = S5L_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos850-uart",
 		.data = EXYNOS850_SERIAL_DRV_DATA },
+	{ .compatible = "samsung,exynosautov9-uart",
+		.data = EXYNOSAUTO_SERIAL_DRV_DATA },
+	{ .compatible = "samsung,exynosautov920-uart",
+		.data = EXYNOSAUTO_SERIAL_DRV_DATA },
 	{ .compatible = "axis,artpec8-uart",
 		.data = ARTPEC8_SERIAL_DRV_DATA },
 	{ .compatible = "google,gs101-uart",
@@ -2826,6 +2844,10 @@ OF_EARLYCON_DECLARE(artpec8, "axis,artpec8-uart",
 			s5pv210_early_console_setup);
 OF_EARLYCON_DECLARE(exynos850, "samsung,exynos850-uart",
 			s5pv210_early_console_setup);
+OF_EARLYCON_DECLARE(exynosauto, "samsung,exynosautov9-uart",
+			s5pv210_early_console_setup);
+OF_EARLYCON_DECLARE(exynosauto, "samsung,exynosautov920-uart",
+			s5pv210_early_console_setup);
 
 static int __init gs101_early_console_setup(struct earlycon_device *device,
 					    const char *opt)
-- 
2.34.1

