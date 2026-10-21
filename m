Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622270;
	b=PzUPDN35/2zeouETduwX3b6DHg+T0/+3Sym8vWIIVVoS7NCzbpQrrbdN0SV4WSYKpwfi
	 kjJdVbKB/+PWSQZngnmI0VQ3Wi97ybCu6WFZwku26vqfIJdY3/HoOxSPv71fhYDo62kGQ
	 6QRKGDUU3+e6V0CcSU9Bh8WYa9Wj9rhTGliR0lPnrZVtmyRqpw+2ZRtPadTdNLNSxO57y
	 dP0kq/GbIIhXbN+a+e4zcQOSF+3JiNDWQq14C11vhE3kkuTYC2nQRdbkRtBfppYE7VZEp
	 7SnlfI+q+upoIxw743pWQnT4uMedGznd7GPmRl1Xfx2IWcamJLkoTYdF6gf0w85V+CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+2fN0tEnRRTl4390kb3/AEZPfclePjDdwwEIqRRQ7us=;
	b=KkBHi37eqLG72WxdX0Jt6dDZx7bI4EeKKZt5Z1rd/9Cy5z9vZiuttHXWDaYALoR4WLHH
	 Ktpqdcsw6tifyAW/zje/k8GYgT4QlWc4iQVp9xfS9Mq4rFS9wGa9QPEdEfi/sIKY7GsEU
	 ogTph9dc2xQb0EtiMDh05Xqqf7vhBXtizknbsEcnmljNrXVSwwKT1zIJ5vX83qzxAdVwG
	 9JHD4JDV7ncNPItgG/3ejV6NAXdaFJbs/z8CCHlZC3ax3fHjhiWsgFPDqKftfuTOSakfe
	 R2dKK+UaHzdq/Uyt/yXc27sTF7uwpxb5U0WSxZvuMAl20bYSRiDoDN04IY6K96nYaDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="G6q6t37/";
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C2606A31F
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 22:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B4C2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G6q6t37/
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-70059e4dab6so762688eaf.3
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792622268; x=1793227068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2fN0tEnRRTl4390kb3/AEZPfclePjDdwwEIqRRQ7us=;
        b=G6q6t37/LpikfrnUcSTD3GJYKrtNYVfuL2DXnKhZ3EU3UcPWRXURJrEQHpzP8q861H
         VRh/2J5uV/zeMV5BFMRNafHyRRGIZfikrS8ZaRoCrm5Qa5eoPZyGZchWYSjxOZEAkVlh
         lQv+RdW/Kh6/ZUQzZA43kONlXCPv++1quqyXT/oLkBaqX1Altijn+gYX48YudiqiryKz
         EyVKDkbNLws6ba6i4SPtyqPXjqrMJtp/vDlLOhEM5YjyaKmFRm6iXLkHF64QaI+4pXzm
         JJXEGPtptJT0KPRLUrPadhsjn3nRFoNK6XYdy/ofgBAts7aMJf7zLh9bqvsx2KKCyl3n
         AnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622268; x=1793227068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2fN0tEnRRTl4390kb3/AEZPfclePjDdwwEIqRRQ7us=;
        b=raey9/uMhXV8qJhe6V14zsizDUi2tSBQtq3dWgaksIyc4T/6wJO3VPlHZkUeR7NX3m
         iJgKg8uj0x/ePwRWO72nuhdPht02/u/jtBf0mA6B9UXCQiSDHPyDwzBUy/LV31fJuaiA
         31v/+hF6cFHXq71vzs5t8aIKTlhfJemf0hyn1aJabXh+fFbCSqy/c9F486FRxsbUfM+q
         9Rsw2t56HdrEMYuwB5IlUuvQiXBNQcczeEfBaej6FWYhHuVOren/RCEiP4dAWQiqxIZO
         K9ejLvskH/LqJABDP9dDDhRhzK9F6Bsntq37wbHE61IgsJnMjLoymWuN3jPZxMhRMqPm
         yTaw==
X-Forwarded-Encrypted: i=1; AKwUvBzBrDhS5rKjpueiAiOf6CK13HDM9E43Kpnwoe1uozOfeDEq6zaDhKwwkEveTALcrOnypWAp6GBtLwj4ups=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSOVr62ulqXWm+zc/YuMKRy6z2rN0ncDHXzo6mfjlTMkwACE8v
	7aN5gY1t4VmPXFENAO5No6j+qYKEubpMKK0+0hD17kUkxcDLk3SvpLnT
X-Gm-Gg: AYBFou1xshjnkyeLeRx5QQR8BAvvPtyDPL0atd48t9t9Uqkr+O6dE2XXZpMTVUq7AjG
	qDfnEZ2BFvsTLXKd0uYyiz4T7f6/eNo8o4EiTic/1mKGs8n9/TZ1kfkMzI6yDIEHTnNNjbN4u5K
	oW6R/9KetL9GPzj/0xX47UZyqPaUY+4vJ91hAgn1x0Sa8K16v5Po9/Sosun9MDaQILCHb3EON80
	jOti2yuJiuF4Nu1PS5M/Jb32dKUWyIXaGEVbb5u5l3iEA41Ks29wsCuGGhZZAKX0WAn2R+wzQY9
	6xkCgdCaINUGY25QjVjzDZSzovA712P+HkZKwQNRcxqBNmwosJpgHeYQ0nsz1LIbx5b5RcIZmT2
	7b6QeEr3ydkpUtONm/CVZYi41NvBTifITT2wmcBtVP/o7F3NGEV9MePmt/sSMnJCPyI8XUiOEU/
	rE1OkRDO9M41c7U+/exhzyL1pzk3gI/yjwHB4clAJV3Ns5fsaseKKQtel5FCc94g0P1RPNwf6DB
	wByt45c1oorNEqBZRABJzZB8CzU0YFKIKIQ97fw5MfnFULg8fsg25gbqKlqC1EfDL4Q7xm69ZSr
	AR9Pm550bPlpJHn80qFvoWxq67DdHrJqtR1fqHIRyX/D01M499bZPkeeckk18I6GkGXmxWRymqj
	hc6PdoPAFTpkkKNm7kJroWSviDoZ/6YPd0syqwSqzKC+9K+FeaYYZKVVgnwKi/sh8Gp5y5HbvJM
	tT9nIOWMTQySofedkXxPgStjs=
X-Received: by 2002:a05:6820:f02e:b0:6f4:9618:bada with SMTP id 006d021491bc7-7093a3d7781mr2027384eaf.0.1792622268438;
        Wed, 21 Oct 2026 15:37:48 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbddc7100sm3538837a34.24.2026.10.21.15.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:37:48 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 21 Oct 2026 16:37:43 -0600
Subject: [PATCH 1/2] serial: 8250: drain canceled TX DMA before reusing its
 buffer
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
Message-Id: <20261021-submit-serial-8250-dma-cancel-v1-v1-1-efe2b89f2303@gmail.com>
References: <20261021-submit-serial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com>
In-Reply-To: <20261021-submit-serial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

uart_flush_buffer() resets the transmit kfifo before calling the driver's
flush callback. serial8250_tx_dma_flush() terminates DMA asynchronously and
clears tx_running, allowing a new write to replace tx_size before the old
completion callback has finished. That callback can then consume bytes
from the new transmission. The serial core can also overwrite the old
DMA source as soon as it reuses the reset kfifo.

Give DMA a private transmit buffer, keeping the kfifo offsets used by
FIFO-window providers. Copy only the queued ranges before handing the
buffer to the device. Flushing the kfifo can then no longer change an
in-flight transfer's source.

Keep tx_running set while a worker synchronizes a successfully terminated
channel. Suppress callbacks and new submissions during that interval.
The DesignWare idle helpers must not pause or resume a retiring channel.
Once synchronization finishes, process the zero-length completion under
the port lock and start any data queued after the flush. Reuse the normal
completion processing for OMAP too, including its delayed register
restore and runtime-PM handling. Drain the worker before releasing DMA
resources on shutdown.

Calculate the queued length before calling the platform preparation hook,
so it sees the length of the transfer being prepared rather than the
previous transfer's length.

If termination fails, leave the buffer owned by the transfer and let its
normal completion release it. Do not submit another transfer before that
completion. A DMA completion still does not mean that the UART transmitter
is empty; the existing line-status checks remain in place.

The race was found by inspecting cancellation and restart while preparing
H616 UART DMA support.

Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250.h      |  13 +++-
 drivers/tty/serial/8250/8250_dma.c  | 118 ++++++++++++++++++++++++++----------
 drivers/tty/serial/8250/8250_omap.c |  26 ++++----
 3 files changed, 111 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 457732e941af..002e456fa384 100644
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
@@ -44,6 +49,7 @@ struct uart_8250_dma {
 	dma_cookie_t		tx_cookie;
 
 	void			*rx_buf;
+	void			*tx_buf;
 
 	size_t			rx_size;
 	size_t			tx_size;
@@ -53,6 +59,7 @@ struct uart_8250_dma {
 	unsigned char		rx_running;
 	/* Protected by the UART port lock. */
 	bool			shutting_down;
+	bool			tx_terminating;
 };
 
 struct old_serial_port {
@@ -401,6 +408,8 @@ static inline int is_omap1510_8250(struct uart_8250_port *pt)
 #ifdef CONFIG_SERIAL_8250_DMA
 extern int serial8250_tx_dma(struct uart_8250_port *);
 extern void serial8250_tx_dma_flush(struct uart_8250_port *);
+void serial8250_tx_dma_prepare_buffer(struct uart_8250_port *p,
+				      struct scatterlist *sgl, unsigned int nents);
 extern int serial8250_rx_dma(struct uart_8250_port *);
 extern void serial8250_rx_dma_flush(struct uart_8250_port *);
 extern int serial8250_request_dma(struct uart_8250_port *);
@@ -433,7 +442,7 @@ static inline void serial8250_tx_dma_pause(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
 
-	if (!dma->tx_running)
+	if (!dma->tx_running || dma->tx_terminating || dma->shutting_down)
 		return;
 
 	dmaengine_pause(dma->txchan);
@@ -443,7 +452,7 @@ static inline void serial8250_tx_dma_resume(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
 
-	if (!dma->tx_running)
+	if (!dma->tx_running || dma->tx_terminating || dma->shutting_down)
 		return;
 
 	dmaengine_resume(dma->txchan);
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 60e99a0db9b8..d4b1e2a059eb 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -8,21 +8,16 @@
 #include <linux/tty_flip.h>
 #include <linux/serial_reg.h>
 #include <linux/dma-mapping.h>
+#include <linux/slab.h>
 
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
 
@@ -36,11 +31,52 @@ static void __dma_tx_complete(void *param)
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
+	if (!dma->shutting_down && !dma->tx_terminating)
+		serial8250_tx_dma_complete(p);
 }
 
+static void serial8250_tx_dma_flush_work(struct work_struct *work)
+{
+	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma,
+					       tx_flush_work);
+	struct uart_8250_port *p = dma->port;
+
+	/* Neither the channel nor its buffer may be reused before this returns. */
+	dmaengine_synchronize(dma->txchan);
+
+	guard(uart_port_lock_irqsave)(&p->port);
+	dma->tx_terminating = false;
+	if (!dma->shutting_down)
+		dma->tx_complete(p);
+}
+
+void serial8250_tx_dma_prepare_buffer(struct uart_8250_port *p,
+				    struct scatterlist *sgl, unsigned int nents)
+{
+	struct uart_8250_dma *dma = p->dma;
+	struct scatterlist *sg;
+	unsigned int i;
+
+	/* Preserve ring offsets for DMA engines which implement a FIFO window. */
+	for_each_sg(sgl, sg, nents, i) {
+		size_t offset = sg_dma_address(sg) - dma->tx_addr;
+
+		memcpy(dma->tx_buf + offset,
+		       p->port.state->port.xmit_buf + offset, sg_dma_len(sg));
+	}
+	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
+				   UART_XMIT_SIZE, DMA_TO_DEVICE);
+}
+EXPORT_SYMBOL_GPL(serial8250_tx_dma_prepare_buffer);
+
 static void __dma_rx_complete(struct uart_8250_port *p)
 {
 	struct uart_8250_dma	*dma = p->dma;
@@ -103,6 +139,8 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 
 	if (dma->shutting_down)
 		return 0;
+	if (dma->tx_terminating)
+		return 0;
 
 	if (dma->tx_running) {
 		if (up->x_char) {
@@ -120,8 +158,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 		return 0;
 	}
 
-	serial8250_do_prepare_tx_dma(p);
-
 	sg_init_table(sgl, ARRAY_SIZE(sgl));
 
 	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, sgl, ARRAY_SIZE(sgl),
@@ -132,6 +168,8 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	for_each_sg(sgl, sg, ret, i)
 		dma->tx_size += sg_dma_len(sg);
 
+	serial8250_do_prepare_tx_dma(p);
+
 	desc = dmaengine_prep_slave_sg(dma->txchan, sgl, ret,
 				       DMA_MEM_TO_DEV,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -141,14 +179,13 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	}
 
 	dma->tx_running = 1;
+	dma->tx_complete = serial8250_tx_dma_complete;
 	desc->callback = __dma_tx_complete;
 	desc->callback_param = p;
 
-	dma->tx_cookie = dmaengine_submit(desc);
-
-	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
-				   UART_XMIT_SIZE, DMA_TO_DEVICE);
+	serial8250_tx_dma_prepare_buffer(p, sgl, ret);
 
+	dma->tx_cookie = dmaengine_submit(desc);
 	dma_async_issue_pending(dma->txchan);
 	serial8250_clear_THRI(p);
 	dma->tx_err = 0;
@@ -162,8 +199,9 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 void serial8250_tx_dma_flush(struct uart_8250_port *p)
 {
 	struct uart_8250_dma *dma = p->dma;
+	int ret;
 
-	if (!dma->tx_running)
+	if (!dma->tx_running || dma->tx_terminating || dma->shutting_down)
 		return;
 
 	/*
@@ -176,18 +214,14 @@ void serial8250_tx_dma_flush(struct uart_8250_port *p)
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
@@ -313,20 +347,34 @@ int serial8250_request_dma(struct uart_8250_port *p)
 	}
 
 	/* TX buffer */
-	dma->tx_addr = dma_map_single(tx_dev, p->port.state->port.xmit_buf,
-				      UART_XMIT_SIZE, DMA_TO_DEVICE);
+	dma->tx_buf = kmalloc(UART_XMIT_SIZE, GFP_KERNEL);
+	if (!dma->tx_buf) {
+		ret = -ENOMEM;
+		goto free_rx;
+	}
+	dma->tx_addr = dma_map_single(tx_dev, dma->tx_buf,
+				     UART_XMIT_SIZE, DMA_TO_DEVICE);
 	if (dma_mapping_error(tx_dev, dma->tx_addr)) {
-		dma_free_coherent(rx_dev, dma->rx_size,
-				  dma->rx_buf, dma->rx_addr);
 		ret = -ENOMEM;
-		goto err;
+		goto free_tx;
 	}
+	dma_sync_single_for_cpu(tx_dev, dma->tx_addr,
+				UART_XMIT_SIZE, DMA_TO_DEVICE);
+
+	dma->port = p;
+	INIT_WORK(&dma->tx_flush_work, serial8250_tx_dma_flush_work);
+	dma->tx_terminating = false;
 
 	scoped_guard(uart_port_lock_irqsave, &p->port)
 		dma->shutting_down = false;
 	dev_dbg_ratelimited(p->port.dev, "got both dma channels\n");
 
 	return 0;
+free_tx:
+	kfree(dma->tx_buf);
+free_rx:
+	dma_free_coherent(rx_dev, dma->rx_size,
+			  dma->rx_buf, dma->rx_addr);
 err:
 	dma_release_channel(dma->txchan);
 release_rx:
@@ -342,6 +390,8 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	if (!dma)
 		return;
 
+	cancel_work_sync(&dma->tx_flush_work);
+
 	/* Release RX resources */
 	dmaengine_terminate_sync(dma->rxchan);
 	dma->rx_running = 0;
@@ -354,6 +404,8 @@ void serial8250_release_dma(struct uart_8250_port *p)
 	dmaengine_terminate_sync(dma->txchan);
 	dma_unmap_single(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 			 UART_XMIT_SIZE, DMA_TO_DEVICE);
+	kfree(dma->tx_buf);
+	dma->tx_buf = NULL;
 	dma_release_channel(dma->txchan);
 	dma->txchan = NULL;
 	dma->tx_running = 0;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index e3f3322da379..d8ea1a1a406a 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1079,18 +1079,13 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 
 static int omap_8250_tx_dma(struct uart_8250_port *p);
 
-static void omap_8250_dma_tx_complete(void *param)
+static void omap_8250_tx_dma_complete(struct uart_8250_port *p)
 {
-	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tport = &p->port.state->port;
 	bool			en_thri = false;
 	struct omap8250_priv	*priv = p->port.private_data;
 
-	guard(uart_port_lock_irqsave)(&p->port);
-	if (dma->shutting_down)
-		return;
-
 	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
@@ -1122,6 +1117,16 @@ static void omap_8250_dma_tx_complete(void *param)
 	}
 }
 
+static void omap_8250_dma_tx_complete(void *param)
+{
+	struct uart_8250_port *p = param;
+	struct uart_8250_dma *dma = p->dma;
+
+	guard(uart_port_lock_irqsave)(&p->port);
+	if (!dma->shutting_down && !dma->tx_terminating)
+		omap_8250_tx_dma_complete(p);
+}
+
 static int omap_8250_tx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;
@@ -1132,7 +1137,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 	int skip_byte = -1;
 	int ret;
 
-	if (dma->shutting_down || dma->tx_running)
+	if (dma->shutting_down || dma->tx_terminating || dma->tx_running)
 		return 0;
 	if (uart_tx_stopped(&p->port) || kfifo_is_empty(&tport->xmit_fifo)) {
 
@@ -1200,15 +1205,14 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 
 	dma->tx_size = sg_dma_len(&sg);
 	dma->tx_running = 1;
+	dma->tx_complete = omap_8250_tx_dma_complete;
 
 	desc->callback = omap_8250_dma_tx_complete;
 	desc->callback_param = p;
 
-	dma->tx_cookie = dmaengine_submit(desc);
-
-	dma_sync_single_for_device(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
-				   UART_XMIT_SIZE, DMA_TO_DEVICE);
+	serial8250_tx_dma_prepare_buffer(p, &sg, 1);
 
+	dma->tx_cookie = dmaengine_submit(desc);
 	dma_async_issue_pending(dma->txchan);
 	if (dma->tx_err)
 		dma->tx_err = 0;

-- 
2.53.0

