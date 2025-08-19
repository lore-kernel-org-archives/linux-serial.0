Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922A261581
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630387; cv=none; b=XCJy9kkD5v9xpxjXl/voygtiinZPX5bufixxLJ3huOn+K3NUcSlNQq/1GSuhZDgtwGWGkIzONI6y/ornGH3djU8cln8VSAFJQhMU/reDJ8mhu1IMQJFLx+yP1/BNAClcXfT0qgzePP7DIUHFmkSF9Fm6TGKwPRz1qhHLNrhem0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630387; c=relaxed/simple;
	bh=0HjZLEDNy/XiBCdGTKkujclxkceWoVchKk0T/18SPHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bzoxc40VSUZRPQlovooC/dfsWfoyU52BImqtMlnvfRQmIS5gmTRrSWU1nvBaUrYcUblCMyVgklmNNGiKSe9WSXOtUpCuAY2EulFiuVap5OEFApmFQ4k4GoiXt/HvO4yg3rdrhOYhhpSQM1UyGEzUw1FIX7TmeaOPE0Z8niqXkVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=SsRFFqkW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="SsRFFqkW"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244581cd020so7067785ad.2
        for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1755630384; x=1756235184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsOx0OvQKMVhNp1s/R61/MaUZB+gIxY9tZv1HKf+Kmk=;
        b=SsRFFqkWe9FmewJpJRaPPDk4X7XKAIbuyhSE+ZubYttE9iVy1rKhjDcBMu4kUaNPsJ
         3zS298alremUIo9eTHqb/d45utVF4GITLUwVxH7t0xthxWA0CNMK5mLPkMLJaFWYmbP1
         sP/jjYgoEJOdtMVLCc6y6tpBKXFO3Z7XI9ORyhgxQ291lnLrTmQKb0w7Xq3Yc0YkFYp3
         3zMHH7EGXoaqYwmlgFX7k8S5nZV+s1DTZe9OHK13jz7z0hMGRmfoP875rB6G93Jc46NM
         i2U21P6z8uipkVNpjyq6A8pBWGDh959a/CbwulxzZ0BvamOjf2mSDJuxSDfQ5g5mXQwZ
         icxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755630384; x=1756235184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsOx0OvQKMVhNp1s/R61/MaUZB+gIxY9tZv1HKf+Kmk=;
        b=Ybeb2CXLSloVaTzUifbEt65RQEFwWTVDL2ezN/a+cCPNisIJomfpfR8sR+WeqSNF5D
         vbKIfZoD5QjER8jS7wWUTch7ngIpU3ldr7zVJJGah3xlLHVNYymiE3QvAewtbrEslhXz
         YVwLrQg3OVpuMjFPhYNJ/mrC9wB5SiovN4RtWZq+8tGbniYrGt+Z9MB7zJkcyk57Du7y
         EgKDfPZ55we44c+XCRCeTqglGX1FJsKDJhmgQo+su7UqWQqJwnMgsW6XFZsJVsCCuENU
         dMEo7d70tX92oFYnKThDcJ43D5W5orgKuoYUGwlowYe4EjXEKnbTHEsPd0XHA8j1lLwI
         nprQ==
X-Gm-Message-State: AOJu0YzLBSMi83XXjleIHH7AEsS31W8Aeo5CS+LhpSPuSd3ldVSBsP6r
	JcHpKQtxmbyMgac3f2B/CwtRV38MHT95uaNcfHN6PbYsMPsLJL698l0M1LwEqAnuswMHDC9uDLs
	BSp2uMIOJ
X-Gm-Gg: ASbGncvr2pg+GlBwHFbb4m/DVR2nME71mYFFzY4Q6y1dUJ7HNsmj+lqVxrPX6iqOhhM
	Wa4LiRg6yUjuBvA+8iOC56nxL9XkscTWGoNXOu78ZiEj2I7Q5+XwT6lFatyxWjiBr3NgOSI8mgX
	V49GfZ/+0kqD+xi2/NCPFvOCr6PSf9gr6vR7KEojYDrjftn/pAZI5m19ONGoUbiIz/4NgMA/l/i
	WHWdUCTGNsnTVLMk+AWJmT8e7n/GfPSc2Ybt4QZSGDCUrAydiyjqGWgAhL3S0BU6kTX4RB38nk2
	0RGd0IxEje+M8r4lz6K5vRE0iHDjW2BPFpNJo8rPk6+4fDNXtuiuBIIUnPokcQDY/YvveA4CmYl
	JyLJPEU6nPBIQnta8bvZdDm+TbicQhkFpg6Td14P/D4+OzRbEgZiXL7CcVs2ZDSwTSZt3coYhsw
	==
X-Google-Smtp-Source: AGHT+IGQ1Y47ugToV+QdKxgoczu8CUM3bvPrICRb5ZJf2sbhfNHnVp5k7JQ7zd+o9+h+2GBomKPQhA==
X-Received: by 2002:a17:902:daca:b0:234:a734:4abe with SMTP id d9443c01a7336-245ef1194b6mr621235ad.1.1755630384159;
        Tue, 19 Aug 2025 12:06:24 -0700 (PDT)
Received: from adriana-wh3p-serial-lockup-loop.sjc.aristanetworks.com ([74.123.28.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed517bd7sm4169945ad.133.2025.08.19.12.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 12:06:23 -0700 (PDT)
From: adriana@arista.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.rg
Cc: ilpo.jarvinnen@lininux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	Adriana Nicolae <adriana@arista.com>
Subject: [PATCH v2] serial: 8250 dw: clear FIFO before writting LCR
Date: Tue, 19 Aug 2025 12:06:21 -0700
Message-ID: <20250819190621.3452231-1-adriana@arista.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is proposing a custom configuration for Synopsys DesignWare
serial to be used by products with associated compatible string in the
device tree.

The PORT_DWAPB config will be used instead of the default PORT_16550A
which does not include the UART_FCR_CLEAR_RCVR and UART_FCR_CLEAR_XMIT
bits for the FIFO configuration register. Having those flags is necessary
to clear FIFO when the serial port is reconfigured with do_set_termios.

Additionally, inside the do_set_termios we use the LCR (Line Control
Register) to enable DLAB bit in order to access DLL/DLM (Divisor Latch
Low/High) registers for baud rate setting. These 2 registers are sharing
the same address space with UART_TX/UART_RX and UART_IER. The sequence is:

(1) enable DLAB -> (2) set baud -> (3) disable DLAB -> (4) reset FCR

When there is a TX or RX flow on the serial while we attempt to set/clear
DLAB, the LCR write will be ignored and we will get a IIR_BUSY interrupt
afterwards which is cleared by only reading the USR (UART status register).

The sequence above can leave the serial in an unstable state in two cases:

- if UART is busy while (1), then LCR is still pointing to the normal set of
registers, which means the code setting DLL/DLM is actually writing into TX or
modifying interrupts in UART_IER which may end with either a garbage character
on the console or with serial interrupts disabled.

- if UART is busy while (3), then LCR remains pointing to DLL/DLM instead of
moving back to RX/TX. The first transfer on the serial will be stuck because
the transmit/receive registers are not accessible unless the DLAB bit
is cleared.

The changes in this patch include a specific serial_out function for this UART
type similar to the one for Armada-38x devices in commit
b7639b0b15ddd1a4686b0142e70dfb122eefc88f with some changes in the tx_wait_empty
function to check the UART status by looking at the USR register and actively
try to clear FIFO to reduce time before a LCR write since the characters will
be lost otherwise after baud rate change.

The USR register may report that UART is busy even if TX/TX FIFO is already
empty so we will loop until all USR[0] (UART busy status) is cleared and USR[1]
TX FIFO is empty (RX FIFO bits should be 0 in this case).
Keeping the same timeout of 20ms as measurements with the 9600 baud when
the console was busy it took max 1.9ms to get the UART free state.

---
Changes in v2:
- Updated the mailing list.

Signed-off-by: Adriana Nicolae <adriana@arista.com>
---
 drivers/tty/serial/8250/8250_dw.c   |   52 +++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c |    8 +++++
 include/uapi/linux/serial_core.h    |    3 ++
 3 files changed, 63 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a53ba04d9770..985a2650f3f3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -33,6 +33,9 @@
 /* Offsets for the DesignWare specific registers */
 #define DW_UART_USR	0x1f /* UART Status Register */
 #define DW_UART_DMASA	0xa8 /* DMA Software Ack */
+#define DW_UART_USR_BUSY 0x1 /* UART Busy status */
+#define DW_UART_USR_TFNF 0x2 /* UART TX FIFO not full */
+#define DW_UART_USR_TFE  0x4 /* UART TX FIFO empty */
 
 #define OCTEON_UART_USR	0x27 /* UART Status Register */
 
@@ -56,6 +59,10 @@
 #define DW_UART_QUIRK_IS_DMA_FC		BIT(3)
 #define DW_UART_QUIRK_APMC0D08		BIT(4)
 #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
+#define DW_UART_QUIRK_APB		BIT(6)
+
+#define DW8250_REG( p, reg ) \
+	((void __iomem *)(p->membase + ((reg) << p->regshift)))
 
 struct dw8250_platform_data {
 	u8 usr_reg;
@@ -220,6 +227,47 @@ static void dw8250_serial_out38x(struct uart_port *p, unsigned int offset, u32 v
 	dw8250_serial_out(p, offset, value);
 }
 
+/* Drain FIFO and wait for USR to be not busy and TX/RX FIFO empty */
+static void dw8250_tx_wait_empty_apb(struct uart_port *p)
+{
+	unsigned int tries = 20000;
+	unsigned int delay_threshold = tries - 1000;
+	unsigned int usr;
+
+	while (tries--) {
+		usr = readl(DW8250_REG(p, DW_UART_USR));
+
+		/* Check UART free and TX/RX FIFO empty */
+		if ((usr & ~DW_UART_USR_TFNF) == DW_UART_USR_TFE)
+			break;
+
+		/* FIFO is still not empty, try to clear it */
+		if (tries < delay_threshold) {
+			writel(UART_FCR_ENABLE_FIFO, DW8250_REG(p, UART_FCR));
+			writel(UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
+			UART_FCR_CLEAR_XMIT, DW8250_REG(p, UART_FCR));
+			writel(0, DW8250_REG(p, UART_FCR));
+			udelay (1);
+		}
+	}
+}
+
+static void dw8250_serial_outapb(struct uart_port *p, int offset, int value)
+{
+       struct dw8250_data *d = to_dw8250_data(p->private_data);
+
+	if(offset == UART_LCR && !d->uart_16550_compatible)
+		dw8250_tx_wait_empty_apb(p);
+
+	writel(value, DW8250_REG(p, offset));
+
+	if (offset == UART_LCR && !d->uart_16550_compatible) {
+		/* Check FIFO is left enabled and LCR was written */
+		writel(UART_FCR_ENABLE_FIFO, DW8250_REG(p, UART_FCR));
+		dw8250_check_lcr(p, value);
+	}
+}
+
 static u32 dw8250_serial_in(struct uart_port *p, unsigned int offset)
 {
 	u32 value = readb(p->membase + (offset << p->regshift));
@@ -520,6 +568,12 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		p->serial_in = dw8250_serial_in32;
 		data->uart_16550_compatible = true;
 	}
+	if (quirks & DW_UART_QUIRK_DWAPB) {
+		p->type = PORT_DWAPB;
+		p->flags |= UPF_FIXED_TYPE;
+		p->serial_out = dw8250_serial_outapb;
+		data->skip_autocfg = true;
+	}
 }
 
 static void dw8250_reset_control_assert(void *data)
@@ -755,6 +809,7 @@ static const struct dev_pm_ops dw8250_pm_ops = {
 
 static const struct dw8250_platform_data dw8250_dw_apb = {
 	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_APB,
 };
 
 static const struct dw8250_platform_data dw8250_octeon_3860_data = {
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2da9db960d09..3882a71920f6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -310,6 +310,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 8, 16, 30},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	[PORT_DWAPB] = {
+		.name		= "Synopsys DesignWare",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO |
+				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_IRDA,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 9c007a106330..8386436b813f 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -231,6 +231,9 @@
 /* Sunplus UART */
 #define PORT_SUNPLUS	123
 
+/* Synopsys DesignWare */
+#define PORT_DWAPB		124
+
 /* Generic type identifier for ports which type is not important to userspace. */
 #define PORT_GENERIC	(-1)
 
