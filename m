Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98603019CD
	for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148087; cv=none; b=SNrBU7vG4olw3gGFUXKCUaoCo+tKvh+9QZkkkqDOl0WtBZAiaz6U4tOMgaTl2AFVdaAxvVHf3mjAkxEvaPrgfrsIbIcx5phaKpt/g29RXViYhBL+pdcaUvLPzr+HaoTgXoSOmYefZNRxPiZ9CtWvBiHkq4aMzx+2p+IU7UV0xNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148087; c=relaxed/simple;
	bh=SxXs0jJw54u4T/BoH+wt2bNZmY83CnWUqMqwrqahc4Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=mn7vGwFSY4J7ORUnvlUSHwbDSu+enxQE3BuhueUWcFBbuS7UKcPUXRKd58Rztq3Lb9C+OnG97vtJVb7OpEXclB4uxqHleLAiK2/gC1RUttT0FVUY9hxerL8ih2768yWMhQy8duPEYL2HOjzi8kE2IAhs/y8N4pSLimxYzjq0UkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U55k0hZB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U55k0hZB"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so10444329a12.0
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2025 01:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764148081; x=1764752881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mvC2xcRT0un3DyED5J47a2ISqsF9fCPldgZwkOR+wE=;
        b=U55k0hZBJv08J2kVicQ6fl6anzRZyGl/SbhGiTqWrFWTcb2xOBGNSSzBbV455U2Gnh
         b9Mk6bfA8FE4AfPI2332yP0YAjIWbbHaRaahVYkzP0t6p7Du92u6kdtTNx31VH88A+k2
         7JST7F/vbaeZ5ODpUF8gXcEJoK10lBr4nxi0Q4hKNSlLvVnEvHnAxwhZS3Vrgq+89hup
         mbRXSjXAGFVkTGqo/++CkWKJQptv4T4+8maRJVaSMaKtbWxwu6lb4pp2JkrlPOQofmb0
         nCUbXLPzELqLiSOt2ENZfbzH3jQyvUwtHTKziMWcmD5e//VAjjtqmG2aHA0yJVFrEIB8
         5q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764148081; x=1764752881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mvC2xcRT0un3DyED5J47a2ISqsF9fCPldgZwkOR+wE=;
        b=MfPTFGWJfRQTwwtTdXlhNTmMZU4Fi8K2T5GBp0MuvRRO469ccBNIRd2vpAxvRMue2m
         7pshEWt0w6+IoxgWN3AawTlKyrGlT3tfQJH/3qGP1/uRogvKyHMH5vzWsSPWIUuM0mSY
         tOaBnMDgVYXUzA7N74XERU7HqsGpibmjiwFhhorGYLN/0CRpH27GHhDX+OdVJIkXCybe
         SqIJuulQB/QOg+GY5PUqs2etur9LlXWtuIOQJe0nAfkoGxWB0/HIrcaDuRDjCzCc/Uve
         pL80WV/aPFzV5SyFgzR6nZ2DGOn3kXh3bjtjQkXo62vo3+K8GZLXbFpxBcnndMlsQkY4
         q8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUwj8V7Cuzh1iIsIfQjj78/icYYlQXEQhxG7iKnEG4BBGt7k2vZIctgbnyuus/z2eBbv9Cdt2ABWpXWckU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDvaHtiB5eoKciJatGzsmwQHhbvPcX1d9jY65AQ3RCql9vYfy
	vpikzEyFhWXAXZyJPSZP4qISB0CSmnP02COlkpF12QsKp7pq/dAGKUmBWi4pPcOzcnfmOBOXCNF
	Bmjc0
X-Gm-Gg: ASbGncsosm6WhDknCj/OZ5rEjh5m42LmkVlFVM6Yo8D75yst9MigJGJeEYrf9MClKrU
	eNTDdi9Wso7+2ij3qDb9ltJJqzEEVZZR6F+LXgucv2qNeiLqgxtGfBjlqqW8ZYNZdzQxi0CbUMI
	4kfQmDOouOW439jOG3lW8bTWFLeizt/+M1fxkAV9XikABlrpuB+72rtIBIH8WcURQpo1eLUyDVT
	6414+jIXPS1nTF8g15Dzfh66hakqhQ+Wo+H1hBZ2XBs0l5bDnzCNKhzDWQPfBbHdd8gk/C5OUuk
	SpibYB1YsSl9/70etfymTIXSOsSQpa7so7kzRtjD/tfoA+JpfXk7nbfrBmXc7f5i0BIZoBsZEmQ
	IQWgOfYZuOIfbmPN1hButyYsd2oh9qvaL/mieKePA7bV/gAZFni1k4Jtwng==
X-Google-Smtp-Source: AGHT+IGGIZQpZs04c2pQ7SPaA6ug0XtF0zPN367anl9ddeyTxnsIDHiUcCNGdJUmhsLdZincjZ8mFQ==
X-Received: by 2002:a05:6402:510a:b0:639:d9f4:165e with SMTP id 4fb4d7f45d1cf-64555d057e6mr15812527a12.29.1764148081018;
        Wed, 26 Nov 2025 01:08:01 -0800 (PST)
Received: from localhost ([151.37.182.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363ac996sm17218301a12.7.2025.11.26.01.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 01:08:00 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kartik Rajput <kkartik@nvidia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: tegra: remove Kconfig dependency on APB DMA controller
Date: Wed, 26 Nov 2025 10:07:59 +0100
Message-Id: <20251126090759.4042709-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=flavra@baylibre.com; h=from:subject; bh=SxXs0jJw54u4T/BoH+wt2bNZmY83CnWUqMqwrqahc4Y=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJsKTGnioQnBCciK6b/eKgOpCqc4BocWfKPLBX jD7YC57Zy+JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSbCkwAKCRDt8TtzzpQ2 X1JnC/kBFPHGjvXwMpT3otYkUd8E5kaxlSYtnyyhQz4I7QI+B7V0UMea7rG2jyKGUSVaW7uegJD E5A/Raj7yYPtjz74kE+xiaUCEi5TSXXvp12vRXArlaCPO5CSwGBNKZ2FuTWdgXJm7ZrAZ+0OihZ OHadygRkA7n/owRWZ9CoGj0QBA0UzbRyvbJkkn9b70a3+aj77IUulSS35loq4casCeo1tzpJOUD uDxHbs3WZ39zRKHHztM+7oCEwCHlb/Hr5nCBV1Qi9Aj8WLhT0suyeRcsneHudIYqC1HYE93B8PG qwM7f7a4gJm9inu/V4TKmCdj9l1GPIDWdFr7ZU8lxLIjA7/z//YJtOVujvTuwxG0mXGTtbg9uff dQ/pW29f1uKxJjclmVkFn371QqC35t8nWHG4HGdVzQtlTMg/EKCmlOJLtmtExAjarc+eqBk0BRl Qt9OX8cxcbhBmqrsr6XPQCg3rQAsxlQLGvkgu/NQdb3x0l09dY2UfthEwCVkFWuvEDVcc=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This driver runs also on SoCs without a Tegra20 APB DMA controller (e.g.
Tegra234).
Remove the Kconfig dependency on TEGRA20_APB_DMA, and remove reference to
the APB DMA controller from the Kconfig help text.

Fixes: 60d2016a5161 ("arm64: tegra: Add Tegra234 GPCDMA device tree node")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/tty/serial/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 44427415a80d..6212a814fdb7 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -255,14 +255,13 @@ config SERIAL_SAMSUNG_CONSOLE
 
 config SERIAL_TEGRA
 	tristate "NVIDIA Tegra20/30 SoC serial controller"
-	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the NVIDIA Tegra series SOCs
 	  providing /dev/ttyTHS0, 1, 2, 3 and 4 (note, some machines may not
 	  provide all of these ports, depending on how the serial port
-	  are enabled). This driver uses the APB DMA to achieve higher baudrate
-	  and better performance.
+	  are enabled).
 
 config SERIAL_TEGRA_TCU
 	tristate "NVIDIA Tegra Combined UART"
-- 
2.39.5

