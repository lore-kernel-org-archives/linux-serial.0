Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795272;
	b=L5v0Sr/iNc3xReT4n00SoDjb9Rb7QrjfX2ORVjx8+CDWMDUKB18A/ueFpmR3RL8KWuRF
	 aSowVkKXGlFNk/gRFsntxi4obbOpBHpxaCC98TP3Dfl0tIrHUwJplQiaJkzrwWfTy1Bs+
	 PbpDYl2y9LSVzMP5K4XJpkv1sihpFFZTKCsnIq7uatuPIFazMXpE4GciDCFEG19I+xJTL
	 An/LBAeFvD/XUufjJB4Z7PZJ2wsFG1rRO6zL42bhhdoU4fvuVIlaOdAcIhRgAwJHYY5rM
	 aDpafsfZXq4cfWkYF8ARKM1k3XWFgCsC/3D09iDnAB6eAiufBaXhhkm6memjgGC6V3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	b=tjUrQT/4J8MCnYZkqZPNtNmo9zkGHxQQdLvuilv7dGz99V0yIgWxVsUfb/Dw3wRHH96y
	 go3656lyxual1HjxZhHSFFffstubYLyqz/TaSM/8oZlLk8LftEQPhQh4etTyLzyQwW1sB
	 fYd5Bq0palt3HxH0uONGxVwRUzsUDsu11iSp26/b7rxdcVYO8V7Lm4SeMqvj9ZUfwPO1v
	 UTdW8ucrloC4ekdw+IPwIiIk2fi2MwyQdEtTgjnbGniNFS+Ww3E7wp7REjNtAMwyDlXh9
	 7RJMOei3SET4T7k5MOZ6MUBIt00wPN/11YGOg3alLQMN0sd++RHcK37UDWqx9CiMB4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FV7ECvTa;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F270606A327
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 22:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F270606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FV7ECvTa
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-46556b9e02cso858404fac.1
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792795271; x=1793400071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=FV7ECvTaiVixQztjBBpuZXi5gImCogaIy6DJ5ak5iOSVc/NuVq3Nfk9DRBYBPkeIeK
         FklJFz4xWAsLbAkMxSFQG6nUKB2wITk9sgeGz4Q3vAMT+IaFZuYeH5+sypXfpYwGbMnJ
         7M0rQEuT6v7SxgvS16QqffhCR4WfkbGLW8pxz8aTGYuTPQo4zOu1xgB/mywaZJIOo0p1
         6uRQZO0t2PsOffzeCVvC8dGJNinqhvPLK1L4bIxAQmKHoarmcO0iDRq0XL5ZtojvpYdC
         Uqgn1Ev40EpOXz+l4RcyrOqgZkJ4RLIcQmofrftoHbD03cjYoaHig7DAzZKdnFFk3KTf
         0nJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792795271; x=1793400071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=1vbWNHunLJTENZqt0/OmGZCzVDElhPhOfgQ+Sei/n+IfNATTiJCPIJX0Az29EdJZyA
         CZvuEpPch7VuXPGzUaHnztBjc8EghsvsHakjlW90iVu1g7OE30DNGb7HfOqqQfEo6dKd
         obZqdelxb076816Cf9GN8HVXyueSpsn1pPh97+SFY5ZFMNhBf19ho9vvc6msA/SCGAhu
         yFEChE57coHLdSvVgHtYKdJ10u9rN0nWIWcpuX9VQW9WuMH7dXA5pFFKbCV265so3zfj
         VNbzzZxU8NNXpPepqCRVbgZnN/rFRI2+jUabCGlLPM8HrGXHta8q+gUd1WNMpHUqdx16
         hzQw==
X-Forwarded-Encrypted: i=1; AKwUvBzga+1VbMgdR4rzx+j8kw79pI8a2JUT8o1IyySRQFLMgRM/vQlNR4oocoJFv0UCgwAU7LmGpZcAG+R57wA=@vger.kernel.org
X-Gm-Message-State: AFq9FYImR33mYMlS4udt5R6X8C7UFOg5GW1BpVv99ZrSFKPwH28HhYBG
	YlzZtexcaPPlPUvU+QigKPMf5bHztDL8dR7E80POa+sTzn77AUEPOiYf
X-Gm-Gg: AYBFou0wHPv/Ur37c3TVfgQ6oP8AY7KUxCfUtnLMdkWITX8atL4Rzd7NzSe7PyP6B97
	YOKr1DfiW0LC4tSh9VgfI//MdvgJfaBwFQ0YewTVDIDATcrm2nnU8tO15KW8gdckSbnYgzjpzld
	tvM7qI3MHfDu4cKsxbZjjOcuEQOVLSB5VcFXntXcKoqorb3sqlwTZ14kwmgqWtYiQHKRzaSKTIr
	xPXdCEWgxT4kDvxp8lBjPGUp3n5wju8GIEy+XyieVVpKa+UdOlGnS71hK3xB63YfP9gjznaCe3d
	ASEJBAEuS7hJNkxnR6FeTyyfso0RiSgskMr1VXMPzsPY6O+y7VdlmnBJnn5P00jVJlZ3PyY4u0A
	/x/xM916ranXX8dVKCIL3Cn/mPGS/8ga3Xdd8S96/LFA5Njonl65vYmxYOHQl4pwHuWU3aXYkWJ
	ghR4WHJRVWOt0uwX0yhaskDZYrTMKInuROEzh6JlpOwgo/r5dF56Ndjzw9eB5meqkT5PMmB2cg1
	NdBvmsOMuFtkYRUUlmnBA3Y+vHwxH5imWs25hSJ5y//6g1mk9Per5hcYs5mrLvz4b8XMUk6ybnw
	HmoMcr/R5wrw2Q3p9Y/NZCbIsbntEp+sy39cl2Br+oHgL0ykFKoeNfUJ8lXLYOkqOInVfQtiSAp
	+7IFcUQMotqN+neQVZ2VtMxWg2r+UTBjlpG5jGyljY6wOdDnSFqCIXyCsOAsxSv+6k/Ub4qlmOU
	a37/8=
X-Received: by 2002:a05:6871:d3:b0:48f:e0f6:bfec with SMTP id 586e51a60fabf-4a83fa4192bmr357118fac.24.1792795271013;
        Fri, 23 Oct 2026 15:41:11 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8431c012esm226213fac.11.2026.10.23.15.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:41:10 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 16:41:06 -0600
Subject: [PATCH v4 1/4] serial: 8250_omap: separate locked TX DMA
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
Message-Id: <20261023-submit-serial-8250-dma-cancel-v1-v4-1-e759de1839de@gmail.com>
References: <20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com>
In-Reply-To: <20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com>
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

