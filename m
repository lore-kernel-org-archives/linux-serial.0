Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955742;
	b=ptp0yIHsncrUfBk3FPnv6StZo6XSIOpJzJP3p9w0nqqfuwUzkckBSNOqBIg9S1SgKg2b
	 xlQf/b+YSKWbxzDrB1P9LVy3U4l2+t4HYN4j4uLuAYyT85UayJfu0Pl2EW1+k60X4U+bn
	 j5CS0aU1yqL2HWfTgJdjC29NojOjMAV+3UJpsYsYGDkE7Pu8aigJYUnYciSw4KrKgkeyZ
	 SU7zGKGoODkXzrmZVKI2vGbM03b0iovGf+4PDCcuf/9ReZlSLXmyro2FjoIYCpLeTnU9o
	 qK98d9ZpUg6YePC5qUQptM+QrZqGPgxGQeb8c6T5SGjVmIZBsC+ePY0kv31mwhemgIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=HomxdjjeHGByvt9dH//9tBYG7Na8GTv/GW/lC1P5pug2UoAKWsYYet1MHDdkEMWU3392
	 xX2VfNVlDw4DkmZiBviKaxppG7M1ii61yXcmqWvSbPj54KL7j4/YEor/wfiAgEuzn8bZ8
	 Lg9BmmyhfN+D00K+MHTeNpw+QoZQsL2eRh7vrQETBJpKLdb+gwFyrvtvSECZ9CPsUyZvJ
	 vibIjqd+rQLzGzal8/LT6N5cAlE4/wt9jiMVYSARp4KQMG9pCuohrKooWNIKjp/pr0xd6
	 0DGOdospIMcxYObq2uY6FGEhZ4XqJcQjN9AVmwLVoMpV9sIhW1M/sTY7k0t40TSmOXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0ruMzzK;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B65606A884
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 22:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38B65606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g0ruMzzK
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4ada9579947so217229fac.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 14:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955741; x=1795560541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=g0ruMzzKPKJB02LGombv7yLKFI97HOz4p6BY+JIZw2mpG37qXNuFOhe2Pu/IVcMllt
         BC3Uqp7Ud2cGSjeN6SSzSGpeflI4x2y0dooeK+rXXj9c80fcvzwtKvKb+bxSzzcHE6LU
         SpXFgtJnQeLt+dNI3rlOHZP1gn7gJ/KufG66UeFOe9Vl/up6aF0NS4+Cwy50aATNaMya
         PA6lrGgBqtuf50+OPs8OyzkcmOb+wVv/f83N6I4+RrCWaqWVMW65XbR/HNGT94JHQQcV
         HTRiDrjKF7v26UQNzn4eGXoI/k3AUyyffd52MiN3f+w5+ib+JMauPCN1r5AhwH9YBFHn
         C+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955741; x=1795560541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=2udAcr27cOst4PdGJYeZzj25CGk5dPHledgyq0tGx5JanT/mVpAxqHyvNZwZEm1KgM
         K/HYIf1LrTltLj/U5KaDFEyhKJPEF+Cz1L1d5spN4JhNLuBEskDzfBRp+ayuSl4NPlrN
         /cEat0KvAG0BtzqV3n9SPgj0PyUKipiIlFB8GOUsVpAF4bKVu5lF6qhdlSsvmnVKVu1U
         GHEdibFgAr2nHPQTkeIXb7hRepC8gzk8d29iHPtyTMmJhODhwX1B0GhKs0629FhyE0ZP
         RrZYwCwRPvm7GEzZvh5TqTXU0Zd1z+cqUImWxsLK+H49M9o8PmcoDMpxMMnmAXSqzBjq
         YJXA==
X-Forwarded-Encrypted: i=1; AL+hErFSqolts1gNgHwStR5eGwb1SAzQuh8l+UBCdMtjcghUGwMpKJnrmJdv1iqGH++XRm5MnpiyG3WHdrNopZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XVZsIg1STZ7xIIIHUZ59XYW9elaAayypZzJLLL3hnUXasNNpZ
	X7TsyiK1SgKH0gdJmhsBRz5NrkVeEMkKB3Q9PGTP9xaqtTbdAA6LfWr7
X-Gm-Gg: AYBFou289p1vlXht3En+kNgc0n94T90l+aZtfpYRqc9L8pZZSPBcitZcTcw0PZz0LuH
	R/BDKu3tUHdFZQ4aVULHbJ/71iunp5w2ljOcShx6DWdTRsBfYiD2Z8VQVcoGzJjSE1tJ7AErn0E
	TDzuW+TGdfY8kQ2S4ODX6cbHPi8WAzRTyD0h6sjBxLqR3pFyBSGT4Wp8kQeCIIZ85sYe8uifsdB
	XilgpZICkl9CipcyHQNRypVDhiJT493s66YYwpf88l8DD2EC5T/hnxPWKixtgn2nXSnETOnjK5j
	l8yakWUmvHZHDtgl4RHsoJorRurVKplGBSL0N1+CCT7fxSqu+ERn4MlpiIwdPUPU9hEorlpvyz7
	bNYYETDf/92R7rYrhm7Im0oONqAJs7Fbsi3pvtSHAzA5HNx492Xzjxe260BkJqjcsC+YB+5EIA6
	Wa3jOu4DLqYi73X/+G8jhFltNCG08JlSO9W++81/ggO20gs2zuYekpd2juMzTGpW8Phulfhnm1E
	zIJNPvYLO76A749fsQpcsptd0VgmnbgG9dmnGyS6VBPbhxVCgUEgJT0w+Lgjz0tZyC6NTIx4dja
	Q70mjhzl/AvL38kPXcGz2yoe8bwgNmv0TV1f0L7nPRWY2CfG6I2gweIq1b5C1C2YRG17AjbhvXl
	mm2gP5xI2jSud2PC/bAQ6ZaVN18B2HAyxKfXcGASpBo16B5yERWzygEwfmlhsXriDpeymdKUeo5
	2dmNfe4Vv8VZJ6DGkwtAPnH2wSH/vNkcEoINKIfT8Kooe3Lx3ZFNRwyztO+J8NKH8lGOqqES/C
X-Received: by 2002:a05:6870:6b86:b0:4a9:5d97:bd7d with SMTP id 586e51a60fabf-4b76010e714mr459331fac.34.1794955741115;
        Tue, 17 Nov 2026 14:49:01 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74560af5fsm583066fac.16.2026.11.17.14.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:49:00 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:48:36 -0700
Subject: [PATCH v9 1/6] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261117-submit-dw-dma-synchronize-v1-v9-1-7dc066ed0bcf@gmail.com>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
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

