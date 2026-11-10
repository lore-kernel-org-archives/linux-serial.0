Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283241;
	b=JivxXiPGMKO4PEdFag5sc0SB4iQJNcZ3181XwXEPhBNjhUsOsDPEfDu70qtwlAWINzV/
	 C2NrTn+WWQh+agOVjASnq5NjB9mpG1/Lsh3XGfzm/iCGZf3ufBeuxOVoHXUIorWQfGrTQ
	 ONzXBe9iBdbxAu8cj7GrNdU1PgyTKH3dKh6MnaksRPtYplEJbDrEZ5vEMLrcHNl9zbxIC
	 d+cIfleUvkZGfgZbRzn7G4L9pcRGqZonDF1LavNf3xpJz6FrTgWjE3SdFEpZ4SDZisGK+
	 ALU3G3+9p9W+LhPR/7UHKQREVwj9grl8j4TiHjB6qrFnpgQvoolTr7Lv7xR9Z0/a9ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
	b=wgBtrORMbe3l59THCxikGx/BEBu0/8oZcmMJaDUAlx3SKPvd/UgY6i1v9P11l0OEI90m
	 6h6w/AepOlgIsHoJLnB2eW7iBnW/7h7HRaOj/Njg13AiZRnZ1fwuu/Q4kC65ENW10d3q0
	 BjvqGIDQmksowMdGui3boV+uVH14B5bUMYLW+WUjLPyfVCnaqbTSYBFhRwlLtpggN3wIX
	 JIm0WkD0Kcqq7n9qYUJKHTkLX4QxnzvRepOhMmPirx8k5/VJxItuXLXKJeOgyHM2/Hvd+
	 zh7JHyFV0wrLqVdWqiACtlJlB3ozpnb1UOxrQq36Qqp2OKfxsaqCqyg4Iq9T33F7ulw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dwzy13Xg;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5360A2627
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 04:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8B5360A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dwzy13Xg
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-717034b331dso916823eaf.2
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 20:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794283240; x=1794888040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
        b=dwzy13XgZrj+ZeKWhgHCpNzdxscT1PlUN2VvUrjJgeAsEE56VzuqLLbhq/KhexZgYU
         GNOMgvt6NyDpyQ2FSPp5RAfKN7eLMvvfA6u29ntwEbDwQoN2mGjSdnogVIkJXQVZVlTi
         waApPVGiZwJUuO8Wuvd/If8FJhI456aYXBJLth9N1UjdY2UQH/unPhsePFdszvQYRfN+
         0CuVjzarm0uq9VQVxcxzXpDi8FZTImuGvoI9goQixLiVlAxNuT2eHoQGII2pumyMT4bF
         poumMSFAzW1Nx+IvAIlZj8SIIylNL1X7IKTGYhMtf/6BgEjKHpKTb3+0dlArqvSIsXki
         TWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283240; x=1794888040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUfxuzZXIT5avg6gl1nxcM7YkzRMwGmAk1oGIMF99rQ=;
        b=KKi8TWyEVHzzcOuTwd5SayDIdnI/1iswq64gAHBBMe0ZbJXr/UXmHzyX/Zlm1KwbuJ
         nhrLuSqn2jsarzGrLz7hCajqBX0ehhCBPnVoREC9KP/TCM23LGGSWCkltrEa+M7EpJL5
         CB3Zh6fAvRngSpnPeKru9WlXQ9ducDGLDsMAlu+NVfOfwvZId8qeFh81ZxHBdAd0MsNI
         v5rBh27p75RuzZl4ZqJyPUDBNl2I/Nm1eSZbyAhc36QwhEq9hrSXlkKUVU+OYjUxQp30
         AoXXV2EdgKbmWDN+1KjQZxpDpUfRDqjzMu/+igzaXp4wiCLGqKGqHLOZNvzLuenYxkJY
         /z+A==
X-Forwarded-Encrypted: i=1; AL+hErHw6G+SQJ8xYT0eTHttnI1y8C1Snqba4A4b2Lj1zkNo3MmyYgsLC1B+i97XAK7TW87bt802uG80k5OW9Tc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9znXR+xZ09Bfnbga28Xd7JZ/258P1te7Uv51mIqLuwjSXgF/WL
	s5+XN2TPhGfqZ/f6QUgjxyUI9eJug0v5xRKzE2Mrpx7iWFXAj8I7hSYW
X-Gm-Gg: AYBFou2nLzNnwPfP3dObvyFJxtKTvlGyPqgLXDv5XCkyze04PfNWZwcXSu3OT4lkRxF
	YM9pAIV1iDicufOqGEzUS8v5imfNlpHSUdehgTeKWe87+3hbTXZ0XhDuGpXIMsWQbYseANeHlgW
	8SDRSz2Aj0v7wdoc5ed+IBjMVXvX9NY5gwfdVaW9rPNhVPyo4k6RgDfSUkXzw5qMv/XN7XYbaww
	oL2A1MjDlUMAfJ2YPX8Pss7BqV6XrfsGBFJUn6oSdDkIhm6iOZ4w6kUsYVSDyqUrW34MpUtZ9vl
	2f37DEMVTN9t8qYCszmgR8nNM7RKyitqa8GndoxzdafSNtB3mTx5Vk8cwiDm8OVFRD6oXnudedq
	b6RkRkXvWXQDjr50RHdrRpGd7IgwEx/jnZgQg7elo/9R99C6ZW84Dp/qMRpJnomt41oelQI8pW7
	If8fUztlgiiB67Yuv14lXogwK8yC4gHoWdYkm3CVsByf7TlXIOw+hi2uy+xWFu++UMK60960Gxg
	9h6EJvojYunh9dcC5ls/q6foq3RIeDvFHUEhk4G+dOXRecRecesCRZusgDRv98ZrYlC8PlsdUI6
	+V9Y8vq7OCsKkDE/Nrds81uD6XBgPbhgjdBithDgZTFryM6FLO5y7pL+vjqqJEELIYnLodTmgtz
	XBs7fJqEYPeyT6U2vaufDI9Z3XI1vMlAOYXKtPUIKSiz3rLbGpWumPFziOi1scaFXRV8F8EQcj2
	+euI6kLCFFjap7HF1fXSucfldyAXdmbL4I753p6lVRbk6V/WW8iTQZiN0pH1QNANXZ/ujbZA2Q
X-Received: by 2002:a05:6820:f02a:b0:703:3ff5:ddc4 with SMTP id 006d021491bc7-718a188120cmr678015eaf.11.1794283239825;
        Mon, 09 Nov 2026 20:00:39 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcc1d759sm1028178a34.23.2026.11.09.20.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:00:39 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 21:00:19 -0700
Subject: [PATCH v11 4/8] serial: 8250_omap: quiesce DMA IRQ handling before
 shutdown
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
Message-Id: <20261109-submit-serial-8250-dma-cancel-v1-v11-4-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com>
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
 Timur Tabi <timur@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

disable_irq_nosync() masks the UART interrupt without waiting for a
running handler. That handler can have observed up->dma and continue
using it while shutdown releases the DMA channels and clears the pointer.
Synchronizing the IRQ later in serial core does not protect those accesses.

Publish the DMA shutdown gate under the port lock before the final RX
flush and interrupt masking. Have DMA IRQ handling check the same gate
under the lock, so a queued interrupt cannot restart receive processing
after the final flush.

Drain the UART IRQ outside the port lock before releasing DMA state.
The lock excludes competing RX processing during the flush, while
disable_irq() also waits for a handler that observed up->dma before
acquiring the lock.

Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for interrupt handlers")
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 5e114dd8f9bf..51013dd2d851 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -771,10 +771,6 @@ static void omap_8250_shutdown(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
-	if (up->dma) {
-		guard(uart_port_lock_irq)(port);
-		omap_8250_rx_dma_flush(up);
-	}
 
 	serial_out(up, UART_OMAP_WER, 0);
 	if (priv->habit & UART_HAS_EFR2)
@@ -782,13 +778,16 @@ static void omap_8250_shutdown(struct uart_port *port)
 
 	/* Synchronize UART_IER access against the console. */
 	scoped_guard(uart_port_lock_irq, port) {
-		if (up->dma)
+		if (up->dma) {
 			up->dma->shutting_down = true;
+			omap_8250_rx_dma_flush(up);
+		}
 		up->ier = 0;
 		serial_out(up, UART_IER, 0);
 	}
 
-	disable_irq_nosync(port->irq);
+	/* An in-flight handler may still be using up->dma. */
+	disable_irq(port->irq);
 
 	serial8250_release_dma(up);
 	up->dma = NULL;
@@ -1330,6 +1329,11 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 
 	uart_port_lock(port);
 
+	if (up->dma->shutting_down) {
+		uart_port_unlock(port);
+		return IRQ_HANDLED;
+	}
+
 	status = serial_port_in(port, UART_LSR);
 
 	if ((iir & 0x3f) != UART_IIR_THRI) {

-- 
2.53.0

