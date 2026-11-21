Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295107;
	b=SjLZ+KU9y7+1ydX7t/bTIzefUT+RfYyMYjVQXKHT4g/rTSyaEgsKZwPSntzv+UiVEzP/
	 Fm31f/V71UHUjsb1I3UV6lGgqr0b1fhrLZZhTFDB/L8pqTLFQV1tsm7bP4ycLBq+BY7JK
	 Xjw5d+tl4+cmQscOg0kVGEi1kWxgsjdj2Kswq3dZTxOtT9RstGCtoCLnS4xe7ccKPLXBL
	 eq5zMEnzPDXZI22XR6YiODNp9/OcmX4g0Ha4GCv9FYdGpZoJm1OuOGEAMtns7Y8A+dAIs
	 HzKJRTA76GaqPh+S39Ln8pQzAsXw67F2r9bdfev/RjdcAjSsYkfybBtTSlljdBb0r5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=LMsrZ3KtoMPvJxEP1YGbl3odSSPptZ7NDLZf4JAvZ5M5OP6biH09K1cqusob2KMZR1HZ
	 KesXS+urDrWSUshwHAOaO7kTDcjHuITjoSbjEe3OX2sTCinGBMdRSHJnOIRIx9T/zc0Cj
	 X6M4bH1oEEPn+WZpvVyFNtrVNBxFPSlJohFwfjM3dlH89PGBvMKm9yNk3lfEfOKmJ/IZ1
	 WgqBlMBoLTfWBps0q0SBJlXjTGPn76JaN3ODhPlefnn8wfvZmDgchqgGnLQSV6TumAKw9
	 N/Nl7/nENfF97Np7khHsoSvpiPiRsTGPnLOLUxvt0JLdykDa+Tg4RMKM4w5B/kbMYjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W66gkJu0;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BF1606A339
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 21:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95BF1606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W66gkJu0
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-71ae5389c00so1282271eaf.2
        for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 13:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795295105; x=1795899905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=W66gkJu0d6mQpLuxKctMUJD71u4yIzfy2caUI62PP823Ntvzn4sVFquiObAUYkq8gy
         9qyDNCfXpuqmwHdxN7hobXWg63PYyHYlxRHzlRJkdhWxfOWZuLKDN4L7PkL4HKr91pEr
         SVTmG8P2td0d6ev4OXR73UulKBdKcDv+t1w3kBzxEQQpWLe+YrRDfq0duVfSD8sEnZZ1
         /4HYc6IGVK2Xo607UIQrPsbwgaID2TvXbV/CQYq9h287oLZQn3Mbq0mGjqPPBPRIgMp4
         AHiVT7ZUAsGOf5ZQ+TzSbsctiQ5ffEfoHfmkfD8aUYAiCU6yhHPqQZ9RHNG8CNX+fIBz
         GZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795295105; x=1795899905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=zuhRdOeRMtSQZ6xEpvNDM0FqgjGGm+GMX9DcCEvasm2ZdMBjoGVRacC1zixqZ4vKRt
         ty6yeGSh+BTdxIu1ahcCg+DIo+cKcferZXoEO0uO1dAwyfvPxJ2TQ3NRZ9aV1CJWPRuc
         WqVb2m0fAkBlcwB7S3J2MZrkK0Xv8/tWZatI1Vif+HYCEu3w/I3r7xiYRjKyZlcD+6IB
         UBn09ZE2aPQpiogSi5IL1c8cYAJCbMe1AGmcZkgbrAt+yaaSr1K5itPaVcyr/sVZ60My
         DoYGwydEX8tET0NNhfELXYVuE8Pr7IlihB8pvdqLZ1YoDWPxbZA5PHhXFNbG+Kpfx4e5
         lE+Q==
X-Forwarded-Encrypted: i=1; AL+hErEorHaLrzll24JOVsa7TlH65mpEGd8QLb6EdoekcC1sFbW/m25H3staVusxnY8rL+3dS3ait4KaPcPNza4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tncOcYOFuTQXklNAToKP30VrxxEnD2P9/2PVmBXMHe8iZOlrA
	pYnTqvABAOluUcEvmJMBw7ihIYFD2sqAx1fd3a1BdSLeyWqRv5YMY/cW
X-Gm-Gg: AZFdTZfHsDKW7B4w+mTLeVuyixb3EKu5ClR0OgBmL81m2a46Y+7Q5yAj+WVwPNbEAyH
	LaklaOBxac0l4Z0kJbWNlEvbRpyjUPbKa8IFHezABJeOnloDvnWu1L5vEQc09DDUlD3TYiNdmxZ
	joSctOOrkCC77WmCowEibYGQv1TKEr/bw6fr7AtUkITLaZxclZ9KlOroO4mgUmwRN5jAoH/Th6S
	Tzs74ApuYIuXQGtAYQPQfCvZ5s8KxiXQmmSDsIX8yNWnca0QkCUX09dKMDvDnoXGVZSbapfdoK+
	evD4C7Qt0xDT7tmAIdK6nHyMw5usFuoMfBG1c/8drruPB704iUuA3m0+8sBvw5PyBdYBDQwZjEq
	7m6nsM1g2GPWmXs/VWunr0/bxi3yft1XGiq5LGq0LcQkTsHUkqfUbUCNcxZA8MPgBGqspxdZ/kM
	xfpfkYKWfKVImmng3i9HBZJw30Mzo20wRSiqij9gQQOPKaDfJDKPtdo/WgtGd5Z+IgSv8XhlA4+
	JZ7Vyou8uGJLT2bUH83pC5zfs8crdUSCy0KrchtFK9dHqd/EFAd7ydl6sBXPlDx7FMY3Q6wQsTW
	o41TrYICnNvfrH12GLlrbfTkFcR/6ifLuJdqLWDZXUlofbnskdv6zSwvIFG5GBlKdaT8ecDBQbt
	34D2bMCQ1aSQAHiW1STBOOGIX5G6wj+4j60OXfJsf27FZEbcz6501NQbZnMZXy2IhE+ljSwL4LL
	OKUFDN/jIKlj1C7F1ug2GO86Uwh0JF8SQ8ZYJBryNcAQIP0ahvWO6L
X-Received: by 2002:a05:6820:a501:10b0:71a:e6e4:553d with SMTP id 006d021491bc7-71b39563ba6mr4471138eaf.69.1795295105432;
        Sat, 21 Nov 2026 13:05:05 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4635728eaf.13.2026.11.21.13.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:05:04 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 21 Nov 2026 14:03:16 -0700
Subject: [PATCH v12 1/7] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261121-submit-dw-dma-synchronize-v1-v12-1-f51eb635209d@gmail.com>
References: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
In-Reply-To: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
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

