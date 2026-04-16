Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75573ED5D4
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370796; cv=none; b=np3oaqQp73UMNFSKb/M2+cAZXlLw3TZMW1tndFTjMdKj47EcDAqQ3QX9u9KEQkUJt/oP7MtGQT/4kaCBvg1kJt1gSeTbcWEShhSqO9J5z9Zle5179Ko07DUPwBFMng44iBqQ0m9Mp20vlYLb/ink4fE70+ZJEqP8372fM2n+jEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370796; c=relaxed/simple;
	bh=ZNDyS+awGPYyhYY2wqVY+4vd+g5xgcLu7pSNmzdrdY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U56Gji1DdJqvA7qeiwPwKQfht/e4KYEoGvPGYTz7ihJKy6sQbedf4ncD89BDsSsbQC7QeLtlNqAD601bKEscDAo0vxx/N1XsmA3fP5yCI70ToA5cjMFH7kdfSaABGRarF9PiC8kXnci8Uo/JT5rCW018XKjtFWDzD4+PDS3cwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx4yLIaK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx4yLIaK"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d7605ec91so4471698f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 13:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776370788; x=1776975588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSeMkiWEZl5lsLoSz5tNKqauPZwfUQxEknHNAlawPhY=;
        b=Cx4yLIaK9q/+amhyhkjvV7qqxtJDOgGSU9vXuuBcylHGwzNuVgScGAjKeETEOIOPtH
         FUImiVQ2KxgyhTLJXN+dK/nm7OmIhv7KAI1utLNYni0u4shN8eIOhWGTBQlYeYar8696
         /jhqlAtCkqYdXDVHMo6Wp9jL/bZbTXpCLumeyue5yrHxdxpTRntEXAZj+MTYB1tGQAaX
         sBz49+jAzFg3nUMW/LZikeAmcQJ3WuCtGULj0NkBhdl1tZTgjJ9hC0ardmezSGjx27GF
         z25s3DMCyxKWhcMDOr/JQ1zUHcaoF4QOyKawzL6cKXlI4WNdQWii8BFfp8afXvQb1RaD
         4s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370788; x=1776975588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wSeMkiWEZl5lsLoSz5tNKqauPZwfUQxEknHNAlawPhY=;
        b=qogHcKIUDrSzYSKd6EprvHTff/MCI7vkZa+s0POquFReIKmIY6JMOCnVkaVparPv8C
         VZ11BeOvFFNS0jdS7DB2tk6ugdrXriE79DTLcJhVpN4jntAt6RHWIyYICJdk0X5Xd8Vs
         R29kDst4Q3qJjCupB/YpnPZiby/JYs44jJtgjnSzMlf6T1qNUcULr/6wPBUoY7j/+oNf
         6TApujKQPnGoL357KA/UTDSre/dSJOxiPLSb3YgkF0pGV8GysCOEgrQS4tYF9P10VOFy
         HuusF7fyGTGivRn/3GjZs23NRJu4uZIky+X9bfELbUT1motxmVgUpPiHzmhJbBoZNQ3o
         nQXA==
X-Forwarded-Encrypted: i=1; AFNElJ80O1V+3CEnMp++/9nwcx943sUJWntZs0O1bDesyU11oRj9hAUh8YYBWZKtmkGaosg1dandP9FRE9FMqbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWEaJAMW2hfWnImwjC/YCdryKilQHi2FbIIB8CpqPQa7863KR0
	s3rvVG3JAxJrRLO+2WICO9DYsJsjHfC7jwkcvkpiOuUOoNZ6o6KSJBw1
X-Gm-Gg: AeBDieuO/AqUOcKRXFY+ek7dNReNbqiMGne/9TKV4JrmC+KdoU78Snn5qDyC5P3WoH6
	9M6bJjNuIshbO/Ex+Xi3BpcbW9b7iM76Z6UP/F/tHkoZ89ZUsjTbwS1u92OzYtg89lZZ+HLHn/b
	DKN/yegutRbC5rxZ0t23GiKGUxLJlVsg4KNAQqyLRKxfHpIfIzrBm7MtJuImhssu3QFsFqazKJk
	rfZsCyJEeoT63/6Era6m+zOicxq+R/KMP4pOgDfpmNwIY+KFX+TXSnldCRUkiQb/OEfy/1d4OxC
	bsZ59HRHxrruT8U9ATnaf4BzUb/otV195pLpr7uvJgXd1chzJU4EB7yqdpCLt2BCJ0L1InEnh5S
	y+wsYC8jghzV2dDg1nkZpbiryQrMd/coXZO1FHJ0mB93QCuMGtaTd1bOQwVbSNkc/9hCjmIGGOX
	2D7+fenYD/BU6KYyDPhVo3gTKglrWdRnwUbqI8lRDhCAGcSS1xx57jJXPN
X-Received: by 2002:a05:6000:240b:b0:43c:f7e5:817a with SMTP id ffacd0b85a97d-43fe1195921mr1194343f8f.19.1776370787861;
        Thu, 16 Apr 2026 13:19:47 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35c026sm16180624f8f.15.2026.04.16.13.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:19:47 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Thu, 16 Apr 2026 23:19:12 +0300
Subject: [PATCH v4 4/8] ARM: zte: Add support for zx29 low level debug
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-send-v4-4-e19d02b944ec@gmail.com>
References: <20260416-send-v4-0-e19d02b944ec@gmail.com>
In-Reply-To: <20260416-send-v4-0-e19d02b944ec@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 soc@lists.linux.dev, linux-serial@vger.kernel.org, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=ZNDyS+awGPYyhYY2wqVY+4vd+g5xgcLu7pSNmzdrdY0=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp4URLRqhlAg7wWpuO7UM+dO5wr9IgPxdFB5P+5
 vUoUcclmM6JAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaeFESxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiLfbQ/+PTMWmPt4g6u+CTBldAZiNn549W+zIJW
 BmndZJRxXguEwhB3ZX5goKPHuPssJBq3rhN092lxHwvSXn35vpbcrGYbUf67MJ5ip/WEDtGJGZR
 2dCHfqfMl50SVl3FTA6qG7NvCBLpX6+ebr9+sPj0FV+k6pqPa98rK20AayB5d9TFT6gXgMNLvOs
 EGFfO4dkY2x/ARGjoK6hjhY6XhW5b5y0wb3krGYlJIzeyJu1/XT/yzFIRoqfFhAZ782Y2JsKTNs
 nwm404jlvcFrzBq0jHUUfW9gChxUN/JXodBTzlI6NxJJJIaN9IulGto94+7tGMcU8WK39Osegr8
 /G0nIqXZSFxtJGXjvelY8VcA2HatwQrZTgl5o0jBTrnJ/Pzm5y5ygNajb4BXVG88keAEzy6f7LJ
 gZl9dln23feYfIxn/+zNLAyYZGCI5j2auIhw0JiRpak9JTKgq89kOxKHfG4mubeepSn4AVUdq2f
 y44Pm2yK435+ZjyXoiwBBAZgz0wzphkmNAaagpOTM1A5eZb2wAKrK98gOR+npXoHaLVvGVmRfxa
 BVVrkRIfMit3Cb634TWiCg4kTPIBUHVGzKDHBpzxZOf52kOEir2VQszoar6+Xo6V4SHedZA+bNC
 iwy8mTcnO2zYDwCHJ7UdHGd9q3ZzWP45Bw8oVWlGPlnYehptsOHc=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This is based on the removed zx29 code. A separate (more complicated)
patch will re-add the register map to the pl011 serial driver.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>

---

I am unsure about the virtual address. It doesn't seem to matter, as
long as it is a valid address. This address is based on the old removed
code. Is there a rule-of-thumb physical to virtual mapping I can use to
give a sensible default value?
---
 arch/arm/Kconfig.debug         | 12 ++++++++++++
 arch/arm/include/debug/pl01x.S |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 366f162e147d..98d8a5a60048 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1331,6 +1331,16 @@ choice
 		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
 		  devices, including VT8500, WM8505, WM8650 and WM8850.
 
+	config DEBUG_ZTE_ZX
+		bool "Kernel low-level debugging via zx29 UART"
+		select DEBUG_UART_PL01X
+		depends on ARCH_ZTE
+		help
+		  Say Y here if you are enabling ZTE zx297520v3 SOC and need
+		  debug UART support. This UART is a PL011 with different
+		  register addresses. The UART for boot messages on zx29 boards
+		  is usually UART1 and is operating at 921600 8N1.
+
 	config DEBUG_ZYNQ_UART0
 		bool "Kernel low-level debugging on Xilinx Zynq using UART0"
 		depends on ARCH_ZYNQ
@@ -1545,6 +1555,7 @@ config DEBUG_UART_8250
 
 config DEBUG_UART_PHYS
 	hex "Physical base address of debug UART"
+	default 0x01408000 if DEBUG_ZTE_ZX
 	default 0x01c28000 if DEBUG_SUNXI_UART0
 	default 0x01c28400 if DEBUG_SUNXI_UART1
 	default 0x01d0c000 if DEBUG_DAVINCI_DA8XX_UART1
@@ -1701,6 +1712,7 @@ config DEBUG_UART_VIRT
 	default 0xf31004c0 if DEBUG_MESON_UARTAO
 	default 0xf4090000 if DEBUG_LPC32XX
 	default 0xf4200000 if DEBUG_GEMINI
+	default 0xf4708000 if DEBUG_ZTE_ZX
 	default 0xf6200000 if DEBUG_PXA_UART1
 	default 0xf7000000 if DEBUG_SUN9I_UART0
 	default 0xf7000000 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART0
diff --git a/arch/arm/include/debug/pl01x.S b/arch/arm/include/debug/pl01x.S
index c7e02d0628bf..0c7bfa4c10db 100644
--- a/arch/arm/include/debug/pl01x.S
+++ b/arch/arm/include/debug/pl01x.S
@@ -8,6 +8,13 @@
 */
 #include <linux/amba/serial.h>
 
+#ifdef CONFIG_DEBUG_ZTE_ZX
+#undef UART01x_DR
+#undef UART01x_FR
+#define UART01x_DR     0x04
+#define UART01x_FR     0x14
+#endif
+
 #ifdef CONFIG_DEBUG_UART_PHYS
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =CONFIG_DEBUG_UART_PHYS

-- 
2.52.0

