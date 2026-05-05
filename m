Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E283033FB
	for <linux-serial@vger.kernel.org>; Tue,  5 May 2026 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777944080; cv=none; b=IfvL3LzDAeptqHKenIjTj+qDQjkczQ+4K2HpxPfVlZ1vnY7YBwiC7z0P+n7qI4RzJ19sXmCgkugoK3ME7ZdsOzvtVwWcacwgF6lr0tGUJ3v8wuSXV0DrswSy7vujm16hBAyZB0wBUemRbIjT5twyF/LY7ygFer8GbrKP7abgRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777944080; c=relaxed/simple;
	bh=D+GWBUsJHrvzMPbMoj2hFUURjtG3vXfq/UASGXzw3Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgGTZyldfrXEhh7QRQ/xxbiqcbCWAyv1FyJtCdumr7R70h+burGoqM8DyUhvqXJGClyQtuP00cbVyJ91MRqeI9YshmJ+2tYUIupIMj/cncVMr2zIm03mYtVqxWy5Bqi/XX8jsnEzSh8+MI8wyx/U9t50mxC2yXnz730uRseBwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW7xp9io; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW7xp9io"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so4252409eec.1
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 18:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777944078; x=1778548878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY8FtTvsOkRG27RzbqzYbmmwJrVSnVWLSNXkY1HB1O0=;
        b=XW7xp9ioa7zier1Nc31pC79C7Iy0W7NsuZQwHKqai6NwHR0teFp0HwoaazDFzIfH+s
         B4iI/GX69sVE4NSBphPV989MX1G5jiYJZThrldGXDt/7tKJL98/aNjrc0u+LbbOHGxrg
         ZEl0KfZxAJO0XzfVNZRGUBwtY7J7EtHj4Sp+rHY742Wq5axk2gnrkaVok7ZLyhAbDrcc
         AZMl2pafr0kCQg46dTJm5fTOFhTja/Dc1QMk1gBGyWNJejkDh/+It/8mFylEbHkY6eQL
         EWosEy4drOI9fNNek/MVCm2+uSuse2ae9UEx6XJDic/34pTBKgm3u7t0034Zggl+Y2s/
         Kvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777944078; x=1778548878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bY8FtTvsOkRG27RzbqzYbmmwJrVSnVWLSNXkY1HB1O0=;
        b=ouWapgRzx3+Uz+5FOhdaUKiBN43rb1PnnW5KYVPL+M2xsw2p91SHBMl572R90+zDK3
         xP0vIk+msXOeuMFrJQpTaNvt4InjHmClzrZU87YZHdytquQt02b9rrOFtlbo8M7YOMyW
         GX4nLzutX6MDmoSSfFUmeycGsI6Elalyjcbjho6IhcUwgZK5b/81AL9sjFWiEvpWNlpn
         7nVGd/R9vCBtSFD/IoLP0SQb4sk1tl9tpDEEv6sgcjohrjdLzGLT3aDqLPiYjAMW9tAB
         KPTP+7d4oqel3nngebdY5XIuQPS9eNV7rEnw0MF2t04DzG0cTX7mvQrqsyBn0HXKdej3
         MRgw==
X-Gm-Message-State: AOJu0YyZiGr14XwjRuse/D3FHn5mTwane1cAKWBT2e2MsaXv8N0UWYSN
	G/OQdWAQw+IO3yo95bDpZ2D8MYCC+l7zf8nyhssCwu9lT13k3t1oE4bZZhogsUdr
X-Gm-Gg: AeBDieuy2rzFllQr0Vlh26PPhsGO/ySpRfoyC00Qip2CGe8SAvhM55cbEGDkpHdree4
	QgAEntt1yeSmZEU6vCrItkmnaKzJvU3uIVXdFpNB7SO5ngSZ1apiaYjA0u2HIZ4dsBrFzGHcgfs
	mKpdH4nS7BYrCQAFC6S2UWeqMI2aFPGX1/NdadmvE1qLMcm1Jik77ij+/O6YCMm/w6wiwfjaC29
	CT64j4O5XYligs6Kx456jkuwQtFidRddhcV8oq+OZs0C0qhs4SKTGwC078s4uQ0V53YAKbmvw59
	aL1n0YTqOIJv8Np3QoiFdAA+OYK1rEoDgUj/d2kLo2RYgFsoPyVTn3XcyQZhYSQSLAFOWpp9q7E
	Tr9Y1WSiSauxVJIVysdYr+JRYoj1FysQRDIvoqtIDbYH8KNiMmi6vkPCPbIsvAxk7CyabcsVCFA
	DiojGyiE3jryPS4kVeo1q5ejJm50owk5bHNf0h8wryKDrvoE3iCuYdf2kW4eqZ5npyDi1dwjPSS
	hwn7P+USVlSNgqSTiBbZ0hkAYb8dkv3S2r1LB528/aYsiqhX1V8HlqNw6blqJoauoaDAFzdGuCv
	RYsoYY0s2TQ3jloK9F495+8BKWie
X-Received: by 2002:a05:7300:7490:b0:2d9:6373:ad10 with SMTP id 5a478bee46e88-2efb7dca3cdmr5035040eec.7.1777944077386;
        Mon, 04 May 2026 18:21:17 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d611sm24060034eec.1.2026.05.04.18.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 18:21:17 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH 2/3] tty: remove unnecessary SERIAL_NONSTANDARD config option
Date: Mon,  4 May 2026 18:20:35 -0700
Message-ID: <2cefa6ee9b6bf13d367e15dd74093a0ef9ad81db.1777943090.git.enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777943090.git.enelsonmoore@gmail.com>
References: <cover.1777943090.git.enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SERIAL_NONSTANDARD config option currently only guards the
selection of two Moxa multiport serial card drivers and the HDLC line
discipline, so it does not significantly simplify configuration. Make
the configuration process more straightforward by dropping this option
and dependencies on it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/arm/configs/footbridge_defconfig       |  1 -
 arch/arm/configs/lpc18xx_defconfig          |  1 -
 arch/arm/configs/mps2_defconfig             |  1 -
 arch/arm/configs/neponset_defconfig         |  1 -
 arch/arm/configs/stm32_defconfig            |  1 -
 arch/csky/configs/defconfig                 |  1 -
 arch/loongarch/configs/loongson32_defconfig |  1 -
 arch/loongarch/configs/loongson64_defconfig |  1 -
 arch/mips/configs/bigsur_defconfig          |  1 -
 arch/mips/configs/lemote2f_defconfig        |  1 -
 arch/mips/configs/loongson2k_defconfig      |  1 -
 arch/mips/configs/loongson3_defconfig       |  1 -
 arch/powerpc/configs/cell_defconfig         |  1 -
 arch/powerpc/configs/microwatt_defconfig    |  1 -
 arch/powerpc/configs/ppc6xx_defconfig       |  1 -
 arch/sh/configs/polaris_defconfig           |  1 -
 arch/x86/configs/i386_defconfig             |  1 -
 arch/x86/configs/x86_64_defconfig           |  1 -
 drivers/tty/Kconfig                         | 18 ------------------
 drivers/tty/serial/Kconfig                  |  4 ++--
 tools/testing/selftests/bpf/config.x86_64   |  1 -
 tools/testing/selftests/hid/config.common   |  1 -
 22 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 5f6963687ee4..58234fd3af4b 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -70,7 +70,6 @@ CONFIG_SLIP_SMART=y
 CONFIG_SLIP_MODE_SLIP6=y
 CONFIG_SERIAL_21285=y
 CONFIG_SERIAL_21285_CONSOLE=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_PRINTER=m
 CONFIG_DS1620=y
 CONFIG_NWBUTTON=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index f142a6637ede..9ca18939b82a 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -92,7 +92,6 @@ CONFIG_KEYBOARD_GPIO_POLLED=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C_LPC2K=y
 CONFIG_SPI=y
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index e995e50537ef..a1045dee7e8a 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -66,7 +66,6 @@ CONFIG_SMSC911X=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_MPS2_UART_CONSOLE=y
 CONFIG_SERIAL_MPS2_UART=y
-CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 8a5dcca743fc..2080e4dfdd6c 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -51,7 +51,6 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CS=y
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_WATCHDOG=y
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 82190b155b14..919c70107371 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -39,7 +39,6 @@ CONFIG_KEYBOARD_GPIO=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
-CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
index ff559e5162aa..481b51eadf41 100644
--- a/arch/csky/configs/defconfig
+++ b/arch/csky/configs/defconfig
@@ -20,7 +20,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
diff --git a/arch/loongarch/configs/loongson32_defconfig b/arch/loongarch/configs/loongson32_defconfig
index d5ef396dffe3..5dd7b8cb8957 100644
--- a/arch/loongarch/configs/loongson32_defconfig
+++ b/arch/loongarch/configs/loongson32_defconfig
@@ -723,7 +723,6 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_8250_LOONGSON=y
 CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_PRINTER=m
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
diff --git a/arch/loongarch/configs/loongson64_defconfig b/arch/loongarch/configs/loongson64_defconfig
index cba4cdff5acd..80396cd61755 100644
--- a/arch/loongarch/configs/loongson64_defconfig
+++ b/arch/loongarch/configs/loongson64_defconfig
@@ -739,7 +739,6 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_8250_LOONGSON=y
 CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_PRINTER=m
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_IPMI_HANDLER=m
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index aa63ada62e28..602795e2659c 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -121,7 +121,6 @@ CONFIG_SLIP_MODE_SLIP6=y
 # CONFIG_INPUT is not set
 CONFIG_SERIO_RAW=m
 # CONFIG_VT is not set
-CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index b9f3e1641105..084b569cf8d8 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -125,7 +125,6 @@ CONFIG_SERIAL_8250_NR_UARTS=16
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_FOURPORT=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_HW_RANDOM=y
 CONFIG_GPIO_LOONGSON=y
 CONFIG_THERMAL=y
diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index ca534a6b66de..0b29ad43b62b 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -222,7 +222,6 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_PIIX4=y
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 12cb1a6a1360..00bf6358357f 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -254,7 +254,6 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_I2C_CHARDEV=y
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 7a31b52e92e1..439c03172deb 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -135,7 +135,6 @@ CONFIG_GELIC_WIRELESS=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
diff --git a/arch/powerpc/configs/microwatt_defconfig b/arch/powerpc/configs/microwatt_defconfig
index d81989a6f59b..60dce8b41f97 100644
--- a/arch/powerpc/configs/microwatt_defconfig
+++ b/arch/powerpc/configs/microwatt_defconfig
@@ -64,7 +64,6 @@ CONFIG_LITEX_LITEETH=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_SERIAL_NONSTANDARD=y
 # CONFIG_NVRAM is not set
 CONFIG_SPI=y
 CONFIG_SPI_DEBUG=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 4ddd2c01b8b7..b745965c5215 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -550,7 +550,6 @@ CONFIG_GAMEPORT_L4=m
 CONFIG_GAMEPORT_EMU10K1=m
 CONFIG_GAMEPORT_FM801=m
 # CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_NOZOMI=m
 CONFIG_N_HDLC=m
 CONFIG_SERIAL_8250=y
diff --git a/arch/sh/configs/polaris_defconfig b/arch/sh/configs/polaris_defconfig
index 4f0396c2ac79..0b51a85300a6 100644
--- a/arch/sh/configs/polaris_defconfig
+++ b/arch/sh/configs/polaris_defconfig
@@ -54,7 +54,6 @@ CONFIG_SMSC911X=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=3
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 79fa38ca954d..b67e7073da10 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -182,7 +182,6 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_NVRAM=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 269f7d808be4..5db8acec1e37 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -177,7 +177,6 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 # CONFIG_HW_RANDOM_INTEL is not set
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 63b378e44a59..a9ade8bc88b2 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -191,26 +191,8 @@ config LDISC_AUTOLOAD
 
 source "drivers/tty/serial/Kconfig"
 
-config SERIAL_NONSTANDARD
-	bool "Non-standard serial port support"
-	depends on HAS_IOMEM
-	help
-	  Say Y here if you have any non-standard serial boards -- boards
-	  which aren't supported using the standard "dumb" serial driver.
-	  This includes intelligent serial boards such as
-	  Digiboards, etc. These are usually used for systems that need many
-	  serial ports because they serve many terminals or dial-in
-	  connections.
-
-	  Note that the answer to this question won't directly affect the
-	  kernel: saying N will just cause the configurator to skip all
-	  the questions about non-standard serial boards.
-
-	  Most people can say N here.
-
 config N_HDLC
 	tristate "HDLC line discipline support"
-	depends on SERIAL_NONSTANDARD
 	help
 	  Allows synchronous HDLC communications with tty device drivers that
 	  support synchronous HDLC.
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 999f56307445..6e448a6f1020 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1594,7 +1594,7 @@ config SERIAL_NUVOTON_MA35D1_CONSOLE
 
 config MOXA_INTELLIO
 	tristate "Moxa Intellio support"
-	depends on SERIAL_NONSTANDARD && PCI
+	depends on PCI
 	select FW_LOADER
 	help
 	  Say Y here if you have a Moxa Intellio multiport serial card.
@@ -1604,7 +1604,7 @@ config MOXA_INTELLIO
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support v. 2.0"
-	depends on SERIAL_NONSTANDARD && PCI && HAS_IOPORT
+	depends on PCI && HAS_IOPORT
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
 	  want to help develop a new version of this driver.
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index 42ad817b00ae..2fc3e7e6ae5e 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -189,7 +189,6 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_NR_UARTS=32
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SGI_PARTITION=y
 CONFIG_SMP=y
diff --git a/tools/testing/selftests/hid/config.common b/tools/testing/selftests/hid/config.common
index 38c51158adf8..89a83cda737b 100644
--- a/tools/testing/selftests/hid/config.common
+++ b/tools/testing/selftests/hid/config.common
@@ -201,7 +201,6 @@ CONFIG_SERIAL_8250_NR_UARTS=32
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SGI_PARTITION=y
 CONFIG_SMP=y
-- 
2.43.0

