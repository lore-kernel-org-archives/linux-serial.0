Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661288;
	b=By32JNcVR4mb5rTUmSxIv+l2biMaKAShtY+jLt1d5d+IxqhExn0yLS8sW1V+91oXy47I
	 6ZHc3G/HMTXGObRIiF0ISI5lh/U91tz305O0SguTyvDUvBv7vfb/nFUlwZMNBGmdkfraS
	 NZiAo+A6jqxc+neLxzH71Etvrv6JqBomLm2kPEDSNzttxEEgx1YHw12LnnUPSzkR4a7bE
	 Z8LIcD9TwfvhpUPsuXrh2/imL9ADoURPmqi+wflvn6+E3TiMpZnKXsdoUUChNPJOyAnB2
	 zacT4jsHU/2v5Y5SEghdkSzXE0ojhQ4tMwYUwZAtm3Bowdq1wlWrkCWL4K9orbdyN/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=M2XizxjRx7xN+F/hlanXYNYyKgk6aZTIwuutS9IFyiI=;
	b=isiedrq8hniS01qp7aB8dJ7FSGpFmvffhva5uMd9j7V6351oLE8xoyZJ314Ew1BU8Hpv
	 iDTZUnkwK3xpdDRPr2rSeBUEd7THpdOT19QH46Cl2wPDHa59a+wwpvUUZzLPFrl67k31D
	 r0Jg5AOSqCx8Dw+QR4v0HR7IJSmIH+aemSikzeRw5MFkSgsnRlxHmAEvhVF6hTpTjNjN6
	 t0uVlBtNo1ZDin5qDz0FZj+nnW8HHunGnfyGlba0bQh7Wf7QhDhV/m28sz/tSQD2Xqe8d
	 4oZLE2J5oQxSfFgRXo/+OmT64Y13BvnLR1fc0QooF51jy13aqGl9dp50FwH8N2QSuHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A9lMPXMH;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3656083612
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 23:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD3656083612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A9lMPXMH
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6df0b02fe91so97037eaf.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 15:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793661287; x=1794266087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M2XizxjRx7xN+F/hlanXYNYyKgk6aZTIwuutS9IFyiI=;
        b=A9lMPXMH+DO7rBt4pf7Uqrr7aewt3CBvqxqOv1/14fiNMERFeysWVuyhAJRMU29pAC
         8k5Djm6TImLq4zESeLhAVZJ9tHRiihDnxu0Rgkn8o72e5vYF1B2fwWdfm0q7HfFCft/0
         uyFdh/YXGTubPJQOyyegYbEI8Z/isfXhaZSRO6LBqD6GuWl0DP+feyBxLhVFu80tB8eh
         ST9kl/H3mUcMZcityAwAKUiTj30E1FcePKd+qFLAM6teFlj269hmu5jprrf2n8Vcsduf
         bDjG50cmzDkg+0xA37wjSP3TvbC2ahLZrRw3pVHJ0vsMh0mamIUxsZdmNb8nq58f66V3
         H+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661287; x=1794266087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2XizxjRx7xN+F/hlanXYNYyKgk6aZTIwuutS9IFyiI=;
        b=uRNPq6bcdmdsBqAV26DEoRk9tv0kSwVqIg1uAl2ry1EaSv4eRP7fSTBoZjIXnBXust
         vF/t2R8mQ3f2P4Gl0YhxHG4QEi+jKptOrYQqBFd6G0Epo5XYaTSHuXylDGduMuO8kQKo
         hfKgipOLksqcqbjqeCCJgMR0LuxmtfRgYK7kZfvGBIzIPci6zO1ohJbWWDkh7owCGJmP
         R3g8bwXwGgXMF8Mwhebar07lpxqXRURUtEkB2TAQBNAYstRTJEdxoboUJRMYtk+fWVSn
         euPL/qBR6+iJ0UTWGVyiMR1B6WEHLw2u7Qg+QxXYtRYMNXpip3L7tUMtXw5t2jF9te40
         oTGw==
X-Forwarded-Encrypted: i=1; AKwUvBwFE8DQgfzAILNRFxl4Y8+c7JKs5pKbpSvtVlWda8Gb5x1UKt0Zy7b4JXdVDLPzfIP1uAoVNjL6kasqqX4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnRSDP9fl0OtG/5UEdmVJVxxzw99Yb4ClepS+OyCVH8gTkrR5H
	hSOC0MYpouNFVja6kfWulFlZ2WFdRHC0Em64hOI1YDXtL6ACItvZjNKe
X-Gm-Gg: AYBFou0Ltzd8ZFOEPEWF4Uk2psC1h/2vbXdJO8PrlzeSDnAggpbgJUdf8oFgJWHjMMt
	MkYUJrrM4BXWHSsOzFWuglXDBhR5ZNVvVi3Su8n3lpafwp721FGURUAuS8717Ph2dFtbpoxvNE1
	xB2FPmPUdCefeRkLDPd3XZJ79s0MVFx3WTzcjdkSewjQlOGLYfJOAY0rKj1HnB8RjZMP+bPp463
	pGfSj+YcKWlZeZzfKIKUCK4eAidhECF9slBnASDbn3pJ51ucCWLoGKz4G5Q+UejdbKuU6MS9Ff9
	/zkU7Q6xDxDrBEXUYgPLBxTAAm2HbkwGgGXGtHHSxKQUBU23VybDwa2KP90JwJTXPyc8D0ejhws
	AT8ZGUDjodjskDH7P+1K6hR6qnay/KxBRGzxIKoPz2hlNb9jB90V2JQ7dDfRNM3iruJwpV6wKgf
	FF6aaF0Vjy5CvV6vflvfCdRLIfIdQ4q4RHQlLcfWLRkjivSPK4RV+zfyo/6tBiEk3EwzRgu/OPz
	9D7MbkZ0/K8LETm9iSnUJVolXzD4MODzoDWxOsuBz2KwbXQ3tWbTtNHouIsTBsa4vFLxZ1cHZWr
	jRp8Asu/dOm4/mrpYaeNwK/KamogNB4N4rWqQmJojFUiSpujOZ0ympbK3TI8LZDhmbBKnxHn7KS
	GxjgJz/Qo+wYktMruygv1AwV2vLyutC50DC4dto1a6G7nHZE3JXbuUUQPLIcZImLMMwnLhseJEo
	j1Q4Gak9/lrZi09gHxHlKphuzTI8TERBr+JVGUrrnYcasG6wshzBU=
X-Received: by 2002:a05:6820:1612:b0:713:da3b:9049 with SMTP id 006d021491bc7-714f2942b37mr4721551eaf.7.1793661286589;
        Mon, 02 Nov 2026 15:14:46 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce869asm10134463eaf.4.2026.11.02.15.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:14:46 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 16:14:33 -0700
Subject: [PATCH v9 6/8] serial: 8250: drain canceled TX DMA before reusing
 its buffer
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-submit-serial-8250-dma-cancel-v1-v9-6-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Timur Tabi <timur@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

uart_flush_buffer() resets the transmit kfifo before calling the driver.
serial8250_tx_dma_flush() terminates DMA asynchronously and clears
tx_running, allowing a new write to replace tx_size while a detached
callback has not yet run. That callback can then consume bytes
from the new transmission. Reusing the reset kfifo can also overwrite the
source of a transfer that has not stopped yet.

Reserve the flushed FIFO storage through serial core before returning
from the flush callback. Keep tx_running set until a worker synchronizes
the terminated channel, suppressing old callbacks and new submissions
during that interval. Return the mapping to CPU ownership before releasing
the reservation and waking writers. Normal transfers continue to use the
FIFO directly.

Reuse the locked completion processing after retirement, including OMAP
delayed register restoration and transmitter-empty handling. Take a runtime
PM reference around worker UART accesses and drain the worker before
releasing the channels. Shutdown releases the FIFO reservation after
stopping DMA and unmapping its source. Serial core keeps writes and wakeups
gated until startup or resume makes the port ready again.

Track a flushed FIFO separately from the transfer length. If termination
fails, retain the reservation until normal completion and account the
completed bytes without advancing the reset FIFO. After successful
cancellation, process a zero-length completion once callbacks have drained.

The race was found by inspecting cancellation and restart while preparing
H616 UART DMA support.

Retain the tx_running check in both completion callbacks. Releasing the
reservation relies on the DMA provider draining detached callbacks when
dmaengine_synchronize() returns; provider callback-lifetime fixes supply
that guarantee for controllers which previously lacked it.

Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  20 +++++-
 drivers/tty/serial/8250/8250_dma.c  | 130 ++++++++++++++++++++++++++----------
 drivers/tty/serial/8250/8250_omap.c |  21 ++++--
 3 files changed, 125 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 974a47f24084..9f01fa36fa3c 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -11,6 +11,7 @@
 #include <linux/serial_8250.h>
 #include <linux/serial_core.h>
 #include <linux/dmaengine.h>
+#include <linux/workqueue.h>
 
 #include "../serial_mctrl_gpio.h"
 
@@ -19,6 +20,10 @@ struct uart_8250_dma {
 	int (*rx_dma)(struct uart_8250_port *p);
 	void (*prepare_tx_dma)(struct uart_8250_port *p);
 	void (*prepare_rx_dma)(struct uart_8250_port *p);
+	/* Completion processing with the port lock held. */
+	void (*tx_complete)(struct uart_8250_port *p);
+	struct work_struct tx_flush_work;
+	struct uart_8250_port *port;
 
 	/* Filter function */
 	dma_filter_fn		fn;
@@ -52,7 +57,9 @@ struct uart_8250_dma {
 	unsigned char		tx_err;
 	unsigned char		rx_running;
 	/* Protected by the UART port lock. */
-	bool			shutting_down;
+	bool			shutting_down:1;
+	bool			tx_terminating:1;
+	bool			tx_flushed:1;
 };
 
 struct old_serial_port {
@@ -400,8 +407,15 @@ static inline int is_omap1510_8250(struct uart_8250_port *pt)
 #endif
 
 #ifdef CONFIG_SERIAL_8250_DMA
+static inline bool serial8250_tx_dma_blocked(struct uart_8250_dma *dma)
+{
+	return dma->shutting_down || dma->tx_terminating;
+}
+
 extern int serial8250_tx_dma(struct uart_8250_port *);
 extern void serial8250_tx_dma_flush(struct uart_8250_port *);
+void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
+				   struct scatterlist *sgl, unsigned int nents);
 extern int serial8250_rx_dma(struct uart_8250_port *);
 extern void serial8250_rx_dma_flush(struct uart_8250_port *);
 extern int serial8250_request_dma(struct uart_8250_port *);
@@ -434,7 +448,7 @@ static inline void serial8250_tx_dma_pause(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
 
-	if (!dma->tx_running)
+	if (!dma->tx_running || serial8250_tx_dma_blocked(dma))
 		return;
 
 	dmaengine_pause(dma->txchan);
@@ -444,7 +458,7 @@ static inline void serial8250_tx_dma_resume(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
 
-	if (!dma->tx_running)
+	if (!dma->tx_running || serial8250_tx_dma_blocked(dma))
 		return;
 
 	dmaengine_resume(dma->txchan);
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 57fc7915adac..344f0dd24b41 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -11,24 +11,23 @@
 
 #include "8250.h"
 
-static void __dma_tx_complete(void *param)
+static void serial8250_tx_dma_complete(struct uart_8250_port *p)
 {
-	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tport = &p->port.state->port;
-	unsigned long	flags;
 	int		ret;
 
-	uart_port_lock_irqsave(&p->port, &flags);
-	if (dma->shutting_down)
-		goto out;
-
 	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
 	dma->tx_running = 0;
 
-	uart_xmit_advance(&p->port, dma->tx_size);
+	if (dma->tx_flushed) {
+		p->port.icount.tx += dma->tx_size;
+		uart_xmit_unblock(&p->port);
+	} else {
+		uart_xmit_advance(&p->port, dma->tx_size);
+	}
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(&p->port);
@@ -36,11 +35,57 @@ static void __dma_tx_complete(void *param)
 	ret = serial8250_tx_dma(p);
 	if (ret || !dma->tx_running)
 		serial8250_set_THRI(p);
+}
 
-out:
-	uart_port_unlock_irqrestore(&p->port, flags);
+static void __dma_tx_complete(void *param)
+{
+	struct uart_8250_port *p = param;
+	struct uart_8250_dma *dma = p->dma;
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	if (serial8250_tx_dma_blocked(dma) || !dma->tx_running)
+		return;
+	serial8250_tx_dma_complete(p);
+}
+
+static void serial8250_tx_dma_flush_work(struct work_struct *work)
+{
+	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma, tx_flush_work);
+	struct uart_8250_port *p = dma->port;
+
+	/* Neither the channel nor its buffer may be reused before this returns. */
+	dmaengine_synchronize(dma->txchan);
+
+	guard(serial8250_rpm)(p);
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	dma->tx_terminating = false;
+	dma->tx_size = 0;
+	if (dma->shutting_down)
+		return;
+	dma->tx_complete(p);
 }
 
+void serial8250_tx_dma_sync_buffer(struct uart_8250_port *p,
+				   struct scatterlist *sgl, unsigned int nents)
+{
+	struct uart_8250_dma *dma = p->dma;
+	struct device *dev = dmaengine_get_dma_device(dma->txchan);
+	struct scatterlist *sg;
+	unsigned int i;
+
+	/* DMA reads the FIFO directly; its occupied ranges remain reserved. */
+	for_each_sg(sgl, sg, nents, i) {
+		size_t offset = sg_dma_address(sg) - dma->tx_addr;
+
+		dma_sync_single_range_for_device(dev, dma->tx_addr, offset,
+						 sg_dma_len(sg), DMA_TO_DEVICE);
+	}
+}
+EXPORT_SYMBOL_GPL(serial8250_tx_dma_sync_buffer);
+
 static void __dma_rx_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma	*dma = p->dma;
@@ -101,7 +146,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	int i;
 	int ret;
 
-	if (dma->shutting_down)
+	if (serial8250_tx_dma_blocked(dma))
 		return 0;
 
 	if (dma->tx_running) {
@@ -131,24 +176,25 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 		dma->tx_size += sg_dma_len(sg);
 
 	serial8250_do_prepare_tx_dma(p);
+	serial8250_tx_dma_sync_buffer(p, sgl, ret);
 
 	desc = dmaengine_prep_slave_sg(dma->txchan, sgl, ret,
 				       DMA_MEM_TO_DEV,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
+		dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
+					UART_XMIT_SIZE, DMA_TO_DEVICE);
 		ret = -EBUSY;
 		goto err;
 	}
 
 	dma->tx_running = 1;
+	dma->tx_flushed = false;
+	dma->tx_complete = serial8250_tx_dma_complete;
 	desc->callback = __dma_tx_complete;
 	desc->callback_param = p;
 
 	dma->tx_cookie = dmaengine_submit(desc);
-
-	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
-				   UART_XMIT_SIZE, DMA_TO_DEVICE);
-
 	dma_async_issue_pending(dma->txchan);
 	serial8250_clear_THRI(p);
 	dma->tx_err = 0;
@@ -162,32 +208,31 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 void serial8250_tx_dma_flush(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
+	int ret;
 
-	if (!dma->tx_running)
+	if (!dma->tx_running || serial8250_tx_dma_blocked(dma))
 		return;
 
 	/*
 	 * kfifo_reset() has been called by the serial core, avoid
-	 * advancing and underflowing in __dma_tx_complete().
+	 * advancing the reset FIFO when the old transfer completes.
 	 */
-	dma->tx_size = 0;
+	dma->tx_flushed = true;
+	/* The core reset the FIFO indices, but DMA may still read its storage. */
+	uart_xmit_block(&p->port);
 
 	/*
 	 * We can't use `dmaengine_terminate_sync` because `uart_flush_buffer` is
 	 * holding the uart port spinlock.
 	 */
-	dmaengine_terminate_async(dma->txchan);
-
-	/*
-	 * The callback might or might not run. If it doesn't run, we need to ensure
-	 * that `tx_running` is cleared so that we can schedule new transactions.
-	 * If it does run, then the zombie callback will clear `tx_running` again
-	 * and perform a no-op since `tx_size` was cleared above.
-	 *
-	 * In either case, we ASSUME the DMA transaction will terminate before we
-	 * issue a new `serial8250_tx_dma`.
-	 */
-	dma->tx_running = 0;
+	dma->tx_terminating = true;
+	ret = dmaengine_terminate_async(dma->txchan);
+	if (ret) {
+		/* Keep the buffer owned by the transfer until its callback runs. */
+		dma->tx_terminating = false;
+		return;
+	}
+	schedule_work(&dma->tx_flush_work);
 }
 
 int serial8250_rx_dma(struct uart_8250_port *p)
@@ -312,21 +357,28 @@ int serial8250_request_dma(struct uart_8250_port *p)
 		goto err;
 	}
 
-	/* TX buffer */
+	/* Normal TX uses serial core's FIFO; flush reserves it until retirement. */
 	dma->tx_addr = dma_map_single(tx_dev, p->port.state->port.xmit_buf,
 				      UART_XMIT_SIZE, DMA_TO_DEVICE);
 	if (dma_mapping_error(tx_dev, dma->tx_addr)) {
-		dma_free_coherent(rx_dev, dma->rx_size,
-				  dma->rx_buf, dma->rx_addr);
 		ret = -ENOMEM;
-		goto err;
+		goto free_rx;
 	}
+	dma_sync_single_for_cpu(tx_dev, dma->tx_addr, UART_XMIT_SIZE, DMA_TO_DEVICE);
+
+	dma->port = p;
+	INIT_WORK(&dma->tx_flush_work, serial8250_tx_dma_flush_work);
 
-	scoped_guard(uart_port_lock_irqsave, &p->port)
+	scoped_guard(uart_port_lock_irqsave, &p->port) {
+		dma->tx_terminating = false;
+		dma->tx_flushed = false;
 		dma->shutting_down = false;
+	}
 	dev_dbg_ratelimited(p->port.dev, "got both dma channels\n");
 
 	return 0;
+free_rx:
+	dma_free_coherent(rx_dev, dma->rx_size, dma->rx_buf, dma->rx_addr);
 err:
 	dma_release_channel(dma->txchan);
 release_rx:
@@ -342,6 +394,8 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	if (!dma)
 		return;
 
+	cancel_work_sync(&dma->tx_flush_work);
+
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
 	dma->rx_running = 0;
@@ -356,7 +410,11 @@ void serial8250_release_dma(struct uart_8250_port *p)
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
 	dma_release_channel(dma->txchan);
 	dma->txchan = NULL;
-	dma->tx_running = 0;
+	scoped_guard(uart_port_lock_irqsave, &p->port) {
+		dma->tx_running = 0;
+		dma->tx_terminating = false;
+		uart_xmit_unblock(&p->port);
+	}
 
 	dev_dbg_ratelimited(p->port.dev, "dma channels released\n");
 }
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index fc1a83d6fa7c..9211ccda316a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1099,7 +1099,12 @@ static void omap_8250_tx_dma_complete(struct uart_8250_port *p)
 
 	dma->tx_running = 0;
 
-	uart_xmit_advance(&p->port, dma->tx_size);
+	if (dma->tx_flushed) {
+		p->port.icount.tx += dma->tx_size;
+		uart_xmit_unblock(&p->port);
+	} else {
+		uart_xmit_advance(&p->port, dma->tx_size);
+	}
 
 	if (priv->delayed_restore) {
 		priv->delayed_restore = 0;
@@ -1132,7 +1137,7 @@ static void omap_8250_dma_tx_complete(void *param)
 
 	guard(uart_port_lock_irqsave)(&p->port);
 
-	if (dma->shutting_down)
+	if (serial8250_tx_dma_blocked(dma) || !dma->tx_running)
 		return;
 	omap_8250_tx_dma_complete(p);
 }
@@ -1147,7 +1152,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 	int skip_byte = -1;
 	int ret;
 
-	if (dma->shutting_down || dma->tx_running)
+	if (serial8250_tx_dma_blocked(dma) || dma->tx_running)
 		return 0;
 	if (uart_tx_stopped(&p->port) || kfifo_is_empty(&tport->xmit_fifo)) {
 
@@ -1206,24 +1211,26 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 		goto err;
 	}
 
+	serial8250_tx_dma_sync_buffer(p, &sg, 1);
+
 	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1, DMA_MEM_TO_DEV,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
+		dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
+					UART_XMIT_SIZE, DMA_TO_DEVICE);
 		ret = -EBUSY;
 		goto err;
 	}
 
 	dma->tx_size = sg_dma_len(&sg);
 	dma->tx_running = 1;
+	dma->tx_flushed = false;
+	dma->tx_complete = omap_8250_tx_dma_complete;
 
 	desc->callback = omap_8250_dma_tx_complete;
 	desc->callback_param = p;
 
 	dma->tx_cookie = dmaengine_submit(desc);
-
-	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
-				   UART_XMIT_SIZE, DMA_TO_DEVICE);
-
 	dma_async_issue_pending(dma->txchan);
 	if (dma->tx_err)
 		dma->tx_err = 0;

-- 
2.53.0

