Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04111957E9;
	Sun, 20 Oct 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729447330; cv=none; b=JKckpF82tf82TejyCUyQ0LnWO7As7jL2t7f6G8WcnlBNZXuwccieZ3V773ndGhZT3UugPGw1OK8AKQJLLujqihIxaQiAQTAm1Hv6iuazC/iZPYVh6t5hs60xumT/Cx0axbmXMcGOo3F7mxInovSKto0U9BN9SmMvS/0Glb1AP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729447330; c=relaxed/simple;
	bh=dHqFkA/UyUtnaj88tOEALnbRjE56MKlSYpYd/DN2NNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHHyLEDg8+aXuyu0hgZpKwPqUNQv9z+zVjHVqUpyMuDZM/E6sNvSp9POcA5qBLvUKEgSWwXUlT6h9x/zylRL7hbNnpAWiTd6AeDGU5CFFHE4fc8BAa+gnzRvO0nTvAn2RQ5i/jdwRlTEGzO0CIvwdc2ZKFmQylETwA4mH5XPDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3LKb7jz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3LKb7jz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so40554225e9.3;
        Sun, 20 Oct 2024 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729447327; x=1730052127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJOU40KbragVWiu4TEFCg8jUPIOwe0Dmrqxh8YGBid0=;
        b=A3LKb7jzkP/9jqmG859eeJ6Ll6lC91T22jPARgkJorMO6b4ww1d0wNHv+gTvP2Bvf/
         o2oh/DwZngZXssapgaLds8Lg6P3Wt8wE0GDlTD+1JA85QrlNSJrRKSg8WRH1Zi0Np8L5
         lhst2fzL+uEAweX9GebObIDu26UXyu1QXXlv4LaOFdna1H5pKhW9ph2LL0r+JF34XW1Q
         eotljlFFLDrl3+cSr3Tng89C+3is5JKV+iwm+vEI+XiUuFyT9ZXgvO1eE5EsPPDpCSwY
         SIjXKNdM1ggtuq07CcVThotlxP81pFSlzAZCR6sDKJb1uJSGw4fbxXl9v7nsMGPaCVUB
         2f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729447327; x=1730052127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJOU40KbragVWiu4TEFCg8jUPIOwe0Dmrqxh8YGBid0=;
        b=S/s0Ape3WdUTB+obBoux3w/37zLvLiCNunPdrOI0OeeKPnPEMi6oyNhkWnrbKF/8vs
         yl69w/2Dwe4Zo1DznTUemC30F46oXqO8r7k+Ogy3TbS6xIdNjlpN+i0bWdfUJTnEsaOA
         9iRyiobQ31ibFOd5y8UJrAulFxtq6UkwA6K+pwxC8jHYs6m7MS5WCJN0NKUTtKY/0cP8
         /zsxDwnLEOjspVQ55rjdaqSIlmnsVd6IjrNElNaC8Eb4DjOk/hGMxBeNOEDmuY7uQBTe
         Q/8YslU0Kj9R8NGYRR0CrdK+jdf/cQNVdRcTii/8KTr4TEMc4Rg9NuhLogB+7MmGI7gB
         ++AA==
X-Forwarded-Encrypted: i=1; AJvYcCV2cfdZ4qAo6/e+un/ypGZmsPzFOB0Dp7OYBdcsp26KH81xLYFdkbaWBpTVcJmS2brk/XgHzSfaG23Ts5JW@vger.kernel.org, AJvYcCWY9epQu3314Q0Q/WHFvofu7gSgaCunQDdc3R2cpuK5uddPremWDMId0EfDksnX76v5D7cZNpw45s/t@vger.kernel.org, AJvYcCXER4FukNnfk1zAx1SkgN1HD+oyF0PsdktyUCvTGwiOs3amucfrTg3rUxECEAvkttnpifzXD8eJ6kYO6Abo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Iy1lv8FLKNQm59wU1JiIy7yjws0swlEeDwWOui99CpFGjUH6
	s8oOyJX45D8geX8DuC5ZGtuQwfTsbvD8p9Du6X/OtOrBgfQLFRRx
X-Google-Smtp-Source: AGHT+IFS9pdpUSEUR+qkGnO2/A0qQ4nF7fipBIDcXd+fdyWcNedtFnw6FCqFhh0YpSzNJh64nHDomA==
X-Received: by 2002:a05:600c:1c29:b0:431:5df7:b337 with SMTP id 5b1f17b1804b1-4316163b55emr64740305e9.8.1729447326671;
        Sun, 20 Oct 2024 11:02:06 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc57esm29922105e9.48.2024.10.20.11.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 11:02:06 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] tty: serial: samsung: Add Exynos8895 compatible
Date: Sun, 20 Oct 2024 21:02:01 +0300
Message-ID: <20241020180201.376151-3-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020180201.376151-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241020180201.376151-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add serial driver data for Exynos8895 SoC. The main difference from
other platforms is that fifosize is only specified via the
samsung,uart-fifosize DT property.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 drivers/tty/serial/samsung_tty.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 0d184ee2f..ce3c3ec34 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2498,6 +2498,12 @@ static const struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
 	.fifosize = { 256, 64, 64, 64 },
 };
 
+static const struct s3c24xx_serial_drv_data exynos8895_serial_drv_data = {
+	EXYNOS_COMMON_SERIAL_DRV_DATA,
+	/* samsung,uart-fifosize must be specified in the device tree. */
+	.fifosize = { 0 },
+};
+
 static const struct s3c24xx_serial_drv_data gs101_serial_drv_data = {
 	.info = {
 		.name		= "Google GS101 UART",
@@ -2528,12 +2534,14 @@ static const struct s3c24xx_serial_drv_data gs101_serial_drv_data = {
 #define EXYNOS4210_SERIAL_DRV_DATA (&exynos4210_serial_drv_data)
 #define EXYNOS5433_SERIAL_DRV_DATA (&exynos5433_serial_drv_data)
 #define EXYNOS850_SERIAL_DRV_DATA (&exynos850_serial_drv_data)
+#define EXYNOS8895_SERIAL_DRV_DATA (&exynos8895_serial_drv_data)
 #define GS101_SERIAL_DRV_DATA (&gs101_serial_drv_data)
 
 #else
 #define EXYNOS4210_SERIAL_DRV_DATA NULL
 #define EXYNOS5433_SERIAL_DRV_DATA NULL
 #define EXYNOS850_SERIAL_DRV_DATA NULL
+#define EXYNOS8895_SERIAL_DRV_DATA NULL
 #define GS101_SERIAL_DRV_DATA NULL
 #endif
 
@@ -2623,6 +2631,9 @@ static const struct platform_device_id s3c24xx_serial_driver_ids[] = {
 	}, {
 		.name		= "gs101-uart",
 		.driver_data	= (kernel_ulong_t)GS101_SERIAL_DRV_DATA,
+	}, {
+		.name		= "exynos8895-uart",
+		.driver_data	= (kernel_ulong_t)EXYNOS8895_SERIAL_DRV_DATA,
 	},
 	{ },
 };
@@ -2646,6 +2657,8 @@ static const struct of_device_id s3c24xx_uart_dt_match[] = {
 		.data = ARTPEC8_SERIAL_DRV_DATA },
 	{ .compatible = "google,gs101-uart",
 		.data = GS101_SERIAL_DRV_DATA },
+	{ .compatible = "samsung,exynos8895-uart",
+		.data = EXYNOS8895_SERIAL_DRV_DATA },
 	{},
 };
 MODULE_DEVICE_TABLE(of, s3c24xx_uart_dt_match);
-- 
2.43.0

