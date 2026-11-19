Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082552;
	b=R4B+/1ZEuggV/HjfY7rpb62WGJM8SO406schlUPzgNO4eeCmfAuzSKttbNW39097uGjW
	 3KkqUssqPePnm9PrRP+LASbjbNaIQYMAY0RuZ9zQHV1UrPk4OtEf1xKkUTOCZXZqUZIsP
	 WrvT0hXnlS4iFyTnPR3wmiWs7Prf8aMA/aqP/rCqjFZsYWMtaMCs2SIsa4e5P1vN5KcKV
	 GC06OAnfy0fr+8P17lHXH5jLK/nhqeB5mq8geFgJt0W7Bu7xwL7p9LmAJ/vUeQg2/ktY8
	 1uuJ9kQRsoVVpQH0qkFYvdK4ukN4XEnPcFA2aEOmpNZj5qYbBRxjxujhPs7fga6H7hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=DWV5UiV73JxIxj1fHbx2z9tuqkP1VTmwP8mYmLVBXLo=;
	b=rFFoFNxo5BqISGaR6dRWkUDCPUwSNYFWavjNsOU/OXP8z+0a4XOBUuSpHxE8IghVtNBL
	 ZhSlhH1z/+8uRVo/xtFuYUo6lh5QmnX+b299/Digno11cKnfLBrlsJ57GksEEGMuVE9bn
	 8Hiw3GWT9R9zOJ68IksNN3LnSnFvEZCZpKXmKh5mFPMjQpESNloRdrHq+mIeahWv7Akoo
	 rLfoC14bSoQNWzI9y0npDhYFU1GOW3eAL0CosA3BLAjv4UGXVgjN4gphDwJGwTCDJ2QRc
	 4jegNVIlUEDIczqH1FqAfpcAAkYbdKTZDu3WM6Jod1YmyCDGo2or4N3yBX8idGM/vaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QC4OvA84;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05860A261C
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A05860A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QC4OvA84
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-71ae5389c00so1407085eaf.2
        for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 02:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082551; x=1795687351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DWV5UiV73JxIxj1fHbx2z9tuqkP1VTmwP8mYmLVBXLo=;
        b=QC4OvA84ShsoKAt9zuU4cxeC+ytAFhA19LqvlUBtK4KNQdbh4JAd4DvAOft/X3bpki
         Pv5AdE9xA2B9+qSJYybbjXbIfuJpsSlHnK1N+MucqFxXYVmjjBQGf8S7tWLwBCRfc4T0
         DPHEG4Nz9LqBUhpeuhzEUIEp4BDJJJ/9Zezn2veQu+ToUldcadomfM8Q78HYLvnEQDdt
         kXxSt9kEoMbAMJn7uIDgA4jQPc64X+IcO9wBPtLhikHNkBBtSjiRpO+PFw9l19sfpIEs
         OjO2u3aSquVIxD09FocNQK24RT50fnAziC0fkInpG6+S/p150ll+rRSbRyGPh+183+DL
         Ai1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082551; x=1795687351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DWV5UiV73JxIxj1fHbx2z9tuqkP1VTmwP8mYmLVBXLo=;
        b=Tv9zmoMk19yq2Q6DdYRy2w8XYDS/IirKzVR2kcDFI2x2UcXWoMvK2qTWL3q5zVu9Z1
         NRHpMV/8iHj2bdpGv001Bih5h6xVaPKDfhKzIx8ReqF0SENc/wBGnxyEhVBnxpCHWDOd
         h5SN7dr0Rl0EFtTUEgrG/bsU5N5KvlbPgr+vwfU4ubR5HS8gu7pveMF8pClRQsJ2QE47
         b2ODk0VBN1aUaQs7MEj4cTt+KhMiUsMVd0P+qLNpiaArzxU5jwiySUR3ukrVK1NISiVd
         EUZTbLw7H7Ha/ypzO02sxwakvbqZkf0c0PnUsk8hyfL9KZqdYOOBsta2JVUEvPROMFvv
         rlkA==
X-Forwarded-Encrypted: i=1; AL+hErFsf8gFXM6EN5tDgOQtuTjXA8o2uHcDuv4ujXiIfFCZifT0cWxJP7mkQjrisfiQa3tzwkks9254yjRk3k8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MsNDM1a1uPnR7IZtlxr7/6GUM+XSTQtHFuQPn3qlHs5+C9Zh7
	R7HiJlgaUmgIEDMhbZRVBv1b1nG2lxNkMQbfNES0ahKC5mZgqr1zZJ+F
X-Gm-Gg: AYBFou2lBVFpcB7huk2nFuoK3+mNQYa0NuXkaYh2USsJP2T0OtJtxnb1NqXW/I70pn6
	AXbiwyWrNoGLewyQZjzq4tErmslDcemg9x9pOe7QsJ5irvNn6Zf76HARybwS7wYxjtOMv3iI5h6
	nfvKsyPESKelRWNlezraWriXW0eBUtBT2WWylGf6NRFpsueOlv5JZLYahlzA8lJuKTEz5uFFAGv
	/LYtx229tYKK66JGniVQo+FWmtTyJ0SBN2lBpUOxwM4s3OKPtsDjpVEF3R8twAYinQbSM1yMgDn
	jmeaY5aSDyFjAIS00N90/+dFBHtCVYhEo24EHyukoYirz+9KjkZQw/tXgdhB/AjeJxXEMZoXGk9
	YrMDebOj4MHkO3fcug4s1XwYekE6BUAgEkYsJeEVbaTikp2F+r7i8gUfdwQ7RPxPc90A9+MSRgB
	ZXYCxVvXOVYikJu8SCCZfY83m9Qe/pjgGuf4yevtzfnIcZb6/75N1huCSC/UwuKP9hlT/cQpzC5
	FckHMyrTW72llKoaM7G4O/X9E7XaIZ16PnuI9Bu8zybKY22WcZb7KSj14KRWd22+6FoNwAj5JY4
	84ScLCtYapeSwod3kEHmr9+v8sEN0XlMqJG+wledcoYOT3k5VY1tEO0SlVzYQMqcaA/8K21qlma
	NMC3OrgWk7pxSm5tUIVLAK9dWKJ0PIYEPl2x06W9gofikM6LG7YrtG2sPQvHowzkPhdfWsZHMvf
	nyEhkqPu5gRNmgYzf8p0kAqZTDbGVet43861E5cOX3mXuf0LeBFh5l5Te3X2me9Ur34rMAgWEQ2
	LM=
X-Received: by 2002:a05:6820:612:b0:6c1:f38e:7053 with SMTP id 006d021491bc7-71b1836c092mr4331998eaf.3.1795082550521;
        Thu, 19 Nov 2026 02:02:30 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b18fbb9a8sm3906194eaf.0.2026.11.19.02.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:02:30 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 03:01:37 -0700
Subject: [PATCH v10 3/7] dmaengine: dw: embed a virt-dma channel
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
Message-Id: <20261119-submit-dw-dma-synchronize-v1-v10-3-3a737597a0d1@gmail.com>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

Move the DMAengine channel and its lock into an embedded virt_dma_chan.
Keeping channel registration, descriptor queues and callback delivery
unchanged separates the mechanical member changes from the conversion
to virt-dma queue management.

Link: https://lore.kernel.org/r/av3oxznSW_5oH8la@SMW015318
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

