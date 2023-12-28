Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB81FE575
	for <linux-serial@vger.kernel.org>; Thu, 28 Dec 2023 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkHzgZxh"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d5ae89c7bso16124595e9.2
        for <linux-serial@vger.kernel.org>; Thu, 28 Dec 2023 04:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703768296; x=1704373096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX8RT8/KwRnpjqmauq2VuiREugBeuTfdnmzmXRQSLkY=;
        b=LkHzgZxhMS7RFnaXfOWocaAkiaPopljttZfgzA4qZ0DTYCGY9z6Ci15SSTFHnLhmiL
         ZXHCT+0V/k91HeKo0SLYciIqVLfG98glh6w+nqt4E8GK0NRGM9FbFwPthVe2Bwka7lnv
         Nv0AEiY//J5AjXORjw81TXD/cKhm4jFOW+Snn1CoK5F5C9scRXLbp80Nw+b3ikQMRLEL
         EZ3W9agXdnpQ9SrM+UxS+h/g95XkPbvO3IldMkeL4j2Tb75wUt/hp2D9X6tmUENqFuSC
         QpwlAj0Dt4pgN32yAE2+GiKp0XqaxGyPJnMIQtoeXkAsatPSGLDdAsmPpL/DL9IALzN5
         Q18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703768296; x=1704373096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XX8RT8/KwRnpjqmauq2VuiREugBeuTfdnmzmXRQSLkY=;
        b=sXrciY5k2736u+CkZMzLqDTahpp+dhj4QaRaywlxKtHl7WZ9Gs9UT0W+wzC8Y1I0FN
         /fl8W54a/nhu73TL6Ykv+Ye1ZiCe1k+Gc8Y5SaQI1w9YaErtwNXMik1PUv0ecJjoTFGK
         8BAfLtK0HDhwh5VFQxkk1Q3w1wsePmnS4fCViHE56WxA1P8wZcz2Zq0BP1BJVsfQZRJM
         YD9+cPHPP/kt0nX6MWzqFLtgPrWlOeV07Qs6f/PrAXn1OkrsoG6eQSDfwdO8USsUu6JE
         H3+mL2bOjR5um5mHNBirxKM7V6olvwCKqi7pgveg6ygdxDkaWlPL27SX2HZyRqjcLOVu
         5aug==
X-Gm-Message-State: AOJu0YyOt26zGbpU1DuU25MAT8Hrd9raE+qXXJU/HAhjQxFLqTIXsIii
	SMikPok/wB7WGc9Y2Hin8NM17Rh6JFE5mg==
X-Google-Smtp-Source: AGHT+IEqHso+KU0TXJoWGdwqMKaajVLMSvd+/nBs9vEkdpDVBsUvd/aUEZUWWnBCnEZtLsrpzQL1bA==
X-Received: by 2002:a05:600c:4f83:b0:40d:5d82:d0f4 with SMTP id n3-20020a05600c4f8300b0040d5d82d0f4mr1363489wmq.61.1703768296198;
        Thu, 28 Dec 2023 04:58:16 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0040d5aca25f1sm8615807wmq.17.2023.12.28.04.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 04:58:15 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	andi.shyti@kernel.org,
	alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	arnd@arndb.de,
	semen.protsenko@linaro.org
Cc: andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-serial@vger.kernel.org,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 06/12] tty: serial: samsung: add gs101 earlycon support
Date: Thu, 28 Dec 2023 12:57:59 +0000
Message-ID: <20231228125805.661725-7-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231228125805.661725-1-tudor.ambarus@linaro.org>
References: <20231228125805.661725-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The entire bus (PERIC) on which the GS101 serial resides only allows
32-bit register accesses. The reg-io-width dt property is disallowed
for the "google,gs101-uart" compatible and instead the iotype is
inferred from the compatible. Always set UPIO_MEM32 iotype for the
gs101 earlycon.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2: update commit message

 drivers/tty/serial/samsung_tty.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 938127179acf..2fbaaf0e756b 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2812,6 +2812,17 @@ OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
 OF_EARLYCON_DECLARE(artpec8, "axis,artpec8-uart",
 			s5pv210_early_console_setup);
 
+static int __init gs101_early_console_setup(struct earlycon_device *device,
+					    const char *opt)
+{
+	/* gs101 always expects MMIO32 register accesses. */
+	device->port.iotype = UPIO_MEM32;
+
+	return s5pv210_early_console_setup(device, opt);
+}
+
+OF_EARLYCON_DECLARE(gs101, "google,gs101-uart", gs101_early_console_setup);
+
 /* Apple S5L */
 static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
 						const char *opt)
-- 
2.43.0.472.g3155946c3a-goog

