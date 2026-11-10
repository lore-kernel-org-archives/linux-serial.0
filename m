Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283237;
	b=bIcFD5uYgtdWdjMDb/iNsOqTYkrNPjsKuLrcdCVDGrMUE/pe+YTzzJuIftnxCLiUZ+Dx
	 35CSWk4XECZ+dXKItO8jXCBd9FhwuzNGGKn27CuyDIHCX2BHIPsL9ZSOVU9kumSbun/Fm
	 upHzx7qhZhrTkzvwo8GvEei3KG8f/tGEwXQHtmBSHps2RnIKCtwazrPv4bH8CiKg740UB
	 FHFmCygQZIgR6lhHXnhUqUEg3zxL+gg4C3bj716dyXBoZFdSeX9wuubmcLI+tXLaP5f4I
	 G0QUVYiEsggbFrOZVvyLBJ723NGYZhZ7yhexxokoHxcsBzNdm/wH60z0ugAxGxBeQxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
	b=CJOvG1XDXSlClPNNzBowO1tryO212myCjI1fTn0zV5Dq27/bgMe8OVtchepQvVlV3k3K
	 ApEUI0CRLH60/RZHMVDddp/ekbt3GlsPFHGZjCe6g7BouFpdl34CFk9YCnkFa/Eu8AC5I
	 Bcb3/k38ppIVm3scyRpfS8UKt9DBAdtzKE/ITjbUU5rTHfO69kH7aslFdHE8A2uB9I11w
	 RpAml9masgy93/SAerWkN1xQMhqXd/J7Qqi2C7BQWxXMwbjqKU5EBEviyW3jAueAGX4nl
	 eMHNQe2h5D50rCnYawF49jq6BQmP3LzW+G1cid/9uHJiVSZgdwI4VDUdop/49MSXkig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXeMNZnr;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B31606A330
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 04:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B31606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXeMNZnr
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8479f46ecd8so803281a34.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 20:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794283235; x=1794888035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=DXeMNZnrr8VqdcBbA0ovlvTA/oo087KjtFXzzsfOZS1Fo72TnIEVZgJkvAH6uzbs0V
         Y+WXNrf8IlbxwwDimNycJg5PyqZZ1GanJRpqSpVTI0ts42GazxswJk2LNu/rMZbpE7Zb
         8y2XNAxb3EPyrdSJnvnPi8nGozKHyrNjiuTXYHWTNnLAgdynK/2gYKqTDKcZdchsXmSl
         m31x5w0l+cA+LsPTJ7ocbgaqyYmgzvuq+YK8U9VhFdY4o3qUf9aL4S8sVOytGgM8roTn
         wd458Aa+Cw+GO/YlLOV9QPFCvFv626WhJdrvv1Jf6dm0VB+7Y2zjD7tOZN7vnRHtpmcw
         QJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283235; x=1794888035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+f3wqnZmmj2eYXbJU0o1qM9Y+NCisSMFy31udWGduqg=;
        b=iBBNbBUEkpontmhCF+QKYzvruSIdyuxhF3ZzVP2SKs0xKhtLAMjcNsIKQq8F9kotfQ
         SqN3fHSv0Zo0ibWWDqe8ATNKGzeKC1hYw/6XzeLegoKoOPANG1pNzmJWPjx1KF8n3Z06
         8+pCKiXqP5ZD4FDmFI6HerjT68DonGrlR5NSeT4arE+eNiWnuxPoGQ7p3ICIrqVUOstP
         HAwkrMVm8NiJQjgBpe09czrrL+V1PCqIJ6fho8l0YxBjQLyjismwj4GLshWPou+3HhUL
         0JYxBVM28h1vFn9PFm5wHCbFWL8FRqbX1KWh8Rs6JdKzUZCcm4yjDlkhngkqY3Sgd+p1
         1bFQ==
X-Forwarded-Encrypted: i=1; AL+hErG+WRDBlAE5IxEm+IKmef6eRVFZySXDC8qz2g12TTZnoQeSgAQm4l5ILCd5RMlZyFuTIE0hl38P0ppY3vE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/84esm+zAFLj9amKxHHnN2T+r92E1Vrl/T9XpgpTh2xcl6dfUq
	49vlmBb6j41MLH94AV71N6nBsEdhZagrwc4oUCDYtnrwBYZ0G3E/LjDD
X-Gm-Gg: AYBFou09ek5MFF1KD/3OK9Wz6OztdxHWqBQNMzGG9xjZthGOY2JlyNmEIlv9jhqUr/P
	c2SdCLhJXD0ppyoF9Vy6kMf0Xu0LF4IWr1bXFdxkGtiOyWPJmzQMljh5yJSTIkzfdBkhItG1UFT
	skdbjB8119L17nL9UChLkxSRfkyi162iCV/in7uWBSvtObweioSPkDFR+2ZXPHLLqK2SPkPxUC0
	4mzusgQw64t41/eKziGHJ+JWdNYABkMAdurrIyWRTrybfZ3VlAXFOZKWcVhRUDyvKUcc6+LpHKW
	ylKNE4UsKY0xGfJj6jAMtRMPwWXCtHxlfIOWfxamIKGbF3EfTnUzw/0dkFmFqLR/6GaTfHa49V5
	oW6Q4u9XPn5A+e+DyG37uRf14NDnz23pvHWGyVZsA9Ngfqg0MniHDeBEdGHdlNB+sylgXRJUoj5
	mD5a7Bb1l1OxHwTxcAfkGgzQDf7/EuMdai9phHv/FqY4l9uhCLX9P5814TIJFmbbRmZzVnFgUP1
	tqLILwW931fQKkIL3ceALTp0N5v7k7CCW8eKIWqj9ZN3Pq6wvFFau0Yjz5y36sMsK7pzfrucpCF
	TXBZDSXq5rm4J73tVBkfK0lL5/gKwb1p9k5V+RX/xqsJb/klAe+EfXlt+abG+YOWWIebFcj5JHf
	uyYwuFcrbjoSnGPEt30FghEJ8V0D/KBEZ6q2pWqtntU/ksjRhnkO8pLm21/lUJeX5fnm9uyuOVK
	8QGYp1yKwciQdwnSeiH4pTb7BMtN6nA380tlvwf3HOWpxEzi5I5Jy6rgf6xFug5ITeJxLqsKx/
X-Received: by 2002:a05:6830:906:b0:844:4959:e856 with SMTP id 46e09a7af769-860dc7c3282mr1426887a34.11.1794283235287;
        Mon, 09 Nov 2026 20:00:35 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcc1d759sm1028178a34.23.2026.11.09.20.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:00:34 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 21:00:16 -0700
Subject: [PATCH v11 1/8] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261109-submit-serial-8250-dma-cancel-v1-v11-1-6364edca63d6@gmail.com>
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

Separate the port-locked completion processing from the DMA callback
wrapper. Keep the shutdown check and locking in the callback, and retain
the existing FIFO accounting, delayed register restore and THRI handling
in the helper.

Reviewed-by: Raul E Rangel <rrangel@chromium.org>
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

