Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5D339858
	for <linux-serial@vger.kernel.org>; Thu, 11 Jun 2026 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149169; cv=none; b=F594eH7MLX3eYL7poxGS2PFvdEhWSOHJGYo1naBj68/sT+G1kRifOrZplF0AzDmrTPUQTMSAZecCgEtZ+MQxVTbE5crVMYpb+2yp2A9vr2XUh3X/lFapA1DGZRUqfkQb0wqlBft3JDTEQJRTfsT5aUEWaL+jcj4bQ5ACA4B2ycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149169; c=relaxed/simple;
	bh=cmMm1p6O9Mp3axJclA4sAP6G4alWEw5/lSU36Eie7X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKRDW725SQJk6X+A2+xbr7PeT6Pjb1rqadgvVt51fCcdEh+rzGC/g/uen2BrBYdAgenJ2O6Wbtb/I5tT2VPNVoZzcfPaCIk2mdpOt425ziJ9xfY7+PYoqTkAnx23+tM3n5vDHG2tUY6wlXm1RQQkF2ipEsx2NpPb0qkKw3621Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai0cgQfP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai0cgQfP"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842288702fbso3151990b3a.1
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 20:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781149160; x=1781753960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+4cm9QbNYmcZl/MXjwCiNY3TdxompycqRGjEnRpi0s=;
        b=Ai0cgQfPlGbsqJVFjJ6ooooc9vvOirX/FhsIbeh45iuQ5FSVURM2ADxO+9I8gzkNHf
         7V2Vns1VsBlLr4DguY6oFSDJ68r7hy7WAUwcPHkEmVbYly4s5bA802zivt4ZcMp4hVMb
         +3o5va4aP3NvC/HEgV/sIl+78IH0wNX2UowkTh5qWhWFkTby8SGnRYP3mvzKsuWwR5YG
         GFhlCurePKydVAQdmH4zSU9NkSf/hgpINMh1IVL0Mj8N+cYbPrMcqqmMQvB8lboTmhTT
         xaLk3CexHgpWBe+pmFpPBgsZZ+cFivNeMGrhCNQuqSeTQ+na45RY+hV5llFvBJEbUsvN
         dgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781149160; x=1781753960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+4cm9QbNYmcZl/MXjwCiNY3TdxompycqRGjEnRpi0s=;
        b=Y5ZRToSy9O2XMwmImbyIN6Z20O7zqIwHWR0fKJzkI0Y8pgB36b5RapBdL3neP1OIpL
         +RjMH0dAy10avkSxxOXg33bzqli77ixrEORBudzPIM47B9TS0UdbARUcWC7GHFX3Fos5
         qBkaxfis0BYyZZrrDxj7LNMCTApByBG+3A0qP/vH2rpU0K7G2l/7MmgTum8iyFd/2h3y
         m7+5oUYcSKOw25/CyORFBNfUyOvwTFWlm8nJaLsyhNGrCdHOdL73TOTnFxSPzCtShGQH
         OBRKu4DNg1ETaaKRxli4nMIjSus9vIO0lxcmIOTfJs0AaHWU7OlNmi/BydZmiyFCrQ9A
         CJaQ==
X-Gm-Message-State: AOJu0Yw9FnbStLIsJLT+vhUprNq5hjrI67KNR9Ml0FWGYjL9vYxLQMQB
	GHE7PoCqFg3Qsh0mdkR01zjpVTEjAipOI79lAZOKjn7ohV4XRPnLA6xsFSe0ig==
X-Gm-Gg: Acq92OFCEYflFu55CpCDQNmVYqKfmOuxraoNxoe7op/zu9RF0EiXCRIP/hEavJ7o4gi
	zhAzdMv+hXhXcbf9hiJyJ9PfR7m6Rbq6ze3Rhoaz2PXSLnNf9MB073iV3NBtLHT2nluJfMR1Z9D
	Ihq9l2YUoAybvXpzf8Zbx2lWu7JT5St/UlQqWhfIp9wF9Mb8iNUCCTe6jRhFfJczYwoCL1fFpZB
	h2ooJNHBrC/bB7vNfWojhWeiQoZ7RK696P6eomuLW9l8c21kTka17djC0vBYLJShp8KfY1kHniI
	chKeJMyYmwOPCHfSGzkGTaR5YmmKQ7tQ2xPGid1dtl3FA98CdXW1mhmzT4IsYmmBtxZJa51hgSr
	S3NNNhhbFG8xfYH5/6KBH7qZuUELEuCbXmPx6sOrPPgZ0i3Q52336xJx7Lt7STwt7YPZwbwTCN2
	M1tnaP9yI9ITxa4j5mzJP6oLcD07Bttu/VLUl+2k0rOOnwjktQVKkC5nY5Idaxk+JOurdrHSnUH
	K4UhD6jhAMG2ItG7Ch2464yBtPiZsPOfRbytu9EYSdTPQ==
X-Received: by 2002:a05:6a00:194a:b0:842:5ea5:5ff8 with SMTP id d2e1a72fcca58-84336bc62c8mr967189b3a.42.1781149160353;
        Wed, 10 Jun 2026 20:39:20 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bb47eesm334548b3a.13.2026.06.10.20.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:39:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Subject: [PATCHv3 5/6] serial: mxs-auart: clamp RX DMA count to buffer size
Date: Wed, 10 Jun 2026 20:38:55 -0700
Message-ID: <20260611033856.6476-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611033856.6476-1-rosenp@gmail.com>
References: <20260611033856.6476-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dma_rx_callback(), the RX count from the hardware status register
(AUART_STAT_RXCOUNT_MASK = 0xffff) is passed directly to
tty_insert_flip_string() without any bounds check. Since rx_dma_buf
is allocated with UART_XMIT_SIZE (4096 bytes), a hardware fault or
compromised peripheral reporting a count larger than 4096 would cause
an out-of-bounds read, potentially leaking kernel memory.

Clamp the count to UART_XMIT_SIZE before use.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index e2b656638ab3..fe48a372d022 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -823,7 +823,7 @@ static void dma_rx_callback(void *arg)
 	stat &= ~(AUART_STAT_OERR | AUART_STAT_BERR |
 			AUART_STAT_PERR | AUART_STAT_FERR);
 
-	count = stat & AUART_STAT_RXCOUNT_MASK;
+	count = min_t(u32, stat & AUART_STAT_RXCOUNT_MASK, UART_XMIT_SIZE);
 	tty_insert_flip_string(port, s->rx_dma_buf, count);
 
 	mxs_write(stat, s, REG_STAT);
-- 
2.54.0

