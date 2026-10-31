Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793450379;
	b=0JlTKRYKDuclmtKVPW2YGUpANZ8AwzzeQXvkFbN0kRWFI3lf68CEp9a2pnhC9Uhw6JMm
	 Hf8qsEyL9S+bWeD7LtHv+C8KGanz2oE5wsh3u/dWIowGJXsAF4tDxEevX57Q2bOzZbTwC
	 SAzBg7In+u5WcC2/JWAfbPt8x/Lcq4EG3QH5ij9fwag+gdROwbrAnLXe8rzN/C/SC1NTS
	 qPJgjs1rHplTKhRvkFanYzBL5wJs+qo07pulJ3AQKT2pA6+dLfgiLYdutKH6QqNAFyS63
	 7zu6FuP9i1l89nGyZ+QNOUGoCPdFn3iCZlYVrwK4fKsxXXFk0zZpCFXijahl0kJoYNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793450379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cnXM6OEqfvGVRy4AJACjTgyVnlWSquVpMq023G3i6Do=;
	b=ytNS5KF62UPHOYZK6v36Tw3tU6rXcpFk79pG3pIPUFLAhKCvMOzO7yyrWnkTLtUKI42U
	 knCmmGFa27NjViFeVOjAZHkfxEZLKCBXHRiasIufj15cSArim8N/GGkC1e1/ZGx3DUhwK
	 3/KAU6Jd66EQhHyEAOSiTX1hoKoWUTcWdrYx/P6XHd6vAdAee1PyEWeVbOs9+sHRWY3NV
	 hC5K3sWTbOHbBNi7Hiq6OoTDwr6QyQobJHT03A37KVZ3MfOuNbKo2rqtmorTvapOeKryj
	 Jv4/XONkVO1IuwmHJIE4nT/9MNEHmUbvdJGDeahBc6mHrSRAfwgRgyGSSsz0GoHX0fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="noT1P/WW";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83E606A31C
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED83E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=noT1P/WW
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35829219da8so3139765eec.0
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793450378; x=1794055178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnXM6OEqfvGVRy4AJACjTgyVnlWSquVpMq023G3i6Do=;
        b=noT1P/WWygxujj5N7CXMhW9KUUVBrILgHD3cyISauVEk/333TsPoEAmqe+vPvqtcRg
         vjg3LueDnm5cH58bO/1RkjL3Zyyhyet/YpGCw85fQZ6clqc8g5c2VvITHO7H4/IZHghP
         i3ItIumFpvLEMSn4TI/dPT0noFcxzmIels6683DS2IBe5sMFlIEcJ42hA8J58SCDMMXN
         oj8Hzu6Lei9XwPEZ1sIQjePY5nh4oDk7mBgwrJAybwT8ux/aOkmsmwM6NttyskzXEH/9
         b3V0q5e0X3miPnQ6m9M4hqBfxNIorRAN2b+on7ZzhuGhOBDcR88eVf6j4nCw6rBNPPVt
         likQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793450378; x=1794055178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cnXM6OEqfvGVRy4AJACjTgyVnlWSquVpMq023G3i6Do=;
        b=gozsfLhbUU+m+yIpJUAAIDH++KOQqPnpp40EXr44HzmmmnUNZ7ffmbNTUGl6YPn51f
         d8DMp9eQ6WcO4d8k37WbuJzT7tDF1EvisI0Ao2LEJrJhTqyw56WFWl7AbsBcUjs9iDFY
         0LlOu9I9AesGEb5mO/n3M5YCUS5GbyYEcVc5Khu76Vq+9per+vlKBeM7vGBy4aYUCuHk
         Q48iCHR87m2T24u32qcngWqt39JNVsrD9I5pr6Fl2JtfeYptTwR6Q0+EQhLenJmVgA42
         20XNjmJPq+HOZfUc63ekxlks0gLO8BTTwFpHmHpZFbIaaoJU3VxHvqJciQtVzZX2zz+f
         n9RQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpYqAIt60kjITvjIrudA0gY4fIaOyu5xJz2fhxNhG4aPxo+1QYYJ+uh8IOSPufi9A9Z4mlsj8lEOPEzWI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOSRHmnM4HeAbVn8dt20Iy3ishb5iJpq4svXVY5Ao//jrGEiG0
	wxd8HbJtKoc4Cpgs3TY4wZziJSyGpSPNwBf6EqubHKG5l7muadZ4bGM1
X-Gm-Gg: AYBFou2ngtNreF5kQ0Zn5NCuNiXJYocQq3Dp1h+sso/fThlPFIJQ+IluR6h09hKPVHa
	MVydRpb2fvgdPOBlCWHwga9onOtXhraEXP5C8WdHcW9AGHoVQkp/y4bVTn1rBDvVUxzcwLghfRf
	UoOYQYQBu9mgwPLfMXgxxa3kjwBhTlVEHt3M5VGYw9wOBa2BIBzY0Wqn67kyoocZDUMSRZ2ox0G
	j1ihWY9yDdyCE+x1eTbvMVV8oR9ioIagjkyf2M8INlJUX0usspP3HJ1NdBV/e32Jvz70pyqiX0V
	zHXhomx9LEOOGxwlTgb7bf5/FzH0lxEFcP53Jxbgt91hfr4rGCrF4exegpShqgiFjYSTZsM3+8+
	eUvSMRq1cSbK2wSINgBUY6RawPBFH28zKTJKSEjSHEqLEFvecV1ai2ZGwrrIVlkIo42iofmsH7x
	gGmv6AITpCAV+QgTKkfP8BmkFTok67b+RqVfLKgjmUOnYpwL0HFstS85t5VWrkhBDm0/PoMcq9M
	xXRPMTtS/DnlZkWL3MgrnRxd2pwfh830bYLbkJsVRLUnJX2M34R3C0rJeshloCnHlgFpAlQJZDC
	mrFNDMHWBv5l5oLt+HmEhnJRQoCzZsv1zMYgQv81IHZqn+x0KNNELZnTQgNJCSIV5LaRzg+7l6S
	8ymwsuh9RJrQvtiS63SQ6eeDB6HPVCJEiwJa9hu5w14kZM2eiOcvjuAdMcCDCOh1X4IwuYjldrf
	R0/mOWqf+2l17x4Q==
X-Received: by 2002:a05:701b:271b:b0:148:ece:8cc3 with SMTP id a92af1059eb24-1a94adc93b7mr10542506c88.24.1793450377950;
        Sat, 31 Oct 2026 05:39:37 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm21566039c88.6.2026.10.31.05.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 05:39:37 -0700 (PDT)
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
Subject: [PATCH 3/5] serial: sprd: fix TX kfifo underflow on flush
Date: Sat, 31 Oct 2026 12:39:09 +0000
Message-Id: <20261031123911.3784690-4-samarth.colleges@gmail.com>
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
calling the driver's flush_buffer() hook. Since sprd_serial does not
implement this hook, an outstanding TX DMA transfer may complete after
the flush and call uart_xmit_advance() using the flushed transfer's
tx_dma.trans_len. This can advance the kfifo tail past its head, causing
kfifo_len() to wrap and the driver to transmit stale buffer contents.
The same issue was fixed in 8250 by commit 9e512eaaf8f4 ("serial: 8250:
Fix fifo underflow on flush").

Since the TX buffer is mapped separately for each transfer and the flush
hook runs under the port lock, DMA cannot be terminated and its mapping
safely released synchronously from the hook. Instead, leave the
outstanding transfer running and mark it as flushed, allowing the
completion callback to unmap the buffer without advancing the kfifo.
Apply the same check in sprd_stop_tx_dma() if the transfer is stopped
before completion. With this approach, the data already queued for DMA
before the flush may still be transmitted.

Fixes: f4487db58eb7 ("serial: sprd: Add DMA mode support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
 drivers/tty/serial/sprd_serial.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 3fdf5939a62c..718732b683f1 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -133,6 +133,7 @@ struct sprd_uart_port {
 	struct clk *clk;
 	struct sprd_uart_dma tx_dma;
 	struct sprd_uart_dma rx_dma;
+	bool tx_flushed;
 	dma_addr_t pos;
 	unsigned char *rx_buf_tail;
 	const struct sprd_uart_data *pdata;
@@ -236,13 +237,15 @@ static void sprd_stop_tx_dma(struct uart_port *port)
 	dmaengine_tx_status(sp->tx_dma.chn, sp->tx_dma.cookie, &state);
 	if (state.residue) {
 		trans_len = state.residue - sp->tx_dma.phys_addr;
-		uart_xmit_advance(port, trans_len);
+		if (!sp->tx_flushed)
+			uart_xmit_advance(port, trans_len);
 		dma_unmap_single(port->dev, sp->tx_dma.phys_addr,
 				 sp->tx_dma.trans_len, DMA_TO_DEVICE);
 	}
 
 	dmaengine_terminate_all(sp->tx_dma.chn);
 	sp->tx_dma.trans_len = 0;
+	sp->tx_flushed = false;
 }
 
 static int sprd_tx_buf_remap(struct uart_port *port)
@@ -273,7 +276,9 @@ static void sprd_complete_tx_dma(void *data)
 	dma_unmap_single(port->dev, sp->tx_dma.phys_addr,
 			 sp->tx_dma.trans_len, DMA_TO_DEVICE);
 
-	uart_xmit_advance(port, sp->tx_dma.trans_len);
+	if (!sp->tx_flushed)
+		uart_xmit_advance(port, sp->tx_dma.trans_len);
+	sp->tx_flushed = false;
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
@@ -555,6 +560,20 @@ static void sprd_stop_tx(struct uart_port *port)
 	serial_out(port, SPRD_ICLR, iclr);
 }
 
+static void sprd_flush_buffer(struct uart_port *port)
+{
+	struct sprd_uart_port *sp = container_of(port, struct sprd_uart_port,
+						 port);
+
+	/*
+	 * The kfifo has been reset. Let the running transfer finish, so that
+	 * its buffer is unmapped only once it has stopped, but do not advance
+	 * the kfifo for it.
+	 */
+	if (sp->tx_dma.trans_len)
+		sp->tx_flushed = true;
+}
+
 static void sprd_start_tx(struct uart_port *port)
 {
 	struct sprd_uart_port *sp = container_of(port, struct sprd_uart_port,
@@ -946,6 +965,7 @@ static const struct uart_ops serial_sprd_ops = {
 	.get_mctrl = sprd_get_mctrl,
 	.set_mctrl = sprd_set_mctrl,
 	.stop_tx = sprd_stop_tx,
+	.flush_buffer = sprd_flush_buffer,
 	.start_tx = sprd_start_tx,
 	.stop_rx = sprd_stop_rx,
 	.break_ctl = sprd_break_ctl,
-- 
2.34.1

