Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955746;
	b=x9F9M0GHZnGeuvfAxvkHDWCNYwsJO2PK3QSkdHgdA04VVp8ZaQAwb58ORYPWNn7wFodx
	 NV5QzgBVLK7d5d5bCudBnuiDvkhiXxlSza3ja4Tte5s7VoW78oEkoPLDUrMkrG0OTJEsq
	 M+Q9tOMAGgb8SmnKk6pRJMcaptv8tdxbGnsY5KcySygAwD7WUIAPRUfJRoOFhikEsZNU/
	 dXciwqlpiJ0+QV4D0GpQ2B6YWf4MyTDlFwL1ewosWP0e9Y1NXbQnHrR+2ZmRqrfsnOi61
	 PiWUC6WyceJE2I5A/D+EBssqx8sr16tTCrp/RSmvRx0/3ftBZ5UKBHhvPVcY1oVpRiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=E5JR6oFMP9CwmZMpNvitxNSrcrNywGdSAOnr1eeLQR4=;
	b=hn9GgC5MNo1MvO9jUBf5ICdBDClBUbt7uhxQ62S8EwCw/3ozAH2HUHIf9woaIT4G2Tiw
	 2o3SaAdDz/QE9M53HMv3bGRR1ObY9x/QLOfVdhWA1b6tEA3hLDBsRDqEryE2hNaUMbwNA
	 Yn5NGlxztZFyGdEa7nsZdhSbK/l+IAhHcYU8c0UJcnIzD9o9eATabFLCQzHgIxli8HNKP
	 u/4y+ktGAH1xAblaGGfbozig5xzy8dJkHPBf6L/dvQ0/EoTZ5PEboK7exRjzDC+sQ5dLF
	 //uqTWg70/QrIKANGcLvamNTRO+5vVzFkI4uGfZSttmf206hG0KKYPbXhy5EjhMcoGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEPnH86d;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC9A606A330
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 22:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DC9A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEPnH86d
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-716c0217635so289905eaf.0
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 14:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955745; x=1795560545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5JR6oFMP9CwmZMpNvitxNSrcrNywGdSAOnr1eeLQR4=;
        b=zEPnH86dvcC0+ztEnOiXtgpeaD/wCZpX5GkFx6hGKJVqJI66E//Ru4bmpe9BlXJLoe
         3iKgJOIkpj/hUpKccdlvZz8zbC1cNFon0sjFSOuYulMJdU9SO3yaHT/jem5o/pqB+Epn
         d3ikX1igI2m4WY8+xQhqRQ8JS8uADzXIyOGtNMzgMF2AZycEMIDr9rVAAt5AC/TWnulH
         YtU+jQXM/hTWASz8aM210Q+bG1GoLZX0gf0Nq6yzX7m6wdDpRZTzyHH3DcOi9laxf6fy
         81M4lilBxTNc7EhyG0UnOcxAGccYaXSjZKf1tMKMEoKc4PcFV3CVQqROaHZbDyBvgR2c
         JblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955745; x=1795560545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5JR6oFMP9CwmZMpNvitxNSrcrNywGdSAOnr1eeLQR4=;
        b=xX5luo8lnePtXMzXwUUHPUl+gplMhbKU960LOMh3PTPbKu+b2L7gt9uEktkI6YGCQe
         lv/vMOqlTHgYuutfMrPpylhwCp5GWjXHeIwwAMaW8fc24AvVBBu+0n8/uJR4gCkGTwez
         hHgdwQOJh/dCf513r+/F3T6D8D13YeHrQqKBaE3uvoFOSg7/CY/fP6M1YZRl5BXhdo0g
         mx/QrGxUYudP3YqbDqGUAPRW9WVT3yDIl4p+LyiUAPxGjfoJx4lGT3vSH+mY6zl5p2Ov
         8+K+94xGSjVtM9hZ78yMx+Od0fxaUg2yFA/bYVRZrDUh0a0i8kpN1JNvCsSBhRAHKQi7
         suag==
X-Forwarded-Encrypted: i=1; AL+hErFU2jOa/VuL06tiQqFUm67uZh7Y/QvDEPjXN9NPiVnqUKXQolI6qr6ePbRQIDP/7tp01TN2xA67N8LuQno=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UuSh6rEikiV/kkIpBA9TNuaPCaPVZksSPKqVg1BQqTBNFxG9c
	4n0tdNt3a0MWAwtSTeI/O50vARSssYgKTG1BBveuTrMdy9JPUTr7JfNg
X-Gm-Gg: AYBFou021+vU6MROGXj56S4LWLCI1QlOjt6gbs1N9cteKyLDt6mbCHY3Um6nu2zZze1
	y/toNlMQ0rBQZUmRWSAjMP8eszB7cUKD2AMDQXx44dv2ueUmJHNNmMteicZXFMSS5KYcFmOTLQE
	ioRSEfQ33e8nnhRymOcweuJyvshvgI4LJKMJzCAnGGCWKNcIEmpipcxaf0IWY7CrhdVo70vfQr4
	80UZYxNOElZIikFsUpEe5EsUHquOJ4P1YzemJL8gMIGyv0e1MGpUVLtYpeWktehWwSiKPgA1sJI
	K4VlwaATl78nGo4v3p4vbebQiMWKAwIP9cp4qRCNUlHRusoJa3GKde4EAzb6oteILTlQ5Rasl8X
	pLfq56aZsu3UHD8IzY5I+6a/btC5BOz8S23yE4BbQvWp3FDL2nq69sET+Bvd4X6LA4TiwlFqqtK
	T/fjVrfvBrOSFhWomcJI3e72BYc1+W5GiFF2FtqKdDAvwPg+/9N2tt4PGe/ObsLLdZPYGj+ZIL+
	6XwMS41OcGoPDTPUsYT9Hho7kFRxCsDgkmf8R+rJwhXejhiDKFkjVyMRmuHolMpo3QXmBnkcB8p
	TFDRo14LkWfiPhYcOT/szXmctPFCdVk21Dg4DuukYuHPrNJ0shxY1jCSNtKQhOYiYeTe2jwdf7a
	ejF6Mvf9nTPim5+vFJYVijTxJRun2uDZIdNwHVwyE91cuLK1GzU2eou14WUFmJEDPybWQSz7B5o
	6Mmgiw2d2R8l5dBc9RdiZSjjlfIilYhGOGTcqInoDifQaGl9EBxiA=
X-Received: by 2002:a05:6820:2d05:b0:71a:dc96:59dc with SMTP id 006d021491bc7-71b028cf76fmr2964926eaf.28.1794955744788;
        Tue, 17 Nov 2026 14:49:04 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74560af5fsm583066fac.16.2026.11.17.14.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:49:03 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:48:38 -0700
Subject: [PATCH v9 3/6] dmaengine: dw: use virt-dma for descriptor and
 callback ownership
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
Message-Id: <20261117-submit-dw-dma-synchronize-v1-v9-3-7dc066ed0bcf@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

The status getter can invoke a client's completion callback while polling
the hardware. An 8250 RX timeout calls it with the port lock held, and the
callback takes that same lock. Termination also lacks a synchronization
hook to wait for callbacks already detached from the channel's queues.

Use virt-dma for transaction queues, cookie completion and callback
delivery. Keep the active transaction and hardware state under vc.lock.
Polling still processes RAW.XFER and advances software-LLP blocks, so
clients such as catpt can complete transfers with the controller interrupt
masked. Client callbacks run only from the per-channel virt-dma tasklet.

Submit only the first block of each transaction to virt-dma. Its child
LLIs remain on the driver's hardware-chain list and are freed together
after the callback returns. Keep the controller tasklet for hardware
event processing and error recovery.

Complete cookies under vc.lock before handing descriptors to the callback
tasklet. Complete terminated cookies in submission order without invoking
their callbacks, so a concurrent termination cannot advance the completed
cookie past an older completion that later moves it backwards. Newly
submitted transactions become eligible to start when issue_pending()
moves them to the issued queue.

Implement device_synchronize with vchan_synchronize(), which drains only
the selected channel's callbacks. Drain them before releasing channel
resources as well. Exclude the controller tasklet while clearing channel
configuration and powering down, and let a pending run return without
register access after the last channel has been released.

This implements the callback deferral proposed by Serge Semin using the
shared infrastructure suggested by Andy Shevchenko.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and enable submission from callback")
Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240911184710.4207-3-fancer.lancer@gmail.com
Link: https://lore.kernel.org/r/avrHOJ-fVZOO32bI@ashevche-desk.local
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/Kconfig  |   1 +
 drivers/dma/dw/core.c   | 446 +++++++++++++++++++-----------------------------
 drivers/dma/dw/dw.c     |   2 +-
 drivers/dma/dw/idma32.c |  18 +-
 drivers/dma/dw/regs.h   |  24 ++-
 5 files changed, 201 insertions(+), 290 deletions(-)

diff --git a/drivers/dma/dw/Kconfig b/drivers/dma/dw/Kconfig
index a9828ddd6d06..444702c4a059 100644
--- a/drivers/dma/dw/Kconfig
+++ b/drivers/dma/dw/Kconfig
@@ -7,6 +7,7 @@
 config DW_DMAC_CORE
 	tristate
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 
 config DW_DMAC
 	tristate "Synopsys DesignWare AHB DMA platform driver"
diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index f7ca9da5af90..982a4b9bd678 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -41,38 +42,9 @@
 
 /*----------------------------------------------------------------------*/
 
-static struct dw_desc *dwc_first_active(struct dw_dma_chan *dwc)
-{
-	return to_dw_desc(dwc->active_list.next);
-}
-
-static dma_cookie_t dwc_tx_submit(struct dma_async_tx_descriptor *tx)
-{
-	struct dw_desc		*desc = txd_to_dw_desc(tx);
-	struct dw_dma_chan	*dwc = to_dw_dma_chan(tx->chan);
-	dma_cookie_t		cookie;
-	unsigned long		flags;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	cookie = dma_cookie_assign(tx);
-
-	/*
-	 * REVISIT: We should attempt to chain as many descriptors as
-	 * possible, perhaps even appending to those already submitted
-	 * for DMA. But this is hard to do in a race-free manner.
-	 */
-
-	list_add_tail(&desc->desc_node, &dwc->queue);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-	dev_vdbg(dmaengine_chan_dev(tx->chan), "%s: queued %u\n",
-		 __func__, desc->txd.cookie);
-
-	return cookie;
-}
-
 static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 	struct dw_desc *desc;
 	dma_addr_t phys;
 
@@ -80,36 +52,37 @@ static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
 	if (!desc)
 		return NULL;
 
-	dwc->descs_allocated++;
 	INIT_LIST_HEAD(&desc->tx_list);
-	dma_async_tx_descriptor_init(&desc->txd, &dwc->chan);
-	desc->txd.tx_submit = dwc_tx_submit;
-	desc->txd.flags = DMA_CTRL_ACK;
-	desc->txd.phys = phys;
+	desc->vd.tx.phys = phys;
 	return desc;
 }
 
 static void dwc_desc_put(struct dw_dma_chan *dwc, struct dw_desc *desc)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 	struct dw_desc *child, *_next;
 
 	if (unlikely(!desc))
 		return;
 
-	list_for_each_entry_safe(child, _next, &desc->tx_list, desc_node) {
-		list_del(&child->desc_node);
-		dma_pool_free(dw->desc_pool, child, child->txd.phys);
-		dwc->descs_allocated--;
+	list_for_each_entry_safe(child, _next, &desc->tx_list, vd.node) {
+		list_del(&child->vd.node);
+		dma_pool_free(dw->desc_pool, child, child->vd.tx.phys);
 	}
 
-	dma_pool_free(dw->desc_pool, desc, desc->txd.phys);
-	dwc->descs_allocated--;
+	dma_pool_free(dw->desc_pool, desc, desc->vd.tx.phys);
+}
+
+static void dwc_desc_free(struct virt_dma_desc *vd)
+{
+	struct dw_dma_chan *dwc = to_dw_dma_chan(vd->tx.chan);
+
+	dwc_desc_put(dwc, vd_to_dw_desc(vd));
 }
 
 static void dwc_initialize(struct dw_dma_chan *dwc)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 
 	dw->initialize_chan(dwc);
 
@@ -122,7 +95,7 @@ static void dwc_initialize(struct dw_dma_chan *dwc)
 
 static inline void dwc_dump_chan_regs(struct dw_dma_chan *dwc)
 {
-	dev_err(dmaengine_chan_dev(&dwc->chan),
+	dev_err(dmaengine_chan_dev(&dwc->vc.chan),
 		"  SAR: 0x%x DAR: 0x%x LLP: 0x%x CTL: 0x%x:%08x\n",
 		channel_readl(dwc, SAR),
 		channel_readl(dwc, DAR),
@@ -150,7 +123,7 @@ static inline void dwc_chan_disable(struct dw_dma *dw, struct dw_dma_chan *dwc)
 static inline void dwc_do_single_block(struct dw_dma_chan *dwc,
 				       struct dw_desc *desc)
 {
-	struct dw_dma	*dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma	*dw = to_dw_dma(dwc->vc.chan.device);
 	u32		ctllo;
 
 	/*
@@ -169,16 +142,16 @@ static inline void dwc_do_single_block(struct dw_dma_chan *dwc,
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
@@ -191,7 +164,7 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 		was_soft_llp = test_and_set_bit(DW_DMA_IS_SOFT_LLP,
 						&dwc->flags);
 		if (was_soft_llp) {
-			dev_err(dmaengine_chan_dev(&dwc->chan),
+			dev_err(dmaengine_chan_dev(&dwc->vc.chan),
 				"BUG: Attempted to start new LLP transfer inside ongoing one\n");
 			return;
 		}
@@ -209,7 +182,7 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 
 	dwc_initialize(dwc);
 
-	channel_writel(dwc, LLP, first->txd.phys | lms);
+	channel_writel(dwc, LLP, first->vd.tx.phys | lms);
 	channel_writel(dwc, CTL_LO, DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN);
 	channel_writel(dwc, CTL_HI, 0);
 	channel_set_bit(dw, CH_EN, dwc->mask);
@@ -217,51 +190,24 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 
 static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
 {
-	struct dw_desc *desc;
+	struct virt_dma_desc *vd;
 
-	if (list_empty(&dwc->queue))
+	vd = vchan_next_desc(&dwc->vc);
+	if (!vd)
 		return;
 
-	list_move(dwc->queue.next, &dwc->active_list);
-	desc = dwc_first_active(dwc);
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: started %u\n", __func__, desc->txd.cookie);
-	dwc_dostart(dwc, desc);
+	list_del(&vd->node);
+	dwc->desc = vd_to_dw_desc(vd);
+	dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "%s: started %u\n", __func__, vd->tx.cookie);
+	dwc_dostart(dwc, dwc->desc);
 }
 
 /*----------------------------------------------------------------------*/
 
-static void
-dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
-		bool callback_required)
-{
-	struct dma_async_tx_descriptor	*txd = &desc->txd;
-	struct dw_desc			*child;
-	unsigned long			flags;
-	struct dmaengine_desc_callback	cb;
-
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	dma_cookie_complete(txd);
-	if (callback_required)
-		dmaengine_desc_get_callback(txd, &cb);
-	else
-		memset(&cb, 0, sizeof(cb));
-
-	/* async_tx_ack */
-	list_for_each_entry(child, &desc->tx_list, desc_node)
-		async_tx_ack(&child->txd);
-	async_tx_ack(&desc->txd);
-	dwc_desc_put(dwc, desc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	dmaengine_desc_callback_invoke(&cb, NULL);
-}
-
 /* Returns how many bytes were already received from source */
 static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 	u32 ctlhi = channel_readl(dwc, CTL_HI);
 	u32 ctllo = channel_readl(dwc, CTL_LO);
 
@@ -270,126 +216,82 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
-	dma_addr_t llp;
-	struct dw_desc *desc, *_desc;
+	struct dw_desc *desc;
 	struct dw_desc *child;
-	u32 status_xfer;
-	unsigned long flags;
-	LIST_HEAD(list);
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	llp = channel_readl(dwc, LLP);
-	status_xfer = dma_readl(dw, RAW.XFER);
-
-	if (status_xfer & dwc->mask) {
-		/* Everything we've submitted is done */
-		dma_writel(dw, CLEAR.XFER, dwc->mask);
-		if (list_empty(&dwc->active_list)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return;
-		}
+	dma_addr_t llp;
 
-		if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
-			struct list_head *head, *active = dwc->tx_node_active;
+	lockdep_assert_held(&dwc->vc.lock);
 
-			/*
-			 * We are inside first active descriptor.
-			 * Otherwise something is really wrong.
-			 */
-			desc = dwc_first_active(dwc);
+	llp = channel_readl(dwc, LLP);
+	if (!(dma_readl(dw, RAW.XFER) & dwc->mask))
+		goto residue;
 
-			head = &desc->tx_list;
-			if (active != head) {
-				/* Update residue to reflect last sent descriptor */
-				if (active == head->next)
-					desc->residue -= desc->len;
-				else
-					desc->residue -= to_dw_desc(active->prev)->len;
+	dma_writel(dw, CLEAR.XFER, dwc->mask);
+	if (!dwc->desc)
+		return;
 
-				child = to_dw_desc(active);
+	desc = dwc->desc;
+	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
+		struct list_head *head = &desc->tx_list;
+		struct list_head *active = dwc->tx_node_active;
 
-				/* Submit next block */
-				dwc_do_single_block(dwc, child);
+		if (active != head) {
+			/* Update residue to reflect last sent descriptor. */
+			if (active == head->next)
+				desc->residue -= desc->len;
+			else
+				desc->residue -= to_dw_desc(active->prev)->len;
 
-				spin_unlock_irqrestore(&dwc->lock, flags);
-				return;
-			}
+			child = to_dw_desc(active);
 
-			/* We are done here */
-			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
+			/* Submit next block, including for polled transfers. */
+			dwc_do_single_block(dwc, child);
+			return;
 		}
 
-		if (dma_readl(dw, CH_EN) & dwc->mask) {
-			dev_err(dmaengine_chan_dev(&dwc->chan),
-				"BUG: XFER bit set, but channel not idle!\n");
+		clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
+	}
 
-			/* Try to continue after resetting the channel... */
-			dwc_chan_disable(dw, dwc);
-		}
+	if (dma_readl(dw, CH_EN) & dwc->mask) {
+		dev_err(dmaengine_chan_dev(&dwc->vc.chan),
+			"BUG: XFER bit set, but channel not idle!\n");
 
-		/* Detach the completed transfer before starting queued work. */
-		list_splice_init(&dwc->active_list, &list);
-		dwc_dostart_first_queued(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
+		/* Try to continue after resetting the channel... */
+		dwc_chan_disable(dw, dwc);
+	}
 
-		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
-			list_del_init(&desc->desc_node);
-			dwc_descriptor_complete(dwc, desc, true);
-		}
+	dwc->desc = NULL;
+	vchan_cookie_complete(&desc->vd);
+	dwc_dostart_first_queued(dwc);
+	return;
+
+residue:
+	desc = dwc->desc;
+	if (!desc || test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
 		return;
-	}
 
-	if (list_empty(&dwc->active_list)) {
-		spin_unlock_irqrestore(&dwc->lock, flags);
+	desc->residue = desc->total_len;
+	if (desc->vd.tx.phys == DWC_LLP_LOC(llp))
 		return;
-	}
 
-	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
-		dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
-		spin_unlock_irqrestore(&dwc->lock, flags);
+	if (lli_read(desc, llp) == llp) {
+		desc->residue -= dwc_get_sent(dwc);
 		return;
 	}
 
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
-
-	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
-		/* Initial residue value */
-		desc->residue = desc->total_len;
-
-		/* Check first descriptors addr */
-		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return;
-		}
-
-		/* Check first descriptors llp */
-		if (lli_read(desc, llp) == llp) {
-			/* This one is currently in progress */
+	desc->residue -= desc->len;
+	list_for_each_entry(child, &desc->tx_list, vd.node) {
+		if (lli_read(child, llp) == llp) {
 			desc->residue -= dwc_get_sent(dwc);
-			spin_unlock_irqrestore(&dwc->lock, flags);
 			return;
 		}
-
-		desc->residue -= desc->len;
-		list_for_each_entry(child, &desc->tx_list, desc_node) {
-			if (lli_read(child, llp) == llp) {
-				/* Currently in progress */
-				desc->residue -= dwc_get_sent(dwc);
-				spin_unlock_irqrestore(&dwc->lock, flags);
-				return;
-			}
-			desc->residue -= child->len;
-		}
-
+		desc->residue -= child->len;
 	}
-
-	/* Residue describes source reads; only RAW.XFER completes a transfer. */
-	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
 {
-	dev_crit(dmaengine_chan_dev(&dwc->chan), "  desc: s0x%x d0x%x l0x%x c0x%x:%x\n",
+	dev_crit(dmaengine_chan_dev(&dwc->vc.chan), "  desc: s0x%x d0x%x l0x%x c0x%x:%x\n",
 		 lli_read(desc, sar),
 		 lli_read(desc, dar),
 		 lli_read(desc, llp),
@@ -401,26 +303,24 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
 	struct dw_desc *bad_desc;
 	struct dw_desc *child;
-	unsigned long flags;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	lockdep_assert_held(&dwc->vc.lock);
 
 	/* Termination may have cleared the error since the tasklet sampled it. */
 	if (!(dma_readl(dw, RAW.ERROR) & dwc->mask))
-		goto unlock;
+		return;
 
 	dwc_chan_disable(dw, dwc);
 	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
-	if (list_empty(&dwc->active_list))
-		goto unlock;
+	if (!dwc->desc)
+		return;
 
 	/*
-	 * The descriptor currently at the head of the active list is
-	 * borked. Since we don't have any way to report errors, we'll
-	 * just have to scream loudly and try to carry on.
+	 * The active descriptor is borked. Since we don't have any way to
+	 * report errors, we'll just have to scream loudly and try to carry on.
 	 */
-	bad_desc = dwc_first_active(dwc);
-	list_del_init(&bad_desc->desc_node);
+	bad_desc = dwc->desc;
+	dwc->desc = NULL;
 	dwc_dostart_first_queued(dwc);
 
 	/*
@@ -430,43 +330,47 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	 * controller flagged an error instead of scribbling over
 	 * random memory locations.
 	 */
-	dev_WARN(dmaengine_chan_dev(&dwc->chan), "Bad descriptor submitted for DMA!\n"
-				       "  cookie: %d\n", bad_desc->txd.cookie);
+	dev_WARN(dmaengine_chan_dev(&dwc->vc.chan), "Bad descriptor submitted for DMA!\n"
+				       "  cookie: %d\n", bad_desc->vd.tx.cookie);
 	dwc_dump_lli(dwc, bad_desc);
-	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
+	list_for_each_entry(child, &bad_desc->tx_list, vd.node)
 		dwc_dump_lli(dwc, child);
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
 	/* Pretend the descriptor completed successfully */
-	dwc_descriptor_complete(dwc, bad_desc, true);
-	return;
+	vchan_cookie_complete(&bad_desc->vd);
+}
 
-unlock:
-	spin_unlock_irqrestore(&dwc->lock, flags);
+static void dwc_handle_channel(struct dw_dma *dw, struct dw_dma_chan *dwc)
+{
+	lockdep_assert_held(&dwc->vc.lock);
+
+	if (dma_readl(dw, RAW.ERROR) & dwc->mask)
+		dwc_handle_error(dw, dwc);
+	else
+		dwc_scan_descriptors(dw, dwc);
 }
 
 static void dw_dma_tasklet(struct tasklet_struct *t)
 {
 	struct dw_dma *dw = from_tasklet(dw, t, tasklet);
 	struct dw_dma_chan *dwc;
-	u32 status_xfer;
-	u32 status_err;
+	unsigned long flags;
 	unsigned int i;
+	u32 status;
 
-	status_xfer = dma_readl(dw, RAW.XFER);
-	status_err = dma_readl(dw, RAW.ERROR);
+	/* Channel release may have drained a polled completion before this run. */
+	if (!dw->in_use)
+		return;
 
-	dev_vdbg(dw->dma.dev, "%s: status_err=%x\n", __func__, status_err);
+	status = dma_readl(dw, RAW.XFER) | dma_readl(dw, RAW.ERROR);
 
 	for (i = 0; i < dw->dma.chancnt; i++) {
 		dwc = &dw->chan[i];
-		if (test_bit(DW_DMA_IS_CYCLIC, &dwc->flags))
-			dev_vdbg(dw->dma.dev, "Cyclic xfer is not implemented\n");
-		else if (status_err & (1 << i))
-			dwc_handle_error(dw, dwc);
-		else if (status_xfer & (1 << i))
-			dwc_scan_descriptors(dw, dwc);
+		spin_lock_irqsave(&dwc->vc.lock, flags);
+		/* The snapshot selects work; recheck events under the channel lock. */
+		if (status & dwc->mask)
+			dwc_handle_channel(dw, dwc);
+		spin_unlock_irqrestore(&dwc->vc.lock, flags);
 	}
 
 	/* Re-enable interrupts */
@@ -574,8 +478,8 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		if (!first) {
 			first = desc;
 		} else {
-			lli_write(prev, llp, desc->txd.phys | lms);
-			list_add_tail(&desc->desc_node, &first->tx_list);
+			lli_write(prev, llp, desc->vd.tx.phys | lms);
+			list_add_tail(&desc->vd.node, &first->tx_list);
 		}
 		prev = desc;
 	}
@@ -586,10 +490,9 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 
 	prev->lli.llp = 0;
 	lli_clear(prev, ctllo, DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN);
-	first->txd.flags = flags;
 	first->total_len = len;
 
-	return &first->txd;
+	return vchan_tx_prep(&dwc->vc, &first->vd, flags);
 
 err_desc_get:
 	dwc_desc_put(dwc, first);
@@ -662,8 +565,8 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			if (!first) {
 				first = desc;
 			} else {
-				lli_write(prev, llp, desc->txd.phys | lms);
-				list_add_tail(&desc->desc_node, &first->tx_list);
+				lli_write(prev, llp, desc->vd.tx.phys | lms);
+				list_add_tail(&desc->vd.node, &first->tx_list);
 			}
 			prev = desc;
 
@@ -711,8 +614,8 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			if (!first) {
 				first = desc;
 			} else {
-				lli_write(prev, llp, desc->txd.phys | lms);
-				list_add_tail(&desc->desc_node, &first->tx_list);
+				lli_write(prev, llp, desc->vd.tx.phys | lms);
+				list_add_tail(&desc->vd.node, &first->tx_list);
 			}
 			prev = desc;
 
@@ -736,7 +639,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	lli_clear(prev, ctllo, DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN);
 	first->total_len = total_len;
 
-	return &first->txd;
+	return vchan_tx_prep(&dwc->vc, &first->vd, flags);
 
 err_desc_get:
 	dev_err(dmaengine_chan_dev(chan),
@@ -872,7 +775,7 @@ static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
 
 static void dwc_chan_pause(struct dw_dma_chan *dwc, bool drain)
 {
-	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
+	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
 	unsigned int		count = 20;	/* timeout iterations */
 
 	dw->suspend_chan(dwc, drain);
@@ -888,16 +791,16 @@ static int dwc_pause(struct dma_chan *chan)
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
 
@@ -909,12 +812,12 @@ static int dwc_resume(struct dma_chan *chan)
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
@@ -923,11 +826,11 @@ static int dwc_terminate_all(struct dma_chan *chan)
 {
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 	struct dw_dma		*dw = to_dw_dma(chan->device);
-	struct dw_desc		*desc, *_desc;
+	struct virt_dma_desc	*vd;
 	unsigned long		flags;
 	LIST_HEAD(list);
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 
 	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
 
@@ -937,26 +840,35 @@ static int dwc_terminate_all(struct dma_chan *chan)
 
 	dwc_chan_resume(dwc, true);
 
-	/* active_list entries will end up before queued entries */
-	list_splice_init(&dwc->queue, &list);
-	list_splice_init(&dwc->active_list, &list);
+	if (dwc->desc) {
+		dma_cookie_complete(&dwc->desc->vd.tx);
+		vchan_terminate_vdesc(&dwc->desc->vd);
+		dwc->desc = NULL;
+	}
+	list_for_each_entry(vd, &dwc->vc.desc_issued, node)
+		dma_cookie_complete(&vd->tx);
+	list_for_each_entry(vd, &dwc->vc.desc_submitted, node)
+		dma_cookie_complete(&vd->tx);
+	vchan_get_all_descriptors(&dwc->vc, &list);
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 
-	/* Flush all pending and queued descriptors */
-	list_for_each_entry_safe(desc, _desc, &list, desc_node)
-		dwc_descriptor_complete(dwc, desc, false);
+	vchan_dma_desc_free_list(&dwc->vc, &list);
 
 	return 0;
 }
 
-static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
+static void dwc_synchronize(struct dma_chan *chan)
 {
-	struct dw_desc *desc;
+	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
+
+	vchan_synchronize(&dwc->vc);
+}
 
-	list_for_each_entry(desc, &dwc->active_list, desc_node)
-		if (desc->txd.cookie == c)
-			return desc;
+static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
+{
+	if (dwc->desc && dwc->desc->vd.tx.cookie == c)
+		return dwc->desc;
 
 	return NULL;
 }
@@ -965,14 +877,13 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 				      enum dma_status *status)
 {
 	struct dw_desc *desc;
-	unsigned long flags;
 	u32 residue;
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	lockdep_assert_held(&dwc->vc.lock);
 
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
-		if (desc == dwc_first_active(dwc)) {
+		if (desc == dwc->desc) {
 			residue = desc->residue;
 			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
 				residue -= dwc_get_sent(dwc);
@@ -985,7 +896,6 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 		residue = 0;
 	}
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
 	return residue;
 }
 
@@ -995,19 +905,22 @@ dwc_tx_status(struct dma_chan *chan,
 	      struct dma_tx_state *txstate)
 {
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
+	struct dw_dma		*dw = to_dw_dma(chan->device);
 	enum dma_status		ret;
 
+	guard(spinlock_irqsave)(&dwc->vc.lock);
+
 	ret = dma_cookie_status(chan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
 		return ret;
 
-	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
+	/* Poll completion even when the client has masked the controller IRQ. */
+	dwc_handle_channel(dw, dwc);
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE)
-		return ret;
+	if (ret != DMA_COMPLETE)
+		dma_set_residue(txstate, dwc_get_residue_and_status(dwc, cookie, &ret));
 
-	dma_set_residue(txstate, dwc_get_residue_and_status(dwc, cookie, &ret));
 	return ret;
 }
 
@@ -1016,10 +929,10 @@ static void dwc_issue_pending(struct dma_chan *chan)
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 	unsigned long		flags;
 
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (list_empty(&dwc->active_list))
+	spin_lock_irqsave(&dwc->vc.lock, flags);
+	if (vchan_issue_pending(&dwc->vc) && !dwc->desc)
 		dwc_dostart_first_queued(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 }
 
 /*----------------------------------------------------------------------*/
@@ -1086,15 +999,19 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 	unsigned long		flags;
 
-	dev_dbg(dmaengine_chan_dev(chan), "%s: descs allocated=%u\n", __func__,
-			dwc->descs_allocated);
+	vchan_synchronize(&dwc->vc);
+	/* The controller tasklet also accesses channel registers. */
+	tasklet_disable(&dw->tasklet);
 
 	/* ASSERT:  channel is idle */
-	BUG_ON(!list_empty(&dwc->active_list));
-	BUG_ON(!list_empty(&dwc->queue));
+	BUG_ON(dwc->desc);
+	BUG_ON(!list_empty(&dwc->vc.desc_issued));
+	BUG_ON(!list_empty(&dwc->vc.desc_submitted));
 	BUG_ON(dma_readl(to_dw_dma(chan->device), CH_EN) & dwc->mask);
 
-	spin_lock_irqsave(&dwc->lock, flags);
+	vchan_free_chan_resources(&dwc->vc);
+
+	spin_lock_irqsave(&dwc->vc.lock, flags);
 
 	/* Clear custom channel configuration */
 	memset(&dwc->dws, 0, sizeof(struct dw_dma_slave));
@@ -1104,13 +1021,15 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	channel_clear_bit(dw, MASK.BLOCK, dwc->mask);
 	channel_clear_bit(dw, MASK.ERROR, dwc->mask);
 
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 
 	/* Disable controller in case it was a last user */
 	dw->in_use &= ~dwc->mask;
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
+	tasklet_enable(&dw->tasklet);
+
 	dev_vdbg(dmaengine_chan_dev(chan), "%s: done\n", __func__);
 }
 
@@ -1221,13 +1140,10 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	for (i = 0; i < pdata->nr_channels; i++) {
 		struct dw_dma_chan	*dwc = &dw->chan[i];
 
-		dwc->chan.device = &dw->dma;
-		dma_cookie_init(&dwc->chan);
-		if (pdata->chan_allocation_order == CHAN_ALLOCATION_ASCENDING)
-			list_add_tail(&dwc->chan.device_node,
-					&dw->dma.channels);
-		else
-			list_add(&dwc->chan.device_node, &dw->dma.channels);
+		dwc->vc.desc_free = dwc_desc_free;
+		vchan_init(&dwc->vc, &dw->dma);
+		if (pdata->chan_allocation_order != CHAN_ALLOCATION_ASCENDING)
+			list_move(&dwc->vc.chan.device_node, &dw->dma.channels);
 
 		/* 7 is highest priority & 0 is lowest. */
 		if (pdata->chan_priority == CHAN_PRIORITY_ASCENDING)
@@ -1236,12 +1152,8 @@ int do_dma_probe(struct dw_dma_chip *chip)
 			dwc->priority = i;
 
 		dwc->ch_regs = &__dw_regs(dw)->CHAN[i];
-		spin_lock_init(&dwc->lock);
 		dwc->mask = 1 << i;
 
-		INIT_LIST_HEAD(&dwc->active_list);
-		INIT_LIST_HEAD(&dwc->queue);
-
 		channel_clear_bit(dw, CH_EN, dwc->mask);
 
 		dwc->direction = DMA_TRANS_NONE;
@@ -1306,6 +1218,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
 	dw->dma.device_terminate_all = dwc_terminate_all;
+	dw->dma.device_synchronize = dwc_synchronize;
 
 	dw->dma.device_tx_status = dwc_tx_status;
 	dw->dma.device_issue_pending = dwc_issue_pending;
@@ -1358,8 +1271,9 @@ int do_dma_remove(struct dw_dma_chip *chip)
 	tasklet_kill(&dw->tasklet);
 
 	list_for_each_entry_safe(dwc, _dwc, &dw->dma.channels,
-			chan.device_node) {
-		list_del(&dwc->chan.device_node);
+			vc.chan.device_node) {
+		vchan_synchronize(&dwc->vc);
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
index 5969d9cc8d7a..9764ad157630 100644
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
@@ -273,14 +274,9 @@ struct dw_dma_chan {
 	/* software emulation of the LLP transfers */
 	struct list_head	*tx_node_active;
 
-	spinlock_t		lock;
-
-	/* these other elements are all protected by lock */
+	/* these other elements are all protected by vc.lock */
 	unsigned long		flags;
-	struct list_head	active_list;
-	struct list_head	queue;
-
-	unsigned int		descs_allocated;
+	struct dw_desc		*desc;
 
 	/* hardware configuration */
 	unsigned int		block_size;
@@ -307,7 +303,7 @@ __dwc_regs(struct dw_dma_chan *dwc)
 
 static inline struct dw_dma_chan *to_dw_dma_chan(struct dma_chan *chan)
 {
-	return container_of(chan, struct dw_dma_chan, chan);
+	return container_of(chan, struct dw_dma_chan, vc.chan);
 }
 
 struct dw_dma {
@@ -391,18 +387,18 @@ struct dw_desc {
 #define lli_write(d, reg, v)		((d)->lli.reg = cpu_to_le32(v))
 
 	/* THEN values for driver housekeeping */
-	struct list_head		desc_node;
+	/* Only the first block is submitted to virt-dma. */
 	struct list_head		tx_list;
-	struct dma_async_tx_descriptor	txd;
+	struct virt_dma_desc		vd;
 	size_t				len;
 	size_t				total_len;
 	u32				residue;
 };
 
-#define to_dw_desc(h)	list_entry(h, struct dw_desc, desc_node)
+#define to_dw_desc(h)	list_entry(h, struct dw_desc, vd.node)
 
 static inline struct dw_desc *
-txd_to_dw_desc(struct dma_async_tx_descriptor *txd)
+vd_to_dw_desc(struct virt_dma_desc *vd)
 {
-	return container_of(txd, struct dw_desc, txd);
+	return container_of(vd, struct dw_desc, vd);
 }

-- 
2.53.0

