Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857382882AA
	for <linux-serial@vger.kernel.org>; Sun,  8 Mar 2026 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772975662; cv=none; b=lJ39IndWZ855aVArjcDv9VJHEWG6BMAHmVdDH5OE33z8szZKoF+795HaukQV+nv0snh+wZe363y/uH4XAWU0LpihhSeLFwc9M6hH+ajhDLKltKOmvXk4RBioxyqrivzRNFSn/CItTKQwT+L3kApr74s5dp4B3nJ0G+FMgxCxlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772975662; c=relaxed/simple;
	bh=ayV0mPSWTYq40kHYXVY6l1WJRrs219j6nJPh+Ai6wFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzXm7GXPCFt9Uh7s0QQ5ZWoIE/yQwcQAbEc7JHVg61c7pdk4JE8aNVRrBGPSkKIcg+CvH3riKfQl684oReCz8UbH7knd3JNnkME7Jvpe40FZCNjspCviPe8fWvcnYytJ6ynn4CZEZCBpLyxf4x6fTP9O3qlesZUhUTViBIVUHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljd0Ebvb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljd0Ebvb"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-660d77cacc2so4059334a12.1
        for <linux-serial@vger.kernel.org>; Sun, 08 Mar 2026 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772975659; x=1773580459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YZmjSe2f6AmZLKDK24gip2MTz9bDyoXie7g+0s0Xf3Y=;
        b=ljd0EbvbDBeL3Q3PeSDXYZwywEju23W5YocAoW4/W1c5bm7pDwwuYjEuVGNTTGkiAO
         F/6Cp2mRVAYcbVz67/7+Au+bF2MpaXbHth+wplb6DJvjrqYIebR2sarnCvT2OTkCeiiA
         GKq7Hrywl7zo8948KWlrUxxHfRebkZxnqO6g2P03oS3MUNwXyY6SwLoZYUpsjOCnNPYB
         RA8OGFSIUjnNgfvH06fO06jysKD7+9ITGbLCJ1zSXMkGoluit8qjRrusA8QIBxWKe+YC
         I0yv6AZ5KMGp/5rVBBQnO4DFoOSZx5eajUjWuqN0xNTg07Vwh8D3doxNMVR88TwAb184
         LqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772975659; x=1773580459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZmjSe2f6AmZLKDK24gip2MTz9bDyoXie7g+0s0Xf3Y=;
        b=ugvEZfKi8Id1biL0LtfjbF3RDv+vct9zXs0RKKL3+MEbBUXPGb6erAbZPtzeDjwDzF
         wC6hQFSj6IMI4uwQRKT9NVAjCuvgVl93zs/7UIP693TYYqU04X/nymAHNikA3eo9+3WN
         5WMAy0zbIdMEfJKP8onGT97DzZfHyGItINXq8cpHvZtt+ZQweYL0NPd2jVFImYFeqd+A
         H2PdMoI4aOG7xQ8Xdcbf/Vc6wkVPjNP37HEG9PE1XOjUHNWD5/5JTSHC9lzBdGtBp1+m
         J9DYkTm++jhUW1UMkv/sjtBjnMlKuFfZN29P7WTiGwdWBfttjQTK0GEOSl4C54OAv0ZB
         Ondw==
X-Forwarded-Encrypted: i=1; AJvYcCV4cfl1qzfrT0nnHbjqnvVfsCCPvEV+X3Q1FFLA6vJ22Pb9v7gdMao7k6L/j9oZCXJ1PvpC36U9Q69mOMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMRLhk5OZEvwLA+fNvGSDBnRxbORBMyl4HbL2nmCzUEo/djtw
	ZhNizUgR/YFPa2a65w4xUE8Iy8anDzmDWDERR6tKYx6jJ5+cpMMmnCwv
X-Gm-Gg: ATEYQzzxXkvm/Sf64iT5UjzN2f2Up7QpiRfpshcOabiPrMMmoTgAswmCPUrTNLP9irX
	9XlMaFS4MpbGWBc7pZV5+UHQ/8U4jRGaBHOwwTIjiGJGTgWx8SGtqAjv221zrIxOWRy/ceVF9n/
	18xWbpBbvTATcRjk1dyAyxVUkGtGjdFv4V/YaVBStpM6XAa6K4+3Y7A7QXLjzLA2UnGUZAjvj8J
	QRMKeMcDjtfixTFgAAxU+P20VgVrhv0AEPpiVShkpaIl12lUBcF0Ba0CqogRhWhqzrhIcsZW7BB
	8ANzdKo3K2je+JswAPZwtowhBdba8Sa751GeJYeIc6AGDpgCwbeYIBYgUr8wylyLZpKhGkBkWZc
	FL1VT4iZsh8BjX1LVgE4iZEv+Db5kfZv2gzwWMFdFEPxYt9LGlCIs3nTrwjSfjH5dpr1kQyk0XQ
	y8BIbyHRkhtSI2SEOTY/ecL+Gh/MKgVb9ineosPgvGq3cWRGeu5wdQbPGBJ3aJ9aUe9YGJMQ==
X-Received: by 2002:a05:6402:40c2:b0:65c:3383:927c with SMTP id 4fb4d7f45d1cf-6619d41eb63mr4525068a12.5.1772975658536;
        Sun, 08 Mar 2026 06:14:18 -0700 (PDT)
Received: from nixos-office (98.206.213.193.static.cust.telenor.net. [193.213.206.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-661a3e61eb6sm2154649a12.8.2026.03.08.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 06:14:17 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: gregkh@linuxfoundation.org,
	jcmvbkbc@gmail.com
Cc: rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] drivers/tty/serial: move ESP32 UART drivers into staging
Date: Sun,  8 Mar 2026 13:14:12 +0000
Message-ID: <20260308131412.1102749-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These drivers were added about 3 years ago, and depend on the
XTENSA_PLATFORM_ESP32 config option which has never existed,
so no device can actually use them.
They can only be compiled with COMPILE_TEST.

As you can see, this config option is still undefined
in the downstream tree:
https://github.com/search?q=repo%3Ajcmvbkbc%2Flinux-xtensa%20XTENSA_PLATFORM_ESP32&type=code

I propose moving these drivers into staging
until there is a device that can boot the mainline kernel and use them.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/staging/Kconfig                       |  2 ++
 drivers/staging/Makefile                      |  1 +
 drivers/staging/serial_esp32/Kconfig          | 28 +++++++++++++++++++
 drivers/staging/serial_esp32/Makefile         |  4 +++
 .../serial_esp32}/esp32_acm.c                 |  0
 .../serial_esp32}/esp32_uart.c                |  0
 drivers/tty/serial/Kconfig                    | 26 -----------------
 drivers/tty/serial/Makefile                   |  2 --
 8 files changed, 35 insertions(+), 28 deletions(-)
 create mode 100644 drivers/staging/serial_esp32/Kconfig
 create mode 100644 drivers/staging/serial_esp32/Makefile
 rename drivers/{tty/serial => staging/serial_esp32}/esp32_acm.c (100%)
 rename drivers/{tty/serial => staging/serial_esp32}/esp32_uart.c (100%)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 2f92cd698bef..97593e31ca47 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -48,4 +48,6 @@ source "drivers/staging/axis-fifo/Kconfig"
 
 source "drivers/staging/vme_user/Kconfig"
 
+source "drivers/staging/serial_esp32/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index f5b8876aa536..78c2e4f49fe5 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -2,6 +2,7 @@
 # Makefile for staging directory
 
 obj-y				+= media/
+obj-y				+= serial_esp32/
 obj-$(CONFIG_RTL8723BS)		+= rtl8723bs/
 obj-$(CONFIG_OCTEON_ETHERNET)	+= octeon/
 obj-$(CONFIG_VME_BUS)		+= vme_user/
diff --git a/drivers/staging/serial_esp32/Kconfig b/drivers/staging/serial_esp32/Kconfig
new file mode 100644
index 000000000000..61c56bfe7764
--- /dev/null
+++ b/drivers/staging/serial_esp32/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+config SERIAL_ESP32
+	tristate "Espressif ESP32 UART support"
+	depends on HAS_IOMEM
+	depends on XTENSA_PLATFORM_ESP32 || (COMPILE_TEST && OF)
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Driver for the UART controllers of the Espressif ESP32xx SoCs.
+	  When earlycon option is enabled the following kernel command line
+	  snippets may be used:
+	    earlycon=esp32s3uart,mmio32,0x60000000,115200n8,40000000
+	    earlycon=esp32uart,mmio32,0x3ff40000,115200n8
+
+config SERIAL_ESP32_ACM
+	tristate "Espressif ESP32 USB ACM gadget support"
+	depends on HAS_IOMEM
+	depends on XTENSA_PLATFORM_ESP32 || (COMPILE_TEST && OF)
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Driver for the CDC ACM gadget controller of the Espressif ESP32S3
+	  SoCs that share separate USB controller with the JTAG adapter.
+	  When earlycon option is enabled the following kernel command line
+	  snippet may be used:
+	    earlycon=esp32s3acm,mmio32,0x60038000
diff --git a/drivers/staging/serial_esp32/Makefile b/drivers/staging/serial_esp32/Makefile
new file mode 100644
index 000000000000..3c23321944e2
--- /dev/null
+++ b/drivers/staging/serial_esp32/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SERIAL_ESP32)		+= esp32_uart.o
+obj-$(CONFIG_SERIAL_ESP32_ACM)		+= esp32_acm.o
diff --git a/drivers/tty/serial/esp32_acm.c b/drivers/staging/serial_esp32/esp32_acm.c
similarity index 100%
rename from drivers/tty/serial/esp32_acm.c
rename to drivers/staging/serial_esp32/esp32_acm.c
diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/staging/serial_esp32/esp32_uart.c
similarity index 100%
rename from drivers/tty/serial/esp32_uart.c
rename to drivers/staging/serial_esp32/esp32_uart.c
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f86775cfdcc9..686e7fb073b8 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1593,32 +1593,6 @@ config SERIAL_NUVOTON_MA35D1_CONSOLE
 	  but you can alter that using a kernel command line option such as
 	  "console=ttyNVTx".
 
-config SERIAL_ESP32
-	tristate "Espressif ESP32 UART support"
-	depends on XTENSA_PLATFORM_ESP32 || (COMPILE_TEST && OF)
-	select SERIAL_CORE
-	select SERIAL_CORE_CONSOLE
-	select SERIAL_EARLYCON
-	help
-	  Driver for the UART controllers of the Espressif ESP32xx SoCs.
-	  When earlycon option is enabled the following kernel command line
-	  snippets may be used:
-	    earlycon=esp32s3uart,mmio32,0x60000000,115200n8,40000000
-	    earlycon=esp32uart,mmio32,0x3ff40000,115200n8
-
-config SERIAL_ESP32_ACM
-	tristate "Espressif ESP32 USB ACM gadget support"
-	depends on XTENSA_PLATFORM_ESP32 || (COMPILE_TEST && OF)
-	select SERIAL_CORE
-	select SERIAL_CORE_CONSOLE
-	select SERIAL_EARLYCON
-	help
-	  Driver for the CDC ACM gadget controller of the Espressif ESP32S3
-	  SoCs that share separate USB controller with the JTAG adapter.
-	  When earlycon option is enabled the following kernel command line
-	  snippet may be used:
-	    earlycon=esp32s3acm,mmio32,0x60038000
-
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index a2ccbc508ec5..bba7b21a4a1d 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -37,8 +37,6 @@ obj-$(CONFIG_SERIAL_CLPS711X)		+= clps711x.o
 obj-$(CONFIG_SERIAL_CPM)		+= cpm_uart.o
 obj-$(CONFIG_SERIAL_CONEXANT_DIGICOLOR)	+= digicolor-usart.o
 obj-$(CONFIG_SERIAL_DZ)			+= dz.o
-obj-$(CONFIG_SERIAL_ESP32)		+= esp32_uart.o
-obj-$(CONFIG_SERIAL_ESP32_ACM)		+= esp32_acm.o
 obj-$(CONFIG_SERIAL_FSL_LINFLEXUART)	+= fsl_linflexuart.o
 obj-$(CONFIG_SERIAL_FSL_LPUART)		+= fsl_lpuart.o
 obj-$(CONFIG_SERIAL_ICOM)		+= icom.o
-- 
2.51.2

