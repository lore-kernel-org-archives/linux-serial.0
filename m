Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563611;
	b=eDt9RV8vJuOYAuvrS0urtnWOK9Wwo1SJwrch5r6VUUr7p6sTOCJU06prbAMKpLI97L74
	 teFLYny8N2bPhahf6BLpG6+Lzwjk+pPSIL426pipsXBbq8aOWyi4pdh2zDzfAQGgX3a+R
	 2TjBQKpmzM5MVE5f3FABuRArGTUdc5BPvwZnjc3vn5mG5dZX17oB9fHSmmJ9oI/yFUpSN
	 aHHGqgPMLEwIWgQsVmK3aYEhpLj0cYVmoWpN0fekoQD3aQu+12nhLvo3U+MGp0Zmf1318
	 /4XvlYa3oiE06h/NF0dd3t6edKvBh9Vry5ag2V8zvcLgLYB82PdPD/8WZFsRsTnkA3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=snI99jPMkmuHdc8mcM4R4e7s0XOn07YSlMRthm825Sw=;
	b=e3Zm2rn01t7hj1ulwM9tVuHZZT+aQEKBg8KJoWwRX8/NTILMKUTsd3iCUoKS4SRfVsiQ
	 BM1tAIwSS9rAO0BqtY3MEDBaXmZSn0brR687BmmtkCGyLLQNPrztKemPpBzq9/y5z9V2q
	 M6rawvxC5F39mdQISQTYmefEpZAd6HU+TDJrnHoJLlqrKSTcpG0Xtb2ERNFYQe3Es1jCF
	 y92w5axNOZaGKoXgNzdZZqhIVeKjzoLX+sPcyzAIBwx3VG9CsV6UFkX2Pn/i47v8cupeO
	 lJWZrbKsfR7tw3J/hXsbp8BdR1cOgUwR/UIN1cabtGUqgPdiqc/RjhQmRS/ahTuV3Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lfnKAE2F;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC1606A339
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 09:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46BC1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lfnKAE2F
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8479f46ecd8so229252a34.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 01:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563610; x=1795168410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snI99jPMkmuHdc8mcM4R4e7s0XOn07YSlMRthm825Sw=;
        b=lfnKAE2FsyT1V/4tIDeVEYgMlXDSq23WxuOShq9iFcoZzHvA2E0L2AX5Am52b8fEsj
         ux8DEypvTvA5r1Q1gp+caEIcZDf7RMyyOMKSq+8PJ1cDTadci0VSdx7HnFI3OGzh/AfT
         WnB8npZZ7Aaox3l1iWIACNxnEdp97GFbllxPYLrsgPKrM+XPnF1QROZN0VFrYL3l+fFP
         hXwUDNhRVhovh7zaJBmB5G6o7Yhpf44Wv8x+UvjOVt1ISSWl0ZpLXobCmSJ465cUN1I8
         EL4v3opO93lmt51YEU24Oc5n49nVg2Ed1jcqCNvymE9hlg1rkI3+TfKiqEECrw0OaZQi
         L3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563610; x=1795168410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snI99jPMkmuHdc8mcM4R4e7s0XOn07YSlMRthm825Sw=;
        b=vpxfSfTc4Rb4WBO+ACwBS+TFstkIUisN6qDJhV1Dq9x+7X/E8+uoViD9jxrdaurBMH
         BNJ5ZWBfNd91KM28+qqdDvQ8FAc0JVhx/3H3ff+o/NE6a5DyhhLtqrwyrLlD4257noru
         YVeEWguC85a4+4yZN3pmDadIoycuCKtCqFlFWaOeOS1JsJbn7xiViGM/va7QPcApHzAW
         T0D4c3UU9wC6nJuzL1qv+ePPGf59pD0dHJLkp9RyUQ1cOZNOMmIcZfKfvALZ6I7ZBYU/
         K/O6zp8EIr72AR+BgmzC0OumRCqIeMrjDYeeT4tuUhBgB0TWXEgAUsQff275M+Bt4gpp
         ejCg==
X-Forwarded-Encrypted: i=1; AL+hErFU0JB1aq4BuR2vgBabZWVUqQjrYR74AECd9vzpWMW/2/TnH8/0EMbXhba8AT7bzyWRi/2xwOSbbopfqNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YOXxzz8BKgdA8q5Z0t/ZcF9tnCYUqSE1cgjBRTV5av0xdtF3v
	6fOF1EThkkBqkmqWx1ERMEEEZYq/XT7KB7BMDZAn3bjGaajwySNprvbB
X-Gm-Gg: AYBFou2u86i6QGJaac8YkaqxZ56EnETpj9JUcrFrqHxBcYfZ0ACmtJjV0/u9PIM8SRP
	kL2ivsVZ9e9b0dM31lG3KOMOMIBF3IN15Sz73dBSO7gVHrlPuKyHOJm8SfmLgIqUzDwX0nyPp1c
	eglfb7zcq+ce4r1kKxozJpF3MJ6kZyG8YZTgFEiP1X9KqQYtdACT++Irjt+BwQvPN0/9IqcF1Ut
	tBhbMQaV/F1oimCIszOzFpYcRaHxiw5TXsTAuy1gI1HUnM83dQDtI4UQW2WYp2IFQTUOPGz4+NF
	3QdvmKOMNGp1X7CSh7ja8CKpn+sAHBtscLaawwkTr/F2kSevSzKE01LjivLzY07cRmmlAoWbKB3
	1T+jw84ufqA63VZsgyDNXuFPb/C01+IWFNv2dx9ndU4H5K9rd1M3H2X7AIRTKUbAssM4w5yAsmb
	datpmDpJabJja0NE9XVheU3FKtQ1IKsDn1NNv7CmfICtVHNK9O76VzkyCw3aop5SWx8KhN0aYQQ
	FOO0El4nG0OfMYsmwyBpN71Tcgcl4UFXYGS21PAaf25SCwdiFPRcLfKaLzga+UWO2m6mA/7QUn7
	ScswzHJYziG68Hrih0y8Wo28hQhPjjh9byK3o2dfbqbbkEbtDTEh/I90O5S9mymuumlm2KjNoEg
	UDri4gX/C5YhUcPTYmlv6+IBY51S/rAMGe28+4c6p6ilWtsz1c+m4OGCLwrsy2nZR7W3/PGbFbV
	si70KkNzg7JusBeuWuubqrrUOIeJuTFnfjUKXrdLNueP1YDCRc7iUaR6snK/D5yroOcdQ4dkH6U
	w==
X-Received: by 2002:a05:6808:2207:b0:568:c71:5338 with SMTP id 5614622812f47-56e63ba982emr1490761b6e.18.1794563609933;
        Fri, 13 Nov 2026 01:53:29 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7094aafcsm1609523b6e.12.2026.11.13.01.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:53:29 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 02:53:17 -0700
Subject: [PATCH v13 4/8] serial: 8250_omap: quiesce DMA IRQ handling before
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
Message-Id: <20261113-submit-serial-8250-dma-cancel-v1-v13-4-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
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

Clear EFR2 after draining the IRQ so an in-flight handler cannot restore
TIMEOUT_BEHAVE after shutdown has cleared it. This also waits for the PIO
timeout workaround, which updates EFR2 outside the port lock.

Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for interrupt handlers")
Closes: https://lore.kernel.org/r/sashiko-outbox-206203@kernel.org/
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 5e114dd8f9bf..f1980c15f85a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -771,24 +771,24 @@ static void omap_8250_shutdown(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
-	if (up->dma) {
-		guard(uart_port_lock_irq)(port);
-		omap_8250_rx_dma_flush(up);
-	}
 
 	serial_out(up, UART_OMAP_WER, 0);
-	if (priv->habit & UART_HAS_EFR2)
-		serial_out(up, UART_OMAP_EFR2, 0x0);
 
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
+
+	if (priv->habit & UART_HAS_EFR2)
+		serial_out(up, UART_OMAP_EFR2, 0x0);
 
 	serial8250_release_dma(up);
 	up->dma = NULL;
@@ -1330,6 +1330,11 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 
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

