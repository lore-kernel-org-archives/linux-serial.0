Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202965;
	b=rzvsUcoH6yASKnrHaNDL68G3vSwBv0S7TC0915ugwoEKGPtUVYOKh0hO4sgv/FHSqS/a
	 AVnKpZ/qWR6z1y87CzdySFhlyzea77IeNh07OtUKsyr5KuRCLTWAqEx8XqMC+ZpCOSK/0
	 OhjsgKoH4qOCLoKrqgZXZ8SDPIkmIELBAYWLEz+UGsv0v4EitfVogPQSfvKxVGQWFPuy3
	 dUy7rpY88D/8LQ7ybA+NiGRlOfJ7PHcfrK6lyIUqAwmKfG3yefuiMVi7tFNrAhv03wMbn
	 ac8TT1Go1xQ35foD50bNTNTZDOkYcBI1j+qqQnobARd+zVV3vBUYoTQsGqhbwQS0Blg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=hGuUwi14BtrG6oK4Cb5Lx0Qvligx+kNB88RfEtMblHk=;
	b=JiDvP/oPwmyoYaRDyvkZxVTpXi4tElup3hmERXj8kZjYe/oclqMfmRv3NBsJaN0kBDFN
	 atMsFkFR6TWjDTBQr4MDRfR2N8xMRIolTzMcrXtUXKCckjypP4weM1qB3RXgpHscIxdfK
	 rraBSbOk7B7oMzaDy9YjNUEVOaKXc9kApVnLLRfC2aLTcInojxVI2X8B94Kzxny0OUytk
	 96zMZadyhDDjkfpBkoe8LrLvf5eC8cMyNL71Ar76OWxiUHqKOHTPAJ+5FqJ8FcHvD215n
	 dEednvmaXNkf773J5sVBrh+Es+jbftk9cA9MjLFLFJih4wcpIBcQNAx785+n76OsFrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nmAhhXBz;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041FE60A2600
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 041FE60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nmAhhXBz
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4932b13c4ccso781996fac.3
        for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 11:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202961; x=1795807761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGuUwi14BtrG6oK4Cb5Lx0Qvligx+kNB88RfEtMblHk=;
        b=nmAhhXBzxVzn9p03rkZL76RcOoq9DtAYRZ2dLD3f3fGfQOg6CElL3L4phHXPolhwej
         Nja0FuS7fduH8trrNRr2CO3lS43Qb97NFviAgEi0GOGYabrtg5pUD8kuSHf5CN0uuo/N
         x5QXqcsLXSh0YGF4+8pMZsCplUjReXI5UVNGNK6g6UYu+19tIwRzZ315RD/Qb0eo6K7A
         VaZ6Jp7lhjQCQYe5bsr7b8ZK0xjCCTCnC/ymUfCO9IQGjLg/C1e485nPkTIABfGlyFvC
         WCJ2P6p75VzTPJ0AClmpzd+Xd8X9ovt5Ox5yGP/zg3mbUV8pGefgJyQWteFg0dLNXbF5
         x+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202961; x=1795807761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hGuUwi14BtrG6oK4Cb5Lx0Qvligx+kNB88RfEtMblHk=;
        b=Y+liAIZgZx0YeNv6NLfNsEryE6w6fcL/W/UKATd4idCKyFrWrYNPXrOSjUr7fY2z+U
         z40rCbUBcMM2HIpV51ZgwzzcTmNBf/9u/BNBSUz3wIll9gQgfDOoDWPbj3RZlf45zj/X
         rsJ3ozashThxXe8m670JYP7xrPDRJGQzrd6KeiaaGIzS/HHLgGnJeoN8cAvqPOWXGiGy
         /E1COraUunb4WMIaezbKTxTF98kKXLsklDcwLshOgCOqjV8Ytutn7bDI9U603+gfHkS6
         NtUMTPjmtGdF1p6HmzyUXdZajki/PlxacEM8uEiET8hqrm//WUrGwQm5w0XB6ezK0vsA
         ET/Q==
X-Forwarded-Encrypted: i=1; AL+hErFDEnIM3qk3/gVyzwfYhcE/hc5w/3+5OodmbEG5BpfTgLtADmcKinZoPZerE21Hfnsxiz96I33km5hJ/M0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TLyaKBeOXPwuh4sMOOqtdrMLK5nuxeuUyqXSTzDQJvLzFpaNV
	dnt6QDeYM4tZpL1X8sWs3y4TD4yyo3G2PYeunilYhtBzstBbTFzpmdPt
X-Gm-Gg: AZFdTZeGedbeGWoKP+JZmHk24QRXDUTD1DGZbqrdEarliQZMo5l7lvIxEKpoxosIaCD
	uA2n9ruEG6kf/rigjruqQ5Og04dY0FcT6S4d0psqRYm4JCaFB/aD84kQShOvIfwLVNqwIyoN4yw
	ecFErwfXNRi9cQZJB2AsI+6pD/SRuG0pa75agFafaMhJI7kivTaGsdgx2tZv/T0xrt1ZOUBrY7K
	H1t8a6VIUCQf51HqZJdfm1MPe3UBEfH444nUBuApog4g2AsdD95XY5BwHqiZQ6SbrgDUW0e5OYV
	W9DFr+nC6kM9o7LR9SUCmjcmmUVonvhilEicP+hZwQc5/pejhf3jWOI7cHFdIMqwu1QxeEuWyto
	MZUwhe/Z+d02S3mDy8R76CFDpSyfDqlr54zkquG+Bp1dR3LfzVb/ge3IT/sbXPHD5ivmKRhVKXe
	yOSI0avQjUQr6dX49AUjqpUDTxeahpWqxYlh7a+2Y1WSJWtsYyXrryIuQSzKn/Gz51ur+NsVyqB
	vmSwhMXl469jpXyyeK4v+GOEQlrcQAYF4qJ6g0aaDrFX82QucXfD0Vk8tVQq/Jt6lf7izpU5ZOv
	7zz7WHFtceILKx27lByzJ0FP/HQ7mDTNhak1RtH5Hps8IOQSOhJGDd81q0BLMo57ul1S2ZksZ7Y
	nlh7XXWX3WVObDaDgU2xtA2l8Aco64U+fMgf3fW6j7J2UpU2tf8dCGM4cwGy2gDyjChiJyKEzZQ
	e/w6XSP1bkAUvkernDh0x8YjFMrbgyWcC1culGt0M0G2CYwiOaXPDT
X-Received: by 2002:a05:6870:6123:b0:4ba:1f23:e713 with SMTP id 586e51a60fabf-4bc83a665b9mr3639958fac.32.1795202960827;
        Fri, 20 Nov 2026 11:29:20 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm3434498fac.8.2026.11.20.11.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:29:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:29:09 -0700
Subject: [PATCH v11 3/7] dmaengine: dw: embed a virt-dma channel
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
Message-Id: <20261120-submit-dw-dma-synchronize-v1-v11-3-9b9166bc2cc7@gmail.com>
References: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
In-Reply-To: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.17-dev

Move the DMAengine channel and its lock into an embedded virt_dma_chan.
Keeping channel registration, descriptor queues and callback delivery
unchanged separates the mechanical member changes from the conversion
to virt-dma queue management.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c   | 112 ++++++++++++++++++++++++------------------------
 drivers/dma/dw/dw.c     |   2 +-
 drivers/dma/dw/idma32.c |  18 ++++----
 drivers/dma/dw/regs.h   |   9 ++--
 4 files changed, 70 insertions(+), 71 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index f7ca9da5af90..3df696e41ff2 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -53,7 +53,7 @@ static dma_cookie_t dwc_tx_submit(struct dma_async_tx_descriptor *tx)
 	dma_cookie_t		cookie;
 	unsigned long		flags;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 	cookie = dma_cookie_assign(tx);
 
 	/*
@@ -63,7 +63,7 @@ static dma_cookie_t dwc_tx_submit(struct dma_async_tx_descriptor *tx)
 	 */
 
 	list_add_tail(&desc->desc_node, &dwc->queue);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 	dev_vdbg(dmaengine_chan_dev(tx->chan), "%s: queued %u\n",
 		 __func__, desc->txd.cookie);
 
@@ -72,7 +72,7 @@ static dma_cookie_t dwc_tx_submit(struct dma_async_tx_descriptor *tx)
 
 static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 	struct dw_desc *desc;
 	dma_addr_t phys;
 
@@ -82,7 +82,7 @@ static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
 
 	dwc->descs_allocated++;
 	INIT_LIST_HEAD(&desc->tx_list);
-	dma_async_tx_descriptor_init(&desc->txd, &dwc->chan);
+	dma_async_tx_descriptor_init(&desc->txd, &dwc->vc.chan);
 	desc->txd.tx_submit = dwc_tx_submit;
 	desc->txd.flags = DMA_CTRL_ACK;
 	desc->txd.phys = phys;
@@ -91,7 +91,7 @@ static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
 
 static void dwc_desc_put(struct dw_dma_chan *dwc, struct dw_desc *desc)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 	struct dw_desc *child, *_next;
 
 	if (unlikely(!desc))
@@ -109,7 +109,7 @@ static void dwc_desc_put(struct dw_dma_chan *dwc, struct dw_desc *desc)
 
 static void dwc_initialize(struct dw_dma_chan *dwc)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 
 	dw->initialize_chan(dwc);
 
@@ -122,7 +122,7 @@ static void dwc_initialize(struct dw_dma_chan *dwc)
 
 static inline void dwc_dump_chan_regs(struct dw_dma_chan *dwc)
 {
-	dev_err(dmaengine_chan_dev(&dwc->chan),
+	dev_err(dmaengine_chan_dev(&dwc->vc.chan),
 		"  SAR: 0x%x DAR: 0x%x LLP: 0x%x CTL: 0x%x:%08x\n",
 		channel_readl(dwc, SAR),
 		channel_readl(dwc, DAR),
@@ -150,7 +150,7 @@ static inline void dwc_chan_disable(struct dw_dma *dw, struct dw_dma_chan *dwc)
 static inline void dwc_do_single_block(struct dw_dma_chan *dwc,
 				       struct dw_desc *desc)
 {
-	struct dw_dma	*dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma	*dw = to_dw_dma(dwc->vc.chan.device);
 	u32		ctllo;
 
 	/*
@@ -169,16 +169,16 @@ static inline void dwc_do_single_block(struct dw_dma_chan *dwc,
 	dwc->tx_node_active = dwc->tx_node_active->next;
 }
 
-/* Called with dwc->lock held and bh disabled */
+/* Called with dwc->vc.lock held and bh disabled */
 static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 {
-	struct dw_dma	*dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma	*dw = to_dw_dma(dwc->vc.chan.device);
 	u8		lms = DWC_LLP_LMS(dwc->dws.m_master);
 	unsigned long	was_soft_llp;
 
 	/* ASSERT:  channel is idle */
 	if (dma_readl(dw, CH_EN) & dwc->mask) {
-		dev_err(dmaengine_chan_dev(&dwc->chan),
+		dev_err(dmaengine_chan_dev(&dwc->vc.chan),
 			"%s: BUG: Attempted to start non-idle channel\n",
 			__func__);
 		dwc_dump_chan_regs(dwc);
@@ -191,7 +191,7 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 		was_soft_llp = test_and_set_bit(DW_DMA_IS_SOFT_LLP,
 						&dwc->flags);
 		if (was_soft_llp) {
-			dev_err(dmaengine_chan_dev(&dwc->chan),
+			dev_err(dmaengine_chan_dev(&dwc->vc.chan),
 				"BUG: Attempted to start new LLP transfer inside ongoing one\n");
 			return;
 		}
@@ -224,7 +224,7 @@ static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
 
 	list_move(dwc->queue.next, &dwc->active_list);
 	desc = dwc_first_active(dwc);
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: started %u\n", __func__, desc->txd.cookie);
+	dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "%s: started %u\n", __func__, desc->txd.cookie);
 	dwc_dostart(dwc, desc);
 }
 
@@ -239,9 +239,9 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
 	unsigned long			flags;
 	struct dmaengine_desc_callback	cb;
 
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
+	dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "descriptor %u complete\n", txd->cookie);
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 	dma_cookie_complete(txd);
 	if (callback_required)
 		dmaengine_desc_get_callback(txd, &cb);
@@ -253,7 +253,7 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
 		async_tx_ack(&child->txd);
 	async_tx_ack(&desc->txd);
 	dwc_desc_put(dwc, desc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 
 	dmaengine_desc_callback_invoke(&cb, NULL);
 }
@@ -261,7 +261,7 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
 /* Returns how many bytes were already received from source */
 static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 	u32 ctlhi = channel_readl(dwc, CTL_HI);
 	u32 ctllo = channel_readl(dwc, CTL_LO);
 
@@ -277,7 +277,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	unsigned long flags;
 	LIST_HEAD(list);
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 	llp = channel_readl(dwc, LLP);
 	status_xfer = dma_readl(dw, RAW.XFER);
 
@@ -285,7 +285,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		/* Everything we've submitted is done */
 		dma_writel(dw, CLEAR.XFER, dwc->mask);
 		if (list_empty(&dwc->active_list)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
+			spin_unlock_irqrestore(&dwc->vc.lock, flags);
 			return;
 		}
 
@@ -311,7 +311,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 				/* Submit next block */
 				dwc_do_single_block(dwc, child);
 
-				spin_unlock_irqrestore(&dwc->lock, flags);
+				spin_unlock_irqrestore(&dwc->vc.lock, flags);
 				return;
 			}
 
@@ -320,7 +320,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		}
 
 		if (dma_readl(dw, CH_EN) & dwc->mask) {
-			dev_err(dmaengine_chan_dev(&dwc->chan),
+			dev_err(dmaengine_chan_dev(&dwc->vc.chan),
 				"BUG: XFER bit set, but channel not idle!\n");
 
 			/* Try to continue after resetting the channel... */
@@ -330,7 +330,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		/* Detach the completed transfer before starting queued work. */
 		list_splice_init(&dwc->active_list, &list);
 		dwc_dostart_first_queued(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
+		spin_unlock_irqrestore(&dwc->vc.lock, flags);
 
 		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
 			list_del_init(&desc->desc_node);
@@ -340,17 +340,17 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	}
 
 	if (list_empty(&dwc->active_list)) {
-		spin_unlock_irqrestore(&dwc->lock, flags);
+		spin_unlock_irqrestore(&dwc->vc.lock, flags);
 		return;
 	}
 
 	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
-		dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
-		spin_unlock_irqrestore(&dwc->lock, flags);
+		dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "%s: soft LLP mode\n", __func__);
+		spin_unlock_irqrestore(&dwc->vc.lock, flags);
 		return;
 	}
 
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
+	dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "%s: llp=%pad\n", __func__, &llp);
 
 	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
 		/* Initial residue value */
@@ -358,7 +358,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 		/* Check first descriptors addr */
 		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
+			spin_unlock_irqrestore(&dwc->vc.lock, flags);
 			return;
 		}
 
@@ -366,7 +366,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		if (lli_read(desc, llp) == llp) {
 			/* This one is currently in progress */
 			desc->residue -= dwc_get_sent(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
+			spin_unlock_irqrestore(&dwc->vc.lock, flags);
 			return;
 		}
 
@@ -375,7 +375,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 			if (lli_read(child, llp) == llp) {
 				/* Currently in progress */
 				desc->residue -= dwc_get_sent(dwc);
-				spin_unlock_irqrestore(&dwc->lock, flags);
+				spin_unlock_irqrestore(&dwc->vc.lock, flags);
 				return;
 			}
 			desc->residue -= child->len;
@@ -384,12 +384,12 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	}
 
 	/* Residue describes source reads; only RAW.XFER completes a transfer. */
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
 {
-	dev_crit(dmaengine_chan_dev(&dwc->chan), "  desc: s0x%x d0x%x l0x%x c0x%x:%x\n",
+	dev_crit(dmaengine_chan_dev(&dwc->vc.chan), "  desc: s0x%x d0x%x l0x%x c0x%x:%x\n",
 		 lli_read(desc, sar),
 		 lli_read(desc, dar),
 		 lli_read(desc, llp),
@@ -403,7 +403,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	struct dw_desc *child;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 
 	/* Termination may have cleared the error since the tasklet sampled it. */
 	if (!(dma_readl(dw, RAW.ERROR) & dwc->mask))
@@ -430,20 +430,20 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	 * controller flagged an error instead of scribbling over
 	 * random memory locations.
 	 */
-	dev_WARN(dmaengine_chan_dev(&dwc->chan), "Bad descriptor submitted for DMA!\n"
+	dev_WARN(dmaengine_chan_dev(&dwc->vc.chan), "Bad descriptor submitted for DMA!\n"
 				       "  cookie: %d\n", bad_desc->txd.cookie);
 	dwc_dump_lli(dwc, bad_desc);
 	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
 		dwc_dump_lli(dwc, child);
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 
 	/* Pretend the descriptor completed successfully */
 	dwc_descriptor_complete(dwc, bad_desc, true);
 	return;
 
 unlock:
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 }
 
 static void dw_dma_tasklet(struct tasklet_struct *t)
@@ -872,7 +872,7 @@ static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 
 static void dwc_chan_pause(struct dw_dma_chan *dwc, bool drain)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 	unsigned int		count = 20;	/* timeout iterations */
 
 	dw->suspend_chan(dwc, drain);
@@ -888,16 +888,16 @@ static int dwc_pause(struct dma_chan *chan)
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 	unsigned long		flags;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 	dwc_chan_pause(dwc, false);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 
 	return 0;
 }
 
 static inline void dwc_chan_resume(struct dw_dma_chan *dwc, bool drain)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 
 	dw->resume_chan(dwc, drain);
 
@@ -909,12 +909,12 @@ static int dwc_resume(struct dma_chan *chan)
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 	unsigned long		flags;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 
 	if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
 		dwc_chan_resume(dwc, false);
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 
 	return 0;
 }
@@ -927,7 +927,7 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	unsigned long		flags;
 	LIST_HEAD(list);
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 
 	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
 
@@ -941,7 +941,7 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	list_splice_init(&dwc->queue, &list);
 	list_splice_init(&dwc->active_list, &list);
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 
 	/* Flush all pending and queued descriptors */
 	list_for_each_entry_safe(desc, _desc, &list, desc_node)
@@ -968,7 +968,7 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 	unsigned long flags;
 	u32 residue;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
@@ -985,7 +985,7 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 		residue = 0;
 	}
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 	return residue;
 }
 
@@ -1016,10 +1016,10 @@ static void dwc_issue_pending(struct dma_chan *chan)
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 	unsigned long		flags;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 	if (list_empty(&dwc->active_list))
 		dwc_dostart_first_queued(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 }
 
 /*----------------------------------------------------------------------*/
@@ -1094,7 +1094,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	BUG_ON(!list_empty(&dwc->queue));
 	BUG_ON(dma_readl(to_dw_dma(chan->device), CH_EN) & dwc->mask);
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 
 	/* Clear custom channel configuration */
 	memset(&dwc->dws, 0, sizeof(struct dw_dma_slave));
@@ -1104,7 +1104,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	channel_clear_bit(dw, MASK.BLOCK, dwc->mask);
 	channel_clear_bit(dw, MASK.ERROR, dwc->mask);
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 
 	/* Disable controller in case it was a last user */
 	dw->in_use &= ~dwc->mask;
@@ -1221,13 +1221,13 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	for (i = 0; i < pdata->nr_channels; i++) {
 		struct dw_dma_chan	*dwc = &dw->chan[i];
 
-		dwc->chan.device = &dw->dma;
-		dma_cookie_init(&dwc->chan);
+		dwc->vc.chan.device = &dw->dma;
+		dma_cookie_init(&dwc->vc.chan);
 		if (pdata->chan_allocation_order == CHAN_ALLOCATION_ASCENDING)
-			list_add_tail(&dwc->chan.device_node,
+			list_add_tail(&dwc->vc.chan.device_node,
 					&dw->dma.channels);
 		else
-			list_add(&dwc->chan.device_node, &dw->dma.channels);
+			list_add(&dwc->vc.chan.device_node, &dw->dma.channels);
 
 		/* 7 is highest priority & 0 is lowest. */
 		if (pdata->chan_priority == CHAN_PRIORITY_ASCENDING)
@@ -1236,7 +1236,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 			dwc->priority = i;
 
 		dwc->ch_regs = &__dw_regs(dw)->CHAN[i];
-		spin_lock_init(&dwc->lock);
+		spin_lock_init(&dwc->vc.lock);
 		dwc->mask = 1 << i;
 
 		INIT_LIST_HEAD(&dwc->active_list);
@@ -1358,8 +1358,8 @@ int do_dma_remove(struct dw_dma_chip *chip)
 	tasklet_kill(&dw->tasklet);
 
 	list_for_each_entry_safe(dwc, _dwc, &dw->dma.channels,
-			chan.device_node) {
-		list_del(&dwc->chan.device_node);
+			vc.chan.device_node) {
+		list_del(&dwc->vc.chan.device_node);
 		channel_clear_bit(dw, CH_EN, dwc->mask);
 	}
 
diff --git a/drivers/dma/dw/dw.c b/drivers/dma/dw/dw.c
index e56974e7d4af..fd4f57476b67 100644
--- a/drivers/dma/dw/dw.c
+++ b/drivers/dma/dw/dw.c
@@ -14,7 +14,7 @@
 
 static void dw_dma_initialize_chan(struct dw_dma_chan *dwc)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 	u32 cfghi = is_slave_direction(dwc->direction) ? 0 : DWC_CFGH_FIFO_MODE;
 	u32 cfglo = DWC_CFGL_CH_PRIOR(dwc->priority);
 	bool hs_polarity = dwc->dws.hs_polarity;
diff --git a/drivers/dma/dw/idma32.c b/drivers/dma/dw/idma32.c
index dac617c183e6..52e591f8410b 100644
--- a/drivers/dma/dw/idma32.c
+++ b/drivers/dma/dw/idma32.c
@@ -35,7 +35,7 @@
 
 static unsigned int idma32_get_slave_devfn(struct dw_dma_chan *dwc)
 {
-	struct device *slave = dwc->chan.slave;
+	struct device *slave = dwc->vc.chan.slave;
 
 	if (!slave || !dev_is_pci(slave))
 		return 0;
@@ -45,7 +45,7 @@ static unsigned int idma32_get_slave_devfn(struct dw_dma_chan *dwc)
 
 static void idma32_initialize_chan_xbar(struct dw_dma_chan *dwc)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 	void __iomem *misc = __dw_regs(dw);
 	u32 cfghi = 0, cfglo = 0;
 	u8 dst_id, src_id;
@@ -55,12 +55,12 @@ static void idma32_initialize_chan_xbar(struct dw_dma_chan *dwc)
 	value = readl(misc + DMA_REGACCESS_CHID_CFG);
 
 	value &= ~REGACCESS_CHID_MASK;
-	value |= dwc->chan.chan_id;
+	value |= dwc->vc.chan.chan_id;
 
 	writel(value, misc + DMA_REGACCESS_CHID_CFG);
 
 	/* Configure channel attributes */
-	value = readl(misc + DMA_CTL_CH(dwc->chan.chan_id));
+	value = readl(misc + DMA_CTL_CH(dwc->vc.chan.chan_id));
 
 	value &= ~(CTL_CH_RD_NON_SNOOP_BIT | CTL_CH_WR_NON_SNOOP_BIT);
 	value &= ~(CTL_CH_RD_RS_MASK | CTL_CH_WR_RS_MASK);
@@ -85,10 +85,10 @@ static void idma32_initialize_chan_xbar(struct dw_dma_chan *dwc)
 		return;
 	}
 
-	writel(value, misc + DMA_CTL_CH(dwc->chan.chan_id));
+	writel(value, misc + DMA_CTL_CH(dwc->vc.chan.chan_id));
 
 	/* Configure crossbar selection */
-	value = readl(misc + DMA_XBAR_SEL(dwc->chan.chan_id));
+	value = readl(misc + DMA_XBAR_SEL(dwc->vc.chan.chan_id));
 
 	/* DEVFN selection */
 	value &= ~XBAR_SEL_DEVID_MASK;
@@ -106,17 +106,17 @@ static void idma32_initialize_chan_xbar(struct dw_dma_chan *dwc)
 		return;
 	}
 
-	writel(value, misc + DMA_XBAR_SEL(dwc->chan.chan_id));
+	writel(value, misc + DMA_XBAR_SEL(dwc->vc.chan.chan_id));
 
 	/* Configure DMA channel low and high registers */
 	switch (dwc->direction) {
 	case DMA_MEM_TO_DEV:
-		dst_id = dwc->chan.chan_id;
+		dst_id = dwc->vc.chan.chan_id;
 		src_id = dwc->dws.src_id;
 		break;
 	case DMA_DEV_TO_MEM:
 		dst_id = dwc->dws.dst_id;
-		src_id = dwc->chan.chan_id;
+		src_id = dwc->vc.chan.chan_id;
 		break;
 	default:
 		/* Memory-to-Memory and Device-to-Device are ignored for now */
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index 5969d9cc8d7a..f47b42d638dd 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -13,6 +13,7 @@
 
 #include <linux/io-64-nonatomic-hi-lo.h>
 
+#include "../virt-dma.h"
 #include "internal.h"
 
 #define DW_DMA_MAX_NR_REQUESTS	16
@@ -264,7 +265,7 @@ enum dw_dmac_flags {
 };
 
 struct dw_dma_chan {
-	struct dma_chan			chan;
+	struct virt_dma_chan		vc;
 	void __iomem			*ch_regs;
 	u8				mask;
 	u8				priority;
@@ -273,9 +274,7 @@ struct dw_dma_chan {
 	/* software emulation of the LLP transfers */
 	struct list_head	*tx_node_active;
 
-	spinlock_t		lock;
-
-	/* these other elements are all protected by lock */
+	/* these other elements are all protected by vc.lock */
 	unsigned long		flags;
 	struct list_head	active_list;
 	struct list_head	queue;
@@ -307,7 +306,7 @@ __dwc_regs(struct dw_dma_chan *dwc)
 
 static inline struct dw_dma_chan *to_dw_dma_chan(struct dma_chan *chan)
 {
-	return container_of(chan, struct dw_dma_chan, chan);
+	return container_of(chan, struct dw_dma_chan, vc.chan);
 }
 
 struct dw_dma {

-- 
2.53.0

