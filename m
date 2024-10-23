Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB991199934;
	Wed, 23 Oct 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674557; cv=none; b=fI6m2Ru79ymGm5/QGH+TzBHVSNAmHKjQBOKKr+jocNaL8b/vTtzID3tTBliMskrkjokszfnOVW6oIBW4JpYrrJX3fXGyknEdrEdatuttJ+3BWRkahxlfO+Dp7ZvsLuJv10TmGZz0eyS4yyMuQejOQZ319++CDFlGFvnC8jHn8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674557; c=relaxed/simple;
	bh=An6KwyGtbwyjAt9NN38EiENLA0XUBmNzsbOhp3H3uVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZYv9ZUqcNdrNblOKkVkDvxglucwIjrSIn1Z6qswcI8oEqcMjdzWdQLy5KvgeUsryG21ZpoS98Ril3wmR7Dr/KMm8sV6HYaX+XluG5i+jmDcjvQWe1zGZ3Dgu0o1qkD1DUuiItzYUhPNxRVwj3ZMxd5xx3hji6ACel3H1ZpcW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz/RbSxC; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz/RbSxC"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso63559101fa.0;
        Wed, 23 Oct 2024 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729674553; x=1730279353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujJ4oLac9g0afJ+xDbcOvTG1+w2apfAzFkZUFjxOHx8=;
        b=Mz/RbSxCZhu1GGzOw4Qgin5I4Bx+G1Q64Tuyp2rm3UZhilzMamiwZGInHdzIgm5YeK
         GAlvPQtLR+s4meN3Dw1BIQgHfW7HFPP1S7fruk0Qa+CfQmQI2GeGu56mq8bwdLzyMxdi
         i2gpXmAWeBrJhcluV9JEeM9WUjoZ41YP5v/XUhJSN2iJJV439Rp1g5ygw23X+Eq1erud
         qX5jA0IwHxCbXmkLUkkAXEM/4IWytRqiZxhlJocaDPKyi16FsKUyBquCnyeh5Y1lbRCF
         geVeA+ya9MTF2+gsdpkWMypwaMy7LQbI7Ss9+yvMy0GALtFC43iARUJ+i3VDD8Osfwb6
         nyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674553; x=1730279353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujJ4oLac9g0afJ+xDbcOvTG1+w2apfAzFkZUFjxOHx8=;
        b=Wf5DEvhL6wir7xHrpRSaF1BcpV3y+PKiM2PcxI7AtEMCygFK3wvhUeTNIOo55hdV3D
         NsD1bPfYwcg/7yvChY1/JP6LxvaPelRYHJ1IHWhubj6IEwGUQ73Dw3oQRlg4ok48psS0
         4cMk+OElICREDfS+T7Q2x3L8X17HHEG696jhYOoDUr0jkKmS9BJbw0VX7rOfqw/OX29j
         rNjorMjRGZycSnPWBHgjujswMqnKMt68cMDi/PBubK6wNTg7eebdd6f/vhQEb2MyKpGB
         RR/E0qXwhKiOf7Z/6GBUS+PdSNE4scROmBNsc48/asNiO6n6yojbkQ7hXwoZGTkgO/LJ
         yqsw==
X-Forwarded-Encrypted: i=1; AJvYcCUXZxP+wYyzCahpr09+zu08+Ge40B6L8slyWmKoS7d6nVF79j6289dWs6jDTHKYLaFPZxBVZSDd9WE8MyXh@vger.kernel.org, AJvYcCUqDtgQL6M9fszcnweja5GSC1yrl2L4g+U5JPQHexk6RBY0SLrj+JRmejlToB6DCZIOiG35FLNcHyYFYg8R@vger.kernel.org, AJvYcCVMBXHq+PlsOV4/nGQPWyY7iLEZhQ703KORPtZ83qFzNQ3RlsG6Us3vxQLJDfvgGMdNzYFsgbXo+u7O@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyp/ijdS0MLyhMP6Uo3oK+g9FxtTXJnqBLIw1XoTYAlMcaXe2
	toKGxOxdKUga0w+CHQfodK4EKPOTTAVJgPtdFrzBzPtspf3bs8y4
X-Google-Smtp-Source: AGHT+IGo5t/YGqOG95+HxnpFXmcZcZV08248fLElKYVYfbislpYCQJusFoz71CRdRKvzJm3CtGqcAw==
X-Received: by 2002:a2e:4619:0:b0:2fb:5b23:edba with SMTP id 38308e7fff4ca-2fc9d32fd88mr7586791fa.23.1729674552286;
        Wed, 23 Oct 2024 02:09:12 -0700 (PDT)
Received: from ivaylo-T580.. ([77.85.230.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6a8efsm4133058a12.52.2024.10.23.02.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:09:11 -0700 (PDT)
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
Subject: [PATCH v2 2/2] tty: serial: samsung: Add Exynos8895 compatible
Date: Wed, 23 Oct 2024 12:09:02 +0300
Message-ID: <20241023090902.538040-3-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023090902.538040-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241023090902.538040-1-ivo.ivanov.ivanov1@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

