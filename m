Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6083BFAE2
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708111; cv=none; b=RNQOZiYz0fq4UG+Q0iTV471ygzFnN/jslZ//uDxDauvUdlVKmhS+SaFlVwe0Eoz/SEOmySOL/eYRMO4ckkF5eXXjt2KXJ8+U/JhNzYJBurgOV0K/OfYuBUmJ85T+g3v29OUABkzU/Bq7oiHTIgHJ1kdFwrmqwh3W3wqoUmA4tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708111; c=relaxed/simple;
	bh=fcg5dGJNBAQyU4b2cL0nA3wqgVJTqz/EfkeGsaL9qZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HmodNhRP2SbZIVRT56jBclkY8pX07MekSLCfAPT55qd3l1OGOSoQPILx5w6ExNs31HRqH5+Hl0alJVSagpJLWg7Gw6ee2kOjL/8Lkt5G4xL67VFVVddsXM71cYLFGtHWq58/cQKR/ROB1oEhnBF46+EWPAi3CelCQb/S5YGXeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcSK/TOw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcSK/TOw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so86583565e9.0
        for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778708105; x=1779312905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilUL26n1rjGYeNrOGQ28D9s1uztNCB3AEwbB2W2pXWM=;
        b=QcSK/TOwj+vFz6gW3iV15mckfT4BSKXGaYPkctagMNZOyUhdUBkYiGvridRlCqtaZl
         OqZGtILhBadOgCFVTekt/G17rs/6yIIpaaNLVVcurJn8PMhcUuz0LN5zb+qkuZt+pszv
         23kKjmBX3rG0eVaOTAdUFeUjUm0iiSgeho26usMO8RsEoNlPxKSF0wcRyQlJrvdyZPF+
         mg8iP3GOTZ+pAHddoSCcZ7dPcS6axNyo/lmtMFZcvTUbAT4pY3pl2Bq17opeariXD1nE
         Va9kEDS1OIXMDZB9CqL8uhO8KXfawFlGjb/FLNei0oR+5QaLqywXq9T1rOuW4wlWLMva
         dNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778708105; x=1779312905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ilUL26n1rjGYeNrOGQ28D9s1uztNCB3AEwbB2W2pXWM=;
        b=QWq+v2xljLqYJSsBahjmFzw+7TxD5jV+fZurc/YvE7pWU2Eq8U1aTp8dBZtiMMPAhQ
         ZgUmB3Hc1nnPJGvt3h4VhD4EbORLTuhwCDWeST4FoaOfCbB+q+oz+v57BNMkhKErdwHk
         yv2hPAxh/uOm0UWh4E0I7OwXx4zWaRC+N3uuW8cCnoReerDH+tt8nZve6GSkQM8qTDEN
         PolwV0Azomu2l91laWashMd6DzLm93qynt9WhC3MFZSJLv/b1TTa1uck7qbCb+co1UBC
         Fb2uHKElLEq4LI44zYM2rCH47dH7lXbnrbaiXWO6KwNpVO/18ny+KDbz/mmacn1clLvW
         HRaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lrk7HGx4v71dSTTtvjW1BV8zthSDjfHVycsETDc60oK+IGSfUm3KSd9qJNGFzWayDRjl4+wbh97KzrA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpAIlGbwTVtEVhz/0Ebpnr7bEnE/yx+0ijC3xnu7THgUwTm7c
	4l6LQqFDTdQUXlqQlKZNvf9qJwpK52KNTj2ZbaKjQ2EAPwimRC8TQqyb
X-Gm-Gg: Acq92OGK5n6s1Q/AzHhDstXUYnnSHk40FviP1qonF3t90AKfhj95J5z2zcBS3rFU086
	SLDLYoeivneLAwB3cXcl2HvLrrhYeoHm/327af5sLegztIB7ueuIhSDNizaYhoChv/NVsfg2YTP
	5JeG5VwW12cWLrC/bvTNc23ioWwst/WODS1JftY8bVq11rIoepP86a2wREzxA7iT+LfOPuWpto1
	3uk8IoP9OQxVmTx7Ph6SUhy5ZURwxkYzCb/WouNworhiYscoWJohl+ejDARQlbJu1y9qh8nZZjQ
	9LPyQatS8UjkuxVLRSVcG2oyP2tSB8Z+FBK3H5j7rmJb8dmXJlOkhNeKzkTdkn+0qeAaXpFpQLi
	VwnTdLFvy3pWTAjPStRHWJHClvH8ffnoDR5Gxo7tftK/VnVBOXn2ieY63Iq+OUsl+bRYNzBYRdh
	yFNub8Ns3LNRdS7R+3KkddMzSH0bFOh5DvqJHq+DQcdls=
X-Received: by 2002:a05:600c:4fcb:b0:48e:5d91:cffb with SMTP id 5b1f17b1804b1-48fc9a0f637mr70497135e9.10.1778708104526;
        Wed, 13 May 2026 14:35:04 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb1fee9csm2553055e9.0.2026.05.13.14.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:35:04 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Thu, 14 May 2026 00:34:56 +0300
Subject: [PATCH 1/2] ARM: zte: Add support for zx29 low level debug
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-zx29uart-v1-1-68470ecc3977@gmail.com>
References: <20260514-zx29uart-v1-0-68470ecc3977@gmail.com>
In-Reply-To: <20260514-zx29uart-v1-0-68470ecc3977@gmail.com>
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2902;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=fcg5dGJNBAQyU4b2cL0nA3wqgVJTqz/EfkeGsaL9qZo=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBqBO6DHrxaXkARBemDDkrBXpRS3oDZcwST0k/6L
 QLZOUY6KB+JAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCagTugxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiJwjg//XTrdw6+H+63UW2tqzNvWFZC4aWlyYUj
 gjO5KfX3MtxNMlzZPWOaHkRmJ6iIfTMtSzw0HVwWP8qpWmyauwAyXiVkiSb/cYBR+zTDOCKh8ct
 2O4/xKK/IxkSkqRJpZFZKUVxPHj96SwxDRx+XljqC2wPPlG2otentnHSTQBnME/vCXr21QqlX2d
 oMn/b3jzcNV5QL5RnBowJT0eG54v7ImmhvtP7D/NmVYP341gctaRixem8tVc5VNDcLZQCTUX6/Z
 jBZg7B5gOsBAe9367QIzSIYsIQ8mGWggHslNjUVnnCHF1wFVJBcfKFiGDa0davUavrGKwpmvLpf
 i93Rj1OnEPKMqp1LVXhgehpD4nXBFgXUSLaHSggtnRK5IdIfm9VHSX5VTGM/Gy4gSTxy70APCTX
 z0OpWcnd+RoFpWF0R2G7l07WtpRE/f1KdpogeWPz93/gK1+q9l5j6/1ar51/DFaS/ILJeQuokEV
 3uoOf4WZF24/O3/nm3WcdjLRalLqAKvDj4UWFnHVoZ7juBtaOIaP+7NMAyVduI9WJ0GnCHyHUC9
 tqjHKhEVWLebrkNuv4zFtLz5BmtgBbTyRhhGbMTJKIgdRDuMbNWq2Hy8XR7ZQpPXWwKx+VM2Jaj
 o1YS12nYo9yXnK3LtuDuvApaJ3Bb7g9H555OERinTF5PknMfisFk=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This is based on the removed zx29 code. A separate (more complicated)
patch will re-add the register map to the pl011 serial driver.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>

---

Patch changelog:
v8: Adjust UART01x_FR_BUSY to match the different ZX UART registers
(Sashiko). I am unsure about UART01x_FR_TXFF and my boards do not expose
flow control pins to allow me to test if it works.

I am unsure about the virtual address. It doesn't seem to matter, as
long as it is a valid address. This address is based on the old removed
code. Is there a rule-of-thumb physical to virtual mapping I can use to
give a sensible default value?
---
 arch/arm/Kconfig.debug         | 12 ++++++++++++
 arch/arm/include/debug/pl01x.S |  9 +++++++++
 2 files changed, 21 insertions(+)

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
index c7e02d0628bf..9dcdeed2357d 100644
--- a/arch/arm/include/debug/pl01x.S
+++ b/arch/arm/include/debug/pl01x.S
@@ -8,6 +8,15 @@
 */
 #include <linux/amba/serial.h>
 
+#ifdef CONFIG_DEBUG_ZTE_ZX
+#undef UART01x_DR
+#undef UART01x_FR
+#undef UART01x_FR_BUSY
+#define UART01x_DR		0x04
+#define UART01x_FR		0x14
+#define UART01x_FR_BUSY		(1<<8)
+#endif
+
 #ifdef CONFIG_DEBUG_UART_PHYS
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =CONFIG_DEBUG_UART_PHYS

-- 
2.53.0

