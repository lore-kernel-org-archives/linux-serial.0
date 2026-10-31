Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793450373;
	b=eHFuvfi7ladQ6I+bdI5JFFjeJW36nDQ4YCiSIfcDTYsdyYLVlauN9+uiytuy9Io2M6DM
	 /LlGcIoCYklRYA+r6tA7CRgi0ycSnBSGGBKv2/CP/f4wlRUQcUR42MGk1YgUoN8TsJn8b
	 Z5bmscMAoFEAqpvljB2E257f3Kupu1Ry/RLtaGD8eDE4VNWP93LmZg7iI+MfBlTGFZyuC
	 LuAahkLh9qCgyuu7rVxcUfOmvr5h9DABnuOratX9MUsi460JpV7SnID8aPhTv7uZPAYp4
	 zfis05SC/k6nec07jYXbrbgGAakXrM5C7PC6INrZLofeiXU/8FWuBAa9ieJ1PfLsqvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793450373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sU9FonDcj7pItReaQHsb8l5aj4324fAJTqMBMqrSuhE=;
	b=EWJTJv9sY1wqul+WLfK15uE5qozH9o+GF8QMsgiDbhbbuyJ12uI0yuc7OzntdbZ+4iKo
	 Wmxnm86dMp8xiIFBd5cCMP9De9kprwiZ92CufGnpYv0T+pI48LEEe1QgZhJ58E1J3YDp2
	 qgKsYdV/zAukjF/oZ+06W3pXTB7U6lvZTzW7RFFtINWct84I7SLs0sdtG51C2SwRbDIeP
	 TNawnCUmkbV+gJ/upWzudIKPWAHwZ8+KtR7FnNMERTnOqNfnSUMCOAlvpsGq9XqVYbQNj
	 hWXsL1y1zyKbdy1txH1z8YoMtxlTHYPk6qeVs+OBvkR6iNkIFCGCmign8ASOzbdc6gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MMeYLSu8;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4C606A31E
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2A4C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MMeYLSu8
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35829219da8so3139695eec.0
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793450372; x=1794055172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sU9FonDcj7pItReaQHsb8l5aj4324fAJTqMBMqrSuhE=;
        b=MMeYLSu8Hfxb4MMwRmB6e+af88Re5khoHp3/t2EUBiUGkWoq5iAZ1cjS/455NZJMYc
         IujJzHWomO3jTDNhqb6DoiExYizct5Q5FVUJmFS7XuCy2LxUc8jj0Oofyc0IHl+EntE/
         eUcP2z4Ax8+oIgGKpmcRfzMrD9dQdamJcuC3zrvef27BS8pSvZievFDvuWoZs0CqMcCq
         3vKRYyOQMEzwBfi2Zm0+f/C1csutboBvSRGc8Yte8xi/BQo0n10Jw6RwB6XCFvO+KJ09
         hZWMahyBeZ0zoMbqMmuxiabU6Q9VNG+7uRaQgI//VnxikZbVXNq/V6EAx1/ZV4NVzTzt
         LUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793450372; x=1794055172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sU9FonDcj7pItReaQHsb8l5aj4324fAJTqMBMqrSuhE=;
        b=njBbCNDrvhZYA5Dl2G71P04nbQxeuQ/cxr5TxAN/hc8QYCgbSpmW8e3bRkAJVrS9pq
         HaM39oqFjS19/KLyyc0E3G/uX1tmtsYbD+wMrEtOP+vnmi+TIza5Xt8TNOWhF64H7P0M
         gLtsKYsAUhRic5oNuWaKn3OJe6NpWq1jo5fz2V9V1m9j4arn+esPPhKtAMxiiU6jSz85
         ee5Q+bEhyqcsR4cfh/xfcwrRf9Tlh5y8AZNnSJ3Lz8q+asjlgKH3KN9ozmCpuqisuwgU
         kkv2+wSZle4nmUIRJSwJM1t1B7hCKj2lCL1DaZ6yx4oX41i5xcO/fSOeFnhv1FalVc8C
         Atuw==
X-Forwarded-Encrypted: i=1; AKwUvByY6LzLJMRh6eWNNAV49i8tO/pAeKickpneUz1jVJLcw9WAZ/6mRba7R8EbVr0IlPS9IMM3b7hMlZerXac=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRnRuSK2//1Srs79SfszWnzwiIALz8P7YEZ541b6yjcZOsoAQl
	EozCRNetyhgVGSNLlLQoAf3KNW3QVEmbGZEe0D1ydxZyAEkQZvduk5N6
X-Gm-Gg: AYBFou1Rzd68U/1iCU9RH3lSvfQIUjJO1/WwGxgezHlEXbmit8nTDz0ru/J3gjp/D7Y
	KB3vjxm/wPP9sDxDWTyGCT532OsyvOFUwSd1jR3XX9SKb1bBndIte2pVZeu99lrg89/YghSCUr5
	Hfg1w67tkGD7tJH+WGIxu1e1vx2Kw0rZXCDebvQhTLI0kQo5+wwOZwypttVwo7EkZDeY0LRaEpZ
	UmQ75CrQUEfhIgHxO60SkGcSEzLqnBa5gr4mAUJhQaI9WYxwsXQXgJ+AvTFEPZjEdzM5GqCHrQq
	/WDtcslKkrqzilQbgRdTIfPHrztjnh7hFmtwPLSpUHmKeIgBsDuL0eQMkBBkx5I21r7VEkTMVA4
	WSadNzzGXWHYtG6vJFUhtm6Ah/XVsq4aIdOg2FriRGukGRn3W9CqG3wc5PeZyGs81AiSLyO2gYH
	RhonOMCWsFIOBExBSp9Ew25vTj3h0pEdZKbes4T8C7BFQlz8u+AZb+V9coYhE9YHdg4ZdUbu9WG
	1hkqIyIZx7S5LMHjDYe1KAaWQ4vuny3XurW3NXsRyZBBs4FVQyru+DoK0gXFqobNDxmdS0avDbH
	y8VfBfirGl7tJ0orwSxdORy8DfXxAwyqgorHHe1v4VK92YftoqntVaZsmP0k+kwxijpX58/XCmg
	I1/UAsRlCVOc2dWCQ+NV6zR8uPwsoPUaJVP2u3ocL05N748P4y84fQuCo4z+ge0F48Q6j/EiWrr
	ZIS9ny3vjMkf+DFA==
X-Received: by 2002:a05:7022:294:20b0:1a9:4d51:8c33 with SMTP id a92af1059eb24-1ac5bda4837mr6575924c88.18.1793450371863;
        Sat, 31 Oct 2026 05:39:31 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm21566039c88.6.2026.10.31.05.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 05:39:31 -0700 (PDT)
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
Subject: [PATCH 2/5] serial: tegra: don't advance the TX kfifo for a flushed transfer
Date: Sat, 31 Oct 2026 12:39:08 +0000
Message-Id: <20261031123911.3784690-3-samarth.colleges@gmail.com>
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

tegra_uart_flush_buffer() terminates the TX DMA transfer after the
serial core has reset the transmit kfifo, but leaves tx_in_progress set.
A completion callback that was already running may have calculated its
byte count from tx_bytes_requested before acquiring the port lock,
allowing it to call uart_xmit_advance() on the reset kfifo after the
flush. This can advance the kfifo tail past its head, causing
kfifo_len() to wrap and the driver to transmit stale buffer contents.
The same race was fixed in qcom-geni by commit 452d6fa37ae9 ("serial:
qcom_geni: fix kfifo underflow when flush precedes DMA completion IRQ").

Clear tx_in_progress in the flush hook and have the completion callback
skip the kfifo update if the transfer has already been retired by either
the flush or tegra_uart_stop_tx(), which also advances the kfifo itself.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
 drivers/tty/serial/serial-tegra.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index b0fc4ae3686f..8b712a9bc293 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -537,6 +537,11 @@ static void tegra_uart_tx_dma_complete(void *args)
 	count = tup->tx_bytes_requested - state.residue;
 	async_tx_ack(tup->tx_dma_desc);
 	uart_port_lock_irqsave(&tup->uport, &flags);
+	/* Already retired by stop_tx or flush_buffer */
+	if (tup->tx_in_progress != TEGRA_UART_TX_DMA) {
+		uart_port_unlock_irqrestore(&tup->uport, flags);
+		return;
+	}
 	uart_xmit_advance(&tup->uport, count);
 	tup->tx_in_progress = 0;
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
@@ -1276,6 +1281,9 @@ static void tegra_uart_flush_buffer(struct uart_port *u)
 	tup->tx_bytes = 0;
 	if (tup->tx_dma_chan)
 		dmaengine_terminate_all(tup->tx_dma_chan);
+	/* The kfifo has been reset: the completion must not advance it */
+	if (tup->tx_in_progress == TEGRA_UART_TX_DMA)
+		tup->tx_in_progress = 0;
 }
 
 static void tegra_uart_shutdown(struct uart_port *u)
-- 
2.34.1

