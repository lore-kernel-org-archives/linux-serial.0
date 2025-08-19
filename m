Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771230F520
	for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627808; cv=none; b=G0/tPiUneEWKYNmd4T/1oYR4UE6cq08k8RxaM8SYBlicM/usgxF425Nyx4UoYad+rSm2Bmd+g3DPSkSBcZzmeVYNYuH6x9YWourPW252y3X9d6axE3Tl8I+oxqIwv+oaaWEouG2lZINwJHVAVYO0fphVquJKSKOjLyTffWtOe2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627808; c=relaxed/simple;
	bh=BcOqI+T8qFCyHRY5QMdVmkot7l8I9zDDBTTGnV7E4/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fo7IaLo061ExQyTiFJdIpn1Lrf3OxyEyRLobQptwxM5swyv18Vb/b7G8qU4daY6CsuuRYzUdR1CGHqeXr0AFyx45qmlAcSXeTc7hhlf2eHktYqfIWI2RRU4jp3c3RD+0u5p3QFXss0voi+Mj1EOLukuKz4EtlvIjxoGcOitOR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=FUoR9Ra7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FUoR9Ra7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244581cd072so5418665ad.2
        for <linux-serial@vger.kernel.org>; Tue, 19 Aug 2025 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1755627806; x=1756232606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLnMvx9RaOOA0m1bhi8bJfAKPPT6sQUeRDIx0EKTLco=;
        b=FUoR9Ra7G/2rbPZrGyHHavQFhRSHYQ1WlmBtQSWUiOQ7ehXj/0aOn7DmT+N8HZIsf+
         ZA/QLNVpPh/om3o3gEQe/h/rAUAd2RkiaioNDBjkEzpcpsUBmwDeepzfaA79EpZNg4G/
         T7/WdKfqwGw4Kd12ItJ2Wh1UVjRHw3ft6v/RKTI8aLUrEnlOemZ74aGDiH1TpAFzLWdw
         l1ep7ZEM+qV6Diw3NOAz5RGB+1dL976Kc8hj6gOIUkGeZuVhq08RYbBNdHdUYOl2QsC3
         cM78LnVRKQkfujrBT/w55Uo4Gq3yUUOAkPyfgP9rjdRuvHcw2KGwHvOea1fWe6z6uRH3
         QuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755627806; x=1756232606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLnMvx9RaOOA0m1bhi8bJfAKPPT6sQUeRDIx0EKTLco=;
        b=Oc/789IUZ6D5GDMtw9RyBkBjSwobLAimmzzwKXYWQJ7Ts98TpNu1fv9m0Jxk6UoU/Y
         KkQcnzUMYizPiniU+bhl0On+4ZMW3vPCUvx0m2a8jk9jSmdYxWV23JBKoZICsmCIGkcf
         BCM48tJ27tlH7NXQKXRbpDAZReSvZ+X+CKEnC4WygliSLNg8xfBnRN5HgbB8X9JSlKoQ
         MwzSAXw+Vle9QLvD5u2SadzRv7zYeIaNvEQy/FpomQpzxs865rHrx9QNNr3NWXXW7rR0
         JwfUIhJH/DlYidvynWHgVYGi2G36JTWxQnZO18rfQoSZoEjBvyAYyGMRCBXM2qpL0wUa
         URgw==
X-Gm-Message-State: AOJu0Yy3+yhb/moVtcdQ9P5DqWRYUdEc0XMhos0eCs58adUho365bTuD
	Yb65+fVBZGeaMJkqtDSGLcZmNJ35X3zRFR11K4dDRL6XGYxX655QTysi05Ev2Dhb64jqtq0IMjF
	RC+AwLx1U
X-Gm-Gg: ASbGncsdZ/KBSBaT4RbABO5WxnY++aoiEdetaw9gIxX0VGTZNtoyw70HmKzVvI5+lUF
	IA2rVttesBbaenr4rMHJugyfnFVG2hrzwCBix7GCwUQsbpWVskcgvUL8hNCp1pbFfVPwdt/Jd2B
	uo2PQSi4HLUfTueK1WEpQ81l5b0zisXQJq7buGY9jIcWU1ugrrPBiFiX5+AyWLG7ffip6r+//vQ
	QvHhwkJjGjDMsMDrmgpvU8wx5ryYowY6VGCPuwub5tnZKTGb2wW3CVYleYS5pG4i8Y1Qa6wMFTo
	nVQlK6GLjPTlPEAMZdz1wBER4KYGxIft3M8fJkD77yZRLHpob7CWSUiwoUqfzbz368l1sUWYTfa
	lcHqQLJimrEThs5hKyAdVEkLpALdE5Xmo/9FBv3x+FGGSym6sGkfzI5k4mz/1FKqlvSvvFK1RcA
	==
X-Google-Smtp-Source: AGHT+IFT2prourgqnT6MUXxWK4OX/CmLd7Bb7z21WmBiAcpm6hk7V8Ox3JSLBPrTsMX4FJC5pHzXhg==
X-Received: by 2002:a17:903:1a68:b0:243:9c:e95 with SMTP id d9443c01a7336-245e051c2b5mr24928375ad.10.1755627805652;
        Tue, 19 Aug 2025 11:23:25 -0700 (PDT)
Received: from adriana-wh3p-serial-lockup-loop.sjc.aristanetworks.com ([74.123.28.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed336002sm3835705ad.5.2025.08.19.11.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:23:25 -0700 (PDT)
From: adriana@arista.com
To: linux-serial@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	prasad@arista.com,
	Adriana Nicolae <adriana@arista.com>
Subject: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
Date: Tue, 19 Aug 2025 11:23:22 -0700
Message-ID: <20250819182322.3451959-1-adriana@arista.com>
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
 
