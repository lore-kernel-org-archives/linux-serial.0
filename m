Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793450385;
	b=0gDjS+l/ZQwmn1lGAc69FOHSHx/APXPnVCfP5uSnXDLDVX2pH23Ne9VlgKUBmYzVgA5u
	 nSTV+IRLJkhC2t3IVeN6IFjdRjcmHcTGlbVaa8Fd+bFhoA8Tt/+4NH+OtJk8fmP1sZRpu
	 4zbXr4nxx685JW2wzo0MDF/iQKm9noSsiMoCbO9gL4WkGoWGi/R9s7+BR2fWfWzBnkXqs
	 lneD3XbzKwNvwjyG0Ms8zjhlX5uo3b7N7g0mq3J2WeMcAUvZEQOulH807ZVZlS6IbOsfM
	 UFbE69durEqYke3zpHBxjlhXm7Xu+OLIE4gWi9RdLFosfu8Gfc66Iv3a1gfz6FQqC/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793450385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9lYqqX+robUheapeipscKVQntLqlVNgi48T6H+L8K2Q=;
	b=kJ9Ni4OkWdpTIidZN/5AEDwCNmt57tXSTWx5rHSNTtfz2NWRAVpJUSPPjNmW1Fu3qCvb
	 DGTf7FHma+07WqfMOD/MoC2rakmgeqqSt9HnyyV83AxtIWxyIKm05prr+DSlmpSeWCf8h
	 me2X9Ft6HwQRnvGEdoBbGlONSohRM78sbCH4I0c8/dvSg0BuMTwB/rUXegs4n7HOpCKmi
	 7PTH0n6y7riq0V7R5/lHtBrc/WCs2/wiBIgrZxn5tzUBrzF5+YRB0w7VJ9l/G7/y+699e
	 ChTo57x1zgWge4inS81RG6swOSSutVAN+3/+sIZR0z7LyWEVGyuy/NKQVJhV+maZzyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOrUj+85;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F15606A31F
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5F15606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOrUj+85
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3514b90bb89so3072543eec.1
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793450384; x=1794055184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9lYqqX+robUheapeipscKVQntLqlVNgi48T6H+L8K2Q=;
        b=gOrUj+8519T2pA46LxOphlK1zNFHwSN41ceBiRGJAgYAb5PSzf7IzjnkBf4OH/X4N0
         p6oBNz6J7VIsngicPqtxG/17AOwKIq7cl5/ISU9x4OPErIOcGINgrkKF6t3DwBkFgpSN
         o4O3SHgkqsosqoaSquQdPSH+3kfb2VqMsnUkEfVjZRc9rJp20boJZKeTjac491DsYIub
         msYaNqqw6ER6GxNFDtA8qmu23PvlDuN/kwhYo5NwBq1VCk0m+qbn/FFNtlHaVCJOAIGx
         PLg9dqwGx6snsttOmfsuPjcSLJfSexSnpQhw1uoP5o8ntynqvRcGT8THTK047zi/zi94
         xWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793450384; x=1794055184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9lYqqX+robUheapeipscKVQntLqlVNgi48T6H+L8K2Q=;
        b=01/Jz1Ti6+JdiwCplChkS0ze4h0Gva525Zph5Fx+oW7XP8JUcPOKlbmZrpX6O64MID
         NHVWLZjjflxFArISnIAGBkkW6Qh6FYNszU5KmghdCvTqRCybsC7JoEuR/zvYafIuBT1W
         TZ6sy6RK2Am6Dw9xNLcd3RIwRAZ7gSAK58pqHiu0UkVbP0G1ZXT2NsmdVY8yFYFySfEh
         ngPWzleXB+1euH4P75faf+X8QmlL0mvXTGWrTSPAufYCHsu7RQ/yL/Mf83P7QOUXX63R
         r2fbc+hxbWMvKL2y34mXUOz0oRDX3o2sNAVLWYPeLWTox9L51rFOBE1Q7NiBpUIBSqTC
         bAFg==
X-Forwarded-Encrypted: i=1; AKwUvBxJIAZQOJ/f8kS4zjbCQO4rwlt4OwpgPHUrc5qnfagkdNWc43rOQ8CfiIbblsCK3BzdkyA/fy0kQl8NvCY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2zQzcrWVA1SIIf0pzLjoTo4wrzzGxqypelIo+jNOc5abumVXv
	oJd749D5sR2dOa2Ynwf4WXgL9yt5mat8yGi4pnSXK1r9WMqMl8dVHuzY
X-Gm-Gg: AYBFou2uGU+x72TbQZvT/YRGLXMxToEUw6jyTdvOSYO/d0V8700JBKnpwb+6XDzyrAL
	HrPsrlzTvOLM10XrqDte1p3sbLtP0ARFZl0cZzdApsL135rJdaF1buENeAQQXH9DKsype7R41/C
	wOFyD+CBYOFGQXvsnsX9j6nuqZu/D1dzHcbgepKKIQTuBGPWbiAwGFMeS9lHSghhTfVbONSdZay
	1/rGoljssbDm7d1Sq6VHPo0iPsAwh71RLFVfYg0NV5MPoguMhSP3PgqpwB0oXw4rDsrBolrLCGF
	//SAA3ZqRbLMnCx6n9lA/q5L4ql90snAhnZ8LGd3DY4fr3e2ZNOelqHSwCfxQlSCYeGVJzVQTo6
	mM5ugCAfaFNxZhOHTiox/MifBPRlqmQdqjm/OZsKjUHgeJ7BS0TqvrMIWdU4U/n01oJTVbDI0ly
	evelG1QgJ0KZym/Oxi9qd9r+SOFFqeQLGs7oKYeahLjXCl3Dr92A9yXlExDlMgrsJLUoivV5yVM
	/K6SEj+yYJ853Dv8LppYvARFEHNeWv+HNa6deY80trzSnL3KUCbRuWZRBm+otuB6DIQD1imHC5q
	Y4AuGnd1fTBdSDlytSx7CKhMdp7AZUXIr+Wf+oHPQ1XbpEsxSVzMJjFwTWuQ3ZQHD5l+G2Fbv2g
	aWk0NeEYOpSa8acvIHzNG03P3YxbCaxDDg5uxteXVCw0idh4L1eGBM7Ne7OizYiW0jHah+yDEnQ
	EEcYchGjWoMhSZbg==
X-Received: by 2002:a05:7022:ef07:b0:188:ea93:6cf9 with SMTP id a92af1059eb24-1ac5eea1fe9mr8982380c88.43.1793450383881;
        Sat, 31 Oct 2026 05:39:43 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm21566039c88.6.2026.10.31.05.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 05:39:43 -0700 (PDT)
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
Subject: [PATCH 4/5] tty: serial: msm: fix TX kfifo underflow on flush
Date: Sat, 31 Oct 2026 12:39:10 +0000
Message-Id: <20261031123911.3784690-5-samarth.colleges@gmail.com>
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
calling the driver's flush_buffer() hook. Since msm_serial does not
implement this hook, an outstanding TX DMA transfer may complete after
the flush and call uart_xmit_advance() using the flushed transfer's byte
count. The existing check for a stopped transfer relies on tx_sg, which
the flush does not clear, so it does not catch this case. The kfifo tail
then advances past its head, causing kfifo_len() to wrap and the driver
to transmit stale buffer contents. The same issue was fixed in 8250 by
commit 9e512eaaf8f4 ("serial: 8250: Fix fifo underflow on flush").

Since the TX buffer is mapped separately for each transfer and the flush
hook runs under the port lock, the driver cannot synchronously terminate
DMA and safely unmap the buffer from that context. Instead, leave the
outstanding transfer running and mark it as flushed, allowing the
completion callback to unmap the buffer without advancing the kfifo.
Clear the flag when preparing the next transfer. This avoids the kfifo
underflow, although the data already queued for DMA before the flush may
still be transmitted.

Fixes: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
 drivers/tty/serial/msm_serial.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index bfa44b01c3e9..a9eca971e9ff 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -185,6 +185,7 @@ struct msm_port {
 	bool			break_detected;
 	struct msm_dma		tx_dma;
 	struct msm_dma		rx_dma;
+	bool			tx_dma_flushed;
 };
 
 static inline struct msm_port *to_msm_port(struct uart_port *up)
@@ -428,6 +429,19 @@ static void msm_stop_tx(struct uart_port *port)
 	msm_write(port, msm_port->imr, MSM_UART_IMR);
 }
 
+static void msm_flush_buffer(struct uart_port *port)
+{
+	struct msm_port *msm_port = to_msm_port(port);
+
+	/*
+	 * The kfifo has been reset. Let the running transfer finish, so that
+	 * its buffer is unmapped only once it has stopped, but do not advance
+	 * the kfifo for it.
+	 */
+	if (sg_dma_len(&msm_port->tx_dma.tx_sg))
+		msm_port->tx_dma_flushed = true;
+}
+
 static void msm_start_tx(struct uart_port *port)
 {
 	struct msm_port *msm_port = to_msm_port(port);
@@ -479,7 +493,8 @@ static void msm_complete_tx_dma(void *args)
 	}
 
 	count = sg_dma_len(&dma->tx_sg) - state.residue;
-	uart_xmit_advance(port, count);
+	if (!msm_port->tx_dma_flushed)
+		uart_xmit_advance(port, count);
 	sg_init_table(&dma->tx_sg, 1);
 
 	/* Restore "Tx FIFO below watermark" interrupt */
@@ -503,6 +518,7 @@ static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
 	int ret;
 	u32 val;
 
+	msm_port->tx_dma_flushed = false;
 	sg_init_table(&dma->tx_sg, 1);
 	kfifo_dma_out_prepare(&tport->xmit_fifo, &dma->tx_sg, 1, count);
 
@@ -1549,6 +1565,7 @@ static const struct uart_ops msm_uart_pops = {
 	.set_mctrl = msm_set_mctrl,
 	.get_mctrl = msm_get_mctrl,
 	.stop_tx = msm_stop_tx,
+	.flush_buffer = msm_flush_buffer,
 	.start_tx = msm_start_tx,
 	.stop_rx = msm_stop_rx,
 	.enable_ms = msm_enable_ms,
-- 
2.34.1

