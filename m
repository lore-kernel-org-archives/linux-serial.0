Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70274439341;
	Mon, 12 Oct 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788313; cv=none; b=u7U7aa51K3VM8WtSRJVzU6+QX+Z2BafpO31nBaEphr9bUkReUvVHOakvlSOlg6aIHO3RCAimyTtT331C4E+yBMWMyXC1Wtezga87LkOJPq16T/4x5+vficRi23ENizE2G6roIVkThjaQ1iB1ebudP7/DnIyHq+54iTdyiWkt82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788313; c=relaxed/simple;
	bh=Ct9uOeYC8SA1Sm9EyJBjZtg8CNMYCoQgwWRIa6qWDME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i8J4E5SVM5VRg9HMOhPmDY7SZuZaLOhOP17r1vpxIZlHNCuW4H3ivc+CgsedzJ1SchTxFO9j8VFxnFQ1H6TW4MD3pR5E+IY9IQXqSM6WIdDwV09UU56GzI/YMvn7Za/IQXZxISiMm+fLkk9aj/3Asjmhw8jInjoOK5bRSPkdIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwc9AW3X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwc9AW3X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EE43C2BD05;
	Mon, 12 Oct 2026 06:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791788313;
	bh=Ct9uOeYC8SA1Sm9EyJBjZtg8CNMYCoQgwWRIa6qWDME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bwc9AW3X5Xf339oTd4A2/da07yR92jx/pKyGFGDLk1kk+pyBX7KOUJWclwSzmCE0E
	 wcvDpImvzyRnF5486E5zKfvjwLwRaNYEoa51NDsv6DwZOIeXC+UnpuDHFbbxHaiUVq
	 7R/yfnSJJD1ZVry46kfgf9sIERAKc/yLMMdt1cNA1f53GhVreY/jaFwBU6mN7uSfRu
	 5H8KOB7frr2WbczU7ccLknEL5UrO5hEGOLkRvKmng+XBzK5V1yIHGHvAXy9dD4PMiB
	 S1wKS+S/kTZRNmp8NTfXEqwzTKehQH9a9F9uzYeOaxUVsicFVBOrxYm2/1nZeN93RO
	 ozS4i8ex8bUsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEF7CA9EC5;
	Mon, 12 Oct 2026 06:58:33 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 09:58:35 +0300
Subject: [PATCH RFC v3 05/10] ARM: debug: Add Cortina Systems CS75xx UART0
 support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-b4-cs75xx-v3-5-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
In-Reply-To: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
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
 Jason Li <jason.li@cortina-access.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791788310; l=4419;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=Kf0Hkr00xHM1irusJF0y6k3iCjmsska+Ga40A3ySHZk=;
 b=kaE8Yznqm8eDc6lOV13OQMfCQIIy7vPRoqMk80J4BqE5k/Z7h5jZ+NXwCzTXv0BWZyOqEjD6S
 wd39YJGzGd9BESrxdWpnS+IkK8n0XtY5T1cphpE3w5xbREnKEivgtS6
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
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/Kconfig.debug          | 16 ++++++++++++++--
 arch/arm/include/debug/cs75xx.S | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index abcf14f10..c43fe288b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -308,6 +308,15 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on these devices.
 
+	config DEBUG_CS75XX_UART0
+		bool "Kernel low-level debugging messages via CS75xx UART0"
+		depends on ARCH_CORTINA_ACCESS
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
index 000000000..967821add
--- /dev/null
+++ b/arch/arm/include/debug/cs75xx.S
@@ -0,0 +1,37 @@
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
+		ARM_BE8(rev \rd, \rd)
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


