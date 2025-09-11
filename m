Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E4326D51
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600240; cv=none; b=SRXVPBtsh/4vKvS0zHTiES/l2xOsXl+NA5P0Aa8q/HxLTGZrSiaamECAeKdBli72uAoBd3/dYOlj+lm7mpx7oS6rUOvV4tYUoV39akzXn90y1Tgu5c07WO4oDqm4fWVuHp6q+xA8mzzpS4N1twLsykZZbJQUWhz6M9QVNMHZ2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600240; c=relaxed/simple;
	bh=5+tN6K7SF96fi7rMsUYISsa4l8A0u28hfVWoo8Jl1iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Yuz2ola7u36UHhhbsSISGnC3CvMgB/4vaIVdktlgYOkkSxNe+T8LxSafTnsbg+GJC/Kue+UhBOv2USb+PytOOV5pFJguTbgI795VR2ZKnfQj/SyPoBMsxtzFv9pZv+JUEuGHhAnXit+N0dPii1Y1xCPa9gg8BQLr6FHJ4At1jPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RGM1Hwq3; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RGM1Hwq3"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250911141717epoutp03a0c04901dd13ea22545d97b39916f9b1~kQBqCCDo03262132621epoutp036
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 14:17:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250911141717epoutp03a0c04901dd13ea22545d97b39916f9b1~kQBqCCDo03262132621epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757600237;
	bh=K69kgncGciGQZo0JXjJXKC6BvkMPaiJgLJglmZzL4cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGM1Hwq34Eh+BIhNJJSTYu+kN9RjqqGF/+z4QqIRGqah5I7L6MqsicFC1T02Z6Ttu
	 +urbOzmpH0gl9WyYKUW8dSojqr0apczlDYuJiu1enayc0qACKZR1mit/gpLxPyzEmC
	 E+9LgCmncmQDWY0OScWrQcXDMXUagdCugwpeNa5g=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250911141715epcas5p493e6a04e3f957c7589b55a2153801fa9~kQBo7E2ov3129231292epcas5p4G;
	Thu, 11 Sep 2025 14:17:15 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cN04W1zmqz3hhT3; Thu, 11 Sep
	2025 14:17:15 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250911141714epcas5p29f591a1d645c9c69dc5b7d2c2d12af50~kQBndP0JP1801718017epcas5p2y;
	Thu, 11 Sep 2025 14:17:14 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250911141710epsmtip120b4dcf88bd4e7d7187d3e096f10cd67~kQBj6-TyE3273832738epsmtip1d;
	Thu, 11 Sep 2025 14:17:10 +0000 (GMT)
From: Ravi Patel <ravi.patel@samsung.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jesper.nilsson@axis.com,
	lars.persson@axis.com, alim.akhtar@samsung.com, arnd@kernel.org,
	krzk@kernel.org
Cc: andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
	thierry.bultel.yh@bp.renesas.com, dianders@chromium.org,
	robert.marko@sartura.hr, schnelle@linux.ibm.com, kkartik@nvidia.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com,
	ksk4725@coasia.com, kenkim@coasia.com, smn1196@coasia.com,
	pjsin865@coasia.com, shradha.t@samsung.com, Ravi Patel
	<ravi.patel@samsung.com>
Subject: [PATCH 3/3] tty: serial: samsung: Remove unused artpec-8 specific
 code
Date: Thu, 11 Sep 2025 19:46:05 +0530
Message-ID: <20250911141605.13034-4-ravi.patel@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911141605.13034-1-ravi.patel@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250911141714epcas5p29f591a1d645c9c69dc5b7d2c2d12af50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250911141714epcas5p29f591a1d645c9c69dc5b7d2c2d12af50
References: <20250911141605.13034-1-ravi.patel@samsung.com>
	<CGME20250911141714epcas5p29f591a1d645c9c69dc5b7d2c2d12af50@epcas5p2.samsung.com>

Since ARTPEC-8 is using exynos8895 driver data, remove the unused
artpec-8 specific driver data.

ARTPEC-8 is using exynos4210 for earlycon, so earlycon code
for ARTPEC-8 is also not required.

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
---
NOTE: This is exactly the revert of the below commit.
commit 1db536f95d0264a2b83fb032d5b057ba0113e622
Author: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri Mar 11 10:45:15 2022 +0100

tty: serial: samsung: Add ARTPEC-8 support
---
 drivers/tty/serial/Kconfig       |  2 +-
 drivers/tty/serial/samsung_tty.c | 38 --------------------------------
 2 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 44427415a80d..6f4d6f44d997 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -219,7 +219,7 @@ config SERIAL_CLPS711X_CONSOLE

 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_APPLE || ARCH_ARTPEC || COMPILE_TEST
+	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_APPLE || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the Samsung
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 2fb58c626daf..322ab280a59e 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2577,37 +2577,6 @@ static const struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
 #define S5L_SERIAL_DRV_DATA NULL
 #endif

-#if defined(CONFIG_ARCH_ARTPEC)
-static const struct s3c24xx_serial_drv_data artpec8_serial_drv_data = {
-	.info = {
-		.name		= "Axis ARTPEC-8 UART",
-		.type		= TYPE_S3C6400,
-		.port_type	= PORT_S3C6400,
-		.iotype		= UPIO_MEM,
-		.fifosize	= 64,
-		.has_divslot	= true,
-		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
-		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
-		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
-		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,
-		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,
-		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,
-		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
-		.num_clks	= 1,
-		.clksel_mask	= 0,
-		.clksel_shift	= 0,
-	},
-	.def_cfg = {
-		.ucon		= S5PV210_UCON_DEFAULT,
-		.ufcon		= S5PV210_UFCON_DEFAULT,
-		.has_fracval	= 1,
-	}
-};
-#define ARTPEC8_SERIAL_DRV_DATA (&artpec8_serial_drv_data)
-#else
-#define ARTPEC8_SERIAL_DRV_DATA (NULL)
-#endif
-
 static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	{
 		.name		= "s3c6400-uart",
@@ -2627,9 +2596,6 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	}, {
 		.name		= "exynos850-uart",
 		.driver_data	= (kernel_ulong_t)EXYNOS850_SERIAL_DRV_DATA,
-	}, {
-		.name		= "artpec8-uart",
-		.driver_data	= (kernel_ulong_t)ARTPEC8_SERIAL_DRV_DATA,
 	}, {
 		.name		= "gs101-uart",
 		.driver_data	= (kernel_ulong_t)GS101_SERIAL_DRV_DATA,
@@ -2655,8 +2621,6 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 		.data = S5L_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos850-uart",
 		.data = EXYNOS850_SERIAL_DRV_DATA },
-	{ .compatible = "axis,artpec8-uart",
-		.data = ARTPEC8_SERIAL_DRV_DATA },
 	{ .compatible = "google,gs101-uart",
 		.data = GS101_SERIAL_DRV_DATA },
 	{ .compatible = "samsung,exynos8895-uart",
@@ -2828,8 +2792,6 @@ OF_EARLYCON_DECLARE(s5pv210, "samsung,s5pv210-uart",
 			s5pv210_early_console_setup);
 OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
 			s5pv210_early_console_setup);
-OF_EARLYCON_DECLARE(artpec8, "axis,artpec8-uart",
-			s5pv210_early_console_setup);

 static int __init gs101_early_console_setup(struct earlycon_device *device,
 					    const char *opt)
--
2.17.1

