Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792824054;
	b=DoXmUmPOWjZBp1y5YlY+eaI2SyvwIBIFcoGx7sCIIlyDU5B5L7TyajGlc/vh7tJ2LhFY
	 598mw9q8e1dcEHPz88E590XCe98kHd4u1oC0lSzyDth8piFtOJDhLYM8S4dSIanIOlA7B
	 KKonTHjFUivsHhZX6t1k637iXevY7AIKlFCpJTFvKWMHVyD9iukp414bagvhVWTcuTaG6
	 gva0w4TDIO2thDHs4B6KBBAkFjv455khGzBZXyvMhQ5Eq+l7SyFOUfS6C4mz46OUMC+qe
	 lePW2EhT3Kysj45ttee0rdKts96DVka7MOhu7EOeOnxQSbRQpyxL2OP9qHiqZYI5GPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792824054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=EQi4FkwCPz+P91uCAdKvfG/KFOE0h5bvVttx19hMZng=;
	b=yrH6e+/4j8esfnzkKVqxZhhce4UDOs4wb21JTnAVLWgjXhWBMy3CQUTfxtFIODj8TrW9
	 WsmQ6uT/TagtZbDUIOFgNElQfiPbbl8mSxstz8tZjSxgqLZnC1FKmtzkJeOrOl94Sg8vY
	 EeSC1dWvlP4gvUVX80KBrjr1N3X/OxNcJLpggIzFn+d/9+9f0iiuJkRrGj+JKEQskhOPc
	 sbTU1N7tXOz5ZRgpXHHOCJqM8KzWuPCAKkUZKpFgwhBvGvVkKTHqLVgjS+jYD880WP1A5
	 F+ROqxv1i2B30bMG2jGO5OQ4AlhW12r78CPc23zn5sGaUinZlOHlMk3/0SmkWCjsAbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="HrO/7/w9";
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBC606A326
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 06:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DADBC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HrO/7/w9
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7fccba9c675so3040937a34.0
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 23:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792824053; x=1793428853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EQi4FkwCPz+P91uCAdKvfG/KFOE0h5bvVttx19hMZng=;
        b=HrO/7/w91ZxLKIveiqHdGCajc6Jx1PGVw27LXdCyYupSg/xUiLieVczmNoN1TpmTj3
         fAyJ4OKz8qjo0Odc5R8evFA1M7QQvdEuk8CM/gx83KcUbAJqr0VV4hJr/W+EgNrRPXMG
         dnv8g+su3Qz5He59IjCcpEyOtXqFjD27yHfgb27vqwFmKbcHYXlREKayeXvAXqPugHpj
         SeE/4IS7xcVNXWCR9YSMIyyMPPK0VDKLejRzkVE4G6VU2oUsj1uOcUhCWPpVnomE9TwQ
         OZBPKnYVXbK+6DiTSXUZhFmuoXfJNaPNXuCvSt7uojanyrSTrPrna/iCsOm5NKA+mHii
         e7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792824053; x=1793428853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EQi4FkwCPz+P91uCAdKvfG/KFOE0h5bvVttx19hMZng=;
        b=ZSk08bYrtl7QVHMHs6VqSENIA/Ake25EcJBFlDnFMl8JBat/LIvLYODNX4tal95pmU
         P2HcR3cxUvjVEgdoLEHYnJhEeYmqXrM8JkKW3sYDBxF1VmDR5IaEEJKlQC0DL+KdfSQz
         TlYXZtM1p4bJ0XluGa3HSTfAMgv3KYSOyN5n4Gd1b0y4NE5atWcsOdJJVKHVDHA9SeSz
         zJElgj4U5qUVqsoZ+oL7U/H0xlsm+qOGW2Cm6+rwamD3paYLrGFdIJWEUOfG18dF2S6k
         iIq0CZX7WI0AbBNNZ3RU4kzPcwdfJOV3XmJwQF08+LAVz5sVaO6WfxPCCHpYnbRQOwih
         oolg==
X-Forwarded-Encrypted: i=1; AKwUvBwTsTC/qEbQu1ODOIAZ1latyABWpzoImYP9jhk0PMh+MLwznUdmY6FfqzwEML6trb3UsA+Zue+4BxG0lV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJn9banah/k/I6iJUXw7RL+k82EyD6wK12DGTLDjB+ytwBVqWvM
	+5cgzTleOYqS77NyBklSY1zfqKde+Q1cKzagnyA5+Rx4Q0QsfuzeEPME
X-Gm-Gg: AYBFou2zNQj7HGN8yiiS1EuLj9e9IKoFDk2rMQaYl2Zg9JE1oGZ8p8NoCr/VnPwFxak
	y9u4KEaJS/OwjhFsH5eOrU8DGUn6gSvUB+e5C1ycrAnMz6EhRUaSL/w4uEx31dOl9AB295hc8dr
	BYj2ON8JDsnBd/E9EI3BDpdPplLv/MmvgCAhFmgKp5Bn+i1oyw2np4NaO0KmdSss3LoYk0nuxXU
	wgeTULysdu0mDp7NoMnEyWuueZXNAtVN5U3HoI3myiQFfZ5fm/iImOX3BP6chT21LrCTDB9JXHy
	40tr5uFUxRFNGrFW1CiLgv8BLXNNiTazyj0MtpOJagBeNkRgQAqFgxy4DrbFe8EdFcvo4RbvEwc
	FPm+jbs66XQDwMFtuh4pMDyajgRtOlcxPfYGOcubCF53oLysxWCayf9ccEX6rczxymh9XkSt4EC
	tDoWcpDav123aPBSITdVn+Dmw4qcWsxk88BH+ZqOi0a03kn0gQAyBJVQVr7DG/OacVKI6ytvMY/
	tyufjwbN/WcmG05nNN0bNoMqr/TlGDj7b4QHOerRI6buBNriyzlvomgyh3fT634o26l7s0YfUI1
	Je2nj8aaSOwzB73DKIw+Uh3pWZ4M0WxTSqjf7nz8YTOiMfx4zXDnH+7Vfm3/yzqkfYRL0LIKTxb
	Bf+f/fzs5SbbBrgm4gfvXv3PkJJDkKyRbxYXUGKV4RsFYkDcKQ9yY+z4h3swI4irnu4SGZhtpad
	bmrQ==
X-Received: by 2002:a05:6808:c177:b0:4a4:64b0:bf5e with SMTP id 5614622812f47-55c006d11e8mr545058b6e.2.1792824052710;
        Fri, 23 Oct 2026 23:40:52 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c56asm864633b6e.9.2026.10.23.23.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:40:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 00:40:41 -0600
Subject: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
In-Reply-To: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Timur Tabi <timur@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

uart_write_wakeup() expects the UART port lock to be held. Several worker,
DMA completion and interrupt paths call it without that lock, including
indirect calls from uart_handle_cts_change() and the transmit helpers.

Take the port lock around these notifications or their transmit helper.
Keep sleeping SPI and regmap accesses outside the locked region, and keep
the FSL LPUART completion lock held through its wakeup. Acquire the port
lock after releasing private channel locks to preserve the ordering used
by UART callbacks. In the MUX timer, publish available FIFO space under
the port lock and keep the hardware FIFO-drain wait outside it.

SCCNXP handles interrupts under a controller lock which its UART callbacks
acquire with the port lock already held. Collect the ports needing wakeups
while servicing the controller, then release that lock before taking each
port lock and rechecking the wakeup threshold. Removal drains the IRQ or
timer before unregistering the ports.

This serializes write notifications with port-locked serial-core state
changes, allowing readiness and transmit-storage reservations to gate the
notification without a check-versus-shutdown race.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/21285.c         |  2 ++
 drivers/tty/serial/atmel_serial.c  |  2 ++
 drivers/tty/serial/clps711x.c      |  6 +++--
 drivers/tty/serial/cpm_uart.c      |  2 ++
 drivers/tty/serial/fsl_lpuart.c    |  2 +-
 drivers/tty/serial/jsm/jsm_cls.c   |  3 ++-
 drivers/tty/serial/jsm/jsm_neo.c   |  9 +++++---
 drivers/tty/serial/lantiq.c        |  3 ++-
 drivers/tty/serial/ma35d1_serial.c |  6 +++--
 drivers/tty/serial/max3100.c       |  6 +++--
 drivers/tty/serial/max310x.c       |  9 +++++---
 drivers/tty/serial/mux.c           | 13 ++++++-----
 drivers/tty/serial/mvebu-uart.c    |  2 ++
 drivers/tty/serial/mxs-auart.c     |  2 ++
 drivers/tty/serial/sb1250-duart.c  | 10 +++++----
 drivers/tty/serial/sccnxp.c        | 45 +++++++++++++++++++++++++++++---------
 drivers/tty/serial/ucc_uart.c      |  6 +++--
 17 files changed, 92 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 4de0c975ebdc..e4149aea4f66 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -157,6 +157,8 @@ static irqreturn_t serial21285_tx_chars(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	u8 ch;
 
+	guard(uart_port_lock_irqsave)(port);
+
 	uart_port_tx_limited(port, ch, 256,
 		!(*CSR_UARTFLG & 0x20),
 		*CSR_UARTDR = ch,
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c3880259e3bc..fb12cef3f719 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1371,6 +1371,8 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
 
 		if (status_change & (ATMEL_US_RI | ATMEL_US_DSR
 					| ATMEL_US_DCD | ATMEL_US_CTS)) {
+			guard(uart_port_lock_irqsave)(port);
+
 			/* TODO: All reads to CSR will clear these interrupts! */
 			if (status_change & ATMEL_US_RI)
 				port->icount.rng++;
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 83186bf50002..054b9d8359de 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -174,8 +174,10 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 			break;
 	}
 
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	scoped_guard(uart_port_lock_irqsave, port) {
+		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+			uart_write_wakeup(port);
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.c
index 39f54bb7b485..028a01fa02a9 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -214,6 +214,8 @@ static void cpm_uart_int_tx(struct uart_port *port)
 {
 	pr_debug("CPM uart[%d]:TX INT\n", port->line);
 
+	guard(uart_port_lock_irqsave)(port);
+
 	cpm_uart_tx_pump(port);
 }
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c8575c965203..cb04571c3d0e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -540,10 +540,10 @@ static void lpuart_dma_tx_complete(void *arg)
 
 	uart_xmit_advance(&sport->port, sport->dma_tx_bytes);
 	sport->dma_tx_in_progress = false;
-	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(&sport->port);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	if (waitqueue_active(&sport->dma_wait)) {
 		wake_up(&sport->dma_wait);
diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index 6e40792f92cf..7720796331c9 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -571,7 +571,8 @@ static inline void cls_parse_isr(struct jsm_board *brd, uint port)
 			spin_lock_irqsave(&ch->ch_lock, flags);
 			ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
 			spin_unlock_irqrestore(&ch->ch_lock, flags);
-			cls_copy_data_from_queue_to_uart(ch);
+			scoped_guard(uart_port_lock_irqsave, &ch->uart_port)
+				cls_copy_data_from_queue_to_uart(ch);
 		}
 
 		/*
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index e8e13bf056e2..cbd9af43c68b 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -740,7 +740,8 @@ static void neo_parse_isr(struct jsm_board *brd, u32 port)
 			spin_lock_irqsave(&ch->ch_lock, lock_flags);
 			ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
 			spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
-			neo_copy_data_from_queue_to_uart(ch);
+			scoped_guard(uart_port_lock_irqsave, &ch->uart_port)
+				neo_copy_data_from_queue_to_uart(ch);
 		}
 
 		if (isr & UART_17158_IIR_XONXOFF) {
@@ -895,7 +896,8 @@ static inline void neo_parse_lsr(struct jsm_board *brd, u32 port)
 		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
 
 		/* Transfer data (if any) from Write Queue -> UART. */
-		neo_copy_data_from_queue_to_uart(ch);
+		scoped_guard(uart_port_lock_irqsave, &ch->uart_port)
+			neo_copy_data_from_queue_to_uart(ch);
 	}
 	else if (linestatus & UART_17158_TX_AND_FIFO_CLR) {
 		spin_lock_irqsave(&ch->ch_lock, lock_flags);
@@ -903,7 +905,8 @@ static inline void neo_parse_lsr(struct jsm_board *brd, u32 port)
 		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
 
 		/* Transfer data (if any) from Write Queue -> UART. */
-		neo_copy_data_from_queue_to_uart(ch);
+		scoped_guard(uart_port_lock_irqsave, &ch->uart_port)
+			neo_copy_data_from_queue_to_uart(ch);
 	}
 }
 
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 62cd9e0bb377..0d7e06c7d790 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -239,7 +239,8 @@ lqasc_tx_int(int irq, void *_port)
 	spin_lock_irqsave(&ltq_port->lock, flags);
 	__raw_writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
 	spin_unlock_irqrestore(&ltq_port->lock, flags);
-	lqasc_start_tx(port);
+	scoped_guard(uart_port_lock_irqsave, port)
+		lqasc_start_tx(port);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 3be30fb05513..ac44681bcb73 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -295,8 +295,10 @@ static irqreturn_t ma35d1serial_interrupt(int irq, void *dev_id)
 
 	if (isr & (MA35_ISR_RDA_IF | MA35_ISR_RXTO_IF))
 		receive_chars(up);
-	if (isr & MA35_ISR_THRE_INT)
-		transmit_chars(up);
+	if (isr & MA35_ISR_THRE_INT) {
+		scoped_guard(uart_port_lock_irqsave, port)
+			transmit_chars(up);
+	}
 	if (fsr & MA35_FSR_TX_OVER_IF)
 		serial_out(up, MA35_FSR_REG, MA35_FSR_TX_OVER_IF);
 
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index f858a6669011..5a8817eb82ad 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -287,8 +287,10 @@ static void max3100_work(struct work_struct *w)
 			tty_flip_buffer_push(&s->port.state->port);
 			rxchars = 0;
 		}
-		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-			uart_write_wakeup(&s->port);
+		scoped_guard(uart_port_lock_irqsave, &s->port) {
+			if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+				uart_write_wakeup(&s->port);
+		}
 
 	} while (!s->force_end_work &&
 		 !freezing(current) &&
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a0ed70185555..d9ce6ba53c7f 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -950,8 +950,10 @@ static void max310x_handle_tx(struct uart_port *port)
 		uart_xmit_advance(port, to_send);
 	}
 
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	scoped_guard(uart_port_lock_irqsave, port) {
+		if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+			uart_write_wakeup(port);
+	}
 }
 
 /*
@@ -1043,7 +1045,8 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 
 		if (ists & MAX310X_IRQ_CTS_BIT) {
 			lsr = max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
-			uart_handle_cts_change(port, lsr & MAX310X_LSR_CTS_BIT);
+			scoped_guard(uart_port_lock_irqsave, port)
+				uart_handle_cts_change(port, lsr & MAX310X_LSR_CTS_BIT);
 		}
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 3a77a7e5c7bc..8be5b3031749 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -189,11 +189,14 @@ static void mux_write(struct uart_port *port)
 {
 	u8 ch;
 
-	uart_port_tx_limited(port, ch,
-		port->fifosize - UART_GET_FIFO_CNT(port),
-		true,
-		UART_PUT_CHAR(port, ch),
-		mux_tx_done(port));
+	scoped_guard(uart_port_lock_irqsave, port) {
+		uart_port_tx_limited(port, ch,
+			port->fifosize - UART_GET_FIFO_CNT(port),
+			true,
+			UART_PUT_CHAR(port, ch),
+			({}));
+	}
+	mux_tx_done(port);
 }
 
 /**
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 33ea496c93b2..7bc0d0d3760e 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -334,6 +334,8 @@ static void mvebu_uart_tx_chars(struct uart_port *port, unsigned int status)
 {
 	u8 ch;
 
+	guard(uart_port_lock_irqsave)(port);
+
 	uart_port_tx_limited(port, ch, port->fifosize,
 		!(readl(port->membase + UART_STAT) & STAT_TX_FIFO_FUL),
 		writel(ch, port->membase + UART_TSH(port)),
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 697318dbb146..6a310309b55d 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -521,6 +521,8 @@ static void dma_tx_callback(void *param)
 
 	dma_unmap_sg(s->dev, &s->tx_sgl, 1, DMA_TO_DEVICE);
 
+	guard(uart_port_lock_irqsave)(&s->port);
+
 	/* clear the bit used to serialize the DMA tx. */
 	clear_bit(MXS_AUART_DMA_TX_SYNC, &s->flags);
 	smp_mb__after_atomic();
diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index b4e1b90e5960..b15f76acd06b 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -454,10 +454,12 @@ static irqreturn_t sbd_interrupt(int irq, void *dev_id)
 
 		if (intstat & M_DUART_ISR_RX)
 			sbd_receive_chars(sport);
-		if (intstat & M_DUART_ISR_IN)
-			sbd_status_handle(sport);
-		if (intstat & M_DUART_ISR_TX)
-			sbd_transmit_chars(sport);
+		scoped_guard(uart_port_lock_irqsave, uport) {
+			if (intstat & M_DUART_ISR_IN)
+				sbd_status_handle(sport);
+			if (intstat & M_DUART_ISR_TX)
+				sbd_transmit_chars(sport);
+		}
 
 		status = IRQ_HANDLED;
 	}
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index cb31e3aceb62..f89efc4a2d77 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -435,7 +435,7 @@ static void sccnxp_handle_rx(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
-static void sccnxp_handle_tx(struct uart_port *port)
+static bool sccnxp_handle_tx(struct uart_port *port)
 {
 	u8 sr;
 	struct tty_port *tport = &port->state->port;
@@ -445,7 +445,7 @@ static void sccnxp_handle_tx(struct uart_port *port)
 		sccnxp_port_write(port, SCCNXP_THR_REG, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
-		return;
+		return false;
 	}
 
 	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
@@ -457,7 +457,7 @@ static void sccnxp_handle_tx(struct uart_port *port)
 			if (s->chip->flags & SCCNXP_HAVE_IO)
 				sccnxp_set_bit(port, DIR_OP, 0);
 		}
-		return;
+		return false;
 	}
 
 	while (1) {
@@ -473,12 +473,12 @@ static void sccnxp_handle_tx(struct uart_port *port)
 		sccnxp_port_write(port, SCCNXP_THR_REG, ch);
 	}
 
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	return kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS;
 }
 
-static void sccnxp_handle_events(struct sccnxp_port *s)
+static unsigned int sccnxp_handle_events(struct sccnxp_port *s)
 {
+	unsigned int wakeup = 0;
 	int i;
 	u8 isr;
 
@@ -491,20 +491,43 @@ static void sccnxp_handle_events(struct sccnxp_port *s)
 		for (i = 0; i < s->uart.nr; i++) {
 			if (s->opened[i] && (isr & ISR_RXRDY(i)))
 				sccnxp_handle_rx(&s->port[i]);
-			if (s->opened[i] && (isr & ISR_TXRDY(i)))
-				sccnxp_handle_tx(&s->port[i]);
+			if (s->opened[i] && (isr & ISR_TXRDY(i)) &&
+			    sccnxp_handle_tx(&s->port[i]))
+				wakeup |= BIT(i);
 		}
 	} while (1);
+
+	return wakeup;
+}
+
+static void sccnxp_write_wakeup(struct sccnxp_port *s, unsigned int wakeup)
+{
+	int i;
+
+	/* UART callbacks take s->lock with the port lock already held. */
+	for (i = 0; i < s->uart.nr; i++) {
+		struct uart_port *port = &s->port[i];
+
+		if (!(wakeup & BIT(i)))
+			continue;
+
+		scoped_guard(uart_port_lock_irqsave, port) {
+			if (kfifo_len(&port->state->port.xmit_fifo) < WAKEUP_CHARS)
+				uart_write_wakeup(port);
+		}
+	}
 }
 
 static void sccnxp_timer(struct timer_list *t)
 {
 	struct sccnxp_port *s = timer_container_of(s, t, timer);
 	unsigned long flags;
+	unsigned int wakeup;
 
 	spin_lock_irqsave(&s->lock, flags);
-	sccnxp_handle_events(s);
+	wakeup = sccnxp_handle_events(s);
 	spin_unlock_irqrestore(&s->lock, flags);
+	sccnxp_write_wakeup(s, wakeup);
 
 	mod_timer(&s->timer, jiffies + usecs_to_jiffies(s->pdata.poll_time_us));
 }
@@ -513,10 +536,12 @@ static irqreturn_t sccnxp_ist(int irq, void *dev_id)
 {
 	struct sccnxp_port *s = (struct sccnxp_port *)dev_id;
 	unsigned long flags;
+	unsigned int wakeup;
 
 	spin_lock_irqsave(&s->lock, flags);
-	sccnxp_handle_events(s);
+	wakeup = sccnxp_handle_events(s);
 	spin_unlock_irqrestore(&s->lock, flags);
+	sccnxp_write_wakeup(s, wakeup);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 6b7dcbbacd13..60f72c19d67c 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -570,8 +570,10 @@ static irqreturn_t qe_uart_int(int irq, void *data)
 	if (events & UCC_UART_UCCE_RX)
 		qe_uart_int_rx(qe_port);
 
-	if (events & UCC_UART_UCCE_TX)
-		qe_uart_tx_pump(qe_port);
+	if (events & UCC_UART_UCCE_TX) {
+		scoped_guard(uart_port_lock_irqsave, &qe_port->port)
+			qe_uart_tx_pump(qe_port);
+	}
 
 	return events ? IRQ_HANDLED : IRQ_NONE;
 }

-- 
2.53.0

