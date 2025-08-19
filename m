Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F7267B92
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630801; cv=none; b=iKxiNKXzlOOmSDurKm/61+I/hvZ2vr387b2/v33IRoRe5qMwmS5NiEKDbz5D21aAeSE9kvWeRHXOJ2RqWJxTrgEFwuTn0dgF4nCo/NLx5bFmBfufwbfiM+td9I7QybGKNZOnS1T+NEPgBlgBbFqYLl9D5Uj4w9cYa3cyJAMztfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630801; c=relaxed/simple;
	bh=0HjZLEDNy/XiBCdGTKkujclxkceWoVchKk0T/18SPHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsZ7aaeMOTc3k9cPNRYJqzVtGn6TWlz2/f0VrDF8sYA3RvTZtFbYZFzjC7G4oHEJOHm9ze8zh2yHbVltvuIcQ9cBehY5e4BDmWgeq02ODqroPasCi33lHPYZnqDsTp9/9DZGrJ/wosNPh4ip5p5hjV1WlFO8vVnDrpA3reNyGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=JLxngPnh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JLxngPnh"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24457f3d233so9618695ad.0
        for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1755630797; x=1756235597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsOx0OvQKMVhNp1s/R61/MaUZB+gIxY9tZv1HKf+Kmk=;
        b=JLxngPnheAjBKZYNkMgtDsGQakNaWAMgbw4PUX3jSGC5CASNQe/yrhb0P7dcJu43Me
         Ktopql+DUpGORiqsIMHKagMlhz55IAN3ElsqKDAM1NmlNR7wTrN83bWLvRV7SJDVXt4g
         s/NRhiYx6XK10QVmPD6YcssN98DoMdHNreFT9RbWJ47WsFOOjlqSUKzJ3i43ttTP7qOp
         6sOyYk5MN0WnGerN84nSW5yB2XRl+BwYxIETRXt9YzL7WdkpAPKG/ROQ46xDF/i1PsgC
         Gb/EsAPvCQGWwJZZrGLdp5gCyooB3FJALaQtqYN1hMfi3AmTp/nBbvxDvjRmPN1bkwz5
         6a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755630797; x=1756235597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsOx0OvQKMVhNp1s/R61/MaUZB+gIxY9tZv1HKf+Kmk=;
        b=BNZeJzS2dSlzaVuE3gkY9J7Nhmti6gwMJAUuZPwRZSnNCQ/RcvihVAgHCkjjByQaTE
         4Sq3hYIUC/gS0G/X6urRWr/Iz9BLU5SayFD4j4sfkjF1cirBgxGsPtuDIt4896VM7XdD
         hhlTOtqecT4B9b3lBsqe20PX7BPrDNCN957WM5NGiTU3eBiP38WB+JCPeGFmG9pIjv3V
         AoTgIwpIxSE8kKPqDNG1DVsbfZfIYZCXtQHuTd7HAcYYOQShWtfd0KdiM28tuepCxTg7
         6cqAumSsTVHS4AiWVI2D79zYmsRYJCkYPBupdtJ/0beMvlwB26T27OJR5NURQoHR48dr
         KJsw==
X-Gm-Message-State: AOJu0YyH8tqg9hkN0o8NDk9j64lCuDkHDeOoXPDyao+pZGAp1jsWMmiS
	PkZJtJ+uPqm1G6BrNsLMgQb8Nb1t6c1uhIphPL4VRMLCBl3W5UajonZoAKk6j4zSAp+WetXh+HX
	cEQEM/Hsl
X-Gm-Gg: ASbGncvn8KN4pjPiBTE+uZiuOD/XGr6cvvRvhZXPduWLCXemfcBJCCxtZJUqWKRAMcP
	g0Pj0A3CemTzcNBN6cW+s6Xmkgvq70qaUELLtKLBBArF7G7b9wFb+fqZjnFDxOcPaTm4lj6VNAW
	JlEahxoWKFGxjRJ2Bed1Hnu2AYe4oytunR23c1bCGJGZ8xD+bKPrnV8p/8ql86e9SwHASozELMU
	l5HdNCrfJbJCC8wqvREDS41jAV5eiCuOFWJP7orrloFuWQQNRcJ8S4+gI5f3QSe/Pg+LwxOnS0U
	zNzr7CzfHUHm78rqouqYC0eQBMikzaulra+I3KaciFfMviDx1T1TRhyx9U2xSyqWxktn059J0Q9
	HVKqbYtnV/y9Xv2wdUs/67eWvSNvLu9woickuDPkov7E1UroOzGrsvfgMxxKhDYuY8JyypYH4eg
	==
X-Google-Smtp-Source: AGHT+IF1vDGJC+mS2MJjFjz4sQNP2vE3bBRgHYGWjbRJs3Wl6NzgtvUfBGdUncJ+KYdkk+gmGwSxbw==
X-Received: by 2002:a17:902:bc45:b0:240:725d:dd66 with SMTP id d9443c01a7336-245ef2536b4mr435085ad.11.1755630797367;
        Tue, 19 Aug 2025 12:13:17 -0700 (PDT)
Received: from adriana-wh3p-serial-lockup-loop.sjc.aristanetworks.com ([74.123.28.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c6f8bsm4376355ad.79.2025.08.19.12.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 12:13:17 -0700 (PDT)
From: adriana@arista.com
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.rg
Cc: ilpo.jarvinnen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	Adriana Nicolae <adriana@arista.com>
Subject: [PATCH v2] serial: 8250 dw: clear FIFO before writting LCR
Date: Tue, 19 Aug 2025 12:13:14 -0700
Message-ID: <20250819191314.3452283-1-adriana@arista.com>
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
 
