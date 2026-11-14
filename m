Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794663673;
	b=HBrsIs6waTMrog0U1+sE2e9mS9wWzP/ON3OkNaLpPOM6R4euzKHm8yFJN27o9+5U5sq7
	 x4fLnoTHqjNDd8xXp5kNSB/gtM5/wwca8ulsMHt9rg8u10dND19fAZBllUuE96vFe3Dae
	 j420mED7uOE2p153mDTXdDGv30MsWUYDvA6uKlQLE5qeVZq2E2FD61rJovOUjHAbZgk65
	 4ygiRN5Kc82M3WlSeJ3wlD07Ju5rKk6GtEan13posbtmfHI6MEG3jJDwBNnuf1CF99jW0
	 ix1qkZ5R0SeqcPOWhor4FRK/Suw5DuknqC8b83ENbrB4LRS4i20BGzC5ixzTjH07aiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663673;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ViW+J37vlQnKvGYExQxk1bMlBbVAMGgbVTcmrc54d/s=;
	b=pNGjXJnwsPkDkXolWhTolbYFE5GIAckFmiTZG6xaTmKGqGRwxfvG3/5djxDImEC0n3br
	 xNL05P1Gx4neRaKW0mUKFcYb+ehifl5VVVbEDQXb4cEBU6CV9T+jyWhvk9JH/dhn0Zr2V
	 QPl5TOW+JqhppvDeMGJbwo3luMFXdpi8/V29jrhwwzJu7Bp/QN5QKHg6UKWyMeJi4uHRt
	 2a/hKtzdNppdprCpNqbXL16yvXffnCdp5+NDeXbuZEyTYLlaSSmyZr75XMYU2q9LR35rk
	 ++lgj9UFCRA6SHwxmpTRfj+W2j+Rp55CeS3jyM1n9wLFhZp7/PyW3aiP64BMMOhTr7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5118z3U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4128606A8A1;
	Sat, 14 Nov 2026 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5118z3U
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794663672;
	b=ddkFgBXxVp2uDRYXlQwF7W4JH+Twu/l36TJ1JJrKPSVzuDaahLY2ikwE2asrRLKwOfO8
	 HWeTN0QhlHN76NJufwkG0e3H5FkKEL3IYhz8zsPYLWpEMW8VkjyXNsB40vkWF5VqZHQUV
	 vrOfXmdp2aMJU1BEZLJ2acL7p2v/1KFL58QTz8g07LH02fX+FpRVDDMLx2rBLJ2691r0w
	 c/Ryf1qaClhQbcEOh0QizJkFOccSBOsGTuTTiMLlgEyO771DUcRYG/gKKTIaZP2azXYs/
	 R22SYjx+fYfCYATiw37RURswl1JAg4t2tLCNnj1qJWcozM3Ut5813IuOQVVMKcm7jSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794663672;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ViW+J37vlQnKvGYExQxk1bMlBbVAMGgbVTcmrc54d/s=;
	b=uHL9cDKnqqHRcEHLu8GTEUNRZQ7+w/V/7tNF0IrvF45BVB+vCfP4B+6tNijbVECLGNrx
	 FJf7kq49L8P11iPwyEvuMH1uhyUP8Qc/JCyfVbKYYZCcGMamw/De/onlr1DcX3yQq6Nm4
	 JFNb4lSiNyGAICT2BmbTHE1YEPrj5hJTPd2YTO4vvEDznGIu6EthMqmfDRwZHIDyjNkt3
	 n+TJbb8MAAaaGucQNU8SGw/Yn6b/8LiqYMOpWW6Var8XQLm+2gm6PCgwWoxDKxyf26Nvb
	 hiF8V7c3MX2l2ORDYWzsdu7NEq9ezEr00D4yz8qT+wzZr7zeeJMIpzU3+lzo4ZUcEpw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CE3131F000C5;
	Sat, 14 Nov 2026 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663672;
	bh=ViW+J37vlQnKvGYExQxk1bMlBbVAMGgbVTcmrc54d/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=G5118z3UENAW+ZkzZfknriWq00ADP5OHS/SDACgSRSGLVG5UAe9o30Isn/4pqB55h
	 H5EBiTV7FRfPH9xfuMxXmHuT3V/Fo5sOfpLc+sVh2k339bFr43l+bWbGAaXu4BSdyx
	 6b57fFAxjTdRUJoo/agn9RdN+to5Lp9LXBnUmDhUBAIC6nBQjr8qb9B3PxPFJaTYqX
	 gAz/t+ShhHNbh2qDB3hrgB48BfkG8vg3oauCFeEMdXz14XV15lACJsP56E1KHlU1te
	 braoHfoqMQD03b7n8QGVwQIs/8ZHpHtrbFbWC3AqtGvkVLVJYR5PoIFE9kDJS9dZfq
	 uoSIh8Pmirlyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 73C9649DCE;
	Sat, 14 Nov 2026 13:41:09 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 16:41:10 +0300
Subject: [PATCH v7 05/10] ARM: debug: Add Cortina Systems CS75xx UART0
 support
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-b4-cs75xx-v7-5-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
In-Reply-To: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794663665; l=4419;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=XANVvquwZ46csK0xa+Qk9KFcex+6JNnk+DkCsDkUuAQ=;
 b=eYLncICdxxmchFEe5kNssxoKaD8u7Yeq0rdmn6PYa5K00V7R4Mw2XY2eQpPUPLphEF5Kg0bIs
 1b2dL7rAlBpAp/Bp656ouPt9ER2JYrdIAvWEnnXviPQhJhGlQGqTSnd
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add low-level debug output through UART0 of the Cortina Systems CS75xx
SoCs. The UART is mapped at a fixed virtual address by the generic
debug_ll_io_init(), so no platform map_io is needed.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
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


