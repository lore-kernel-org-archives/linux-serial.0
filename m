Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0E530EF96;
	Tue, 21 Oct 2025 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036020; cv=none; b=THzFxx0XRQhIjAvvI7yaD2sjG70Mp9rCD8etBK0nJePbDBRmJPTgTApNpPC27hHeAIFMHoT+sWNighkBRWZjwP8FByJnFkfryJUjkkyJ0G9xn/yfQWgoPkb2WasE6tOgSvoHxdYg5NImFfvFzcVkv0IImnJW8TaVLnI9v4t45s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036020; c=relaxed/simple;
	bh=6GvszD4k30k14LRU5kjplPeEIsOAoPLv5KEhnBxMU4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OYrzGL+BjQC0DlPZtrkdIZKcFc3zwG+rpbkm1SES1zMK8ySwLrroFSw7puNddASQmoUAxZwordFGGMpvYrDtRtMgE8U89yEgGzEsYNynJLt8PKg++Wj52Zl2EFr/TYRzs+9mido7mXuoqtPEt3Ekx2++i/76C/LmX8vZKwK7t3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=REuyJlIH; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="REuyJlIH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=k7
	jOLgF/O1DqtBwLXTDxtFPlJqI0+MQTD0oEBqIYiSE=; b=REuyJlIHYT306cKcsE
	TyPmc1AOe7HxMBV8WFL2PQ26B3IateowLg/kVstmhdLTwkUF2aTYiD1+EXlYaTPU
	/TE3BWsDmrtAFqUgDRyL3oVf/bJscfwWMY0BeHSsu8S9JRqSMTZAkApvvVbIK/uC
	cb0/MxeAF1Vwk4TbiTCvCeXzQ=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnrdzVRvdotXAZBw--.8968S2;
	Tue, 21 Oct 2025 16:39:50 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	tj@kernel.org,
	hch@infradead.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH v1 2/2] serial: 8250_dma: add parameter to queue work on specific cpu
Date: Tue, 21 Oct 2025 16:39:47 +0800
Message-Id: <20251021083947.705135-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnrdzVRvdotXAZBw--.8968S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFWDAw1fuF1DAw4fCryxuFg_yoW7ArWkpF
	4rArWqvry8tasFyw1kGr4xXw4fZayftr47ur97K34SyFn0yF909Fs3KFWF9rWkCF95Xr1a
	vFZ09F1UC3W2vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziqg4DUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRxPtCmj3QkFeZQAAsU

On the embedded platform, certain critical data, such as IMU data, is
transmitted through UART. The tty_flip_buffer_push interface in the TTY
layer uses system_unbound_wq to handle the flipping of the TTY buffer.
Although the unbound workqueue can create new threads on demand and wake
up the kworker thread on an idle CPU, the priority of the kworker thread
itself is not high. Even if the CPU running this work was idle just a
moment ago, it may be preempted by real-time tasks or other high-priority
tasks.
In our system, the processing interval for each frame of IMU data
transmitted via UART can experience significant jitter due to this issue.
Instead of the expected 10 to 15 ms frame processing interval, we see
spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
be 2 to 3 occurrences of such high jitter, which is quite frequent. This
jitter exceeds the software's tolerable limit of 20 ms.
Add module param tty_flip_cpu to queue rx complete work on the specific
cpu by tty_flip_buffer_push_wq. The default value of tty_flip_cpu is
WORK_CPU_UNBOUND which means using the default system_unbound_wq called
by tty_flip_buffer_push, otherwise we use the newly added workqueue
wq_tty_flip which is set to WQ_HIGHPRI to promote performance.
We set tty_flip_cpu to a specific CPU core that has relatively few
real-time tasks running continuously for long periods. Additionally,
tasks on this core have some correlation with the UART data related to
the 8250 DMA operation. After queuing work to this designated CPU and
set workqueue to WQ_HIGHPRI, we can stably eliminate the jitter and
ensure that the frame processing interval remains between 10 and 15 ms.
If we do not add the WQ_HIGHPRI flag, our testing on the platform shows
that there are still spikes occurring approximately once every hour.
Considering that projects utilizing this optimization feature must have
encountered similar issues to ours, just add the WQ_HIGHPRI flag in the
patch, without adding new module parameters for selection.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 drivers/tty/serial/8250/8250.h     |  2 ++
 drivers/tty/serial/8250/8250_dma.c | 46 ++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index cfe6ba286..e6da925df 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -20,6 +20,8 @@ struct uart_8250_dma {
 	void (*prepare_tx_dma)(struct uart_8250_port *p);
 	void (*prepare_rx_dma)(struct uart_8250_port *p);
 
+	struct workqueue_struct *wq_tty_flip;
+
 	/* Filter function */
 	dma_filter_fn		fn;
 	/* Parameter to the filter function */
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index bdd26c9f3..9a0abee62 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -38,6 +38,35 @@ static void __dma_tx_complete(void *param)
 	uart_port_unlock_irqrestore(&p->port, flags);
 }
 
+#define TTY_FLIP_WORK_CPU		WORK_CPU_UNBOUND
+
+static int wq_tty_flip_cpu = TTY_FLIP_WORK_CPU;
+
+static int param_set_tty_flip_cpu(const char *val,
+					const struct kernel_param *kp)
+{
+	int cpu;
+	int ret;
+
+	ret = kstrtoint(val, 0, &cpu);
+	if (ret)
+		return ret;
+
+	if ((cpu >= 0 && cpu < nr_cpu_ids) || cpu == WORK_CPU_UNBOUND)
+		wq_tty_flip_cpu = cpu;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct kernel_param_ops tty_flip_cpu_ops = {
+	.set	= param_set_tty_flip_cpu,
+	.get	= param_get_int,
+};
+
+module_param_cb(tty_flip_cpu, &tty_flip_cpu_ops, &wq_tty_flip_cpu, 0644);
+
 static void __dma_rx_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma	*dma = p->dma;
@@ -61,7 +90,10 @@ static void __dma_rx_complete(struct uart_8250_port *p)
 	p->port.icount.rx += count;
 	dma->rx_running = 0;
 
-	tty_flip_buffer_push(tty_port);
+	if (wq_tty_flip_cpu == WORK_CPU_UNBOUND)
+		tty_flip_buffer_push(tty_port);
+	else
+		tty_flip_buffer_push_wq(tty_port, dma->wq_tty_flip, wq_tty_flip_cpu);
 }
 
 static void dma_rx_complete(void *param)
@@ -244,6 +276,12 @@ int serial8250_request_dma(struct uart_8250_port *p)
 		goto release_rx;
 	}
 
+	dma->wq_tty_flip = alloc_workqueue("wq_tty_flip", WQ_PERCPU | WQ_HIGHPRI, 0);
+	if (!dma->wq_tty_flip) {
+		ret = -ENOMEM;
+		goto release_rx;
+	}
+
 	dmaengine_slave_config(dma->rxchan, &dma->rxconf);
 
 	/* Get a channel for TX */
@@ -252,7 +290,7 @@ int serial8250_request_dma(struct uart_8250_port *p)
 						       p->port.dev, "tx");
 	if (!dma->txchan) {
 		ret = -ENODEV;
-		goto release_rx;
+		goto release_rx_wq;
 	}
 
 	/* 8250 tx dma requires dmaengine driver to support terminate */
@@ -294,6 +332,8 @@ int serial8250_request_dma(struct uart_8250_port *p)
 	return 0;
 err:
 	dma_release_channel(dma->txchan);
+release_rx_wq:
+	destroy_workqueue(dma->wq_tty_flip);
 release_rx:
 	dma_release_channel(dma->rxchan);
 	return ret;
@@ -322,6 +362,8 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dma->txchan = NULL;
 	dma->tx_running = 0;
 
+	destroy_workqueue(dma->wq_tty_flip);
+
 	dev_dbg_ratelimited(p->port.dev, "dma channels released\n");
 }
 EXPORT_SYMBOL_GPL(serial8250_release_dma);
-- 
2.34.1

