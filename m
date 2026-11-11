Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435399;
	b=g5QhNDuAT33utqMEXnvBiJFFRfWOq0yJIS/a4AR384mTInZyaFkTCA59O9MZAyPUHIKP
	 dqEOmnhdzXrbwfvwVb6OJs2sM7KjH13zPtlSRBbGT4T3+Kl+jbD0YVu4jnNKSBEtSHLqD
	 y7jU40SkeizkSG/v7dQiuVM0Ddcs0A/XAZYXnDTajbvJLsbOWIGg7/Pv+VqoioLYEz4eE
	 HEq04uB/DMkFwVhJV4byRYMFHo1ceI27EuiWfuf0YEL/jgaWsZlJdKfg+W4nSVIriHPC4
	 MCLWyuJ46Iy4FGh/5Z5Ni/d8THHRSOL8XTNaDvhulCiC7+iwCztbGR3Sy/154VbLwaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
	b=JIo1EWukph9hsVxryHQ0sEzW2XRlKz6kW23oXjv8e/V+bJrvmOTBCaVUqYZmL0NCIYbW
	 vx7yIHbDvAdT8MUecYOZ5d3wMAfyZ4PinWfflilHrxwFLiGwp33XDgk3V7qn89EuIDBZk
	 lQHTHmlQf5YRtR/gZR6FioTRPRJpiJUfUwNHP+DNNFiadH9WN34bTbA1lyGjx4pviZu8o
	 Al7/HCFolEM5yXlxuaLZQ0kuoNw6hsURQ3h437sk6rAnMwPEmTpMizs3askh9PJWWwuK7
	 ZNB/yMVbSv8T6QvjUV+lpXbK/R7uc9c3GypRnxP6RkWNk+LC2Lm2W/q73djAV09fpaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Kzn/9CAi";
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D72606A893
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 22:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2D72606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kzn/9CAi
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4a77761ff8aso2067605fac.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435398; x=1795040198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=Kzn/9CAisPVWcpWdEKMAUCom/auubQjRXYiZhTs5TM7aCO2F52Co8TsDyLQnkT49An
         gCg3o6aXAR04mcNWGtb8H+cc49tj27S6arOswstkbUFZsPvS3aTwVXFtBzCljRWwlzec
         WTl195YjVB018BH9UWdDg7rMZ1bDzfBC1Siak9H5TadTXAPibqrkUBwfqIRmoua8s2/I
         +ejBSyYCGv3xrRvJ9MrHY0DCuv/eY3WiaO0t+devkD6WE0UPsrFsUCpTXs1C4kPb6kTJ
         Lacyi3ltJLa+Vfcz0l1z91cXO2bfVhs2ySJZBKmr9qbSqPhew1sfspqqs2qnlCOi+nNI
         TRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435398; x=1795040198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=xt4k15uESjZSGKaDLr/j1usTs+T51DAqy+eeEJ1arj0Ri/1wDkY+QhuzdGUvqxMEgc
         cUMMUC4W+b3qw0CdSHEUj0nIibb185u0wUNstEVjFK+1QWOYV+04EcTfFJr32FqJCQSx
         IL/t32wEZA8/nI5ULi3KWvzoiNNqeP/KNeucRmnoZmwQYqsnTNPvY68AE1TlXPnYa5Pe
         uqXEcA+FkpXDCgFYYYuUsH3Lj8B1MRC55taNsnxc0OcCcSlhLcHxseJ/1Gt94iV4aGsF
         QkQ/LDtF6qK5qVddrpfn+g/WDMkhLBHjwB0Z70sZ3cXhc6ejjeNJCUnr0ovXRSMxvrnt
         i0aA==
X-Forwarded-Encrypted: i=1; AL+hErF9Rgn4K/iO4iOpa/7U2K0w9EDhJLvhfFBc4quY2xwpNngcH1xeUfjk0iwAyhy588qDwvmPGDu1prMIsI8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yfhQWLcgU1uFrHqIfHoTH/0zsG//x0vyy9XaWSl/nPLII7HVU
	cNPB0MLJH0y50n01yVdM3/jFL4MICQHC5FEtoe4fZjUJeLMtrWG30X5z
X-Gm-Gg: AYBFou0RqHpnen1xaci00iKpXHZt2N6N+5PNiJOM8LdPtbRwYoRQNgNQKR7rsAf4sVd
	/8J86X5vRFqBUu24NRPdZlESddtfERg3FZ6wTvNQ+BlpHt0VmUUBLGY01ZrBqtReqKPJejJs4Uq
	8xja+kFfQDM30HG7y+p3tyxIKxfSsfMXyJsuua6lhZPTpV8mq8wuTznzoRuV04DkZwxG0QgbiQm
	xPQUqqijTkBwWZQiG4PejO7v7qkFvMQRSIGoEuHTOY0zhckGNVy0+ZN7woAz7fBBcZ3fhrc03Sf
	xJ1zlW6351zRIQjfkKyKBflvlvkvG/ftytbl1ver9IG71yVLTIQ16jWK67Q+TNYngjOrY7riHvP
	zQGtDNd4rDIFZSnCKannHlr6LpVuP2iE0E+l61EaRsFrH+6RwkDqUd4jNXFE43wo2EReKjnUeEw
	jC2QiHvgxodDTJLBCXYHm0uiiomjTd+Qd7KPApjL+K4LfMRPINuvhf5ryTLKoljgwDbZg4J1/dq
	fJmrJ+JJsjscZRrxmo7kKcOzTKv07hy4CST2uJ5LIOyD2Jm5P5t+j0jlfNrLNplHkexYtb3OGei
	nO9z8d25KgUpzPVoFX9+yOFommOY8P6DUks6+OW0QSrxIZtj8S/9Mst1DnQN8u1YnbK7f+YRNIw
	Hh2qGEDjtNJD8LC2GIDuYTP6zpZQAhX+tmD5ka1uFn16pBJigHargqDV6demjY9VV0EDefh/Tto
	devxUKmrlJxDvFb1d8eyxPb09/HXgR1z/AHmhCp3UuSabP4VtxeqU=
X-Received: by 2002:a05:6808:1a01:b0:4d6:92d4:c806 with SMTP id 5614622812f47-56b987289b0mr3147119b6e.62.1794435397786;
        Wed, 11 Nov 2026 14:16:37 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae38ecsm5917498b6e.1.2026.11.11.14.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:16:37 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 15:16:28 -0700
Subject: [PATCH v12 3/8] serial: 8250_omap: serialize RX DMA completion and
 flushing
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
Message-Id: <20261111-submit-serial-8250-dma-cancel-v1-v12-3-9e3456bc2555@gmail.com>
References: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
In-Reply-To: <20261111-submit-serial-8250-dma-cancel-v1-v12-0-9e3456bc2555@gmail.com>
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

Moving RX DMA locking out of __dma_rx_do_complete() left the DMA
completion callback calling it without rx_dma_lock. Shutdown and runtime
suspend flush RX under rx_dma_lock but without the port lock, allowing
these paths to overlap the callback's buffer accounting and flip-buffer
insertion. RX submission and UART interrupt handling also require the
port lock.

Take rx_dma_lock inside the port lock in the completion callback. Hold
the port lock around the shutdown and runtime-suspend flushes, matching
the existing interrupt-path lock order. Assert both locks in the common
completion helper and the port lock at the flush entry point.

Fixes: 789898416749 ("serial: 8250: 8250_omap: Move locking out from __dma_rx_do_complete()")
Reviewed-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index b6f108d34854..5e114dd8f9bf 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -771,8 +771,10 @@ static void omap_8250_shutdown(struct uart_port *port)
 	guard(serial8250_rpm)(up);
 
 	flush_work(&priv->qos_work);
-	if (up->dma)
+	if (up->dma) {
+		guard(uart_port_lock_irq)(port);
 		omap_8250_rx_dma_flush(up);
+	}
 
 	serial_out(up, UART_OMAP_WER, 0);
 	if (priv->habit & UART_HAS_EFR2)
@@ -898,7 +900,7 @@ static int omap8250_rs485_config(struct uart_port *port,
 #ifdef CONFIG_SERIAL_8250_DMA
 static int omap_8250_rx_dma(struct uart_8250_port *p);
 
-/* Must be called while priv->rx_dma_lock is held */
+/* Context: port lock and priv->rx_dma_lock held. */
 static void __dma_rx_do_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma    *dma = p->dma;
@@ -911,6 +913,9 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 	int			ret;
 	u32			reg;
 
+	lockdep_assert_held_once(&p->port.lock);
+	lockdep_assert_held_once(&priv->rx_dma_lock);
+
 	if (!dma->rx_running)
 		goto out;
 
@@ -977,7 +982,8 @@ static void __dma_rx_complete(void *param)
 	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) != DMA_COMPLETE)
 		return;
 
-	__dma_rx_do_complete(p);
+	scoped_guard(spinlock, &priv->rx_dma_lock)
+		__dma_rx_do_complete(p);
 	if (priv->throttled)
 		return;
 
@@ -995,6 +1001,8 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
 	unsigned long		flags;
 	int ret;
 
+	lockdep_assert_held_once(&p->port.lock);
+
 	spin_lock_irqsave(&priv->rx_dma_lock, flags);
 
 	if (!dma->rx_running) {
@@ -1811,8 +1819,10 @@ static int omap8250_runtime_suspend(struct device *dev)
 		}
 	}
 
-	if (up && up->dma && up->dma->rxchan)
+	if (up && up->dma && up->dma->rxchan) {
+		guard(uart_port_lock_irqsave)(&up->port);
 		omap_8250_rx_dma_flush(up);
+	}
 
 	priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	schedule_work(&priv->qos_work);

-- 
2.53.0

