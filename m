Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC363ECBFA
	for <linux-serial@vger.kernel.org>; Tue,  3 Mar 2026 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772536484; cv=none; b=uPpzINw0LeKDvGyrHNK/rfUW45E7OrZEELBHSbe/1NjdBfyqE1o7sOYDXwBXlx8Wq1KQWxB6QLZfJ4xGxbXgzghTYX3aiauuiaNmuzn3RitLtPGnqyi5gK2Z0hXRawXLdl9c3phuzZOfCKlKkx8OnDdHUrxFQVlZ8BAl1tgP9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772536484; c=relaxed/simple;
	bh=lG/DZ3WywMxkW718njBWn7clqicbwq5XJkykLBVrlxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZJ3hPpRyVm3UKIYKfyvVUzOIVba3fZFevhNykB06DbNRGKYbZOU8tH834jbooTXCGgmrVJ4A1cdqh1FjUIkjR7EEui5pNzK+1UBylIXvJSI7CbqMRDeYVjYNhLr+8akUuZkoY/FRQyNLkAYGKuLGQ2gjFUgld7nFYJx3Kxubf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U5HyLv8P; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U5HyLv8P"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48374014a77so66484285e9.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Mar 2026 03:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772536480; x=1773141280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgdv9fVdx/IEA9nZHRjuPZVXLrXBxXsiA90FmBdGMb0=;
        b=U5HyLv8Pho13u/f+I/VS8HGivtUhBmlPHKZGs3ruUQ6tZPB5FMR9PB8JfJbVyZzpdn
         903IE7AbTrVf+9p1ONpfCkGLXzyoCRSVP5AtHpX0vYjFYgNtDrAZWMqducZPC1Ff2enq
         GoSF4iRStBYYrqDMbCmlfp1Oz6d8wEMMhwa/kq90qqMAIu6OQ03FJ0BbP8nrcLKV4IEM
         SaWaiReST+XomkoO03wAYUxmzTMGZ8r6V3L5kM+H2zlPA8Zx0CLeGPEU4JXYzdjAAM7V
         39GU4W/ZWhd/+KmU5o2O7/7HLC0KuSM1mJTMtN2b3V35asKX1R+Aldumd1oSYXCij/CQ
         CpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772536480; x=1773141280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xgdv9fVdx/IEA9nZHRjuPZVXLrXBxXsiA90FmBdGMb0=;
        b=UkwwqdEhFub6TOGU1EXf8Ks8ZvsQseEL2AX63crY+naMHsfEBCNpS6qUHASWbfqbCg
         xmQHwgp02bmBaoAB+x0FUU3iZ0YnLlSIMmrGUpvu1ATxccqMvon5Lb+z9SkHKSBMLrKr
         wV2hLGw3/NQ3i+Pol/jj+LguwqTpmFu4yHEEsqxQ5e+h+l4Ej7mitV2zuVHdzeSV8iHP
         +YueFfQiPc/At7pEQRd7p5rLU9nT0bpvqi7zi9/bUmK23iy6ONU8uW5I0eUWAl9+gvFm
         RrsNVdg8u6uddTFEsbm3PbgQaDTJ8lt96/bIK2DM8rETDqVpf9IHUCoR5NT/ZIT+iGU3
         Uwww==
X-Forwarded-Encrypted: i=1; AJvYcCWP30+e475+Jy8D53yY4Fc8RqegbPq/0Ry7wlx6PAfo3Ag4oVRN+W8As6HR2Y5QafzCPRP1LoYl2RVasUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3tJkwBrHmT2ocCmWHpJPJo0vRXS7WzNaqFOYpZwinL+SoITF
	ldrbWaENjVgAgpyh0U48xqBn4ptJTl3NU2ht4bcLCny6Wks78UXrqGIEy4V6cfgKxuM=
X-Gm-Gg: ATEYQzwPGJk4W7xJ0XFu7o3JvkmTFK0F6JRWVHiwycXvEcuy4qVqAwhTIe2XBVvnlfF
	/F8CJICzi6eVmXRR6ht/NiQBPXACqcLz3h+IGrU9WbYlCkdq3ZpTbxn2JjyiE2GCpjvBzv4imiA
	Lr3TE5LBj43btEy3MjgLeTYGKHXyjmkAGWDOxeDst0YtEVSAs+UjVAtH1R/9eGlAwgZtvc4xNKN
	ZaArXB3qEaEB0cWWKM4umIznROsYRuoNo7hAlYEV5OD9Ml1zXNvI0ookTZr0lOPKtILJyG02STr
	doURt+ffUFLMQF9gPOvdA7OTWr5V6EidQDeWjLz2xKpqVl2d+qCaXyiOtIv43pwkkuDCDb2gWkZ
	pHCiPHlRVXq5d4xCcQeAD3eroOrOA24WTE02LHwZExLOYfoOO6oXTHYuh1NrkfhHHLr9L
X-Received: by 2002:a05:600c:c4a6:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-483c9bc0344mr259053495e9.12.1772536480350;
        Tue, 03 Mar 2026 03:14:40 -0800 (PST)
Received: from localhost ([151.19.25.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485133508bbsm17667855e9.5.2026.03.03.03.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:14:40 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Zong Jiang <quic_zongjian@quicinc.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] serial: tegra: remove Kconfig dependency on APB DMA controller
Date: Tue,  3 Mar 2026 12:14:38 +0100
Message-Id: <20260303111438.2691799-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461; i=flavra@baylibre.com; h=from:subject; bh=lG/DZ3WywMxkW718njBWn7clqicbwq5XJkykLBVrlxU=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBppsIidjpJYctRWN5hOyNxVnAxdEa0f5jD7q4mR uzU4wLOdImJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaabCIgAKCRDt8TtzzpQ2 X4ATC/96p9lCQmb44HSR3w9JqD1EHcLByEZFcPkoExD7sDGiieEB+CH535JniKYxqREOVQlfv+S 5cIEBoK7p9IHqCh8NVX0vQjY99JaZ3a1YF60RDWD6z58CGAVUoCMXjx+LOeRF+c+QZIQDUnXYtE u+rHOzXPY1Z7GYJdE3vxvtCX0SjTv9gUT3zCtXsfucHPRP+TfsSbhEw/Vr3w3wtphsN7qBVEjma 6wkdMlBsClq3NO1segO6rKiSI4xmWGSQ2DCy2Oe4BFrXGcAK0rg770YU8BHvJUEHv/90PmGbc98 czYGo2A5+7zBFle4NH6neAU4QIdc8iVq8F0A6qghEz7c1QzWXSOj62qNKsu2Bf1wiW1qwH0wLVy XU4FYby8xqDFPw75Q3mnUnZLTGCiufFaXeIH/c/BFpw5CgZPswsKMQ0+p4UGsb9G6XG4EAQXGK2 y/HW62d9bRQ9ejp5M3OQSkCaBq3yBNesNEfQo6It1WX2KrmsDxlZoL1L7f2W2twqskBGU=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This driver runs also on SoCs without a Tegra20 APB DMA controller (e.g.
Tegra234).
Remove the Kconfig dependency on TEGRA20_APB_DMA, and remove reference to
the APB DMA controller from the Kconfig help text.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes from v1 [1]:
- added Andy's Reviewed-by tag
- removed Fixes tag (Jon)

[1] https://lore.kernel.org/linux-serial/20251126090759.4042709-1-flavra@baylibre.com/T/

 drivers/tty/serial/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f86775cfdcc9..8500b1eed5b5 100644
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

