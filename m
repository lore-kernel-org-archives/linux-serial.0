Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144395;
	b=kOc1/S/NPiIf74tRKLJBFweR+IpcaSAELZS5FrSJJ6V5QcZWVkFf1GYlvRXCLX/7xrfK
	 Of2bdmIOI+ZP7ukNe4f7aR6IE0npFCm92EaiHmhMuuUO1w+xMUXeKTbDoPnqrN4HZNSN0
	 P/i5FTvdyUAbLr5Rhws/j4MSC3AGJktiQPafnLLyXJAACTafr2XBP3lOeEsR7nVN+W0z8
	 CBpxBzbKW3QaA8Pef6/FOhb4mWFWh8+OTV9QSXB6xRZWVMiWNG+vQtwR4Acm42oieZiCm
	 5qHzZ4kRtPmiusuKz93M4Zeblnes2CHOIIa+Yixisi+NWBvOmUUGfwOOsvPNR8h2CMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	b=vHQV7wL/aumRGoffhNRZLdLhZufn+d+nRauC9VBfPI5G7YqTpSvjBxmwvNymsXI4upMW
	 fBc3uRglDErxl05i52IgpdKKa93wL0K8bJeT1iy3i/6IJ6Su1vgkz79LtaOUoBdsrLeQS
	 Qe15+acSJAQy+WaXOat/Mjs3i5+prF/U22O2tC+PHni/dSNsqqveGYS/l76CaIFhiv9ns
	 EYariL/3yfrjHPHxwX4HwXgFaO1brHYsCTHnOWYepk5mjJ1M0G5142zghwiwygLZKZixA
	 1ZUOUbpnfXorKrCL+LcOCSe/0eQud40UMoNZEXMPZxmA/gCqJy1BzPXazXfs3NWW6PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qdYhQ3R/";
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3C606A322
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93D3C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qdYhQ3R/
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-84d5e56f876so296266a34.3
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144393; x=1793749193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=qdYhQ3R/n3DzcCumCOhrFW/n5TjZH5P+HncGKay9qiDO9UZmBQm/zQ2sj+2AtlY2w6
         2sEnmq38N8d/1+S06QpS157WBQaVslaN6l8YTy5W/VWOdQHilbBouyB8C/PYFA7b8WSJ
         pdNhG2tgjbaX3QRO2ppdrv9SH9ifa8oosnT7pJXGStEl5jVKYGlFghJrdiCf86Hk1Pet
         eKI/ClAzQ/8aj018Gk26LNs/DgsE5Dd0YRRGSJ1CfPD1jUpQi2DOPPtgmO8Gdy8y5gbb
         p5+QFqjhWlz/HrqDK0OpUCa0m25RQhw+rRNuPQiU+OrsVMuvxZJYVXxbrttMU6znYLN8
         318Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144393; x=1793749193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=UB2ojQapKdi9kLGpEY1ndFW78MfTkicNMcpfxlAe0897UA0p64RU4kvNs+BTBcddVc
         1EZc3ZYQEpJtP4MHoE2+wz8jC4o46X2l8IstfPH43SL0DX64BrDA6l/jjl+BsGl30QbC
         gloDqnykpWsURoz7lqEbeXGWt5tYcJCSRufOd7RDrs9yxwTemSiFaAxKKpdEuUQ3jmlE
         5pK6YQrcWAXD0uX5NQnZV8WWpqh/rI2AJsy25sFit9gKGyagoo2Y9kM4JPvGi+UbTUMC
         5qns8jTXJMnEw3k8lzx6Po+AXtcRLoIalk5KyFbA1v9Q04lZn4jYuKYe8UyOyQDtMw2R
         J1RA==
X-Forwarded-Encrypted: i=1; AKwUvBwBzugsV2sThjcmEeHhPPJyrdCje6qP0TuxVUL5mTnchzQV+ABduTFJz2lVtxp6f9pZkSdOiFBXPk9Dne0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhH9Cuxb2QWSRoTpb+LM7P91kBd6Hqzxz7BLPMpqjUIqg1IRvR
	Gtk5wuxAPpeXQCGTzNJx6m4ZrTCZMiWjDrpvkq/glI48BCa/kkGrTwta
X-Gm-Gg: AYBFou3Ghqp/3rlc9tgCgszcycT2u/ZoAnjgWuW+ph0kcbo9qqMZaOtGCbnAVfaBPeH
	5mJGQL10RZ+tKpckeHut65t7sN6P6YBC2rT6fZxMfGGdIh/KrKVA6PzHAwfilLc4BKnGlYT4XBk
	NPckml0znAyQPIurqL7uRmdpWk1+7wg1cugzSNA3iJTpYs+L7fbSrReiyVTj2rAZg7x9pZZqIn2
	mWTsHpWZP4/GSCu3e1OQOYhm8np2q7KzMTtufJXdFpd3jBHPU1MOUxWMsXY5rY2OAecOkdZrS2s
	watUywd0nNiIgilqhmmEkBodZDXe1MVigJhlakknPfwYTA9AxLXyKIov6utDd/8qQvyF+qGQulO
	Fq4Lr9+JYBtYYtWoNwxAMxxGZ7XT2jrP4SfvyflK0GfU4WJvMoM3raLT8eWgpKXzzti5F4uHEq4
	R4rdmXL4F+KNokwKnHc6UIPzePEiYsJG7h2d0TfAQP+Cw+ZqJtaGGjtqodsuFCIkRW/OHfCYbF5
	DQhHHHHkEa9apQ8qHKbB1/bI/B8SIMwnxR918xmCsqveYVJgdYytU8aWjP9++j43uf0oBlyp7LZ
	ES/ik81jiG4zJVYH1kUk5qVWcmff6DsEzIQ4zNk/Nx51Bg4W79LqU0G7fHii2ReXfQQ36KkJagw
	+uHkZXNV43t5F8j6ajylxVyZLlLD3IW4Qdks+8gSISjAXkezpZs7WWOA6CnGyWf5E0Pw7f53OWe
	7Nr1U=
X-Received: by 2002:a05:6830:25d1:b0:82f:5471:4dd7 with SMTP id 46e09a7af769-85ac11bfa1cmr895947a34.30.1793144393599;
        Tue, 27 Oct 2026 16:39:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1fd31a6fsm62836a34.18.2026.10.27.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 16:39:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 Oct 2026 17:39:46 -0600
Subject: [PATCH v7 1/5] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261027-submit-serial-8250-dma-cancel-v1-v7-1-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com>
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

