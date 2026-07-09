Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917913E024E
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630633; cv=none; b=RqzbNBAeolXGNi2Y+hcMzNvPVx4gOKWyD36Uto/0Tpg3ODzaXZQ+Qm8Qz7ZwOienphgUg4zTQDJWUKDk0wjxIK62oF6CxeAHoJzlYViX4tQCV+NQ9BeXHKJyPyw8LA9aaZpkX9OCL63U48R6u7YMzBwoO4snxzO+pnO4JnxGbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630633; c=relaxed/simple;
	bh=FNzWFrZTMb4t6db1Hi3CrlR0Ddfp078rn2TuHJbzoqs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bESn6pSdqF06NElXtBxysFTKnWpplmR3+WntvR1Gf554ZilKUbM6arXyDR28B2k1uPVGFlGO2foKXEkryp6QJLe6t4MrJSQnU2OeLA0Zt2tFehWCsFL4wk6HQSPYKNRi2UKCKGqRkWYY1iH22qWicacbmYAhUyW0GNGDaH/u47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfNDsRm8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfNDsRm8"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493ec555a26so1587445e9.0
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630630; x=1784235430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oIYK6Uxf0rVQVemNqKtH34uzk/Dg/3P3lfTJg9gaVtw=;
        b=MfNDsRm8q7qG5LaQyf2538rpPfm1yiIrC8ccGQ4EQN+4f5B6XTQxSbwbmM0RO6PpuS
         CepzOMT0421L4Mb5QiE4Too3z5FDzly+2rZu72Bib6Xo8deTFJjRpauursqo3Y5/BizV
         6I2cy+SmyhMNwpxKhkZ0Jc2NAAyzrkQ0d7ZFk2zy1Xr0ZkP0VIeqhbDzC6YCa1xHafZx
         upMdL0wIDUIHODIGd7EdBscaL2hd/hP+qUduExye+LngKocivJ0ua5fB0w4WeWNMQ7LC
         EniSx9emMDseON8EZfpSu34tmLOPxc/wgICX8uEOOX6CPXOWrOCuhohxXR5k43pquRxZ
         nqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630630; x=1784235430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oIYK6Uxf0rVQVemNqKtH34uzk/Dg/3P3lfTJg9gaVtw=;
        b=D7AAY05HSlkpJRxcMeTSak9nU/beU740g+0FegV7frt48Y8Fmf+y2olv70yDJCAyHZ
         CDI5TfzytdUe72Vn3p8p6yLMhF873xVB5b6KiOKzIA9WJ8PVWuQ0T9EbcGLEIZxVXMvu
         GhCC3KJcGrdsnmYC4/EtugCbEcPWTZT9Y6vdWj142oQY/EQfVDs1C4TGkFQP6VstG1J0
         iPhesQJhrlKjs+7iEA6pQ/M2ycMpMkLZmDe+qrP0LaUPmHQnugvdHXGJRly60D/+TMuX
         zrgyyBe8aJhVBvdcKC3glZajIr04gjqhDNJuTtjROOLGbJPTxwxtc0pfZdXK16WEfwAE
         fwTg==
X-Forwarded-Encrypted: i=1; AHgh+RpQabXwXjB1JAeOCAZA8TnB7nP7mLZ5Qwxp5Bh7+Bj/9qeifm4rKe1n98YWALscLSWL5VbV1eG/QpoEk9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YylMpLtKQQ+jOrUuqk9RglqS6D6YAdioskqBof+3IFdJj4Nkmbe
	OFi7n+KsYq6YjJ2A1rPH2DXhYFbm/Uij6GQm+ENgP5bLujV1PXvCpXIw
X-Gm-Gg: AfdE7cmLkUovRX/NDXHkJu81l5i1M+SIA9x3oUQHvu8SUge6h3TGvi9Bw/a4s+0FBhc
	tpBJBNDAQafrn6SbkhcrYtTnNHEj4JkmbWVbDDEM6Av5cofZsT11JqCgiMwxmBLw6Vgl2gIUA1r
	Fz8qmRL7Kz2is/+/hresPUvbStOyFtpXUl4qrF/u1hmCpYXonOz30xUctRUCDAxdkW1JNHlkYBq
	joUlB6ubZO/O/X+CEwtToq6cklMK3cAOMxsk/I2WnFI212IdvobmRvFkcc9jc+KPe/xVt6s2P66
	9gCSrlUncOntNwi80eH0B9xQiAjCwyXf4T/IRfRqzD/RhIekwcZFkxs6R1o76SFTqwI5LUwYMe6
	B3HqBYhrnEVoISMVK4OpRDlMMH0BuChKYqFrSiZeZvfkFmG4lY+rm6H51qn9O7P344ZKwBOMczG
	PYoHNsq1+m+ip79oVQRTsHZAW9bkg5f07iU/Zh/Jxqx4l81cJjYTWX02DYJ5Hd34Mx4uMpyxPLw
	+Mg5QUFIwBO1woHyMo=
X-Received: by 2002:a05:600c:e558:10b0:493:e57e:7aa5 with SMTP id 5b1f17b1804b1-493e68c6e63mr58776745e9.22.1783630629769;
        Thu, 09 Jul 2026 13:57:09 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm52894965f8f.6.2026.07.09.13.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:57:09 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Lukas Wunner <lukas@wunner.de>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 3/4] serial: 8250: map UAPI port type to internal enum
Date: Thu,  9 Jul 2026 22:56:51 +0200
Message-ID: <20260709205656.319531-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709205656.319531-1-ansuelsmth@gmail.com>
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is currently some confusion when a new 8250 UART device needs to be
defined with the related index for uart_config[] to be directly defined in
UAPI header.

There isn't any specific reason to define the index directly in UAPI header
unless it's also needed to be defined for userspace usage.

To try to address this confusion and making it clear how these specific
index should be defined and where, create a dedicated enum in 8250.h
with all the current defined values in UAPI header and document how these
id should be defined.

Rename the define in 8250_port.c with the new UART_ prefix.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/tty/serial/8250/8250.h      | 122 ++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c |  72 ++++++++--------
 2 files changed, 158 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 77fe0588fd6b..3a45f957d3a9 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -73,6 +73,128 @@ struct serial8250_config {
 	unsigned int	flags;
 };
 
+/*
+ * The uart_config[] array index is referenced and defined from index
+ * in uapi/linux/serial.h and uapi/linux/serial_core.h.
+ *
+ * This was old practice and for anything that doesn't need to support
+ * userspace, new type should be limited and added only HERE.
+ *
+ * Any UART port that requires userspace support, should define the
+ * dedicated index in the UAPI header and reference it when added
+ * to this enum table.
+ */
+enum uart_port_type {
+	/* From uapi/linux/serial.h */
+	UART_PORT_UNKNOWN		= PORT_UNKNOWN, /* 0 */
+	UART_PORT_8250			= PORT_8250,
+	UART_PORT_16450			= PORT_16450,
+	UART_PORT_16550			= PORT_16550,
+	UART_PORT_16550A		= PORT_16550A,
+	UART_PORT_CIRRUS		= PORT_CIRRUS,
+	UART_PORT_16650			= PORT_16650,
+	UART_PORT_16650V2		= PORT_16650V2,
+	UART_PORT_16750			= PORT_16750,
+	UART_PORT_STARTECH		= PORT_STARTECH,
+	UART_PORT_16C950		= PORT_16C950,
+	UART_PORT_16654			= PORT_16654,
+	UART_PORT_16850			= PORT_16850,
+	UART_PORT_RSA			= PORT_RSA, /* 13 */
+
+	/* From uapi/linux/serial_core.h (14-123) */
+	UART_PORT_NS16550A		= PORT_NS16550A, /* 14 */
+	UART_PORT_XSCALE		= PORT_XSCALE,
+	UART_PORT_RM9000		= PORT_RM9000,
+	UART_PORT_OCTEON		= PORT_OCTEON,
+	UART_PORT_AR7			= PORT_AR7,
+	UART_PORT_U6_16550A		= PORT_U6_16550A,
+	UART_PORT_TEGRA			= PORT_TEGRA,
+	UART_PORT_XR17D15X		= PORT_XR17D15X,
+	UART_PORT_LPC3220		= PORT_LPC3220,
+	UART_PORT_8250_CIR		= PORT_8250_CIR,
+	UART_PORT_XR17V35X		= PORT_XR17V35X,
+	UART_PORT_BRCM_TRUMANAGE	= PORT_BRCM_TRUMANAGE,
+	UART_PORT_ALTR_16550_F32	= PORT_ALTR_16550_F32,
+	UART_PORT_ALTR_16550_F64	= PORT_ALTR_16550_F64,
+	UART_PORT_ALTR_16550_F128	= PORT_ALTR_16550_F128,
+	UART_PORT_RT2880		= PORT_RT2880,
+	UART_PORT_16550A_FSL64		= PORT_16550A_FSL64,
+	UART_PORT_PXA			= PORT_PXA,
+	UART_PORT_AMBA			= PORT_AMBA,
+	UART_PORT_CLPS711X		= PORT_CLPS711X,
+	UART_PORT_SA1100		= PORT_SA1100,
+	UART_PORT_UART00		= PORT_UART00,
+	UART_PORT_OWL			= PORT_OWL,
+	UART_PORT_21285			= PORT_21285,
+	UART_PORT_SUNZILOG		= PORT_SUNZILOG,
+	UART_PORT_SUNSAB		= PORT_SUNSAB,
+	UART_PORT_NPCM			= PORT_NPCM,
+	UART_PORT_TEGRA_TCU		= PORT_TEGRA_TCU,
+	UART_PORT_ASPEED_VUART		= PORT_ASPEED_VUART,
+	UART_PORT_PCH_8LINE		= PORT_PCH_8LINE,
+	UART_PORT_PCH_2LINE		= PORT_PCH_2LINE,
+	UART_PORT_DZ			= PORT_DZ,
+	UART_PORT_ZS			= PORT_ZS,
+	UART_PORT_MUX			= PORT_MUX,
+	UART_PORT_ATMEL			= PORT_ATMEL,
+	UART_PORT_MAC_ZILOG		= PORT_MAC_ZILOG,
+	UART_PORT_PMAC_ZILOG		= PORT_PMAC_ZILOG,
+	UART_PORT_SCI			= PORT_SCI,
+	UART_PORT_SCIF			= PORT_SCIF,
+	UART_PORT_IRDA			= PORT_IRDA,
+	UART_PORT_IP22ZILOG		= PORT_IP22ZILOG,
+	UART_PORT_CPM			= PORT_CPM,
+	UART_PORT_MPC52xx		= PORT_MPC52xx,
+	UART_PORT_ICOM			= PORT_ICOM,
+	UART_PORT_IMX			= PORT_IMX,
+	UART_PORT_TXX9			= PORT_TXX9,
+	UART_PORT_JSM			= PORT_JSM,
+	UART_PORT_SUNHV			= PORT_SUNHV,
+	UART_PORT_UARTLITE		= PORT_UARTLITE,
+	UART_PORT_BCM7271		= PORT_BCM7271,
+	UART_PORT_SB1250_DUART		= PORT_SB1250_DUART,
+	UART_PORT_MCF			= PORT_MCF,
+	UART_PORT_SC26XX		= PORT_SC26XX,
+	UART_PORT_SCIFA			= PORT_SCIFA,
+	UART_PORT_S3C6400		= PORT_S3C6400,
+	UART_PORT_MAX3100		= PORT_MAX3100,
+	UART_PORT_TIMBUART		= PORT_TIMBUART,
+	UART_PORT_MSM			= PORT_MSM,
+	UART_PORT_BCM63XX		= PORT_BCM63XX,
+	UART_PORT_APBUART		= PORT_APBUART,
+	UART_PORT_ALTERA_JTAGUART	= PORT_ALTERA_JTAGUART,
+	UART_PORT_ALTERA_UART		= PORT_ALTERA_UART,
+	UART_PORT_SCIFB			= PORT_SCIFB,
+	UART_PORT_MAX310X		= PORT_MAX310X,
+	UART_PORT_DA830			= PORT_DA830,
+	UART_PORT_OMAP			= PORT_OMAP,
+	UART_PORT_VT8500		= PORT_VT8500,
+	UART_PORT_XUARTPS		= PORT_XUARTPS,
+	UART_PORT_AR933X		= PORT_AR933X,
+	UART_PORT_MCHP16550A		= PORT_MCHP16550A,
+	UART_PORT_ARC			= PORT_ARC,
+	UART_PORT_RP2			= PORT_RP2,
+	UART_PORT_LPUART		= PORT_LPUART,
+	UART_PORT_HSCIF			= PORT_HSCIF,
+	UART_PORT_ASC			= PORT_ASC,
+	UART_PORT_MEN_Z135		= PORT_MEN_Z135,
+	UART_PORT_SC16IS7XX		= PORT_SC16IS7XX,
+	UART_PORT_MESON			= PORT_MESON,
+	UART_PORT_DIGICOLOR		= PORT_DIGICOLOR,
+	UART_PORT_SPRD			= PORT_SPRD,
+	UART_PORT_STM32			= PORT_STM32,
+	UART_PORT_MVEBU			= PORT_MVEBU,
+	UART_PORT_PIC32			= PORT_PIC32,
+	UART_PORT_MPS2UART		= PORT_MPS2UART,
+	UART_PORT_MTK_BTIF		= PORT_MTK_BTIF,
+	UART_PORT_RDA			= PORT_RDA,
+	UART_PORT_MLB_USIO		= PORT_MLB_USIO,
+	UART_PORT_SIFIVE_V0		= PORT_SIFIVE_V0,
+	UART_PORT_SUNIX			= PORT_SUNIX,
+	UART_PORT_LINFLEXUART		= PORT_LINFLEXUART,
+	UART_PORT_SUNPLUS		= PORT_SUNPLUS, /* 123 */
+};
+
 #define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
 #define UART_CAP_EFR	BIT(9)	/* UART has EFR */
 #define UART_CAP_SLEEP	BIT(10)	/* UART has IER sleep */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 033d8fb8bb23..a0b80324a559 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -43,27 +43,27 @@
  * Here we define the default xmit fifo size used for each type of UART.
  */
 static const struct serial8250_config uart_config[] = {
-	[PORT_UNKNOWN] = {
+	[UART_PORT_UNKNOWN] = {
 		.name		= "unknown",
 		.fifo_size	= 1,
 		.tx_loadsz	= 1,
 	},
-	[PORT_8250] = {
+	[UART_PORT_8250] = {
 		.name		= "8250",
 		.fifo_size	= 1,
 		.tx_loadsz	= 1,
 	},
-	[PORT_16450] = {
+	[UART_PORT_16450] = {
 		.name		= "16450",
 		.fifo_size	= 1,
 		.tx_loadsz	= 1,
 	},
-	[PORT_16550] = {
+	[UART_PORT_16550] = {
 		.name		= "16550",
 		.fifo_size	= 1,
 		.tx_loadsz	= 1,
 	},
-	[PORT_16550A] = {
+	[UART_PORT_16550A] = {
 		.name		= "16550A",
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
@@ -71,18 +71,18 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},
-	[PORT_CIRRUS] = {
+	[UART_PORT_CIRRUS] = {
 		.name		= "Cirrus",
 		.fifo_size	= 1,
 		.tx_loadsz	= 1,
 	},
-	[PORT_16650] = {
+	[UART_PORT_16650] = {
 		.name		= "ST16650",
 		.fifo_size	= 1,
 		.tx_loadsz	= 1,
 		.flags		= UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
 	},
-	[PORT_16650V2] = {
+	[UART_PORT_16650V2] = {
 		.name		= "ST16650V2",
 		.fifo_size	= 32,
 		.tx_loadsz	= 16,
@@ -91,7 +91,7 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {8, 16, 24, 28},
 		.flags		= UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
 	},
-	[PORT_16750] = {
+	[UART_PORT_16750] = {
 		.name		= "TI16750",
 		.fifo_size	= 64,
 		.tx_loadsz	= 64,
@@ -100,12 +100,12 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 16, 32, 56},
 		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP | UART_CAP_AFE,
 	},
-	[PORT_STARTECH] = {
+	[UART_PORT_STARTECH] = {
 		.name		= "Startech",
 		.fifo_size	= 1,
 		.tx_loadsz	= 1,
 	},
-	[PORT_16C950] = {
+	[UART_PORT_16C950] = {
 		.name		= "16C950/954",
 		.fifo_size	= 128,
 		.tx_loadsz	= 128,
@@ -114,7 +114,7 @@ static const struct serial8250_config uart_config[] = {
 		/* UART_CAP_EFR breaks billionon CF bluetooth card. */
 		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,
 	},
-	[PORT_16654] = {
+	[UART_PORT_16654] = {
 		.name		= "ST16654",
 		.fifo_size	= 64,
 		.tx_loadsz	= 32,
@@ -123,49 +123,49 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {8, 16, 56, 60},
 		.flags		= UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
 	},
-	[PORT_16850] = {
+	[UART_PORT_16850] = {
 		.name		= "XR16850",
 		.fifo_size	= 128,
 		.tx_loadsz	= 128,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
 	},
-	[PORT_RSA] = {
+	[UART_PORT_RSA] = {
 		.name		= "RSA",
 		.fifo_size	= 2048,
 		.tx_loadsz	= 2048,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_11,
 		.flags		= UART_CAP_FIFO,
 	},
-	[PORT_NS16550A] = {
+	[UART_PORT_NS16550A] = {
 		.name		= "NS16550A",
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_NATSEMI,
 	},
-	[PORT_XSCALE] = {
+	[UART_PORT_XSCALE] = {
 		.name		= "XScale",
 		.fifo_size	= 32,
 		.tx_loadsz	= 32,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_UUE | UART_CAP_RTOIE,
 	},
-	[PORT_OCTEON] = {
+	[UART_PORT_OCTEON] = {
 		.name		= "OCTEON",
 		.fifo_size	= 64,
 		.tx_loadsz	= 64,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
-	[PORT_U6_16550A] = {
+	[UART_PORT_U6_16550A] = {
 		.name		= "U6_16550A",
 		.fifo_size	= 64,
 		.tx_loadsz	= 64,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
-	[PORT_TEGRA] = {
+	[UART_PORT_TEGRA] = {
 		.name		= "Tegra",
 		.fifo_size	= 32,
 		.tx_loadsz	= 8,
@@ -174,7 +174,7 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO | UART_CAP_RTOIE,
 	},
-	[PORT_XR17D15X] = {
+	[UART_PORT_XR17D15X] = {
 		.name		= "XR17D15X",
 		.fifo_size	= 64,
 		.tx_loadsz	= 64,
@@ -182,7 +182,7 @@ static const struct serial8250_config uart_config[] = {
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR |
 				  UART_CAP_SLEEP,
 	},
-	[PORT_XR17V35X] = {
+	[UART_PORT_XR17V35X] = {
 		.name		= "XR17V35X",
 		.fifo_size	= 256,
 		.tx_loadsz	= 256,
@@ -191,7 +191,7 @@ static const struct serial8250_config uart_config[] = {
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR |
 				  UART_CAP_SLEEP,
 	},
-	[PORT_LPC3220] = {
+	[UART_PORT_LPC3220] = {
 		.name		= "LPC3220",
 		.fifo_size	= 64,
 		.tx_loadsz	= 32,
@@ -199,16 +199,16 @@ static const struct serial8250_config uart_config[] = {
 				  UART_FCR_R_TRIG_00 | UART_FCR_T_TRIG_00,
 		.flags		= UART_CAP_FIFO,
 	},
-	[PORT_BRCM_TRUMANAGE] = {
+	[UART_PORT_BRCM_TRUMANAGE] = {
 		.name		= "TruManage",
 		.fifo_size	= 1,
 		.tx_loadsz	= 1024,
 		.flags		= UART_CAP_HFIFO,
 	},
-	[PORT_8250_CIR] = {
+	[UART_PORT_8250_CIR] = {
 		.name		= "CIR port"
 	},
-	[PORT_ALTR_16550_F32] = {
+	[UART_PORT_ALTR_16550_F32] = {
 		.name		= "Altera 16550 FIFO32",
 		.fifo_size	= 32,
 		.tx_loadsz	= 32,
@@ -216,7 +216,7 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 8, 16, 30},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
-	[PORT_ALTR_16550_F64] = {
+	[UART_PORT_ALTR_16550_F64] = {
 		.name		= "Altera 16550 FIFO64",
 		.fifo_size	= 64,
 		.tx_loadsz	= 64,
@@ -224,7 +224,7 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 16, 32, 62},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
-	[PORT_ALTR_16550_F128] = {
+	[UART_PORT_ALTR_16550_F128] = {
 		.name		= "Altera 16550 FIFO128",
 		.fifo_size	= 128,
 		.tx_loadsz	= 128,
@@ -237,7 +237,7 @@ static const struct serial8250_config uart_config[] = {
 	 * workaround of errata A-008006 which states that tx_loadsz should
 	 * be configured less than Maximum supported fifo bytes.
 	 */
-	[PORT_16550A_FSL64] = {
+	[UART_PORT_16550A_FSL64] = {
 		.name		= "16550A_FSL64",
 		.fifo_size	= 64,
 		.tx_loadsz	= 63,
@@ -245,7 +245,7 @@ static const struct serial8250_config uart_config[] = {
 				  UART_FCR7_64BYTE,
 		.flags		= UART_CAP_FIFO | UART_CAP_NOTEMT,
 	},
-	[PORT_RT2880] = {
+	[UART_PORT_RT2880] = {
 		.name		= "Palmchip BK-3103",
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
@@ -253,7 +253,7 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},
-	[PORT_DA830] = {
+	[UART_PORT_DA830] = {
 		.name		= "TI DA8xx/66AK2x",
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
@@ -262,7 +262,7 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
-	[PORT_MTK_BTIF] = {
+	[UART_PORT_MTK_BTIF] = {
 		.name		= "MediaTek BTIF",
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
@@ -270,7 +270,7 @@ static const struct serial8250_config uart_config[] = {
 				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
 		.flags		= UART_CAP_FIFO,
 	},
-	[PORT_NPCM] = {
+	[UART_PORT_NPCM] = {
 		.name		= "Nuvoton 16550",
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
@@ -279,7 +279,7 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},
-	[PORT_SUNIX] = {
+	[UART_PORT_SUNIX] = {
 		.name		= "Sunix",
 		.fifo_size	= 128,
 		.tx_loadsz	= 128,
@@ -287,7 +287,7 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 32, 64, 112},
 		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,
 	},
-	[PORT_ASPEED_VUART] = {
+	[UART_PORT_ASPEED_VUART] = {
 		.name		= "ASPEED VUART",
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
@@ -295,7 +295,7 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},
-	[PORT_MCHP16550A] = {
+	[UART_PORT_MCHP16550A] = {
 		.name           = "MCHP16550A",
 		.fifo_size      = 256,
 		.tx_loadsz      = 256,
@@ -303,7 +303,7 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes   = {2, 66, 130, 194},
 		.flags          = UART_CAP_FIFO,
 	},
-	[PORT_BCM7271] = {
+	[UART_PORT_BCM7271] = {
 		.name		= "Broadcom BCM7271 UART",
 		.fifo_size	= 32,
 		.tx_loadsz	= 32,
-- 
2.53.0

