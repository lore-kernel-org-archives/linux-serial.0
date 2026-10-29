Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312990;
	b=SYObfDtdZR+kABpDlFZJd+6E3iWi3nEsGkp9taN6N11SyjTbiRiV7Gvw2FWub9Z7CiFf
	 GXh8g7hYBq1WQOYinci7B0NDub93XYgy1cmHREtcSxC1eJKUNvu8GJhePV8+dBS6a9nVA
	 vFQARTBHJBVj2ls2Hni96YQosuTkI/4Qku8auWMJBZOUkuIbG2DU/6X/AFAiXQJnBj8O0
	 +8Yb3z4Q+oosW8VI1YIe9XGJUJXw8twqRbrX13lU+5PyvMGpPkJUMBLp4ibmvXaG1MqqE
	 9FekEQQPsLjwfEcoV4V1Q8YYwKfO/o40arrBWNlnDv6/aUBwKTHT2sDf6e3lAw7IVSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Z1RBMhPbkQG/cfbp95fXygy3gDDtR0uz5LmPXIHWuEM=;
	b=J+q1ZMrvpMNSdP4M0P1Qdmn+dWxyCqHgjJgBw2BWTjh7sXMMCTLVqa1cWBIUl32F1ZJh
	 YDo4/yHaZBmG45MhNe2q3HtOPatL+z2T9xCa/Kg7HsUwfhqtKXGQaVCzm1yi3GKyqqdCc
	 //5ee9375x4BtlSm5i0WaFv4kM0YHLLqePdOvgtPyHgoRhAdaLb57XQTYV705xeNkrmdd
	 9HIb7wT1PQIflLWnn0rtVBVpWURQf9V6gML16k5muPL4g74axxOUngsQmt2SELaMvlwKZ
	 eGYcjBPVNbtUIxpx1HTMYXIfmFCgTQIDM98fhS1UPNBAZyIVJl4ioN1Gg0V3M1rMv8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3pW6rN+;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40241606A32E
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40241606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o3pW6rN+
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4f66bb2ab57so33301b6e.3
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312989; x=1793917789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1RBMhPbkQG/cfbp95fXygy3gDDtR0uz5LmPXIHWuEM=;
        b=o3pW6rN+IRyI/oytvBm53MAPphqJG9oMLcKhsK7DG+Jic6zYw7yaIaEcwFyCGlY3QE
         VtgG3P8mBUebEt936PY9t0K3EMvSvaEUCH10OifCxtHQ4cnjy058eDRzLdZHoRp65QJy
         8E/bk+6qnJralV+Uc+H/JpG9KnCQ2CI85KOk+riWbKZgy7AFGqh3l56vvhotu36/HjxY
         WO+fsp4zckvUj7aHHlrbLb+19UnJvLhMTWPsGC152w9ur3SsWwjKzkrqfQapg2LC3C2b
         08d1mhmeH0QIa+h8yzCB38AWhfYfPTLP/Pp60GZcWdrNfKV0IZe0ImZmiOfx0gYvnqtR
         9WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312989; x=1793917789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1RBMhPbkQG/cfbp95fXygy3gDDtR0uz5LmPXIHWuEM=;
        b=RbumzbR2mFrdElKYZlKoylLH6fKaAFJKLfF91sl/TpNRZRs1ZF0vO5mp/qfPL3ibTK
         iGgJB32baiSulE0HYyQqd7TpPfpIY6TaWvXenxAyZeN0fpClZ1assQ1IVaGz9N92qfKq
         xOUu+ucJnu55+BVECJroaYMQc/+xm0XZo4ImVG8A+j5v15sLCJZD5mfi5V5AHXIRfWLk
         LDnkHBpEgdt2+VNtDpxRUYkOgGYdOSe2pIqU6tI+Xdre3LAMw6m2eiYdWgxwnE3MzW2P
         nizThp5+aINwG3PSz89ygei4xVNauwsOi3Bug7ZzrlyQpayPPqPR7CC6sSPyrBvrA23N
         lrhg==
X-Forwarded-Encrypted: i=1; AKwUvBwM9ZNp5ArTXfAGjDRJQUuAuuhebOsf1RkRW8WBK40mhtdTZ7vomN0boK5LVOLtAq1gpG0Sp3JeeEg3mg4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1UITZwkNitMkxRLu9/3SZG7Lb6ZPvvOD5P2UMT+r4YSGjMRiW
	ClFm7hJ9y0QyE7L600xqPg8+85GodUP4FJux6rzrLi/yC2/EFqblWbOg
X-Gm-Gg: AYBFou2nt8hNB7B6YegAAkwH0yxjv71zqlXCejnCT84KbZmfGeU70NTjUagto8Z2nWL
	2y6PXT+31AhLkm416uXCPaI+5ptbR7ZfUn+ppyTQ3GPMlb31iWGdVPyfEOAowgEkrqaI15at1zb
	Q5qs6CcKxJ/qT03DZ1Sw0hcqnRlcADM7D7Qg9aan2pwH5JTBZYjA0u+ksdw307qxkWxF5B/3uy/
	pby8hCW6vO5g3NI2cq1UCU0Aoc9nqJ/pkwGoE4SU19U7bWIpEuAR2jqVx/5/fsGfodcWtUmGola
	0GjtWJnf3Stg7g2oMzyNxPKt8yd1w0+20eAIjMkt8T9L7SBYD2pStTTVqe/lokK0Cy4L6gzgCXY
	4yPmoWIw1ExpkAJB7m6PI7H6vvKmn0Ola/T0o+AvyKQ9WzYzp22iijytWHQ2biZ4UUlsrMVYjyC
	NQHHi5tZfM1wbB+MWBHTJFSHLTytKV5sdaTYHM0YQ3w9QfHcRr7gRz+MFY3Wyvth0HnZ+4mYiDw
	+czWhacn61iIxDiOOXwd/8mXpxdLQHhgEVvdAdGPugYUE9TKE3tLqi0toZ4nVv8rv8hPHydSdoq
	CVSco3gheKoHfOXbjNzedl/Ni0/xRGr79M3savcNBez45NQ+UVKP9VmhS/WWNcdNcRGls4p16nk
	Op3zhRdYNZMcjQ2Jdu7HOQWiw69VCGwhcL0L816lLPLBVWzKhgDWSR98tTWALfvoySLMe+U4JKE
	1b3FEaeOZlA/0WCL6s+1SMNTfnCQTr1skHnA/00ijfIyHHlnhFybf9
X-Received: by 2002:a05:6808:23c7:b0:4d6:90f3:74a1 with SMTP id 5614622812f47-5640decd670mr462865b6e.44.1793312989197;
        Thu, 29 Oct 2026 15:29:49 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm236130b6e.2.2026.10.29.15.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:29:48 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 16:29:35 -0600
Subject: [PATCH v4 1/7] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261029-submit-dw-dma-synchronize-v1-v4-1-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw/core.c | 70 ++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index dd75f97a33b3..07a5f5105787 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -141,6 +141,12 @@ static inline void dwc_chan_disable(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -257,34 +263,6 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
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
-		dev_err(chan2dev(&dwc->chan),
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
@@ -302,6 +280,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	struct dw_desc *child;
 	u32 status_xfer;
 	unsigned long flags;
+	LIST_HEAD(list);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	llp = channel_readl(dwc, LLP);
@@ -310,6 +289,10 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	if (status_xfer & dwc->mask) {
 		/* Everything we've submitted is done */
 		dma_writel(dw, CLEAR.XFER, dwc->mask);
+		if (list_empty(&dwc->active_list)) {
+			spin_unlock_irqrestore(&dwc->lock, flags);
+			return;
+		}
 
 		if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
 			struct list_head *head, *active = dwc->tx_node_active;
@@ -341,9 +324,23 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
 		}
 
+		if (dma_readl(dw, CH_EN) & dwc->mask) {
+			dev_err(chan2dev(&dwc->chan),
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
 
@@ -389,22 +386,9 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
 
-	dev_err(chan2dev(&dwc->chan),
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

