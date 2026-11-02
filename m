Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661279;
	b=EEyGIv310FpE2G5kNGwUSG0Mb2EIBYu8AFH1ygY+B/2MZDNQVuab+OBQB0cyodzdQWOB
	 szEnCB1xZ8oFfexOJdgOOWrGvRLbLMTJ3guRzOiw7xzmcAZKuuNGZCYY5IeRaDv2GSkXw
	 0Qs1bV5er4hI8adkuDFFu4s/q3YyzlOi2Uh9ih3HeJTp8hM1gHp/jOlpdk5EiwhwzhX7h
	 7rDDjf4iqtL0w9N30FynfndukVYUKj2BsBX61BH54ThCfc1ZVDk9sgBCgcJNv+AABtvWG
	 TXjC6GyMDY2rqwZHVXzj9qgpCVvsgcQvX6UASxufMafGA7Bm/fvx4TZX/vRdDkJN7EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	b=35WXmuUJldGDqdYCrU93Jh9/XZmPTppJGWX+YIKtEbmympnfpk4o0HLz8fctJ8/G3QYU
	 PaHgFC4xjl1Yeg2ClP21ZPHsMFzJ0WYH32X2Qzp0zEjFQMWQmE89VauQ4nG2hZQru5ViP
	 yuDQyb9Yxdi/cbRQ4w6NAukpazqAURwBEKC1hyZdQc8+QDNzs0dMI86AuCt1EXUeMtjF5
	 2OpjTFP4ldSFn1eQOCy20QfSBFuHuN4agw/1rzq9rTyp31hC0yXpfI/CVPKWomJLs+UCq
	 smGXRuhrvAEI2vh7klvFRAAV5WEmOIJfeJGgKj223MgsxM4v+KExwMiyTSgpt+vanIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zAbh+AKF;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED73606D833
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ED73606D833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zAbh+AKF
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6de2f213b7aso1542113eaf.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 15:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793661278; x=1794266078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=zAbh+AKFnmrKyu3yPlpJFTyovgT0X36iWP1xt6340TDWsSmwQJQfezmHFkrbt1wDPC
         99siFVB0N5xKyLIlR5dsryAQuDVnIUnIajfuT5VV1tWbyu/eiGC2prSWyo/Z5UDd2p5h
         pij+0JsWXSB1Ksv/0jbZvaca/4zUCLoBvRQETgKQ0m84A4Fr/ayPsLf+tx5OKCRDuG+3
         Mic/ANVZLEOhfTtQSU1FL0vdkAV00Rj5soDPKEt4yDizTQ2MU6yL2E0ar0dCssYnlljq
         5nygHbLug0idpwvep2XFY18Kk+25Cf/rn7u9y/bDfLt/G/wGPWccQJQdhU1yNlfdDW/a
         aFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661278; x=1794266078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=wFv3T1hpel4H5A7eQkqzQRBzQvNF1ZxlAcwCV/35Z6UfmU1fXHmcBQjZdDzmtK96eT
         cXVu+r6tgY4YK8HsII8UBJXtWOn9/9UR3XmUQMucwdmYhDtASh33oeZkeK1fgquCAznl
         lLXIbFmke+josry3QzwyFki0c3odiIKjRdQ8cZQOM/CbdGoq7LwKW8Gx31L6O8fjVGYM
         TyGcJ8WkYWnQu9jJSXEeu20rdRJXE6vfnbHJOmQ/bs6lZB+9ev7RmRZjWAQFZRXtoIpm
         YWouoKOybokwjorbtDqa76n/4raFoGtfRqMUXdsS2jN74vapAN4wBXTttVifI7G/D9tU
         8X5Q==
X-Forwarded-Encrypted: i=1; AKwUvByJM5wUHHHhhQ9+HnCLcnd1Rd7WEgVAa1KtSJY5Clt353V7yX0P/ivyBnqgdkSSBBbNa0glNdDrid0rU9Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdqBPXj1V2XgDU6qjD3lmiPbY/ZsmDQ6710x5sHKUeUgqxwq2Z
	G1DhOsiLt+DpyGvMhSXDt5GPk1BkXYhMWZjujEQBWlTI82HzRGCd6gZr
X-Gm-Gg: AYBFou1QXMLUZHyJX5dG9p3DtIE9MhRTLpvXfU8+rq+R6G8dJMs/b2FXrv82Jdq/b2g
	jqd7MimelLfH75vjW92J7KmaxobkKhZdWDR/oCVV1Ry6FgjlC8c2j3P9mDEkeWw1IiVDXeIsIVQ
	hHcnBzvp2zfJATGKDRDmYWBfYOe4id49ODTUdt8zNYks/ASZVCVQXAmLea1xqWGhRMZB+pnpn3S
	6Rur4f+a8MCuLeNj24PcI3gxk1PDQzISk2S1EkVpgmelCwO0WKv0RImoIFO0sgOGyKzN19XNipu
	ZjuW1uG6awb9J++HxDYdhAmg0Wabqzx/gcw5nYr9cAp/L+sjeHC8JVc5FlC5DmoQBeMXzCSM/Ph
	ry9VXfR+t6OxlaDg014AGqRRHD7wUvwuZz1N/Dcl72BH/HaeHGLsC6w1RKho0DSctxDEdxpp1mo
	T7Dn30EVoM9RsylbowmQOBahwZNH7GUF6fYuRcrctq0E8OnzP7YMIzirFcBBNQBIA8A/qey4/4O
	gpsp+21w+9VFwDHjYf848Czdj9OdVpaUb9Eg87LkUH39nA8gVYiN01cWeYHQ6B6DEvhhJlw9lq9
	s47T5js9Li8Ao7MpEJ2N3V0IJ/mpT5w+s0+eReCziYYbf29bGjKwfPsOJfD6r3RFgVtyaldw468
	uuuqQ4QCHBkKDcKGGhTb5QoOQDOxGVhyCo9gOomVPcHyTbKTJLjlkzGPgXMTusLIjxftTMjvffz
	2uchm32i3W4Gj/R9GBawWlycrcnku8f7YxP4Vwtj/g2/Y4jJfzfZ0=
X-Received: by 2002:a05:6820:1621:b0:6b7:8396:f3cf with SMTP id 006d021491bc7-714f29e457fmr6317068eaf.49.1793661278004;
        Mon, 02 Nov 2026 15:14:38 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm10134463eaf.4.2026.11.02.15.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:14:37 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 16:14:28 -0700
Subject: [PATCH v9 1/8] serial: 8250_omap: separate locked TX DMA
 completion processing
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
Message-Id: <20261102-submit-serial-8250-dma-cancel-v1-v9-1-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
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

Separate the port-locked completion processing from the DMA callback
wrapper. Keep the shutdown check and locking in the callback, and retain
the existing FIFO accounting, delayed register restore and THRI handling
in the helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 4805b644ccb1..b6f108d34854 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1080,18 +1080,13 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 
 static int omap_8250_tx_dma(struct uart_8250_port *p);
 
-static void omap_8250_dma_tx_complete(void *param)
+static void omap_8250_tx_dma_complete(struct uart_8250_port *p)
 {
-	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tport = &p->port.state->port;
 	bool			en_thri = false;
 	struct omap8250_priv	*priv = p->port.private_data;
 
-	guard(uart_port_lock_irqsave)(&p->port);
-	if (dma->shutting_down)
-		return;
-
 	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
@@ -1123,6 +1118,18 @@ static void omap_8250_dma_tx_complete(void *param)
 	}
 }
 
+static void omap_8250_dma_tx_complete(void *param)
+{
+	struct uart_8250_port *p = param;
+	struct uart_8250_dma *dma = p->dma;
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	if (dma->shutting_down)
+		return;
+	omap_8250_tx_dma_complete(p);
+}
+
 static int omap_8250_tx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;

-- 
2.53.0

