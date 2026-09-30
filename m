Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B386456290;
	Wed, 30 Sep 2026 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751604; cv=none; b=IEdpcl5UPRhQd6Wm285bhamcYL+uXogGOPEP3Ps2W7EPnLICBYmUCtxoqcbX6KDqII1lWYftTY9HAl8FfPoF5bw/yg/a4MGa7oXKXDgErVPLLV8blKWNc3STICCB95hktIrpuq1d0cIZu4JkRp+ETTMEWzrr8pCCoOCQj9Umg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751604; c=relaxed/simple;
	bh=hzX+BW99zLKW+UZLSsYAs6LrFdlNAAorh5he6Eb96bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvXEnU39jZA0A4qtEb3ihXpYsY9CEfatYLtV0i7Ke8RFVxGPPd18IH+mzU4m5XrUQv560dxcB2QqH2lYVW9Uej0oZpa5BDmHg+nPojO8MfBSEXI//mApPrMHyuA2nVF5f2iz9cSSYVXWKq6FoibabxRu9iYkNEe+w/5fzNeeb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvmtpaXc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvmtpaXc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0970CC4AF1C;
	Wed, 30 Sep 2026 07:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790751603;
	bh=hzX+BW99zLKW+UZLSsYAs6LrFdlNAAorh5he6Eb96bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LvmtpaXcPpB6ezZm+lfOrr8CS6JX9wgqQUjR/099MToqbYZkTG/6jTCcJI3CQ3pjq
	 EUiBNgI+RCwQZpOt77+b82pECCUnsvdVyrsh2Zymp57LppdxYbtwupl51vcsRZnBk+
	 8F1FDyjYktLxVVsBlzajf6bR2yhPvWw/pV2pSd9krNYU29SeHcxOypg3oos8ExXWXA
	 wxJtrtqF/Miirg/H3MmEi5pIgQ2sPs8OAZ30GA4LSkDyTO3Qx2dm8pFO7zSxAafpSl
	 RnjbFMZru8/qRDic1yX4tIVdSNptT5FAEpbeJOIRjYeMovlYurpEQWfMdV8U2mY4PB
	 ubfhgcGalp+Pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB2ECA5FC4;
	Wed, 30 Sep 2026 07:00:02 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Wed, 30 Sep 2026 10:00:04 +0300
Subject: [PATCH RFC 05/10] ARM: debug: Add Cortina Systems CS75xx UART0
 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-b4-cs75xx-v1-5-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
In-Reply-To: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Drew Fustini <fustini@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790751600; l=4352;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=sEPOw8alv56KPplmHlQD4phQ/jVW47QaipdeKCgPXwk=;
 b=UirYMOT2tAmsSLcqdN21egSNpm948On/Kbua1bC6dqLJFg8O+WEpk4FMXPzG0XhSZGyayTunQ
 0Y9k6JYIxCWBlRQSEsjr2SswS9rRtqOUQpkNcTQD2XKUZnB8qBRmwNt
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add low-level debug output through UART0 of the Cortina Systems CS75xx
SoCs. The UART is mapped at a fixed virtual address by the generic
debug_ll_io_init(), so no platform map_io is needed.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 arch/arm/Kconfig.debug          | 16 ++++++++++++++--
 arch/arm/include/debug/cs75xx.S | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index abcf14f1027..61cd64fc152 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -308,6 +308,15 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on these devices.
 
+	config DEBUG_CS75XX_UART0
+		bool "Kernel low-level debugging messages via CS75xx UART0"
+		depends on ARCH_CORTINA_CS75XX
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART0 of Cortina Systems CS75xx SoCs. This
+		  is the console port on the Securifi Almond+. The UART is
+		  expected to be set up by the bootloader.
+
 	config DEBUG_DAVINCI_DA8XX_UART1
 		bool "Kernel low-level debugging on DaVinci DA8XX using UART1"
 		depends on ARCH_DAVINCI_DA8XX
@@ -1531,6 +1540,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/vt8500.S" if DEBUG_VT8500_UART0
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
 	default "debug/bcm63xx.S" if DEBUG_BCM63XX_UART || DEBUG_BCMBCA
+	default "debug/cs75xx.S" if DEBUG_CS75XX_UART0
 	default "debug/digicolor.S" if DEBUG_DIGICOLOR_UA0
 	default "debug/brcmstb.S" if DEBUG_BRCMSTB_UART
 	default "mach/debug-macro.S"
@@ -1632,6 +1642,7 @@ config DEBUG_UART_PHYS
 	default 0xe8008000 if DEBUG_R7S72100_SCIF2 || DEBUG_R7S9210_SCIF2
 	default 0xe8009000 if DEBUG_R7S9210_SCIF4
 	default 0xf0000000 if DEBUG_DIGICOLOR_UA0
+	default 0xf0070110 if DEBUG_CS75XX_UART0
 	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
 	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
@@ -1670,7 +1681,7 @@ config DEBUG_UART_PHYS
 		DEBUG_RMOBILE_SCIFA4 || \
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_BCMBCA || DEBUG_ASM9260_UART || \
-		DEBUG_DIGICOLOR_UA0 || \
+		DEBUG_CS75XX_UART0 || DEBUG_DIGICOLOR_UA0 || \
 		DEBUG_AT91_UART || DEBUG_STM32_UART || \
 		DEBUG_STIH41X_ASC2 || DEBUG_STIH41X_SBC_ASC1 || \
 		DEBUG_STIH418_SBC_ASC0
@@ -1708,6 +1719,7 @@ config DEBUG_UART_VIRT
 	default 0xf7000800 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART2
 	default 0xf7000c00 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART3
 	default 0xf7020000 if DEBUG_AT91_SAMA5D2_UART1
+	default 0xf7070110 if DEBUG_CS75XX_UART0
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
 	default 0xf8007000 if DEBUG_HIP04_UART
 	default 0xf8009000 if DEBUG_VEXPRESS_UART0_CA9
@@ -1772,7 +1784,7 @@ config DEBUG_UART_VIRT
 		DEBUG_QCOM_UARTDM || \
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_BCMBCA || DEBUG_ASM9260_UART || \
-		DEBUG_DIGICOLOR_UA0 || \
+		DEBUG_CS75XX_UART0 || DEBUG_DIGICOLOR_UA0 || \
 		DEBUG_AT91_UART || DEBUG_STM32_UART || \
 		DEBUG_STIH41X_ASC2 || DEBUG_STIH41X_SBC_ASC1 || \
 		DEBUG_STIH418_SBC_ASC0
diff --git a/arch/arm/include/debug/cs75xx.S b/arch/arm/include/debug/cs75xx.S
new file mode 100644
index 00000000000..d840384cc32
--- /dev/null
+++ b/arch/arm/include/debug/cs75xx.S
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Debugging macro include header for the Cortina Systems CS75xx UART
+ */
+
+#define CS75XX_UART_TXDAT		0x10
+#define CS75XX_UART_INFO		0x18
+#define CS75XX_UART_INFO_TX_FULL	(1 << 2)
+#define CS75XX_UART_INFO_TX_EMPTY	(1 << 3)
+
+		.macro	addruart, rp, rv, tmp
+		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
+		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
+		.endm
+
+		.macro	senduart, rd, rx
+		ARM_BE8(rev \rd, \rd)
+		str	\rd, [\rx, #CS75XX_UART_TXDAT]
+		.endm
+
+		.macro	waituartcts, rd, rx
+		.endm
+
+		.macro	waituarttxrdy, rd, rx
+1001:		ldr	\rd, [\rx, #CS75XX_UART_INFO]
+		ARM_BE8(rev \rd, \rd)
+		tst	\rd, #CS75XX_UART_INFO_TX_FULL
+		bne	1001b
+		.endm
+
+		.macro	busyuart, rd, rx
+1002:		ldr	\rd, [\rx, #CS75XX_UART_INFO]
+		ARM_BE8(rev \rd, \rd)
+		tst	\rd, #CS75XX_UART_INFO_TX_EMPTY
+		beq	1002b
+		.endm

-- 
2.53.0


