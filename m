Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715663;
	b=Rc8HkJRF1H63vQ06HhERsZLkSKhPwDWLHf8UMX9miD0mrJB1nQ5X8g0DABv3XgTxLu/s
	 2l2s0iVITzYDrS9IAMtFYg2cFFQwu8IxmK8jkaDgFw/4osYX733RhJL9XXEkXCnhDnbER
	 EoGgcLBxbEjaYAsOxjGZJWRatdSdydjyMMm8KT7+CkxDcr0B7Qp2M6+ACQxNUb/5vK+4f
	 UW++JRT20Af+i6kfuHqqvM5Qhip4wHWABIjdkL9dzjhNzYd6eCf/emzdoaw0FVcJ9sQ/f
	 7PoXgjQiPhfXDR2E2udTK+TbMK9zz4fSPXukpNjG9tsGTNN0ANHGv7g9Al/Wkj4LUNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wOqIFGFfDcVsYZmpTIKhCRD7GalMgIESXWig5VjcM88=;
	b=v7d4l54xrXgCoRx82Z3q69ATB8TS6cAD9rbiBe7h+dPjaJqtQGdMKutAosfXCSQPz0kY
	 M8Z8S1mR0/SKa+xY2B71e1ARDipy9M7R0S68FPBGAWCT+XPk2rwhxoxqyVkBDzMXALCeT
	 WybbX/K7kHQYzrimNPjgzikb1tnohIrGQcJb5hwIg7/lkSuPdfExYWp7v55P6bllB+F+H
	 RUcPZnLsUJyIMIxzvQuhSPtmky7UDr0TkFos5F4A6xLA8jJTjgXAPqRpCMK2PezTmOqln
	 ny+mIpvrRxDw2E3lWWhP4HIvkBH3sDdjGrRdAqm2tpsCyqki5/nPK7A9gYs4bXmOr8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H6Xz6qV7;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD25606A321
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 00:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD25606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H6Xz6qV7
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-703be215729so194400eaf.1
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 17:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792715662; x=1793320462; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOqIFGFfDcVsYZmpTIKhCRD7GalMgIESXWig5VjcM88=;
        b=H6Xz6qV77D0PhKeccZ/JLv02ehjDKHGE5HVbFyKlA5eAg3yMvgUHVsRhKC9ThGO4CF
         CVef/LaKAAAYD2zGDFI5XuPJZ0IN847ZtmnX26jYVfo/gBHB9VDEr3MPkmG/oeJO9cWq
         /qmmblTv1+LaFIsMW0nom19V4ypYhVBTc/MlSHs91SIkWT9qdD4xdEynEZLSGxSOy61G
         QrVzhID+K9fui4pVbRhXxRowJV6IkON/sAFygEgNmmhmM4ZhwBR1GwiwTjU/kqVs5WE3
         7JB/H6FNvlg+GQwMJpcmo4e/qnvWMULA4Ls9l2cuxgYjJ5Cb6mZl3AxeB1Nk56w1IBRK
         t1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792715662; x=1793320462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOqIFGFfDcVsYZmpTIKhCRD7GalMgIESXWig5VjcM88=;
        b=v04lTqWLFydj4FEekenYIrux2HCegd872d+YRxTWo5g9r9oqMCl2nIVakEcPieIk5k
         uYMqfz7dpkxLs605cyJF/vZLz1mxkrJ6Ff+R5Ez3Rb27T0fkUaBDlqJcw2msQlLkgWUZ
         WhETwyp3Wgyd3b0OswfX7ChebNXf4x+yPXG6JPOQF6+7JuGbhTJEjp/ZR1Pnzo8Dg3o9
         dUIcr3iP5M8Q16f40Ud7ChJIvcDBJSZ1dSiDnLIUcNBk6aLUGs5lcfOegIak74DlQqIp
         KYShmmGO3JsMtNbjfYJUaezuJLwbpTSgt51Bdnlb/J17Fk2IXUcKyMF1eC9YdPd9IfWc
         inGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzV5ZXY/UnwSZ910p0sdY4h5hwOQJUwX22falRIvAIZtvCqacmtAPDvGPgIL4ipd2fwHq7zOidixzeiABc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAjDy8GkZHHVOgPvzgO7FVh7z1sPBl6Gk12vNDsL8vXTDm4lnM
	y0WzFFJjCJ0K8a4wR7T1lhEVcSfLuryGtpMqLAZp7EAPOTq4YU95cHWl
X-Gm-Gg: AYBFou08xSNKciZaJxjrW4ev0HMkkMm1n3NnaPpEn1r64aVSGsxucu6CYrSydeEIggz
	pipt2aOQy9CDUT2HaoKpW52B96NjDbApuaFHGzO7Og4FpC0SEtr2xEw7A4ZaLmb/Ab9s/4sILC0
	kY1alS7CVhlAWxyN3yPND9GjIFD/ATQnJEgbJ5yLlptAHYwXg6oA0MOboCN5aC8oAzbomnvYXIM
	JP3rUNbDcFtm2nndzm2ZhxJp+a/aS1u1VW0+G1XIUP+dwtuhqnBclndmDDu7V0BPXeKwqBXsQ9I
	BUgKgdyDupMZXBcOAvYSqzb2OFrpv3iWxoAJxlCi0GSP6xjAqn7CzuxMYgFQvgTIpN8jPrQ91p4
	igy5vkV2Q4T28hdsb0zr/UiQI4wnjwfCk2jQZCm2h6xUOcM3VxIGHBMsiCJO12rh4rPl/ONtd9j
	BsE0HUxcyrCEaMmWfWNRddw3YXn6tFgR3rAoJU0H0H4kaab4om88+iQCn21TF+Wgl4bV+oipLbw
	dTlXKS6FeS6wW0pD+k97NMIJiOyp+CvxKcID0llgcS7TvxWGTsbt2A2pNzWt2USVUV0A9eKJyBd
	3FADmUasMv/lcgB68+hTQI+vXOUPUB/o3whLO9tqGkSGEui3Cx8puGN/ZCoO2Ty6QpuJDSPpzm2
	r84dvD+332d2x7QK2dDokRtQNaaqDShA7pMHm+hsRH6H7uTS4a5jxi51hNnIfaPdJPeCOU/ihkt
	N0nA==
X-Received: by 2002:a05:6820:1689:b0:6dd:1d43:8cd0 with SMTP id 006d021491bc7-70b88aea676mr690857eaf.80.1792715661900;
        Thu, 22 Oct 2026 17:34:21 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a820a9bcf6sm459716fac.12.2026.10.22.17.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:34:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 18:34:02 -0600
Subject: [PATCH v2 1/4] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261022-submit-serial-8250-dma-cancel-v1-v2-1-088ea51e3891@gmail.com>
References: <20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com>
In-Reply-To: <20261022-submit-serial-8250-dma-cancel-v1-v2-0-088ea51e3891@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Separate the port-locked completion processing from the DMA callback
wrapper. Keep the shutdown check and locking in the callback, and retain
the existing FIFO accounting, delayed register restore and THRI handling
in the helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 4805b644ccb1..46f1fff361dd 100644
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
 
@@ -1123,6 +1118,17 @@ static void omap_8250_dma_tx_complete(void *param)
 	}
 }
 
+static void omap_8250_dma_tx_complete(void *param)
+{
+	struct uart_8250_port *p = param;
+	struct uart_8250_dma *dma = p->dma;
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	if (!dma->shutting_down)
+		omap_8250_tx_dma_complete(p);
+}
+
 static int omap_8250_tx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;

-- 
2.53.0

