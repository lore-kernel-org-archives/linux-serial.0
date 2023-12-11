Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mv90KEiF"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD4712E
	for <linux-serial@vger.kernel.org>; Mon, 11 Dec 2023 08:24:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3333b46f26aso4450336f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 11 Dec 2023 08:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702311873; x=1702916673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soCDsbziWMjEDTQYnQ64foy2UwOB+R/XTZlhNIOpiP0=;
        b=Mv90KEiFdCnukZEC8IyQeMn4ix8LVHXIfq2XsEVKPIez3t9KniRglfc6bcuHODhKxy
         vNyma+Fn+NwGy2SCUqpb+XeOMbrWNTLhyzwxHgCK4fgPlC/lM6/yTdsipXyyedQ8UbWK
         +MtTJPgXAPr5O92gC10f/lWGK82kfk+VEK4DPotd5RNGTZyDrrVcDTIPZvYBMKiPoNBW
         MAXB0uxHwkYEBrAe6cFM1Kwu/lNEjjGbn4amV7ke98yHhmPYrmD7DtOvp2+DjIZspf2T
         EW/7htLGltebBIDwa4a5x1waUPx17rqH6PcsTz1dleXx3izX2YEhWkKC6bZxyGpnc0Fv
         yw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311873; x=1702916673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soCDsbziWMjEDTQYnQ64foy2UwOB+R/XTZlhNIOpiP0=;
        b=BqNvpT9rMfxko/55JM32FJqOBTedQWfqq0X1yGoNBz9XXTPetQRh/6ZS3JAFIaxxn/
         0QRVszQWClvvH76Ece1YcmBVXv8TvF8usZDJlM7jgtoDa3H7hN4MxF1gCgiulnM1H1KQ
         /8Xl55ZL6hvzW/sYVKZe4Y1r3z+sw24nbKMpnTM0Nd3waDHZYMGTEYgQbZJwhDMTsrHI
         5MYpNz8UNmcYgQ41yWXrj+O7Ggj+Yp1vbd0BBxavt2dgsz/GA5wHBoU5awIJ46O0erdk
         5Mt2DQfrxHArU+K2myeNhUG+kPhtOYo/GVQprPa8u69uNI7Z9rzhvVJ3VD1EYXNpzqBx
         GkDA==
X-Gm-Message-State: AOJu0YyGalxn6zn6t+sULUPTHzkWIhJNFaZ2F4ax4LyXS8J+TkdxLqIY
	U/il14xQ9w8Qjw7+H1JXrgh9Vg==
X-Google-Smtp-Source: AGHT+IG8umBo1u1ZfEfeCl0PvULKc4ZOBWDQmYUZk0RSYEHoF9NTjOzHwGb+4PRIdrH5nk5CfFUEqQ==
X-Received: by 2002:adf:f70f:0:b0:333:3af7:a4ef with SMTP id r15-20020adff70f000000b003333af7a4efmr2016600wrp.8.1702311873314;
        Mon, 11 Dec 2023 08:24:33 -0800 (PST)
Received: from gpeter-l.lan (host-92-29-28-58.as13285.net. [92.29.28.58])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d58c4000000b0033333bee379sm8923103wrf.107.2023.12.11.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:24:32 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	conor+dt@kernel.org,
	sboyd@kernel.org,
	tomasz.figa@gmail.com,
	s.nawrocki@samsung.com,
	linus.walleij@linaro.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	olof@lixom.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cw00.choi@samsung.com,
	alim.akhtar@samsung.com
Cc: peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	semen.protsenko@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	soc@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	kernel-team@android.com,
	linux-serial@vger.kernel.org
Subject: [PATCH v7 13/16] tty: serial: samsung: Add gs101 compatible and common fifoszdt_serial_drv_data
Date: Mon, 11 Dec 2023 16:23:28 +0000
Message-ID: <20231211162331.435900-14-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231211162331.435900-1-peter.griffin@linaro.org>
References: <20231211162331.435900-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add serial driver data for Google Tensor gs101 SoC and a common
fifoszdt_serial_drv_data that can be used by platforms that specify the
samsung,uart-fifosize DT property.

A corresponding dt-bindings patch updates the yaml to ensure
samsung,uart-fifosize is a required property.

Tested-by: Will McVicker <willmcvicker@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 1b0c2b467a30..71d17d804fda 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2490,14 +2490,25 @@ static const struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
 	.fifosize = { 256, 64, 64, 64 },
 };
 
+/*
+ * Common drv_data struct for platforms that specify samsung,uart-fifosize in
+ * device tree.
+ */
+static const struct s3c24xx_serial_drv_data exynos_fifoszdt_serial_drv_data = {
+	EXYNOS_COMMON_SERIAL_DRV_DATA(),
+	.fifosize = { 0 },
+};
+
 #define EXYNOS4210_SERIAL_DRV_DATA (&exynos4210_serial_drv_data)
 #define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
 #define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
+#define EXYNOS_FIFOSZDT_DRV_DATA (&exynos_fifoszdt_serial_drv_data)
 
 #else
 #define EXYNOS4210_SERIAL_DRV_DATA NULL
 #define EXYNOS5433_SERIAL_DRV_DATA NULL
 #define EXYNOS850_SERIAL_DRV_DATA NULL
+#define EXYNOS_FIFOSZDT_DRV_DATA NULL
 #endif
 
 #ifdef CONFIG_ARCH_APPLE
@@ -2581,6 +2592,9 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	}, {
 		.name		= "artpec8-uart",
 		.driver_data	= (kernel_ulong_t)ARTPEC8_SERIAL_DRV_DATA,
+	}, {
+		.name		= "gs101-uart",
+		.driver_data	= (kernel_ulong_t)EXYNOS_FIFOSZDT_DRV_DATA,
 	},
 	{ },
 };
@@ -2602,6 +2616,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 		.data = EXYNOS850_SERIAL_DRV_DATA },
 	{ .compatible = "axis,artpec8-uart",
 		.data = ARTPEC8_SERIAL_DRV_DATA },
+	{ .compatible = "google,gs101-uart",
+		.data = EXYNOS_FIFOSZDT_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
-- 
2.43.0.472.g3155946c3a-goog

