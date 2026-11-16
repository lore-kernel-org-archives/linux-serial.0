Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826386;
	b=R5rCHcXEUPWVI2h5HY/fUGTX8cbsxv2/3HJjSrNkBucFW4ihNvZFF2rvtQfGgGGA9NJn
	 qd9xz4oEAI/wDlN0eA8o1qE2SPD1SxQCBqRHbwObz+9uaKkKvJHJXz4fTW0XBEDJ28p5u
	 /siJU3IMTKhFyeOFOD17WsdBvtxqkEQNJXzinCojFicrt/VI05EjYGx3zl0l/+2V3SmNs
	 JXu6+UFw7Y5yn3+GSXiye7bFcP1bYB6s+zuJV3K67pZAHXKb/F19RrIz6jr1l13BQRt+i
	 0KyQOiURgaK/s5q3nWOKfxjrTcGeO4Tgc7YmTpe36Wx2nZEAygjbFQJdj9m5WaCW8Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=3axdRX8xpRdmEiUYcQG4lkyfkZOdLcKAP8AxwlzLPlumGejvhG3QCYJKjdCHWYohQrcL
	 4xZg/0lQztaiX4CpOnnorEIaOe98IpZ5wkhz65XJorRcpSeHzaKz3BRHQupxORQegoiE6
	 J+BrgvaxeeQEZW7mDNwF6cXlzqUAYK8eOviBBDHftqE1ywpuYdrDUTC0UhCa6uExDtSv4
	 6Z6FM7JpTJ6MS5fCuBd6rYt7644GJDrH9lKuOn/Ku6C00+6fi+BNlAwfkrGjYvpMwHClF
	 bl8FVB0UxYKoUX2qbXJEkhnySlHS7Bte3/pq5M8MbTjE/y/Q/YYy+XWYCDAl2yxjqwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oJrJ4TgF;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AB606A335
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 10:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 527AB606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oJrJ4TgF
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-862b090e41eso776730a34.0
        for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 02:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826385; x=1795431185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=oJrJ4TgFryQ2A0pMaS4x8z1zIHdBSKyOhDY6LTiBPYm9D0+BuFBTcvFETam1BcvZyw
         M8SmNt1wAnDvWQcyJixj5eD4oP65pKd0gMD2+kXnqItjHYqDgaEAkM/d8KK0pCgjGzuG
         ieIOJg7x2cLAtbAcuQkDDp/CFmc4CbbdqqIbWv7zxHmD05fVaZw6+kLmuRZc0lpXg+5u
         w3uIkkoMueaj341LiYnraW///UTRBlYhvt97oUK3y4/SmT680I+Bs9ALfnD0g2W+Fzzr
         +2wKmZlevxHe6Esc5gIVILddUqwP2Y/bDhCQornkhm1mUsXXaQ9hATMShvnt4r0ZGxTd
         0Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826385; x=1795431185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=uzINmL5SWZpPPedbvaiUcSMl3UGyzPtx8iYqLcP7T9107qiVhG1IgPwzw26xlljnj7
         4+2rOUa85upy0IRykJ+nsDc41khZQEY6t2XbwA31kmeB2mxI/c162Jup/qSvl4K6m3im
         InWc9RLNmKt9Xn5T+V/IULQRZqZnKqy5auZWp3HLmEBbFquDuPybTRr4keh30VupchB4
         LpXQvXyiunWZD5L0O3UZWVkUI60bKvAeFoahSN9wFZyOcszqwhLpl5Ma1LjsiPOZ1Ssg
         urTS2IAoPiyfY4Zcxh/ZkavElY4s050XmqOnDatLP6/TO7JMnNZrRA75bYeHv9Uy76sS
         CERA==
X-Forwarded-Encrypted: i=1; AL+hErEqBLGm8xYxk/6l2nEtvUa/g1o/1ZX/RL4utLuAPuCs7Af2XL3SqoPrml28XsUhqY0TAtoTY+GzgJ8iSTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EXZDJ+n7H5Ycu8RUYt6Uv1d1WXqwRU4LWRZo401mq9m3/Bapt
	VxTIq+7JrL6wK4Cnp7abcNJCi1UV6r+ZUh1ZUe7qxYj9K69mDUFtep1I
X-Gm-Gg: AYBFou1YmTBarRDR+4diNu1tte+v5qNxGV8Sv5zmwZBFE6qIhGnrH/fELmssss/AbSU
	EIZmN6b1okUdHUJ5WyfDevabrkwFpY7mdECM5uoz7edfKyTE7zG7Db0YkqD5sjy7RHfK1Tu90wr
	A4TKeckIqqGSgD7MLdmczGV0D9M11CIzcd489GQbh2f0EGDiwqhpjhnd+5u/Qmhx2GSctC6fxDR
	xSnhbU+s8WnBsPdWvDCBhLZ0ARCNx2/NHeYFAdbjCfo/PChrZ1kc1LuiH8rk3qdJSaqjyjMlieC
	mZTlo6OsmmvGHnwSLd3n+S7C38IUVoQ/y8YlcU9egzK31zfeLWgX9M07dmGYNHkWxR7pebXeVJh
	JJa0YHCtUdAgMYnL/jVJerYPfw27DINIkQBcDPQmITzRxvFX6m9jbTXs3I2oRTeMeXhRhruoH5B
	C5GP93Ag5xd4dvxdQcIb/utuMsarNtaqq+uWRm8XJU2BiI5goKhd5kSxZsaXvIkry2Rd1TKvr9A
	35w2c5EFQj9p/izGg/LGnkUSE8h19/XCTPj6j0xlOw10VsQpiBfpkOmi7QU5PR0VGk7gH8Fi1+V
	9zYcfj2gvF/fOnMJ5r5aM8izXqwfaRvK0b1IYwdfzeEl1oh8UyYUPFOOahlnY8yqT7UBcTJ6Ehb
	HNACwZHS9mSmDENh2k65h7HZ9Bozavk0nsX2GfdMnwzWVxavZ6EAq7opgjaPcosqBLiSUJoOP7O
	TeMshpxAsDhzHQWQ3jn/lQ8yvnfyilkbFp6J87388lbvFuEAmfhc4=
X-Received: by 2002:a05:6830:310f:b0:862:a53e:6f60 with SMTP id 46e09a7af769-862a53e7201mr7369586a34.3.1794826385277;
        Mon, 16 Nov 2026 02:53:05 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862b08b8b5bsm5555546a34.5.2026.11.16.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:53:04 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 16 Nov 2026 03:52:29 -0700
Subject: [PATCH v8 1/6] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
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
Message-Id: <20261116-submit-dw-dma-synchronize-v1-v8-1-4a82d64fcd1a@gmail.com>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Williams <djbw@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.17-dev

From: Serge Semin <fancer.lancer@gmail.com>

If a client driver gets to use the DW DMAC engine device tougher
than usual, with occasional DMA-transfers termination and restart, then
the next error can be randomly spotted in the system log:

> dma dma0chan0: BUG: XFER bit set, but channel not idle!

For instance that happens in case of the 8250 UART port driver handling
the looped back high-speed traffic (in my case > 1.5Mbaud) by means of the
DMA-engine interface.

The error happens due to the two-staged nature of the DW DMAC IRQs
handling procedure and due to the critical section break in the meantime.
In particular in case if the DMA-transfer is terminated and restarted:
1. after the IRQ-handler submitted the tasklet but before the tasklet
   started handling the DMA-descriptors in dwc_scan_descriptors();
2. after the XFER completion flag was detected in the
   dwc_scan_descriptors() method, but before the dwc_complete_all() method
   is called
the error denoted above is printed due to the overlap of the last transfer
completion and the new transfer execution stages.

Clear the channel interrupt status when stopping it, and keep the XFER
check, descriptor detachment and queued-transfer restart in one locked
section. An empty active list needs no completion processing.

When the locked XFER recheck finds no event, only update residue. A stale
tasklet snapshot may belong to a terminated transfer, and a zero residue
only means the source has been read, not that destination writes have
finished. Requiring RAW.XFER also prevents the fallback scan from freeing
a descriptor still linked on active_list.

Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and enable submission from callback")
Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: require a locked XFER event and handle an empty active list]
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 70 ++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 575b7bb6af9a..2a9db9e39f5f 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -136,6 +136,12 @@ static inline void dwc_chan_disable(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	channel_clear_bit(dw, CH_EN, dwc->mask);
 	while (dma_readl(dw, CH_EN) & dwc->mask)
 		cpu_relax();
+
+	dma_writel(dw, CLEAR.XFER, dwc->mask);
+	dma_writel(dw, CLEAR.BLOCK, dwc->mask);
+	dma_writel(dw, CLEAR.SRC_TRAN, dwc->mask);
+	dma_writel(dw, CLEAR.DST_TRAN, dwc->mask);
+	dma_writel(dw, CLEAR.ERROR, dwc->mask);
 }
 
 /*----------------------------------------------------------------------*/
@@ -252,34 +258,6 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
 	dmaengine_desc_callback_invoke(&cb, NULL);
 }
 
-static void dwc_complete_all(struct dw_dma *dw, struct dw_dma_chan *dwc)
-{
-	struct dw_desc *desc, *_desc;
-	LIST_HEAD(list);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dma_readl(dw, CH_EN) & dwc->mask) {
-		dev_err(dmaengine_chan_dev(&dwc->chan),
-			"BUG: XFER bit set, but channel not idle!\n");
-
-		/* Try to continue after resetting the channel... */
-		dwc_chan_disable(dw, dwc);
-	}
-
-	/*
-	 * Submit queued descriptors ASAP, i.e. before we go through
-	 * the completed ones.
-	 */
-	list_splice_init(&dwc->active_list, &list);
-	dwc_dostart_first_queued(dwc);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	list_for_each_entry_safe(desc, _desc, &list, desc_node)
-		dwc_descriptor_complete(dwc, desc, true);
-}
-
 /* Returns how many bytes were already received from source */
 static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 {
@@ -297,6 +275,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	struct dw_desc *child;
 	u32 status_xfer;
 	unsigned long flags;
+	LIST_HEAD(list);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	llp = channel_readl(dwc, LLP);
@@ -305,6 +284,10 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	if (status_xfer & dwc->mask) {
 		/* Everything we've submitted is done */
 		dma_writel(dw, CLEAR.XFER, dwc->mask);
+		if (list_empty(&dwc->active_list)) {
+			spin_unlock_irqrestore(&dwc->lock, flags);
+			return;
+		}
 
 		if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
 			struct list_head *head, *active = dwc->tx_node_active;
@@ -336,9 +319,23 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
 		}
 
+		if (dma_readl(dw, CH_EN) & dwc->mask) {
+			dev_err(dmaengine_chan_dev(&dwc->chan),
+				"BUG: XFER bit set, but channel not idle!\n");
+
+			/* Try to continue after resetting the channel... */
+			dwc_chan_disable(dw, dwc);
+		}
+
+		/* Detach the completed transfer before starting queued work. */
+		list_splice_init(&dwc->active_list, &list);
+		dwc_dostart_first_queued(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 
-		dwc_complete_all(dw, dwc);
+		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
+			list_del_init(&desc->desc_node);
+			dwc_descriptor_complete(dwc, desc, true);
+		}
 		return;
 	}
 
@@ -384,22 +381,9 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 			desc->residue -= child->len;
 		}
 
-		/*
-		 * No descriptors so far seem to be in progress, i.e.
-		 * this one must be done.
-		 */
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		dwc_descriptor_complete(dwc, desc, true);
-		spin_lock_irqsave(&dwc->lock, flags);
 	}
 
-	dev_err(dmaengine_chan_dev(&dwc->chan),
-		"BUG: All descriptors done, but channel not idle!\n");
-
-	/* Try to continue after resetting the channel... */
-	dwc_chan_disable(dw, dwc);
-
-	dwc_dostart_first_queued(dwc);
+	/* Residue describes source reads; only RAW.XFER completes a transfer. */
 	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 

-- 
2.53.0

