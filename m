Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648061;
	b=jV2RH/JKR/Ouur9ZEfUjE6+2Join1lZFSrOI6qL7Q7S2HdLzq+df1MBhRt3rRUeT2df6
	 VwkWKVayzoES6bAnwLHN7HqBFWjcbeiq4uBEJYNPPukRgvdPJmnbmrKVANsOSBdP8XuLI
	 GVfz5YE3Bv9Ctz86QEi6vZyttvPF4lOfl1gtcMKAyidaLY3E72PLvfQF6P5RFzzHBbaaL
	 DyqLJwY71vHDZGnZbGbuTkhTDoqWhTLU1urF/vGFgdSa517aWUpkT04YqXxeXbmnsvDYa
	 7btZ5mKXrkUPGrqOSbotbPILPrYT7VVmDKR/tWcXBtzFyTeEJ8j8O+nPsxKB14iricw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=t3MDVMcb8Tbat3St7BaSyqmnuDVgM4KJUIzQ62gcNzds/il3o/Mw4kNrOh9STYG6+n6c
	 wdw860p4hDNpi0JCBNklhJW0pVE40jzjZOqXkWPotYTiF3fNJLCE1hNgzLHJZYPOzdCZ5
	 p3yKJ5TgQXbb7buVt/m4+4babGXROELoCKwsDVfw8tg1lyXIjCXZAmi6SxOPyEWEUtESi
	 yvrDA9jeL/JJHI1ZMYXvo2s/BLlYWqWFRuF/X0Myrp+jIM/KOHilV8sp2Y9LoETV97hsT
	 KahgnhKLl2FOLkUkDCzTaB3DgZK0D6xaJgGyNIPCn1CUtHJI0+iCUKl9iu8CrKFamJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpSNen4N;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C064606A336
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C064606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpSNen4N
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-84a248254f4so2409779a34.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648059; x=1794252859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=RpSNen4NuMcD8RfuTuX/4qNZOlAqG9kEZUodizemBf//CAHSt/hHOxCTwluuPnbzQl
         KPTqvkuTB0BE+qTsQv7zckzUVeIOqNdXcxzK8yYss3jBf7MDOE+FzM/bL61B5vEDb51F
         mNjIYqnuMcey1OWsI4aVQYcewyT+mGT99ssQ9AWMZu9Leo9zYzyx4x7GJvxRvi2VKShA
         KY2Tlv9Q+J3tsN/mq9cb4q37oULXAK4kG+Wst1a4RB15e+qotNdqS31ckB4tbCIbm7Tp
         M9yFkP6AZ4sigExQI4+lyxOBY+7z896vkMpMrVIwO2z+tQMJAbvCHgxSykxSipYsiBtr
         XuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648059; x=1794252859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=pQPrRqLBgXwPplGVOB0mEp6Fr18S52vVvzBraESBEwZ+t47LNOz2Mel+n/Y28ydbUP
         G7jTSEFGVKek8r46oTUuhxpti59FbLRHmO9oiiXbV9C4qY5YS9Bm619RnEJ9P2RyU6rS
         AsRKnW/999TRFlYnRJh3VKa0lZdvUOBw2bBt2KyaLFczuQBfQqb+IF8kK6uZiFECdsaG
         IOZFXtSgDOTJmyx1vbg1lvIJrbICyXXrwRmhJWzCy1+YUZLNbZpSK/Wu4zv5KR9z5JJn
         WsymAIlKmUtnKO+PhwaLTb71qsEdiQILO8xqyfQGQLfI6MP1vVzQn4zkXuibrVJYFIL5
         WG/g==
X-Forwarded-Encrypted: i=1; AKwUvByvndSg0aXs3ZT4OUib/B91Tp9GFL9YGvA+tsD3G2mtdgJOGsfv1z0usjzs/OL8vMRBFhool/+4Vy8P1Ew=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3KyEykw61dQgKA2ukEGv0X8qdww91srGGlrPD41W/S661ZIqu
	Ztpp2FafPKxY6Xoyd3uu9jqF0ga2DfumLROv91P+RKA2CnDqLTy8eWyr
X-Gm-Gg: AYBFou11Qyx+EMz6VaX3pRg3MYXARgU0pd1z9Q14Kn74+jxlUqcItKX5lTrNY6US9AF
	POERQ+b6P75DM3x8GNtkB3CA4HM1gLpAK61BEj08waBYVv+nUBU5NlsrHYKlo1npYEKh1pakx2+
	wrN2GB3NejDKmIE3q3UiHxd0PWA9mFg4eALkZtpoeKfMeSbr9IMQctFZ+rHfDt9ZQWP2eBcT57X
	aiwmAZffR/XxNOSfz/V5vZyHhKCftBB0+qLrCayn+fY3TMvGX9E0FyfvfW/18T1xcmJIl8UKnPb
	dyxBRcEL65YF23/HckMdE2vNvuVHISxlhesg3aZnTpc3fJMAUEi9cRLy5ESX5sk7cOg5Iexk0Kc
	iryIB6DyLO6hsaF9yfH1Z9nyBOEAtV1x6+digO5eG75a25YMwVlf+DALYpJfI8v5uUIdsSmU5qK
	yeLlb0an6bZ6+5tObSsasx1EM9jMzxhfmTHCz8MsycEhaAma5dDmC/uSuVHAVFdPBYv18pQFrjE
	ZewiaR3tN8LJNDNP5UDNRQFqUwZWXqXPDEUQNQtPe/TrDl4vF2JVrnmKwip2a3rrgGTfipqg/HR
	ZblpsSO96xLZ0XNc3MT2jP4UGv+HyhHnk/s1NYwvKKqX1VTAEtJ4LTB2P0WdGIqWrd8WOpl/qdH
	tM+ao7fnHW+Uc+Mxz9VNQJvDpxe1hIJQfyz08WCqjlmlCFYQ89zsQk+28kgXGX4ieSFbwzGi1qk
	CVxfpyw2HRkUlU7Kzyos9nG7dOwwEdQx08liPPQ4KzucG2kouDBPg=
X-Received: by 2002:a05:6808:191f:b0:4f4:3790:6615 with SMTP id 5614622812f47-5640deea416mr8455725b6e.11.1793648059580;
        Mon, 02 Nov 2026 11:34:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:18 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:13 -0700
Subject: [PATCH v5 01/10] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-1-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
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

