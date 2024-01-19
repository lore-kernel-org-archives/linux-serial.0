Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F194C631
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661136; cv=none; b=Z7SrshNfN3rAZ01tKbA10i8IzFbv/W2+qVQNHjvknfxsy9tY3mPRhYFccT2JrW39CgKmW+T0RLFahCXHqs0jslSIrrk/+VVz+8IJOMCaKd/iXf7eZ9uBSa3bjUFovBT20KtPJxFaeTkbhNQ8P1xDjdidYYY+3c6Rs9D3GV+v6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661136; c=relaxed/simple;
	bh=/DF+tSTszWj2uKRB4Z1qpd0yWVCMU7iJvLB0kXUUb6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KysNKdVAW0C0olAGVyqy8jxb0yaVA6ZB1//vywpzhxqNlVFxeLDFxOyr//eXX5XMnP7ILPq3+e/t73Z7UUnYeEZZT8vfWWR4/gyaAZ0CET6dRikp4jl29uevOF7hnx1uT/cRBYPw6EbPfbQowbvZwWun+FWtWXxVT303wvtj8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WE7gNYyK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WE7gNYyK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e76626170so6697235e9.2
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 02:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661133; x=1706265933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRO/29BBu0wOqLjfgi9jbts6vS9S++O3BcU4FggPnxQ=;
        b=WE7gNYyKhLzuSoNC0WsGVziSsd2vsjXkn3FQ0m0zWTS39XXHdf6oV+Usp4jeHV2O6B
         CZ9bjxME448NK0/WeJr0JcF0gXlwy3gnsn5U3q4kCg7aiTrSaROQoGDp2AgejcdV1FkI
         PL1UshFL4+1Q5dKveWPcTGiKfLh08PEPU4zQcq96vj8QJRzqKwHpcO26deFX7uR2OoQY
         hxHqsy0AYi3eOp+dIQIhQ4hSEqSd16Jo/Cjl9zEJnRjAvw7R4uCRHK59vjG2X2OCpAhd
         EkpXHvnsnddEiBY7QnI1jX3QW8QvY/m497dhJVrTK4afeEzJwdjzZ9mLy67fIHEh3iHr
         /oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661133; x=1706265933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRO/29BBu0wOqLjfgi9jbts6vS9S++O3BcU4FggPnxQ=;
        b=OUcQSXst3/eT3oATK1fTqtDbUtzk3syms8lu63DGsK+8MRkq2uGQPgY22npBWscMjV
         bl4rEUgT+fgpwuwFOrhHHzIpGGNfavTU9X8UVL+kJP7BZYQdIvnkYTIxUvkhWSYf6h7f
         P1BtVKizBZrUgJY3yTmIT781z3QPo76XlUsydwckzZuyKyYM0v+KzYpXmvMEJgSxnywN
         BIR6HhUKV/mkdq38lLSB0cEH9wekDePmFciIbuD+gbwM5XI+7bxbo2Bc1DxyJJceMnvP
         9y0v9KCBshE4ktQcZhiqed5xy8meHf7WdVO/gt9JzUUGRefoQXV6IFN3RxR2kGx8ZZdj
         IRsQ==
X-Gm-Message-State: AOJu0YztiFLazefWRVcmDbxMJ6nuDMX6b29rS6gUu6nrL3vDlSt7VIuv
	NaCWWPYF1A+Bqs7oA12KgJ1FgT96sAaweY6CFfaWMpPTQ/f296K3E8TyXzQCVE0=
X-Google-Smtp-Source: AGHT+IGrA5J+z8EbYw2wyRH3MCBXeZ1K10bB38FMjwSnkyuqVvhBeOxNJ4f01saw5T3Tqey5/1SUhA==
X-Received: by 2002:a1c:790f:0:b0:40e:4d1b:27e0 with SMTP id l15-20020a1c790f000000b0040e4d1b27e0mr1506294wme.20.1705661132761;
        Fri, 19 Jan 2024 02:45:32 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:32 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 04/19] tty: serial: samsung: set UPIO_MEM32 iotype for gs101
Date: Fri, 19 Jan 2024 10:45:11 +0000
Message-ID: <20240119104526.1221243-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GS101's Connectivity Peripheral blocks (peric0/1 blocks) which
include the I3C and USI (I2C, SPI, UART) only allow 32-bit
register accesses.

Instead of specifying the reg-io-width = 4 everywhere, for each node,
the requirement should be deduced from the compatible.

Infer UPIO_MEM32 iotype from the "google,gs101-uart" compatible.
Update the uart info name to be GS101 specific in order to
differentiate from the other exynos platforms. All the other settings
are not changed.

exynos_fifoszdt_serial_drv_data was replaced by gs101_serial_drv_data
because the iotype restriction is gs101 specific and there was no other
user of exynos_fifoszdt_serial_drv_data.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 38 +++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 9d3767021f9c..7a1b1ca82511 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2494,25 +2494,43 @@ static const struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
 	.fifosize = { 256, 64, 64, 64 },
 };
 
-/*
- * Common drv_data struct for platforms that specify samsung,uart-fifosize in
- * device tree.
- */
-static const struct s3c24xx_serial_drv_data exynos_fifoszdt_serial_drv_data = {
-	EXYNOS_COMMON_SERIAL_DRV_DATA(),
+static const struct s3c24xx_serial_drv_data gs101_serial_drv_data = {
+	.info = {
+		.name		= "Google GS101 UART",
+		.type		= TYPE_S3C6400,
+		.port_type	= PORT_S3C6400,
+		.iotype		= UPIO_MEM32,
+		.has_divslot	= 1,
+		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,
+		.rx_fifoshift	= S5PV210_UFSTAT_RXSHIFT,
+		.rx_fifofull	= S5PV210_UFSTAT_RXFULL,
+		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,
+		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,
+		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,
+		.num_clks	= 1,
+		.clksel_mask	= 0,
+		.clksel_shift	= 0,
+	},
+	.def_cfg = {
+		.ucon		= S5PV210_UCON_DEFAULT,
+		.ufcon		= S5PV210_UFCON_DEFAULT,
+		.has_fracval	= 1,
+	},
+	/* samsung,uart-fifosize must be specified in the device tree. */
 	.fifosize = { 0 },
 };
 
 #define EXYNOS4210_SERIAL_DRV_DATA (&exynos4210_serial_drv_data)
 #define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
 #define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
-#define EXYNOS_FIFOSZDT_DRV_DATA (&exynos_fifoszdt_serial_drv_data)
+#define GS101_SERIAL_DRV_DATA (&gs101_serial_drv_data)
 
 #else
 #define EXYNOS4210_SERIAL_DRV_DATA NULL
 #define EXYNOS5433_SERIAL_DRV_DATA NULL
 #define EXYNOS850_SERIAL_DRV_DATA NULL
-#define EXYNOS_FIFOSZDT_DRV_DATA NULL
+#define GS101_SERIAL_DRV_DATA NULL
 #endif
 
 #ifdef CONFIG_ARCH_APPLE
@@ -2600,7 +2618,7 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 		.driver_data	= (kernel_ulong_t)ARTPEC8_SERIAL_DRV_DATA,
 	}, {
 		.name		= "gs101-uart",
-		.driver_data	= (kernel_ulong_t)EXYNOS_FIFOSZDT_DRV_DATA,
+		.driver_data	= (kernel_ulong_t)GS101_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -2623,7 +2641,7 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 	{ .compatible = "axis,artpec8-uart",
 		.data = ARTPEC8_SERIAL_DRV_DATA },
 	{ .compatible = "google,gs101-uart",
-		.data = EXYNOS_FIFOSZDT_DRV_DATA },
+		.data = GS101_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
-- 
2.43.0.429.g432eaa2c6b-goog

