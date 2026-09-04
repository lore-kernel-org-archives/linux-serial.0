Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA963EEAD0
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521995; cv=none; b=bkq2UTi/BjDqG6wsaRua6Ya0JZnkSxbwFnnaB1ynmzCvs1IPKYvWNuV6O1cNdCrooHpD1xoCDi6nTtLSneVqqxBn/eAQ6Yhl6Xw+TaT8mdxRlfm5tdGuuX69dmDWr9xFJBdTJ7xk6c+PIt1oOoUEXvIj1UMaNzt+9Wxu1lsWeCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521995; c=relaxed/simple;
	bh=ZHpQXOmdtqVcYG4CYb/RNohg1NDsdDi8pJ8YkSDbF/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=amIE02NMUkCmltW2+fdnvV5ej9/2/nV866aZTqemeoE91rKYhPMZIxGIRXVwLPDYhGCNWYg78Q1unP80/w9HvIilWJIIloyGYV1LxBNolysLc32shUCI1KM9pcutDUdtNy8Ldi+MQv+5yPmB67WeiMcmTOCer3Xos3ws5vFITg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1yh6G8J; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1yh6G8J"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3964dfb5a69so1174279a91.1
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788521992; x=1789126792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xe6EwabIXBD1fwJZlA9EYarG/RJHgSOSX9nc22lp4dc=;
        b=p1yh6G8JOuaKS1WYZLlcazb/iPx1+tFpyklplLzR/B9h4VvavH4KuF3aG0PFSkzSAP
         jbVsNxtsRuMNh/RF3t8nGvncMMkAAqXlLxSngPvSsKdWXlGLAZ+V9cG5xbTve49NOjUf
         xF7Hz6pmZNy53ZWeUZO3cGjq8atjGxfwtUSnrpk1E5/E1P4x6YqrgYlpudt6EFeJ+2vJ
         ccT8lesSYHLIronK/f1jAeOFpwIxhguXuVGUW3bqQY5awCefrmGWBx2KY7bHYr4LvmCU
         D9Xr6QqczKqk+W0ru5uPUyE9ZuEoN26R88IM5K3RU/xm9S0htDhFKvQ8ni7rr4zjRGk5
         n6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521992; x=1789126792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xe6EwabIXBD1fwJZlA9EYarG/RJHgSOSX9nc22lp4dc=;
        b=iEFTwgR7ADKR8WYHQ3BF5lksDkUJyDXU3A7brWuP2QwtvS+39+cA6noyctQvX0hKAQ
         9TqQ4B72fpiBu10h+YZcQb9kpTtJLNKFoxnr81cgA0anuX+npUZhoph0PMQPVGbJAaE+
         DFgaEJ+wQBj86NQUvsXfEVQNFHatsBKuekz9t9M8EZikXpP4dJmESz03oRrCCL3Y5JAl
         1B9qZNsuKWtH24GwvY/+3LT696IDaPulqM3t8W2ZNJQmI9nIPizorJX8Rve/WmO0hQZ0
         8iZs7b2KA1lWVb7zPSCG9F0uuUmN8/TyqMCFlLhJgDBS+o4ZpIFIXwomj6kAOJ0rvQBs
         irJQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6c2gcnecHPOkHSSxlekeFtSW4WRe12O3Z+zpXzsmESDazMaj18qh+5dO6w4wNxVa91I4+2QlRZfYDToo=@vger.kernel.org
X-Gm-Message-State: AFuF++kPy/Din5B2zzyJa1Hjc9UMQlBAQKwvAojPL10hq/BLl2e7rgMn
	oMQ6R3N07401fxbYzQoZil+7NBqNluUwdqbzglg5l+0Jexz0UaCcs1F+hebeskEbF2s=
X-Gm-Gg: AYBFou11OaWdfJg3VhHv7erl5/m92djBsf9NvSB9OSssrEdhSfB/tn/xtjmdm6+YH6U
	7sks5ydP5ipETkitsg7yfoRPqOVQhjNZbLwoOh3fBN3PuuNgAbowBicghoVzbhE2JlNMhkfScCF
	nRAapnCCKKMi0l1fLaVXZab5GFqvz5BzI6jp9bZaGF1b7qHe+PQqu6uUCWWRYnSzLKDS9mV1Df9
	HyGVlZuyd2GTECsdcTMSD7llUfhoB4Dk0aiKemBMNmP+khcIJ+QTgMhcsSbgHEnkDGP8FD5XAv5
	IxAoS2wosY4z/vNUzYP24vh+AqfUn6BbTPHysaGAQQ6VSuhnnsTVB9PyVFbP9seN+gfNA1/7f4T
	n4RitTj2mAIBkTtbB+2Xq5t3g2xjFBZpR8+270rGyG2BpxvU7CUxMG0Geqfn9bZr/i4qHQPym17
	WcgSBfRHbYO8Kp2E+6hFeJQhA2SOXm//3twdlkzerFTaz3U1NS+FJmnP3o6LG9HfaKTlAnIunzj
	esXkx031T5o22U40jQp8H+txPQryX0LeGiGmA==
X-Received: by 2002:a17:90b:3b88:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39b261da746mr7361746a91.20.1788521992489;
        Fri, 04 Sep 2026 04:39:52 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm9124215eec.15.2026.09.04.04.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:39:52 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] tty: fix typos in comments
Date: Fri,  4 Sep 2026 17:09:35 +0530
Message-ID: <20260904113942.22785-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/tty/serial/8250/8250_exar.c | 2 +-
 drivers/tty/serial/ar933x_uart.c    | 4 ++--
 drivers/tty/serial/atmel_serial.c   | 2 +-
 drivers/tty/serial/imx.c            | 2 +-
 drivers/tty/serial/men_z135_uart.c  | 2 +-
 drivers/tty/serial/mvebu-uart.c     | 2 +-
 drivers/tty/serial/mxs-auart.c      | 2 +-
 drivers/tty/serial/pic32_uart.c     | 2 +-
 drivers/tty/serial/pmac_zilog.c     | 4 ++--
 drivers/tty/serial/pmac_zilog.h     | 2 +-
 drivers/tty/serial/serial-tegra.c   | 2 +-
 drivers/tty/serial/st-asc.c         | 4 ++--
 drivers/tty/serial/uartlite.c       | 4 ++--
 drivers/tty/serial/xilinx_uartps.c  | 2 +-
 drivers/tty/vt/vt.c                 | 2 +-
 include/linux/tty_driver.h          | 2 +-
 16 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 836792e861bf..1e37e3e5d319 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -587,7 +587,7 @@ pci_fastcom335_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 }
 
 /**
- * cti_tristate_disable() - Disable RS485 transciever tristate
+ * cti_tristate_disable() - Disable RS485 transceiver tristate
  * @priv: Device's private structure
  * @port_num: Port number to set tristate off
  *
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 5b491db9d2fc..118fa8b1e44b 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -343,7 +343,7 @@ static void ar933x_uart_set_termios(struct uart_port *port,
 	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
 			    AR933X_UART_CS_HOST_INT_EN);
 
-	/* enable RX and TX ready overide */
+	/* enable RX and TX ready override */
 	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
 		AR933X_UART_CS_TX_READY_ORIDE | AR933X_UART_CS_RX_READY_ORIDE);
 
@@ -490,7 +490,7 @@ static int ar933x_uart_startup(struct uart_port *port)
 	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
 			    AR933X_UART_CS_HOST_INT_EN);
 
-	/* enable RX and TX ready overide */
+	/* enable RX and TX ready override */
 	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
 		AR933X_UART_CS_TX_READY_ORIDE | AR933X_UART_CS_RX_READY_ORIDE);
 
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5d8c1cfc1c60..c4b465f6a69f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -40,7 +40,7 @@
 /* Revisit: We should calculate this based on the actual port settings */
 #define PDC_RX_TIMEOUT		(3 * 10)		/* 3 bytes */
 
-/* The minium number of data FIFOs should be able to contain */
+/* The minimum number of data FIFOs should be able to contain */
 #define ATMEL_MIN_FIFO_SIZE	8
 /*
  * These two offsets are substracted from the RX FIFO size to define the RTS
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 513dbe95f7e9..0eac2fd2ed37 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -137,7 +137,7 @@
 #define USR1_DTRD	(1<<7)	 /* DTR Delta */
 #define USR1_RXDS	 (1<<6)	 /* Receiver idle interrupt flag */
 #define USR1_AIRINT	 (1<<5)	 /* Async IR wake interrupt flag */
-#define USR1_AWAKE	 (1<<4)	 /* Aysnc wake interrupt flag */
+#define USR1_AWAKE	 (1<<4)	 /* Async wake interrupt flag */
 #define USR2_ADET	 (1<<15) /* Auto baud rate detect complete */
 #define USR2_TXFE	 (1<<14) /* Transmit buffer FIFO empty */
 #define USR2_DTRF	 (1<<13) /* DTR edge interrupt flag */
diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index 9138fa29d301..41dd7059e367 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -532,7 +532,7 @@ static unsigned int men_z135_get_mctrl(struct uart_port *port)
  * men_z135_stop_tx() - Stop transmitting characters
  * @port: The UART port
  *
- * Stop transmitting characters. This might be due to CTS line becomming
+ * Stop transmitting characters. This might be due to CTS line becoming
  * inactive or the tty layer indicating we want to stop transmission due to
  * an XOFF character.
  */
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 33ea496c93b2..0306f219feb0 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -942,7 +942,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 
 	/* Manage interrupts */
 	if (platform_irq_count(pdev) == 1) {
-		/* Old bindings: no name on the single unamed UART0 IRQ */
+		/* Old bindings: no name on the single unnamed UART0 IRQ */
 		irq = platform_get_irq(pdev, 0);
 		if (irq < 0)
 			return irq;
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 697318dbb146..5355409134da 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1009,7 +1009,7 @@ static void mxs_auart_settermios(struct uart_port *u,
 		if (is_imx28_auart(s)
 				&& test_bit(MXS_AUART_RTSCTS, &s->flags)) {
 			if (!mxs_auart_dma_init(s))
-				/* enable DMA tranfer */
+				/* enable DMA transfer */
 				ctrl2 |= AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE
 				       | AUART_CTRL2_DMAONERR;
 		}
diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 8407f85776c0..1d4adb5c7d88 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -547,7 +547,7 @@ static int pic32_uart_startup(struct uart_port *port)
 	pic32_uart_writel(sport, PIC32_CLR(PIC32_UART_STA),
 			PIC32_UART_STA_UTXISEL1);
 
-	/* enable all interrupts and eanable uart */
+	/* enable all interrupts and enable uart */
 	pic32_uart_en_and_unmask(port);
 
 	local_irq_restore(flags);
diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index e3a919328695..31cb2cde3116 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -368,7 +368,7 @@ static void pmz_transmit_chars(struct uart_pmac_port *uap)
 	 * R3 still signals the interrupts and we see them when taking
 	 * an interrupt for the other channel (this could be a qemu
 	 * bug but since the ESCC doc doesn't specify precsiely whether
-	 * R3 interrup status bits are masked by R1 interrupt enable
+	 * R3 interrupt status bits are masked by R1 interrupt enable
 	 * bits, better safe than sorry). --BenH.
 	 */
 	if (!ZS_IS_OPEN(uap))
@@ -1929,7 +1929,7 @@ static int __init pmz_console_setup(struct console *co, char *options)
 	port = &uap->port;
 
 	/*
-	 * Mark port as beeing a console
+	 * Mark port as being a console
 	 */
 	uap->flags |= PMACZILOG_FLAG_IS_CONS;
 
diff --git a/drivers/tty/serial/pmac_zilog.h b/drivers/tty/serial/pmac_zilog.h
index 837b97ca0a90..40f47b389b55 100644
--- a/drivers/tty/serial/pmac_zilog.h
+++ b/drivers/tty/serial/pmac_zilog.h
@@ -21,7 +21,7 @@ struct uart_pmac_port {
 	 * early inited port)
 	 */
 	struct macio_dev		*dev;
-	/* device node to this port, this points to one of 2 childs
+	/* device node to this port, this points to one of 2 children
 	 * of "escc" node (ie. ch-a or ch-b)
 	 */
 	struct device_node		*node;
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 8004fc00fb9c..2eb49bcc766d 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1096,7 +1096,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 * EORD is different interrupt than RX_TIMEOUT - RX_TIMEOUT occurs when
 	 * the DATA is sitting in the FIFO and couldn't be transferred to the
 	 * DMA as the DMA size alignment (4 bytes) is not met. EORD will be
-	 * triggered when there is a pause of the incomming data stream for 4
+	 * triggered when there is a pause of the incoming data stream for 4
 	 * characters long.
 	 *
 	 * For pauses in the data which is not aligned to 4 bytes, we get
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 6ed9a327702b..f065b300ac09 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -378,7 +378,7 @@ static void asc_set_mctrl(struct uart_port *port, unsigned int mctrl)
 static unsigned int asc_get_mctrl(struct uart_port *port)
 {
 	/*
-	 * This routine is used for geting signals of: DTR, DCD, DSR, RI,
+	 * This routine is used for getting signals of: DTR, DCD, DSR, RI,
 	 * and CTS/RTS
 	 */
 	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
@@ -829,7 +829,7 @@ static void asc_console_putchar(struct uart_port *port, unsigned char ch)
 {
 	unsigned int timeout = 1000000;
 
-	/* Wait for upto 1 second in case flow control is stopping us. */
+	/* Wait for up to 1 second in case flow control is stopping us. */
 	while (--timeout && !asc_txfifo_is_half_empty(port))
 		udelay(1);
 
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 6240c3d4dfd7..153233fe4347 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -163,7 +163,7 @@ static int ulite_receive(struct uart_port *port, int stat)
 		port->icount.frame++;
 
 
-	/* drop byte with parity error if IGNPAR specificed */
+	/* drop byte with parity error if IGNPAR specified */
 	if (stat & port->ignore_status_mask & ULITE_STATUS_PARITY)
 		stat &= ~ULITE_STATUS_RXVALID;
 
@@ -393,7 +393,7 @@ static int ulite_request_port(struct uart_port *port)
 	ret = uart_in32(ULITE_CONTROL, port);
 	uart_out32(ULITE_CONTROL_RST_TX, ULITE_CONTROL, port);
 	ret = uart_in32(ULITE_STATUS, port);
-	/* Endianess detection */
+	/* Endianness detection */
 	if ((ret & ULITE_STATUS_TXEMPTY) != ULITE_STATUS_TXEMPTY)
 		pdata->reg_ops = &uartlite_le;
 
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a072b75dbaf2..7eaf70614f9c 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1476,7 +1476,7 @@ static int cdns_uart_suspend(struct device *device)
 			readl(port->membase + CDNS_UART_FIFO);
 		/* set RX trigger level to 1 */
 		writel(1, port->membase + CDNS_UART_RXWM);
-		/* disable RX timeout interrups */
+		/* disable RX timeout interrupts */
 		writel(CDNS_UART_IXR_TOUT, port->membase + CDNS_UART_IDR);
 		uart_port_unlock_irqrestore(port, flags);
 	}
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..494749282041 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1142,7 +1142,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 static inline int resize_screen(struct vc_data *vc, int width, int height,
 				bool from_user)
 {
-	/* Resizes the resolution of the display adapater */
+	/* Resizes the resolution of the display adapter */
 	int err = 0;
 
 	if (vc->vc_sw->con_resize)
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 1f2896e56e77..626e0692c97a 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -22,7 +22,7 @@ struct serial_struct;
  * These are flags passed to tty_alloc_driver().
  *
  * @TTY_DRIVER_INSTALLED:
- *	Whether this driver was succesfully installed. This is a tty internal
+ *	Whether this driver was successfully installed. This is a tty internal
  *	flag. Do not touch.
  *
  * @TTY_DRIVER_RESET_TERMIOS:
-- 
2.48.1

