Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUg91Jw5"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63320191
	for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 02:52:58 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so77614955e9.2
        for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 02:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551176; x=1703155976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xcopqDHmkhwhZiddcnv/4oqDnf2f2C/EfKwZNlZ0qw=;
        b=hUg91Jw5utLpyY8E5CDdi/IaLvyeX0Y0EjDQzG/iXoXcPl49mRrpQKxyr1hIszPB90
         K96OtV50cQ0BFgtgMjFXXvyd9y0PMBTJFqCub65yjlpfaguHH9eptI1C2VHeAUJWGF5g
         JvDuidXOqpSolEOQu/zGoXqs/NsPiASXms+GYVj/H4rx7efIrkc9y+LgScmkUyTjAndg
         tmepwkVmlGOSfXqm4T4JDNEHhz2ny7sf48EWaZcznpt+VaXNy/vAWIX0VluNSK/2Jnn+
         0PtGNRfLvurQlW2YLtcrcb8lAIoJTdZJmHQ0wtPI70QelPCDQ19lyLVuw0MNY4+sdSuC
         pHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551176; x=1703155976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xcopqDHmkhwhZiddcnv/4oqDnf2f2C/EfKwZNlZ0qw=;
        b=aURJJD1BRF7xf8tJrTnY4q0cJx91u4FUJMEv0Okxu1ZxQqXBeUC/9n4aXiz1WqCa0z
         hr7k07wYo4RmAhCo9JlQn6Q3qlSkid6duXCQwkYtNY1wqZh41Iy5Fi/IZsWWbHGDs9iW
         q0GQsTGEOL/QXprgN7aKIUBeQZL0lJRQwAWManigAY2bi3i4LcK2jqlon1D8AH02GMe0
         eSvS/t3I5ykgznw9NO2j1EUnwvZlXmYHz4nAVstUTjby18/Or2aTP4Jct9wC0p2/k3Fm
         GvW1baFngaXKnwvpWuOTLD1S03On5faoKHLvRAP8TQNxfvQL70nFRiiI0uatGbapORUM
         W+EA==
X-Gm-Message-State: AOJu0Yy22BseltHy1daaziMremxnPWor7tTTR61FvmJ3nyamj16L9LHQ
	qgaLGZjzHWEknEh61W2sk3LgoA==
X-Google-Smtp-Source: AGHT+IFoOjFMWtrSQgxb2NLW2t0CuX+poAGfnV283P6BxnO1HFB3lfJ/1vp1DW3s4vZF+aaQfp5C7g==
X-Received: by 2002:a1c:7411:0:b0:40c:30f8:dcf0 with SMTP id p17-20020a1c7411000000b0040c30f8dcf0mr5564669wmc.64.1702551176443;
        Thu, 14 Dec 2023 02:52:56 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm17614854wmo.22.2023.12.14.02.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:52:55 -0800 (PST)
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
	catalin.marinas@arm.com,
	will@kernel.org,
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
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 05/13] tty: serial: samsung: add gs101 earlycon support
Date: Thu, 14 Dec 2023 10:52:35 +0000
Message-ID: <20231214105243.3707730-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GS101 only allows 32-bit register accesses. If using 8-bit register
accesses on gs101, a SError Interrupt is raised causing the system
unusable.

Force the reg accesses to MMIO32 regardless of the user's settings.
This is a common practice for such earlycons (bcm2835aux, uniphier,
lpuart32), in order to avoid crashing the kernel with a wrong early
console definition.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 66bd6c090ace..19cd3e6a9b6e 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2787,6 +2787,17 @@ OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
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

