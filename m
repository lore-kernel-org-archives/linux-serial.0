Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283239;
	b=L4LDv71WYq4kYTj2pIusOqFL6uvpGwXBAy9di/YJq/GZXkh3nw0NrZCi1Mh2OuGz6epI
	 ULsxugfTVTs4Uu00V+P9V7AzgH8VueEsPKN7bWfyLnO8ZyKl3C8wuWbqqb/vNn9tX6jZU
	 N1GqWuiKhxyT/PwL9Je2myWpOesX2jT24HbWv5EE0BMqfQYF3SogNkN2An8fdvwZKH/0F
	 HoNoesLbxcvk7q3kup7dVVtqX1bH4rN6jRMfZHjnDckaJAIBqYx/Sn1o62h4GBv7auahx
	 p9Zw8SAE51VIM/GHNGh5Sj6FNmGs1WOhMvEY8afvgZJlO1dfIjkPHE4BSNDojobOBPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
	b=gx4T0oQfjXHT96jx2wTzL+Sf0a2aQlVz2Ri+khNBOtpmwgCcRPxe+LdefIKmaaZM4lJu
	 MBF1h6JAth6HPXQG5yg51P/LG8cQbse64+h/N27byIBoTNHlUHghISEH5pa+MmIBV2Wyv
	 9qemNKfQ0TLxj9acVEXWwAa2OPcG26afHjdsDEOdMm8bUl9NWgiQm2isMZTSWxMGDoMEX
	 JS/8ZF3H5tx8RwcCYqLDrDxPv+Lfl4fBvnol76htJnyr1xI2Ocsmn1i3T2g56nAYPi/Q5
	 n6U1KRuGNR+j+7gCaE3Jyy1kJcFgFdB3p2Ju4X2skoH7U4M9q/IkUMdzlUmA8Mh1y3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TU5WtYqu;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5251060A2619
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 04:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5251060A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TU5WtYqu
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-85ac281604dso917914a34.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 20:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794283238; x=1794888038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=TU5WtYquFyWvFTRZA842ChZD64LZfAdBeSrRmVmD4nOaZvxlAIrFLWQNxTouj2aCzF
         HI6wIuBorwNHV1NtJ4LRy3qonEtpkhJAiBaLdzUlyLtOZLWoeglglbT/rdJnrCaXREr7
         /whdvTkGCjz9ApySXKJgfStj1Q+5fq3oMqLYNLmX0/e6ZkuoUAElzMWRPbUK3K+QHfOg
         2X2Y+Ysnaii5zPtXOOovfjX/zLAsUo9HByynEZ6L6x7ViGWY5CHdnkpDBaL3cfI7aSqB
         HRPPLzuA6ZD3gAHZHyhXjOb7pY9rsEX+2/rAHP/Uu900IG2GWrmKAGw7mhxWg9j/pYDC
         56RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283238; x=1794888038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLeox9UCna+JAgQJPZ2ik+qyzedm8mitCUwWv3Rb40k=;
        b=DI3OxOtXGlNC3emn0UkY5ep2MqdskxpIpe5KehweV6GeJeG1Dm4PTXYq86ATJexjku
         2SHDskea2KypW36zL1J4h6S4qbvSb020/HV7UG2/Np8hRgySGuigGU/ChXn6IX9LTR8+
         EQdrNk2EllDL7AO1uh3vDqqGSbqVEhO5A+u0MW1dufULfHyHPFp0/RhgKspHCKSabw4i
         ybrH9tVKc7Ze3ID4AVkwtOM9swXEBOcnsDjoxtO7ascheCcHJL6sShbkve7CHhdvFOO6
         DxmKo53zDRs2DXCY5NCeEMqDVZ6zzIglDQJPqnzRcXP7IKM4obt55rFoM1Uvr4P80Nim
         1JZA==
X-Forwarded-Encrypted: i=1; AL+hErGAU6liIQ5jB25XO/j8KPEFXKBsUDop0H5Bu8NopfYaTlIpL8jm7ZsG2Hev546+dH7Jvc5bdHQU/HYFlWE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pjJYaCajJwtrraCFQhWSHzKmyqDNr9vMZq1o+meVmlxn3Va/5
	VEwyH9DWXjIb70xP5lNmqy/2ZFantTNEfN3XPau+UL0EDXN1C+6MIvpj
X-Gm-Gg: AYBFou2zCc+nxpqAZekg7/rANBCNn+9Y/o7K0Ym7YVAaTI3X1fIZVbTKbbK/ZrqEA0q
	fEG0JppOe+0ih+kdwv+dUGoFz4c4Ahd9ywro+fayrVHKjSy85a9lAQjYXCfQUZdCqNwxV4NRJLb
	B81NcTDUcH7BuyobBkXeQf7UEvwzP25UEz42iqsA2yHzUB6L7L2iy/nmsw1ZZdpMUdBVeJzB90X
	rt65SZEQfNsn2tZee/h0mmCrLQm45t+IbR7ytar3VfUqXt0fy+G/yTg2+lmfYYfCNapQ1jLBXQ+
	dDpoOnaJ9BnCu9mO3gMJrfKSWjbdNmPDYDL5n/YHpgCHXXAKE78VZecLj4vGre5/Cl9Dt+/BaaD
	OyVPJ9uQzE3fReKYiPGjuP7LgcVI6AgMbyUIAQxaFCjNx6uDceWtAuhQtcI2y0di6GSDKoOEhU6
	GBV/beBEDSV04OTAyn/FtYbwhzYg2qhSJE7L1QLra/Uida4Guapx7rkjyrnGnEkMUdM6Nk90VcK
	SzSrj6iZJi272kfGfMqcjkLMyxFm34ysiCtGoIAhkQK3nmnK9614uHkIk2f10g4zY6MXxvvnViI
	Ctnc4f0XGtonPtx9x7kLJVQcPcXSkTVPIvDT99FVt5aOKTxT7C4WubV6OiNFnNTAxz9ANfnxEAF
	HDON5QtLRxentzs/EmG+1pMkgW11ulwcMWpWenJaWeYfutHPtAnZugY91xsxK9AK6A5dQdTCHts
	NgAzFB4//+uniUxVckIt5JI7POO1R7FpSfWJ25hVrjeTU9rFufICU=
X-Received: by 2002:a05:6830:2693:b0:843:cc20:9d03 with SMTP id 46e09a7af769-860dc70cd38mr1124080a34.6.1794283238334;
        Mon, 09 Nov 2026 20:00:38 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcc1d759sm1028178a34.23.2026.11.09.20.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:00:37 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 21:00:18 -0700
Subject: [PATCH v11 3/8] serial: 8250_omap: serialize RX DMA completion and
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
Message-Id: <20261109-submit-serial-8250-dma-cancel-v1-v11-3-6364edca63d6@gmail.com>
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

