Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423FD17AE11
	for <linux-serial@vger.kernel.org>; Sun,  8 Mar 2026 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772975524; cv=none; b=hZmlTiNW6P6e7u2cSgtSExcJ2QpuR4b0Qri7TdKcq99AxB9evXBopKbjewa3M7xhBrf9tdz5J4v1p6eCq/vyJy3uJyxrBzXSs2DA9k06fKtmJNVytHUBNkLBkXci3dhWZKELrFieCGYRv+hWj6eQAlfUukF2YXfQm9/OdSiEsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772975524; c=relaxed/simple;
	bh=ayV0mPSWTYq40kHYXVY6l1WJRrs219j6nJPh+Ai6wFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZfVwIVmXgoKVmX1RrATd7l3kqjwpeCGuuSHpWe3wwA/kTW5ESiQj4ZG5CoSh39FoBrtw02P4B6m+FK9yoWsRETn8VctK65nbeFynjD5XCV+kdzSXuXEZTTJ9uiDal+4Wxr/iQ3Z60j5RxDurnFRJfuJczmmVMx8vwBoBvnA0dKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjrqfJmR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjrqfJmR"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b96e579c0fcso72793766b.3
        for <linux-serial@vger.kernel.org>; Sun, 08 Mar 2026 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772975520; x=1773580320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YZmjSe2f6AmZLKDK24gip2MTz9bDyoXie7g+0s0Xf3Y=;
        b=JjrqfJmRDh0jrlAEmSVT3U7Igjq11cFgXbGMJhGAC3Q2OFCLdXt5xKOJYA6XK96Kyv
         BnNIbFwM0dvgbfs+0at6XTfvGwrWuBACLB4q2Xl4kOIOAD9qBfFpWNkROSYjKj1hxWNI
         a9dZh4oTYf1/Evu2SJnEdw8sNJHYBIuLr/JMk8r0xPoO634Z9t2A4MYn4sG5UwT1BnLE
         Q+eo9Npj+vRI9kHkt+3GL0Rauun8NwUjDBPnJMql8QAnc1r4QqFhZr7AhLaKhIZ8ViCK
         bB1OoaQDhXZ5B2T6cv71BvLWqtj9nQ/kAcKEJKA4pr77WX0upBdWnJEZ2IKCNhHAYAcf
         PnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772975520; x=1773580320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZmjSe2f6AmZLKDK24gip2MTz9bDyoXie7g+0s0Xf3Y=;
        b=a5MIXU/gUdv/FQAv2uO20mS54LBI1xlSLxhqi53giSf+rUJ057eLV+NSg0/unpNdRr
         /IsgG6Zf5/qvDJ6kT2iuwGzqsqMg7J901NtLhWpZ5I0LQcQTif9zkA1LWp3IhI+r1LTl
         b5YSifNS50YEyPTlLE1v1gYJVOc2bXNlr0jMTIqchpqXr3zo2fnJaLbzInSCM3cenDor
         x9AN1ftKC3htP9cHj7m8egsGToBRh2jm1AcPuOrNRrb76bqm7SOZote94YHABvFjXWtI
         GIGqO2YNmYGvR3MKUtODr//IwlrQuIfAk/uiY3/H23kjhc+Eh045kFUuNstgrIeqQe1B
         1H6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIP6TdJ59q6OqniSuaQZwjsBV/RvK+EIm0V2tBRvr9AO2Jm8JQWD/8JegY0aUva+o+H22HSK7bgIoXaYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzt+7mgUNZxfL4ZFdJvn2T7aJau1z+kG94WSvLUpNyuS6uFGaG
	aS204ndXU5a+WQW5PtV6twBQ3wdkY02uf3ulJmEAHdl47llhn7I12Bcl
X-Gm-Gg: ATEYQzwFKa4rKlC0BCwrrN6aoBmoFbkVfLtciHYlN2IZSw3yII65GTGe+QVIsaT/fql
	Nb6VrNgVcl02V3UhJxHE9rxDLfxNp+kVYzU5P6FcsK3V6hxq3zwAK8EmrkDD/gVly5kiddKT+mR
	7+/HVy5c2aIPt+RwVQURuOzRAWjbHRV/rpHCjxng2e+g0B+BdbqsAGYVsCRg6oYdElDnJAsl/n7
	2CyLYUID2AUdB0vmSDaKzUzx14OBRaNFbkZ1w/DODdVfK8Jrr7HajnzDZjMZmKGK/kIe/eTujSB
	Dy4An6QZi3BotT368Eim7BQKNeBUAS4NbG7hgpUrqA+8/EYzM9CaVcJI3pDYrNc0qJuaFU/F1Sl
	Ytl4V0cP59JKmqqHeEnGLi/7Y22o7Fa8BOVgifOgGLscbSjKrLSdnx5zn1EL9MnkPSDk+kX5FZL
	sV6gEA6Z+Z9EgFvkiZmvE3nj0TVxZxMU+wRA3h4XrjkZfHjt/zc35eT/QpBnFeFgatwKB0Ag==
X-Received: by 2002:a17:907:3faa:b0:b8a:f2cb:8088 with SMTP id a640c23a62f3a-b942df7e851mr378460266b.33.1772975520183;
        Sun, 08 Mar 2026 06:12:00 -0700 (PDT)
Received: from nixos-office (98.206.213.193.static.cust.telenor.net. [193.213.206.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f18bb43sm240592066b.66.2026.03.08.06.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 06:11:59 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: gregkg@linuxfoundation.org,
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
Date: Sun,  8 Mar 2026 13:11:56 +0000
Message-ID: <20260308131156.1102166-1-julianbraha@gmail.com>
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

