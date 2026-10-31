Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793460435;
	b=Hg6pMZoxtdfq5M4J724a1lFU7STpynVMoNA40kGJw9/WKO80kTGeS87rOUQ3X0hWSi6i
	 zIw+4kZSX4DuKTBLqGF9aw20n4ZbaCoDD/bLVkheYH9L9RAVo/Z1jwqZkp7roTB3W8U+m
	 w4t+89EMpW7+9chC9yPADg3zfBUdJzuK/CBp5aLx4MhF/1xiJIlRl4AGoTKdbYjx1MFm8
	 LCJ2k3J4qoM1a6YDx+lm1EdpVpzDadBtkXffhi6DuN10dPq/hccxyuVQswIi3laWM0fnM
	 7yYFmQQEHT+IbGiopiXmCurV9V25NNxUXJa/5GWyaSsRdP308K4r5x+EVON7tEdGngA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793460435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ApVcgRbUJOCRqk0kM38newz6TbCCt9oxZvC4V9s3//Y=;
	b=069ZlwM+cY+vWr9p60cRh9bdsJBr1Z0AmXqEZXzdPbuNZslvP9A95d8grg9kO0X1MgHW
	 4uvH8pVzvXFZ9A08md0rAgtd7XW4pYaGLByws8P/ulB9PONpZdG988ZQN+KKY8oaiAsyB
	 dFBDSJlO9nvHcWsjECxpzXtuqRrzoNEQqip/fIe24dFK8oKfqzbGgIQs9u8l6bcT5ACVQ
	 gie9YPo8oWGr2OEk5OPw9DUnbxomthfOLdS4Qddf8ae8WZeRdhHl3pCRgXjNTJUUAoyG1
	 pRU7cZ6DJBxL/S5IIwUFmpGMdpIBmxigeRyWk2BZC+lEIE5Po5Maol2OJrM0l4ebZ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xxKt9e0N;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE683606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 15:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE683606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xxKt9e0N
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cc7c286026aso892109a12.0
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793460434; x=1794065234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ApVcgRbUJOCRqk0kM38newz6TbCCt9oxZvC4V9s3//Y=;
        b=xxKt9e0NpDf3tVGVMS6wABgShbLvUu1jspoSSPdQR+jrZURTsAUlFjFIUbaa+zldue
         BH9Q2YVj/MhQi17vot9q4bxY+OgPjR93EO4U/n2JdlDzmd3jONUECn7mMK4+NWPOJKOn
         CZ8OwCL1ud1Ux8ShHqn1BWX9Kct1BdM5w1EHu0/NuVMZGDeco7HRAjwnrvuugCPwdkE5
         pC1dHjy68JWDh21fbmodKPKtC9Ll9YrERB/aYMaK6ZLn5+eTmvLscCsZLsAkpTivuWve
         OF/OmyNhWECuTIhr0RePHZiKrER11pXgxqnJkKFItyYqiktMFEKB6P5GQzeInHxmkwCS
         ttqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793460434; x=1794065234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ApVcgRbUJOCRqk0kM38newz6TbCCt9oxZvC4V9s3//Y=;
        b=ClpBOeVNbJTZLgcPhGihAYdYMo7VrM1adU3b8xVCb/T2jcwg+n8IQoIAsSPoG209jg
         ARtSgcb/C50PHDX0n28tRspjxSXOoe4raT10oPiqeYMR30APQUJm2pFdNc7QHrar23aj
         RrfzbTM1XX/prvc2pkBdY8y7z7IUJ1+4WEWri2ZsZ3735fNf+7JrHW3H6yzdS77An5he
         LDPCUm0YiiQekC1mzdO5LRliwjEuny93KzCQwpppf359KZtPNzJeO+W8aegyFYhLXQCN
         otbpqaEw/mmZPi2lyJAqusZxPUYJNzV8BuR89exmo5zpgzSmglmCsept8iYdoqcuE154
         OcZw==
X-Forwarded-Encrypted: i=1; AKwUvBzbVB/M7jXesfs+AJjRT/Vkcx4RcNcnX5AT7/sWaziIFfUAqhj2vqCBvVe9gbqjzHUldcehdxJOo48gZ2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6piZu+ecFlPBe6qPQ6/ASTkw7VW48uVTF1xztjQV9PJO7GRIU
	VNC528ekUoWPEqczxu+p0XFMprfi/+tifPdTOMxb9aQUA9tS15FSuPIq
X-Gm-Gg: AYBFou2mntEUHdynIBKVOFJRAXh416dG0zAOo1uOatl+8RMq+3Y8zAWQMP4vSUz8zrn
	cKhixeBJ3Va5nqAiufC/7/SHA6VtUoA3wh49PACUBjkO8uZDCBi6I6hr0I4hSFKu+ONdpSGi3TZ
	HbAtJ0HaEbC0jcRZxMdqe8V/hESg2aVQ3u60/7yl6g0EE3LEjbw03fPlHdYlaAlKuMDzcHwrORy
	8EjOGgcg6ZeP6Fnh8xJLohBunbPcFdHB6SPg7J+OUT9wLBhao0o9gVP1YRHXrZe4NrLUoDFYH44
	eMG9zMAoela80c+etIp/BNKanwCU1Ljbf39fEfCVn+yfXNAhgtWwSsVgqM51YwjJL0De7OLs8WC
	O9sGBVWsH01TpSp6NcN2Zao2u9DRDEM6DZ66Aw2mxqH26OBSTtVJNRAYg6QLyEJWmvSBxXMtoys
	2h39TKJQf3N3Xnm/nxXw+MrqZUMxSCzHbJbw5KgLiZA5R1H8LUlas3zF3v2AN8gM8YFVUkoqBB8
	mmAJPTsNm9STEFsC+lSVTuy18dLHMuBngMzPSHHJynFgZ+R/5GtuJBHzMAkCHH1YNy8itdxfanO
	eAG7xTc9CqpncDaq8NtAT8Hn0MdWEY8=
X-Received: by 2002:a05:6a21:6b8c:b0:3de:b120:bba0 with SMTP id adf61e73a8af0-3e928cd25a1mr4531768637.36.1793460433856;
        Sat, 31 Oct 2026 08:27:13 -0700 (PDT)
Received: from kei ([222.141.54.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09615125sm1731025a12.1.2026.10.31.08.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 08:27:13 -0700 (PDT)
From: tianci xie <xiex16070@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Samarth Narang <samarth.colleges@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tianci xie <xiex16070@gmail.com>
Subject: [PATCH] tty: serial: samsung: fix TX fifo underflow on flush race
Date: Sat, 31 Oct 2026 23:26:56 +0800
Message-ID: <20261031152656.1422-2-xiex16070@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20261031152656.1422-1-xiex16070@gmail.com>
References: <2026103122-repurpose-cost-2da7@gregkh>
 <20261031152656.1422-1-xiex16070@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart_flush_buffer() resets the xmit kfifo and then calls ->flush_buffer()
with the port lock held.  Neither s3c64xx_serial_ops nor
apple_s5l_serial_ops implements that callback, and
s3c24xx_serial_tx_dma_complete() computes the transferred byte count from
dma->tx_bytes_requested before it takes the port lock.

A completion that has already sampled that count can therefore run after
a TCOFLUSH has reset the kfifo, and advance the freshly reset kfifo by
the byte count of the discarded transfer.  kfifo_skip_count() does not
clamp, so ->out moves past ->in and kfifo_len() wraps to a huge value.
The driver then keeps transmitting stale buffer contents, and a later
close can wait in tty_wait_until_sent() until it times out.

Handle this the way 8250 does in 9e512eaaf8f4 ("serial: 8250: Fix fifo
underflow on flush"):

 - add s3c24xx_serial_flush_buffer(), which clears the outstanding byte
   count and terminates the TX channel asynchronously.  The port lock is
   held here, so dmaengine_terminate_sync() cannot be used;

 - sample dma->tx_bytes_requested under the port lock, so that a
   completion racing with the flush observes the cleared value and
   advances by zero.

The callback may still run after dmaengine_terminate_async(); for the
fifo it is then a no-op, but it does clear tx_in_progress so that a new
transfer can be started.  As in 8250, this assumes that a terminated
descriptor is retired before the next one is queued.

Reported-by: Samarth Narang <samarth.colleges@gmail.com>
Link: https://lore.kernel.org/all/20261031004733.3345841-1-samarth.colleges@gmail.com/
Fixes: 29bef7990845 ("serial: samsung: add DMA support for TX")
Signed-off-by: tianci xie <xiex16070@gmail.com>
---
 drivers/tty/serial/samsung_tty.c | 40 +++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 640f85e..e955b7e 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -330,7 +330,6 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 	int count;
 
 	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
-	count = dma->tx_bytes_requested - state.residue;
 	async_tx_ack(dma->tx_desc);
 
 	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->tx_chan),
@@ -339,6 +338,17 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 
 	uart_port_lock_irqsave(port, &flags);
 
+	/*
+	 * uart_flush_buffer() resets the xmit fifo and then calls
+	 * ->flush_buffer(), which clears tx_bytes_requested.  Sample the byte
+	 * count under the port lock so that a completion which raced with a
+	 * flush cannot advance the already reset fifo past its write index.
+	 */
+	if (dma->tx_bytes_requested)
+		count = dma->tx_bytes_requested - state.residue;
+	else
+		count = 0;
+
 	uart_xmit_advance(port, count);
 	ourport->tx_in_progress = 0;
 
@@ -1162,6 +1172,32 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 	}
 }
 
+/*
+ * Called from uart_flush_buffer() with the port lock held, after the xmit fifo
+ * has already been reset.  A TX DMA transfer still in flight carries data that
+ * no longer exists, so drop its byte count before terminating it: the
+ * completion callback may still run and must not advance the reset fifo.
+ */
+static void s3c24xx_serial_flush_buffer(struct uart_port *port)
+{
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
+	struct s3c24xx_uart_dma *dma = ourport->dma;
+
+	if (!dma || !dma->tx_chan || ourport->tx_in_progress != S3C24XX_TX_DMA)
+		return;
+
+	dma->tx_bytes_requested = 0;
+
+	/*
+	 * dmaengine_terminate_sync() cannot be used here because the port
+	 * lock is held.  The callback may or may not run afterwards; either
+	 * way it is a no-op for the fifo because tx_bytes_requested is zero.
+	 */
+	dmaengine_terminate_async(dma->tx_chan);
+
+	ourport->tx_in_progress = 0;
+}
+
 static void s3c64xx_serial_shutdown(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
@@ -1684,6 +1720,7 @@ static const struct uart_ops s3c64xx_serial_ops = {
 	.stop_tx	= s3c24xx_serial_stop_tx,
 	.start_tx	= s3c24xx_serial_start_tx,
 	.stop_rx	= s3c24xx_serial_stop_rx,
+	.flush_buffer	= s3c24xx_serial_flush_buffer,
 	.break_ctl	= s3c24xx_serial_break_ctl,
 	.startup	= s3c64xx_serial_startup,
 	.shutdown	= s3c64xx_serial_shutdown,
@@ -1705,6 +1742,7 @@ static const struct uart_ops apple_s5l_serial_ops = {
 	.stop_tx	= s3c24xx_serial_stop_tx,
 	.start_tx	= s3c24xx_serial_start_tx,
 	.stop_rx	= s3c24xx_serial_stop_rx,
+	.flush_buffer	= s3c24xx_serial_flush_buffer,
 	.break_ctl	= s3c24xx_serial_break_ctl,
 	.startup	= apple_s5l_serial_startup,
 	.shutdown	= apple_s5l_serial_shutdown,
