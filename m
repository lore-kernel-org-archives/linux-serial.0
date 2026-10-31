Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793450367;
	b=MLH3CsZLmVFWct6zuYQYbDlLLo5CLms3TFI3JVadKv2Gik5IFQxRmBg3P4c251aP1L9j
	 Z/RUb2qwO0xQ9XAG1qMK9iL+A6HaHMkfME2HtqiAjI5r8D1KNYYWKMP7Fm/WZvPYcKPxp
	 Yt7jcfoi55EAMjurGinANoBensyK8V1/x9mMtSRDmbblD7PqGZMzlc4/svoVkeDfFjmlJ
	 lYmOCf6P7EifNuBaQgYRbdFSFosm8MA0Bx8itNiunrMoxm9SY/mPzUKNwWkUpwKZqWSw3
	 bhLnGaurrzKhzZvL7zBplrtqCqKaaBjWLYxoYU6EBz5sKynhF1/9YeniGC7cndtFf7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793450367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uvdMMWuBJgZn2yb+YVIOL/4xZHnwlAFydQfLAoaMsLI=;
	b=0XQFkhc+/DoztoRwVCjmlWu0Qkf9QJDDVvuOdRwxowPFKBCcfHVv8TXz2H4WZ1v7xu9n
	 BgQtTZ5ZKw5dklN0UTOLvMOGBUyANHMxD3s6KH1B8rOPevgTzIJd9tKb6lLP2rR+C7Zkb
	 tis1fO1a+Yp8eUVPbBG0YN4tHN8TScOsHrHP8wkGAxJUAX3aJrIinWL+HL3rXuuHOTWWW
	 ARjUULU1lwanimGJ9fZI82taqbw52VvYKN6ADLLtj+77J+h9nZKHGosVtfmvpPbKNr7v2
	 8ESTaE/S+LM9fKY/CpnMEPkOChOHyCLB2yivJW6E2KdXPN9pmHOog9cFZFrfQos6C4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="i8vqxDj/";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571F606A31E
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E571F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i8vqxDj/
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-353804b591eso2564322eec.0
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793450366; x=1794055166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvdMMWuBJgZn2yb+YVIOL/4xZHnwlAFydQfLAoaMsLI=;
        b=i8vqxDj/OUDJ1iQa7GwdkezQ2bdVTg2TW5UH+uRGHmgDt64Tf6eQQH+vruS93m5WCW
         qW+JBf2KzhXySFZYomRP0Ax7toZf1WMPxxt9QHqp2bkyfYjwWoTnLxn+/qA+FYbnWdOy
         Wl4Mfpu/HXfjiROPPAOVIseUjKHClJwZcEiN87ym1oRxh0isvc+cawWTxzdU8ZWGIZzO
         ngKVY7BHtTJccDsQHVgv1EHBw/jPrfFsZx1gCeD1q6c9TQTgUxKxBUxMYhARjHh2o1s7
         rUOxjeGB8BhyVzXA5SMe1mlF8LTo9V7aOm5KyfAetaE/B8YGInq6fMaj8f/d8d+RlMNa
         Wtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793450366; x=1794055166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvdMMWuBJgZn2yb+YVIOL/4xZHnwlAFydQfLAoaMsLI=;
        b=KO0yGXgrNwN0qrhZnmUdkN65eftQheYA+FIcWhUkAEkNlxu6d1wHwURFO8o6rJ1Svo
         fr5md25Aq+K3AyVM/6GW+lHeQZUCmWT3qvhLcIvCIO54+Fo+4AWofDigE/4Kj7cTQX9R
         e+ar0Itp8yzsSCyI+6S5dBRantwV9hLM2LCpChjxR/t5nEph2a55IfxJ7rL/Tsiy8SuL
         soXzL4mGpIfKtmrYBcdr/rPMEqV6XyT9VyRB2IBgwoe9DZYMg7Zmaa3RZxZ0e/vRj+I2
         oqzEp1t9/9nyVNGxCbmabxiQlQS223u3bTBt/CMeg3h20D1Yp1DlenddhhbjOwDKDEim
         yppA==
X-Forwarded-Encrypted: i=1; AKwUvBylHaveyBcQeKPTNRFpkjVC2YApS1UZOEZRZVCm946qbydRrNsiTvwodbO/WgoeU1wYO1zga9RTXqidM2M=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2RA75izAcpyk4uhSqiCt1QGGHvFo1Odmul9ni/GRPw3FWnFjv
	5Shm+x2B6y5FMsKR/rgOU+Z6LoiAWWr3JbWIcFZbJYBKqGooaXVBRmd3
X-Gm-Gg: AYBFou1u8K+iEVMuYjmEnKIXhWe7akzIbUwDcEwptzy7s+4xh70KBBqpAb276M9DGW2
	Y+JN+iLuj7aheuuss2WOHDg8PP5Dw6iALs/S1eCkWp9DylEhKDj3o3kgTJiKUv48uZAulQt+cNK
	1wFxta++dLrYF2hOV1a0y9XUOfF38jCZ2hjHvYT9DwZSoIA43zpDDQXCTnn0JcUTRGVtfrA+qid
	+4beeaLwL/X45r74IdhirufDfuav5JwL6+sEXm7rBu6e6LW8iE0CDFOgCr3B4FZgPyPe9Hx//5L
	FqDimRX4Lwf1DMK1Jj4Z5tOGIcaopV1zaSrB1QW34r7MYqlanKn2LgzSp9Whw8lftsiSKvO5lgQ
	Yy5KUBV+e2yA+T8Jv7EpE+cDlVnZzS+03AlbBM2q3WlYX63V7ZrMh2Vi+E5Zx/gqWSNMTmE/l06
	NgzSmvOtpX8ohJm3WVA+rcdogAhUr0gUg1OjQoKLXhwhyD7SwXKU2imFADm6v9Dxn7F3ViH21Ge
	iixVkAqGBJuaTpF1xBwKb2dvsvZ7GVyx35oioJG3htpcgahBzyBLJqVSgyQ+npqzyOX10pXxcEp
	Nzn6iOoUP3QJQEBWixq6/Gyi+JdP0BvGWPVqoGbDhnTRcBrc3t3h3YKJ7LW4oraaH0D2nkONDWT
	oT31KAwbQeg0S/1T640iGKpo2tgyNfnnlDPDcQRviYc+LvnjutCXf9bPo9s3E5dY6I29Y52irAj
	g97aT3NXPOpduzzg==
X-Received: by 2002:a05:7022:b053:10b0:190:da74:2c89 with SMTP id a92af1059eb24-1ac5bda4447mr7716798c88.21.1793450365870;
        Sat, 31 Oct 2026 05:39:25 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm21566039c88.6.2026.10.31.05.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 05:39:25 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Samarth Narang <samarth.colleges@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] tty: serial: samsung: fix TX kfifo underflow on flush
Date: Sat, 31 Oct 2026 12:39:07 +0000
Message-Id: <20261031123911.3784690-2-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031123911.3784690-1-samarth.colleges@gmail.com>
References: <20261031004733.3345841-1-samarth.colleges@gmail.com>
 <20261031123911.3784690-1-samarth.colleges@gmail.com>
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

uart_flush_buffer() resets the transmit kfifo under the port lock before
calling the driver's flush_buffer() hook. Since samsung_tty does not
implement this hook, an outstanding TX DMA transfer may complete after
the flush and call uart_xmit_advance() using the old transfer's byte
count. This can advance the kfifo tail past its head, causing
kfifo_len() to wrap and the driver to transmit stale buffer contents.
The same issue was addressed in 8250 by commit 9e512eaaf8f4 ("serial:
8250: Fix fifo underflow on flush").

Add a flush_buffer() hook that terminates the outstanding TX DMA
transfer and clears tx_in_progress. Since the TX buffer remains mapped
while the port is open, DMA synchronization is not required before
returning from the hook.

A completion that is already running when the flush occurs may have
calculated its byte count before taking the port lock, so it must skip
the kfifo update if the transfer has since been retired by either
flush_buffer() or stop_tx(), which already advances the kfifo itself.

Fixes: 29bef7990845 ("serial: samsung: add DMA support for TX")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
 drivers/tty/serial/samsung_tty.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 640f85e2d636..2bea7ef078d2 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -317,6 +317,20 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 	ourport->tx_mode = 0;
 }
 
+static void s3c24xx_serial_flush_buffer(struct uart_port *port)
+{
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
+	struct s3c24xx_uart_dma *dma = ourport->dma;
+
+	if (!dma || !dma->tx_chan || ourport->tx_in_progress != S3C24XX_TX_DMA)
+		return;
+
+	/* The kfifo has been reset: the completion must not advance it */
+	dmaengine_terminate_async(dma->tx_chan);
+	async_tx_ack(dma->tx_desc);
+	ourport->tx_in_progress = 0;
+}
+
 static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport);
 
 static void s3c24xx_serial_tx_dma_complete(void *args)
@@ -339,6 +353,12 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
 
 	uart_port_lock_irqsave(port, &flags);
 
+	/* Already retired by stop_tx or flush_buffer */
+	if (ourport->tx_in_progress != S3C24XX_TX_DMA) {
+		uart_port_unlock_irqrestore(port, flags);
+		return;
+	}
+
 	uart_xmit_advance(port, count);
 	ourport->tx_in_progress = 0;
 
@@ -1682,6 +1702,7 @@ static const struct uart_ops s3c64xx_serial_ops = {
 	.get_mctrl	= s3c24xx_serial_get_mctrl,
 	.set_mctrl	= s3c24xx_serial_set_mctrl,
 	.stop_tx	= s3c24xx_serial_stop_tx,
+	.flush_buffer	= s3c24xx_serial_flush_buffer,
 	.start_tx	= s3c24xx_serial_start_tx,
 	.stop_rx	= s3c24xx_serial_stop_rx,
 	.break_ctl	= s3c24xx_serial_break_ctl,
@@ -1703,6 +1724,7 @@ static const struct uart_ops apple_s5l_serial_ops = {
 	.get_mctrl	= s3c24xx_serial_get_mctrl,
 	.set_mctrl	= s3c24xx_serial_set_mctrl,
 	.stop_tx	= s3c24xx_serial_stop_tx,
+	.flush_buffer	= s3c24xx_serial_flush_buffer,
 	.start_tx	= s3c24xx_serial_start_tx,
 	.stop_rx	= s3c24xx_serial_stop_rx,
 	.break_ctl	= s3c24xx_serial_break_ctl,
-- 
2.34.1

