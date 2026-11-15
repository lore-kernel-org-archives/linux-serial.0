Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727182;
	b=cQwW7l9jInTM8VMlHc1q5OJmCygoT6PCGFi1Sw7LcqfCpOt6FfHe6HMAJxDPvqccp2TC
	 uEED5QIt1angVisXHjsoPVlP+9G0A4HzmZ/co+5cfEXRinuz9xLWzdiEJSdv4lYcKxjxU
	 qNU16Kj83WNCHAZSZqf4YlSsZzMfSpR9gj7Qy8LVrNevClpQ9mA2cRY4XYe6sKeSIdYGt
	 SrL7EPTjtDCoXSUDRNtendf3l5gbWzi1mCM/FflV8yi3t8RBEyF72xcJh5n72N50qa4rH
	 PF26UhOswMGxMXLNU3tYmSoSK5BXNYVRqbV6cC+gRzdHnyLDWDtcAbpxciFOnkdGkTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=Pw+mOxsJGd5eAXqzwx3gFqo6bGdXqmOs1wf8v8A5lvAOweJy3S/VWqRfQWyRCtXITTEM
	 VvlEjzqOItdezpytdTf9bcwGW5eLieYuLv1pbyLDxJH7pEwLX+Vm4OkAw9/8dASloS4lX
	 9+RQVvC7y55Qhc2gE5AM/YrdO2ZES5sTXc3KnlEGGcb+TwrhWNVq1oiEqRXQ83kshha81
	 yvC8gKW+x32J+SgY4BVUNpFwthPgIUiA/VUb398McC3KKIClRJ3fH6tk+U4yaHYtlbUqb
	 rJeuIgVEUWZsgtvzlThvC75mjkfGrzcB28jh2Jl0TmHwxPmTdNDKFj7Pa+9i2K5ss/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CkUE5Xf0;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE3606A338
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AAE3606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CkUE5Xf0
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-71ad099391dso330220eaf.3
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727181; x=1795331981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=CkUE5Xf0RKZPU0t7sBntWYPolbo03ZSkqenXAOOpmmSR99wEK2TSjY/osLh1drfDtS
         JVgVl2VScphUySm1r+PyBVq4np9+t+7JJKAoD3weRgwwbNAiPD4jR4ub7V77890LAXUA
         3eD6SU1y6JSzbLPtVt1LdWJmuCzsscZKmzoljjL2+KrsYAB6yo0hqIWBqEjB97XDF2Jw
         9HwzjsJE2RFVHoenXYZnpAUApnmDB9wq5rtdPuRk0R0QVioxA80E9zN/kb/ZByOHu/IH
         UxwvdlHEkVhXwetEJivs14ikbkxwDKgFMEUIf88eV2DkG6gP4KBQwLKfBgn0ubOWyAZM
         7+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727181; x=1795331981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=mk/6+VnRvNX8loGHtYNhcWuKdBOAGK6SC06+eD3PfP0C2XPa3n72LbEJq6I56oIBs9
         h4dN7UPATdFnnEuj3bNnXWs8psd38++za8+CSouLRzjpj1bDNgBD8NcWAJrvDUI2Aqya
         0z1boN60G3jG599bCr6eKtR9vGjOkMyZ7t+eo8PGQGeETmPn2qFSASmLSqZ5eKxF3AoR
         ZFFspMhjKETGqswf7NYXLVypfT4hG3OuLu7Hm5rDfLF45euDIudYWayDrnmlKM5EFazD
         6MAjwJYTD9SOsm3IibYEUuO6mQjNHd228wx73CBBegtBtQbFSQmQPRzMZ/RgOlvZqE+O
         ryTA==
X-Forwarded-Encrypted: i=1; AL+hErHJAJ99+dTI3N0AC9nelYy25mNowDtbn4MH3NApfmF57MNtt14LPpBNXjDBebWeNcVb4u7nL53sQTQMmnc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vt7do3wWXrx3DIYRt+cW/deRMHKz9ai2EKNmOc1kPPmXyXfFg
	1tHTpTETt0XzccZaYS+wgHXeXgEDVkBt706phE2XPkYZ8KP3asrFKqGF
X-Gm-Gg: AYBFou211bCdiFk7Hf61SuhPwoH/N5Vg+QGBLlXxQ7hwK9avBq3SLtK5LtZtq5TqhwP
	d37N1O4WAWG7kLK2i6UL70MGl057wx9i6omnZ8FqPUrVrf+EelRd5U9jRANW0MYU29vKUjcPB5w
	1cxHf7th86+9AGhQ0lN5i1gmlk6ja4kf+ZDzzfhRGGL66hIm3c8/iQoeoGHhlBUju5nU2mxg8tV
	Q82/z8QItYiOV32N3Mllq/WsUQl37UejMKx9XqsokosRLnAykrhUk3PrUP4H/G8D3cUsgcHsGO+
	HcmnJ4A3iBb3ySyrdxf12HqYzU21lT6F3P76/jsmD0zF73QOb3FYtTmoJ9mU0eKseT2MITIhUvm
	0WQik+i0Ps0EQ6Wr63+RtxfR7nhZE1QsBV15QyPeDeXYiRsLnys+Y4ESAxjGAaOj1BmyRavajEL
	0n3T7yZJMXcYioPIcJ1/S3sc4K70YnbefulpfOkRQe/+PiZaSFZIzVpdsRBzuFicmAmagEmlnoa
	QdbJYhDYhZ8p5O8hMjmb6J2fptVzXqZ8pGjadH8wYDBmFRxARMsIOh9toOWMRgH1fAzQgpWUydP
	4lOjpVdSlG+Pp3XZ+RQ65UpLC8xzMe4ucaQnznqsajkEJ50LJh52kAAqf+XzgonlIHPNFI5u2Hq
	JrI1mHBGCMcnK8+n45BjmVLRE2cbjUNsiucNTwJGxFwQ0Jf+MeFzImUZSSL1YTsfDbLf5VN9G8R
	v+2N3tAfNNSblb5dCflmTTIE9+knHmrT4k8+FPCcq0zUq8pZxb+InqZJm9t/Cq/FuFfp4RtE36
X-Received: by 2002:a05:6820:8592:20b0:716:c93d:cb39 with SMTP id 006d021491bc7-71ab5109a89mr3057192eaf.44.1794727181155;
        Sat, 14 Nov 2026 23:19:41 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:40 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:34 -0700
Subject: [PATCH v7 01/10] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-1-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
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
X-Mailer: b4 0.15.2

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

