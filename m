Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C150242
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661149; cv=none; b=jEGwdSHhf+Hd5e4qzeI1nFYXkwaIvfvbZtHdd+tC6//gNOKOTXsct8oydCQc9xwRgvqJSMzDL9IBz0TQ3NrVzBJNzTHTsO9vFFrUjE3ABdi7zWZWxSvV9gxVE4UTsaEdS3bVf9N1lEmm3Ei5u49xmOcx9+WqbxsjR/PxhgzVa6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661149; c=relaxed/simple;
	bh=ZFSueeqJOG50kpfUkqWZIIakY/L+wXXiARZ0cSz/CKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWzAQISCWerWwxUtxSepzGxrHjvI9bxqeCTPN9jXZyEHQlQ4sBLljtRCoICY8qvykdeir3pRzSAU/3bcns+Tw1vjaDm0UvPrDazBMutcRue9vvf6l+8n4aoilDseesgd9VC+1iUzuaovS54fIzuqAOd7xx25POwwbRFAhJKdGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTc8qlV5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTc8qlV5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e9d288f45so6300525e9.2
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 02:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661145; x=1706265945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwo45PT47NHmv38PG0rfELhMxvzOHKS168E5xQGMKNU=;
        b=qTc8qlV5brIp3i10rpuf2Wny+Ysd3EH9O50JGwdKQGn1nWIT2VWv6XR0Uojsi7FOa/
         KB05+DM6/q5ZQJKR0+6T1AedB4wFFX3ccBeRGdnwKIuQOY5r7KlnHaQGbmuZscPJ5fbI
         pfa4dBpqov3WiEiniuLGZxUeKavMJpETq3ReZthVfFLYXso69NsLz4rY1qXUmFnY3tAM
         ARHBzmwf0fcPJJtnWsbrg5s81WI14eSUrA/D96CnZOpBWjbN2vmos8DXjihZW8zOH2DW
         rT7oKOsvK+WVA+mSf8f83jCdMtSQqDuVGetd6LH4vIQcT6sg6sKujvMxPmEfiApuN4m/
         vnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661145; x=1706265945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwo45PT47NHmv38PG0rfELhMxvzOHKS168E5xQGMKNU=;
        b=u9kntZh5Xu7vyt1RmAHvXkQ8tPUI6hqobMuB3ykKsJ3mJRoTfwfaQlYdP+a36gJjnm
         0zBijZlL0ZHtgNpro6C4WUNy3nf5nSZFsJmNWbC59bvbv85vYBpPWV4tokjCemUvTOX4
         inBSm1xWmJ0KcofrldcyJ9RPAW6+/TdfWg6mtSyEjnxCbXxf7u0v7+euwApUr0dkQLHC
         f81nza+qD2VLizLk4eag/PMACWgCqI8onFVkC0XLh+fVqpnWSde4ylxaEShXBysPwCnp
         bfcPiFrsrIOfPtVIPHXhvi0mX4h2ZVQnOEMqL8lSTkO1DfUea8ESG/jgkhUYoDb3XySH
         od2w==
X-Gm-Message-State: AOJu0YyV63JfJPz9wVrudwrt0deh4aPt3M6UVur6v87eMTLSoIxvQhxv
	kMQvYVc41lThSr9bP9iIhhGLkGK1WPiW5j7BB8iRKFUyXFYQVh+j22u1apM1Ltc=
X-Google-Smtp-Source: AGHT+IGDB9vqcXlGOfTsqQDi0fDJITgrOZsH9TN5J8Bnk1BdqNWsb0qFE7oeW7Dj1+a5XuLSTOkUiA==
X-Received: by 2002:a7b:cbcd:0:b0:40d:6f34:5c13 with SMTP id n13-20020a7bcbcd000000b0040d6f345c13mr920130wmi.231.1705661145026;
        Fri, 19 Jan 2024 02:45:45 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:44 -0800 (PST)
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
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 17/19] tty: serial: samsung: shrink the clock selection to 8 clocks
Date: Fri, 19 Jan 2024 10:45:24 +0000
Message-ID: <20240119104526.1221243-18-tudor.ambarus@linaro.org>
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

<linux/serial_s3c.h> provides a clock selection pool of maximum 4 clocks.
Update the driver to consider a pool selection of maximum 8 clocks.
u8 is large enough to allow more clocks than are supported by the driver
now, and not too big to cause spanning of ``struct s3c24xx_uart_info``
through 2 cachelines when compiled for arm64. The goal is to reduce the
memory footprint of ``struct s3c24xx_uart_info``.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 149f618e22ce..c429029c0207 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -81,11 +81,11 @@ struct s3c24xx_uart_info {
 	unsigned long		tx_fifomask;
 	unsigned long		tx_fifoshift;
 	unsigned long		tx_fifofull;
-	unsigned int		def_clk_sel;
-	unsigned long		num_clks;
 	unsigned long		clksel_mask;
 	unsigned long		clksel_shift;
 	unsigned long		ucon_mask;
+	u8			def_clk_sel;
+	u8			num_clks;
 	u8			iotype;
 
 	/* uart port features */
@@ -1340,7 +1340,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 
 #define MAX_CLK_NAME_LENGTH 15
 
-static inline int s3c24xx_serial_getsource(struct uart_port *port)
+static inline u8 s3c24xx_serial_getsource(struct uart_port *port)
 {
 	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 	u32 ucon;
@@ -1353,8 +1353,7 @@ static inline int s3c24xx_serial_getsource(struct uart_port *port)
 	return ucon >> info->clksel_shift;
 }
 
-static void s3c24xx_serial_setsource(struct uart_port *port,
-			unsigned int clk_sel)
+static void s3c24xx_serial_setsource(struct uart_port *port, u8 clk_sel)
 {
 	const struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
 	u32 ucon;
@@ -1373,14 +1372,15 @@ static void s3c24xx_serial_setsource(struct uart_port *port,
 
 static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			unsigned int req_baud, struct clk **best_clk,
-			unsigned int *clk_num)
+			u8 *clk_num)
 {
 	const struct s3c24xx_uart_info *info = ourport->info;
 	struct clk *clk;
 	unsigned long rate;
-	unsigned int cnt, baud, quot, best_quot = 0;
+	unsigned int baud, quot, best_quot = 0;
 	char clkname[MAX_CLK_NAME_LENGTH];
 	int calc_deviation, deviation = (1 << 30) - 1;
+	u8 cnt;
 
 	for (cnt = 0; cnt < info->num_clks; cnt++) {
 		/* Keep selected clock if provided */
@@ -1473,9 +1473,10 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	struct clk *clk = ERR_PTR(-EINVAL);
 	unsigned long flags;
-	unsigned int baud, quot, clk_sel = 0;
+	unsigned int baud, quot;
 	unsigned int udivslot = 0;
 	u32 ulcon, umcon;
+	u8 clk_sel = 0;
 
 	/*
 	 * We don't support modem control lines.
@@ -1776,10 +1777,9 @@ static int s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
 	struct device *dev = ourport->port.dev;
 	const struct s3c24xx_uart_info *info = ourport->info;
 	char clk_name[MAX_CLK_NAME_LENGTH];
-	unsigned int clk_sel;
 	struct clk *clk;
-	int clk_num;
 	int ret;
+	u8 clk_sel, clk_num;
 
 	clk_sel = ourport->cfg->clk_sel ? : info->def_clk_sel;
 	for (clk_num = 0; clk_num < info->num_clks; clk_num++) {
@@ -2287,9 +2287,9 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 {
 	struct clk *clk;
 	unsigned long rate;
-	unsigned int clk_sel;
 	u32 ulcon, ucon, ubrdiv;
 	char clk_name[MAX_CLK_NAME_LENGTH];
+	u8 clk_sel;
 
 	ulcon  = rd_regl(port, S3C2410_ULCON);
 	ucon   = rd_regl(port, S3C2410_UCON);
-- 
2.43.0.429.g432eaa2c6b-goog

