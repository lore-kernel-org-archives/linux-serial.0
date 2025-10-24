Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974561E4AE;
	Fri, 24 Oct 2025 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288726; cv=none; b=L0VK0m5319Pq5zHMy3/IZsHsZTnmhi1L0J9ODDSN6mzDUQX9gCv6CgBAjrhnb1qoKhMgjSMVyaGMD0P8qyIqTtomczsQBEKPyMrLSuNUWVJ/0Gea1op3qNVkMG74Z6mdfeP5EixbZiXk7jzy390Q7OA7XiFqcKLNHs3ZOkrgdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288726; c=relaxed/simple;
	bh=lYIgpBfxvQ4WzZ5IqAIE/hqG83YejURQMyOiNm0N3uI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M9FQeviH5ZbsTzdYSz16Vq738ObJqIZPEr3cjhNb1ptyhvRB7GPTiAUdbnxeSOvC1S6DCoAiN8eeF/REzODwchQ1ZPX/Yu7iFeNt3VwIYkpDk9aRhfivNeHeLjaI7O2wSdsSZFHgkbnbO+glqgRoMFFxU2Aev3HoCgtntm2H2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gy65XFbe; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gy65XFbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9m
	kIPgSKt9newQ2psHkDbYkEBK8hyNFyicM9TJzk87A=; b=gy65XFbenl1WKHYcti
	LOg9BDmF3UcOx7VBvzoR41RLLqOPUKRTQz/xRDf6NcCmXH87H9I7TtAU41jXUZNs
	I3Z43RVpV9xTl4NSEF5EWgQKXIxDo3iuKqkAq9AhzRNXM1pW3F37V7vQIKwhz/k+
	uODEizwq3jfjqkRZvxOz9+cJo=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3P2DqIftoFHjCCQ--.7622S2;
	Fri, 24 Oct 2025 14:51:23 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org,
	hch@infradead.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH] serial: 8250_dma: add workqueue to flip tty buffer
Date: Fri, 24 Oct 2025 14:51:20 +0800
Message-Id: <20251024065120.1951924-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P2DqIftoFHjCCQ--.7622S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF48KF4xZFWDWw4DKw1Dtrb_yoWrKF4Upa
	n3CrWDt348K3Wjyw4DGF48XF4S9F1Syr17GrZrK34ayFn0yr95uFn7tF9YvFWkCrZ7tr1Y
	vF1jga43CF12qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zikpnPUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvwubpWj7Ietf-wAA3z

On the embedded platform, certain critical data, such as IMU data, is
transmitted through UART. The tty_flip_buffer_push interface in the TTY
layer uses system_unbound_wq to handle the flipping of the TTY buffer.
Although the unbound workqueue can create new threads on demand and wake
up the kworker thread on an idle CPU, it may be preeempted by real-time
tasks or other high-prio tasks. dma_rx_complete calls spin_lock_irqsave
which do not disable preempt but disable migrate in rt-linux, leading to
the kworker thread running the dma_rx_complete work cannot be pulled by
other cpu when idle_balance, causing long delays.
In our system, the processing interval for each frame of IMU data
transmitted via UART can experience significant jitter due to this issue.
Instead of the expected 10 to 15 ms frame processing interval, we see
spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
be 2 to 3 occurrences of such high jitter, which is quite frequent. This
jitter exceeds the software's tolerable limit of 20 ms.
Introduce wq_tty_flip in tty_port, allocating a workqueue using WQ_SYSFS,
so that we can set cpumask and nice dynamically.
We set the cpumask to the same cpu where the IMU data is handled and has
less long-time high-prio jobs, and then set nice to -20, the frame
processing interval remains between 10 and 15ms, no jitter occurs.

---
Change in v2:
- Do not add new module parameters
  as suggested by Greg KH
- Set WQ_SYSFS to allow properties changes from userspace
  as suggested by Tejun Heo

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 drivers/tty/serial/8250/8250_dma.c | 19 ++++++++++++++++++-
 drivers/tty/tty_buffer.c           |  2 +-
 include/linux/tty_port.h           |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index bdd26c9f3..7ff705a78 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -207,6 +207,7 @@ EXPORT_SYMBOL_GPL(serial8250_rx_dma_flush);
 int serial8250_request_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma	*dma = p->dma;
+	struct tty_port		*tport = &p->port.state->port;
 	phys_addr_t rx_dma_addr = dma->rx_dma_addr ?
 				  dma->rx_dma_addr : p->port.mapbase;
 	phys_addr_t tx_dma_addr = dma->tx_dma_addr ?
@@ -244,6 +245,11 @@ int serial8250_request_dma(struct uart_8250_port *p)
 		goto release_rx;
 	}
 
+	/* Use the default workqueue then if alloc_workqueue failed */
+	tport->wq_tty_flip = alloc_workqueue("ttyS%d-flip-wq",
+					     WQ_UNBOUND | WQ_SYSFS,
+					     0, p->port.line);
+
 	dmaengine_slave_config(dma->rxchan, &dma->rxconf);
 
 	/* Get a channel for TX */
@@ -252,7 +258,7 @@ int serial8250_request_dma(struct uart_8250_port *p)
 						       p->port.dev, "tx");
 	if (!dma->txchan) {
 		ret = -ENODEV;
-		goto release_rx;
+		goto release_rx_wq;
 	}
 
 	/* 8250 tx dma requires dmaengine driver to support terminate */
@@ -294,6 +300,11 @@ int serial8250_request_dma(struct uart_8250_port *p)
 	return 0;
 err:
 	dma_release_channel(dma->txchan);
+release_rx_wq:
+	if (tport->wq_tty_flip) {
+		destroy_workqueue(tport->wq_tty_flip);
+		tport->wq_tty_flip = NULL;
+	}
 release_rx:
 	dma_release_channel(dma->rxchan);
 	return ret;
@@ -303,6 +314,7 @@ EXPORT_SYMBOL_GPL(serial8250_request_dma);
 void serial8250_release_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
+	struct tty_port *tport = &p->port.state->port;
 
 	if (!dma)
 		return;
@@ -322,6 +334,11 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dma->txchan = NULL;
 	dma->tx_running = 0;
 
+	if (tport->wq_tty_flip) {
+		destroy_workqueue(tport->wq_tty_flip);
+		tport->wq_tty_flip = NULL;
+	}
+
 	dev_dbg_ratelimited(p->port.dev, "dma channels released\n");
 }
 EXPORT_SYMBOL_GPL(serial8250_release_dma);
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 67271fc0b..7f83f377f 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -530,7 +530,7 @@ void tty_flip_buffer_push(struct tty_port *port)
 	struct tty_bufhead *buf = &port->buf;
 
 	tty_flip_buffer_commit(buf->tail);
-	queue_work(system_unbound_wq, &buf->work);
+	queue_work(port->wq_tty_flip ?: system_unbound_wq, &buf->work);
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 332ddb936..f5a5e50ff 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -121,6 +121,7 @@ struct tty_port {
 	int			drain_delay;
 	struct kref		kref;
 	void			*client_data;
+	struct workqueue_struct *wq_tty_flip;
 };
 
 /* tty_port::iflags bits -- use atomic bit ops */
-- 
2.34.1

