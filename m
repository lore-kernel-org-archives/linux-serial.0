Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793450286;
	b=wt+DsNoqui0ow/4OmdgnQu6lhDvsOOIq4nL8TRr+O0H4ewiX8OBuPeBmCTDZA683rBkk
	 FchRxbJ7hD0hI7gROOjqGMdlSwVkkzKU8CC8P5FULKuY5G0UTGwNeTdP1t4gMKcmX74n8
	 XTtWwBOL7UA+3/pOLLVCBHZ8lp7YPNh/KDByCwCl+pdeAYsFuGUKjZ+C4HJrsV7fuMoV6
	 WQyIwzaU34B8Rw+bzM9r3yIrWCA27KwcY/om/wPuRKFasfsxLHOxY1uqM+fOXhRzkCjP8
	 Hx2ko19ozFWHF6ES6iDqU5J4dlziSKOhoOIiLUtEg3HdTCY9Ly2Alvc9TzmZbOpOzdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793450286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=maS1TlQtTNtCaHJfozZuk+FUqQKZG+g+AwgR3S2V5EU=;
	b=46DXLUtqj0W7DoMeFSouqPhToavNqQwgIFmRWjVmKYn9eLoHnkkEZO0PcyxBIEHCUkVR
	 JR/U7wzUwXw5Pwh4lKjTeQWYrXOzt/yIhscxKmgHipQGqF2wzQ1COA48BNfXHCusBfTZO
	 lDxNB37bx4V/WxMSteqcTa1+GXkdAlSRanOM+Y09suMuONCYHlto+N3tS0c++cLrcGyAU
	 tc5VdWHf1Bp/PWhH7Ea0MzyVW8Oi8ej+zLrarylALtvqLML4fa0dVo91oxFZM8RVT2Tdh
	 vh9td1EyLfKiN/AnIFNa1NqonkjC9dstUgORAuIjBvFeupJEKEE9ClfI8K1RW3cH97g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8JKjXk3;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26122606A31E
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 12:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26122606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U8JKjXk3
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1ae18eb9b69so911629c88.0
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 05:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793450285; x=1794055085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=maS1TlQtTNtCaHJfozZuk+FUqQKZG+g+AwgR3S2V5EU=;
        b=U8JKjXk3DYErMaXytKjt953ljSKW3ppg9GTvcuywwBmgHb9qsx/TYxkg1QCQhybUYE
         AyUsBc6WOUe2ejfl5VdAi4tvlr1QPIGrqmnj1b2Vkh4WjCMveaQo7BkiOTiu3JRA9KHl
         5XxJ5doDpvLiYKYoAHBCR63xb6RcfA8TPTcka71YuK3yYmIW4oZ9IZnhv0v8xcGcRnMb
         qUXAbsMDfItKeD/+I8/yFeq7hDWZWYUYK3ryc5Y/txSSUsSZWquoT6TtvN7GRLVbr3Ud
         kSv5fj6GuigqTiij6/noqO7CImceKPwkJ7B1NGgpIG1jrepjjRLK6qpnUr6uFd/q/Fl3
         gn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793450285; x=1794055085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=maS1TlQtTNtCaHJfozZuk+FUqQKZG+g+AwgR3S2V5EU=;
        b=CIVdKnlhULdF88D2CAaFxo+Dj1R4asKqa+7M5vS9tPDQ+HcGHku3Xi6LDF8sWr9PgM
         N287j8a+N9KFul1er0bywBmgjXtE3bZnddC5mTDb5qQdOPXD1Xcl+TZ7cYzeC5N7Sy+g
         SHPNb/psAq38dSm6snOhTDv0GlWsr8rUXKczFHNZLFcHv4PKvgOsUNyrnc8YsT7jcK6R
         hKeiyKaKKb95/oxEBd7+fuGs2dNoCiTFpe3fpeH1ilu35NEgDeQLvdZA77BGBLxb7iV6
         L1t9q42W06bzU0CpZ/HocHuvE+DuvSlgwCm3o0s4wXYF+GACAy6JQ7VCv1ZkWQHPyVTt
         6oEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxM35S0ae5WsQXv1aHCYF70DWajofYr4oZfwtS/YuWVollr4fFMqXcWSXToHc8J2hM2EGCU95i7MNQoPs8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4f0vslVHrDkPjY0O3wghgHrS3hExEWKd67ZsoZSAQNySSBx4J
	51s5pV5xdzPmfBKP3abkP8lZqLOdjuwzi/KYz5Zzjuj+rdOFSbR095mj
X-Gm-Gg: AYBFou2BwJ6pZr0BEiW9r07PnpVj29oD0BW1HKfuuJOyAsSuxRIOltC2GyyS6IEMQTE
	K8YvVIPGDJuBrdJxvRjFGfr7xv3QmEw8aqkobZYpgifx7ZvzJMcYU5yOFuavwCREDpYDHK6M2HQ
	7g8oY0j6N3sO4Wu3nVPVSRmXqokRhwEmcKiJshSJcFxE12mWNv/ozWxhpuR49zuJfXe1v86NI0l
	6iqaFQ+6RaLJhy1ilS/OLgHrPGhofaf876EOkkEsAdVf/MR2pHtsbh21x9ND2Y57HHN0DzNOStC
	kOq7hV79VW2zi2+KHvSRay3hckTQdX85yQvA8dJEPIa1ekvV1fTDPVZ5twtmYCzeLnu3L92bB2N
	xSjzaHrwdsDOvmxydKm9HsvYH2RfYD52s8USB1QH6ZSXpDKCojMG2XKrAdCj7EJuGG7Su6mYoAi
	0LhzWSS6eBi1K9hMYUotmjF2OEz2dchQSA7HUdnJkjR4vH71CvE/cNB/JZQTkUqdVmXn2DpH2F/
	GqyCNLdXB1jTiDirZ9xnViga6p/EklgcM0DOMFjpWSQfAhPl/W/zaGfe8F7/QjJ5Y8d1OonppWz
	TISjK573COC4mQ95b7gyFTw15zh1ep/WQOcKf1oHUfaSUPMuQh+tU/E7VuQuNn1Y5u+7OdTHOko
	m8XOEsfwlNCOwmqv8E/dfeEladg6pgVco3J4yMKv4UPfAuPgrqYS4Wpqiocr8Jv9MJsshWOb9CW
	27oYKGZdMFGx4tInD8AlRN/OZDHLSwlW4yQ44=
X-Received: by 2002:a05:7022:3a03:b0:152:9e88:daaa with SMTP id a92af1059eb24-1ac5f181628mr8313206c88.36.1793450284992;
        Sat, 31 Oct 2026 05:38:04 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a13652csm17300763c88.17.2026.10.31.05.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 05:38:04 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Samarth Narang <samarth.colleges@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tty: serial: fsl_lpuart: don't unmap TX buffer before DMA has stopped
Date: Sat, 31 Oct 2026 12:37:49 +0000
Message-Id: <20261031123749.3783352-3-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031123749.3783352-1-samarth.colleges@gmail.com>
References: <20261031005425.3351240-1-samarth.colleges@gmail.com>
 <20261031123749.3783352-1-samarth.colleges@gmail.com>
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

lpuart_flush_buffer() unmaps the TX scatterlist before calling
dmaengine_terminate_async(), allowing eDMA to continue reading from the
buffer after its mapping has been released. Reversing these operations
would not be sufficient, since asynchronous termination does not
guarantee that DMA has stopped and dmaengine_synchronize() is required
before releasing memory accessed by the descriptor.

The issue can be triggered through TCFLSH(TCOFLUSH), hangup, or close
while TX DMA is active. On systems using SWIOTLB, outstanding DMA reads
may access a bounce slot that has already been reassigned to another
device, potentially transmitting its contents over the serial line.

Since flush_buffer() runs under the port lock and cannot sleep, request
termination there while keeping the scatterlist mapped and
dma_tx_in_progress set to prevent reuse. Defer unmapping to a work item
that first calls dmaengine_synchronize(), have the TX completion
callback ignore flushed transfers, and ensure that shutdown and suspend
wait for the work to finish before resetting the TX DMA state.

Fixes: 6250cc30c4c4 ("tty: serial: fsl_lpuart: Use scatter/gather DMA for Tx")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
 drivers/tty/serial/fsl_lpuart.c | 53 +++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c8575c965203..8343351199eb 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -26,6 +26,7 @@
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/tty_flip.h>
+#include <linux/workqueue.h>
 
 /* All registers are 8-bit width */
 #define UARTBDH			0x00
@@ -280,6 +281,8 @@ struct lpuart_port {
 	unsigned int		dma_tx_bytes;
 	unsigned int		dma_rx_bytes;
 	bool			dma_tx_in_progress;
+	bool			dma_tx_flushing;
+	struct work_struct	dma_tx_flush_work;
 	unsigned int		dma_rx_timeout;
 	struct timer_list	lpuart_timer;
 	struct scatterlist	rx_sgl, tx_sgl[2];
@@ -530,7 +533,7 @@ static void lpuart_dma_tx_complete(void *arg)
 	unsigned long flags;
 
 	uart_port_lock_irqsave(&sport->port, &flags);
-	if (!sport->dma_tx_in_progress) {
+	if (!sport->dma_tx_in_progress || sport->dma_tx_flushing) {
 		uart_port_unlock_irqrestore(&sport->port, flags);
 		return;
 	}
@@ -558,6 +561,36 @@ static void lpuart_dma_tx_complete(void *arg)
 	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
+/*
+ * flush_buffer runs under the port lock and can only request termination.
+ * Unmap the TX scatterlist here, once the terminated transfer and its
+ * completion callback are known to have finished.
+ */
+static void lpuart_dma_tx_flush_work(struct work_struct *work)
+{
+	struct lpuart_port *sport = container_of(work, struct lpuart_port,
+						 dma_tx_flush_work);
+	struct dma_chan *chan = sport->dma_tx_chan;
+	unsigned long flags;
+
+	dmaengine_synchronize(chan);
+
+	uart_port_lock_irqsave(&sport->port, &flags);
+	if (sport->dma_tx_flushing) {
+		dma_unmap_sg(dmaengine_get_dma_device(chan), &sport->tx_sgl[0],
+			     sport->dma_tx_nents, DMA_TO_DEVICE);
+		sport->dma_tx_flushing = false;
+		sport->dma_tx_in_progress = false;
+	}
+	/* As in the TX callback: no restart while shutdown waits on dma_wait */
+	if (!waitqueue_active(&sport->dma_wait) &&
+	    !lpuart_stopped_or_empty(&sport->port))
+		lpuart_dma_tx(sport);
+	uart_port_unlock_irqrestore(&sport->port, flags);
+
+	wake_up(&sport->dma_wait);
+}
+
 static dma_addr_t lpuart_dma_datareg_addr(struct lpuart_port *sport)
 {
 	switch (sport->port.iotype) {
@@ -605,12 +638,16 @@ static void lpuart_flush_buffer(struct uart_port *port)
 	u32 fifo;
 
 	if (sport->lpuart_dma_tx_use) {
-		if (sport->dma_tx_in_progress) {
-			dma_unmap_sg(dmaengine_get_dma_device(chan), &sport->tx_sgl[0],
-				sport->dma_tx_nents, DMA_TO_DEVICE);
-			sport->dma_tx_in_progress = false;
-		}
 		dmaengine_terminate_async(chan);
+		/*
+		 * The transfer may still be reading the TX scatterlist: keep it
+		 * mapped (and dma_tx_in_progress set) until the flush work has
+		 * synchronized the channel.
+		 */
+		if (sport->dma_tx_in_progress && !sport->dma_tx_flushing) {
+			sport->dma_tx_flushing = true;
+			schedule_work(&sport->dma_tx_flush_work);
+		}
 	}
 
 	if (lpuart_is_32(sport)) {
@@ -1760,6 +1797,8 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 		goto err;
 
 	init_waitqueue_head(&sport->dma_wait);
+	INIT_WORK(&sport->dma_tx_flush_work, lpuart_dma_tx_flush_work);
+	sport->dma_tx_flushing = false;
 	sport->lpuart_dma_tx_use = true;
 	if (lpuart_is_32(sport)) {
 		uartbaud = lpuart32_read(&sport->port, UARTBAUD);
@@ -1926,6 +1965,7 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 	}
 
 	if (sport->lpuart_dma_tx_use) {
+		flush_work(&sport->dma_tx_flush_work);
 		if (wait_event_interruptible_timeout(sport->dma_wait,
 			!sport->dma_tx_in_progress, msecs_to_jiffies(300)) <= 0) {
 			sport->dma_tx_in_progress = false;
@@ -3179,6 +3219,7 @@ static int lpuart_suspend(struct device *dev)
 				writeb(temp, sport->port.membase + UARTCR5);
 			}
 			uart_port_unlock_irqrestore(&sport->port, flags);
+			flush_work(&sport->dma_tx_flush_work);
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_sync(sport->dma_tx_chan);
 		}
-- 
2.34.1

