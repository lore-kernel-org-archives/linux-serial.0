Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756137B03A;
	Wed,  8 Apr 2026 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633091; cv=none; b=F+xP4TWObk26g2Dq1tH+SXPfnJEZ4Yf+Pc7izaHV9ppH0xfEiBl5wJP+Z8PMTMYkLre9BzRQbR54A5ZJXEYzDVB/5dGTX+gg97rjzTr8wogQuaR85mDl1z9fXT0LojJU25cpCjZHL1qmCf2MHy4p553FHZoNawREYsxWlnzzwMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633091; c=relaxed/simple;
	bh=ugSiQmeeShsf9MP1HOVc66DgYUbnxxgKkUUksMuObP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTmHbWFXeZ2pqASg6aFI/9ImJQSZ6I3uVv3UomRZPy9XhuYwbAZE+FjA4DnYHGFWUJQ9FqyJh9WIDcOD5c8l6hELsmDwtP7gl/rXgi8moG1MClquA9QOCWKXWM2gY4patlfDmJoPWtMo7+D69TkT6tTY7O5wbPJSnm8HVoQp/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bjtu.edu.cn; spf=pass smtp.mailfrom=bjtu.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bjtu.edu.cn
Received: from DESKTOP-3MH7KM4 (unknown [223.104.41.120])
	by front_03 (Coremail) with SMTP id JTzCeUDwF7moAtZpRk6jAA--.53366S2;
	Wed, 08 Apr 2026 15:24:25 +0800 (CST)
From: Zhaoyang Yu <23120469@bjtu.edu.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	kees@kernel.org,
	fourier.thomas@gmail.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gszhai@bjtu.edu.cn,
	2426767509@qq.com
Subject: [PATCH] tty: serial: pch_uart: add check for dma_alloc_coherent()
Date: Wed,  8 Apr 2026 15:24:21 +0800
Message-ID: <20260408072421.831-1-23120469@bjtu.edu.cn>
X-Mailer: git-send-email 2.53.0.windows.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:JTzCeUDwF7moAtZpRk6jAA--.53366S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4rCF1UZr4UZw4rtw1UWrg_yoW8Ww1kpa
	9xZFWvyrW8t3Z3tF4rAw13Wr1rAan3Xa42grWUKw1ak342vrn7Kw15t34Fvr1rA3yxtwna
	v390yFW5uF48taDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBvb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1lnxkEFVAIw20F6cxK64vIFxWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jeFALUUUUU=
X-CM-SenderInfo: astrjiauwzquxmwxhvlgxou0/

From: Zhaoyang Yu <2426767509@qq.com>

Add a check for dma_alloc_coherent() failure to prevent a potential
NULL pointer dereference in dma_handle_rx(). Properly release DMA
channels and the PCI device reference using a goto ladder if the
allocation fails.

Signed-off-by: Zhaoyang Yu <2426767509@qq.com>
---
 drivers/tty/serial/pch_uart.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6729d8e83c3c..ba1fcd663fe2 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -689,8 +689,7 @@ static void pch_request_dma(struct uart_port *port)
 	if (!chan) {
 		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Tx)\n",
 			__func__);
-		pci_dev_put(dma_dev);
-		return;
+		goto err_pci_get;
 	}
 	priv->chan_tx = chan;
 
@@ -704,18 +703,26 @@ static void pch_request_dma(struct uart_port *port)
 	if (!chan) {
 		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Rx)\n",
 			__func__);
-		dma_release_channel(priv->chan_tx);
-		priv->chan_tx = NULL;
-		pci_dev_put(dma_dev);
-		return;
+		goto err_req_tx;
 	}
 
 	/* Get Consistent memory for DMA */
 	priv->rx_buf_virt = dma_alloc_coherent(port->dev, port->fifosize,
 				    &priv->rx_buf_dma, GFP_KERNEL);
+	if (!priv->rx_buf_virt)
+		goto err_req_rx;
 	priv->chan_rx = chan;
 
 	pci_dev_put(dma_dev);
+	return;
+
+err_req_rx:
+	dma_release_channel(chan);
+err_req_tx:
+	dma_release_channel(priv->chan_tx);
+	priv->chan_tx = NULL;
+err_pci_get:
+	pci_dev_put(dma_dev);
 }
 
 static void pch_dma_rx_complete(void *arg)
-- 
2.50.1

