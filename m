Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295111;
	b=qWnj1UNib2gLrMHTP78DaGD7wQOlHLeKmhtTDD2dDC0/HMjoAPAm3I+MekTiMAnQIP6E
	 DDDlshKUavdkpDcbLtgJimZtkV6GwNzz6N1L/pcJjJzetNAiBLnPPL3Z/NIdsdUJz/u65
	 hkwqHr7tPfo7eCeSp0uk8yutBVGcXd/IGtT6b1FzSRc/dF9gyt1jrg+r9zOv38SInud2H
	 zSn5svv5tAOsKvu75OpurphyejLpXuRtIU2oRJBsQjoeJDNZA1jc35JF/aHskVcn8Lb8v
	 ZVC86u/j14PrT+ZCNtcu6nFqtn0Y4vJZPm5zDykI9Wnb0j2RWcLREieW36C2WwIRXCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=eMHtTNoDtOmLsG+n0Epf9jVt0Nnn7Z2IR97Lo/M4oJ8=;
	b=HqRTskT48L4UZFtaSs8DnU5Em147SHq1m33Yh76gXEw/s98QxeePooihIPybbel6PwSw
	 W/sgUX+TBctwsk5hmspJzs3FEpYnrGG43jg/atwQ7RgYfpA7Zwouym+Pa0p8Ey0o2EfKs
	 +vFsmgZvneoN90Y45imEvKubjKmo4pKlHP6UVVGVYzl9W6UADoXCvAZf/oSQfg9YFJ29m
	 qGvoB0EM6CUjdv5fQYMc+WXQTwheunMqOpkJXraSk6wFZ23rkTpd8LhgederxAmieM4MJ
	 YCKl+wGRnAb7xsnICSLFrNeBikbXuUhqDwDDuw4Z+woBNUiH7OKephuuo2smg1zfvKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ET6yYTSK;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BA606A683
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 21:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C67BA606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ET6yYTSK
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-71aed54d4c5so1314924eaf.0
        for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 13:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795295110; x=1795899910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eMHtTNoDtOmLsG+n0Epf9jVt0Nnn7Z2IR97Lo/M4oJ8=;
        b=ET6yYTSKbAdvmZprBfC49YCwgRXWqXS0qguJY7Pock1voJA1vAljAxSV8R2WNfDhG9
         1hh6AC1VMoO11cFdAHYoGm6p1L9gQ2tEYge3AwU7iAmMt8v2PyFwLdKdmqF1+ntFFCl1
         TXxZnMUirpPbBS2xefY14mEgLSZGrOgHUrDbh4dM8eTAES5Jo/PyKPpqCeD3W2bVLetL
         DU8T18pEkLKeurk7v/8YvswDLzKYyHsH36Z3JUuCWrIWPi5iDGBdp3uvuim+Wl4Q/Wgw
         jrbBbMv7N01ulA4GONRWe02qjN1IfccT4tQg7JeEKgzticLzV7rYffh8Kvzem7i1Gzz7
         QuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795295110; x=1795899910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eMHtTNoDtOmLsG+n0Epf9jVt0Nnn7Z2IR97Lo/M4oJ8=;
        b=lwC/Tzde6plws5jOjZuswp5g+wtq/nAYlVbz58By24TjeZiXHGEwTKKzKWIM9oqa5b
         LvJ3PjQ5QNBLAoxAZiL0J2Rwd6lJ88RihTpMNSf4dMu6wxg6oWEfvNvgHlo42BJ5r4Vn
         3mBRso9QFMgqVJ7zHiqxL+UXw4546PZQ+pJUPTKuQ8ZIynPRm59hCnHV6VQlmsKni1C9
         7dAEQcrOWv6UKoCwcgZMnstwpiwlZ0O8i/KXzLZsqxWADRszskz2hBR54+Ntk4LMnUjr
         J3Jdz4P6QYrFmqlVra4gRrHoTKz7xpzpJsL4xPzZrJAxQ6mlmgwsYO4DFqW0KughjOdj
         u6hw==
X-Forwarded-Encrypted: i=1; AL+hErFKLs3QUgk6DtQNlEMAC511BDqK5+cCpFtw3F7SNmGi/mMWU6a/Hg13wdZNWfa+AlakZzmZKsfG6UyIrOY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zXEz2ZVYCmuzdDK/HMvi5hs80OEKbpAaqYlarG3d68Q5zkq4E
	SDPB9JGGKoyGRHaXbo/nOndymghuwFxdykNQf2Ty6ZTXXucmka02xWyu
X-Gm-Gg: AZFdTZcfE6cENsPR65kbLx609A3MKes0OIYi/zY8g6M9jzV1ZiGZgixljpNRoukj4F5
	2FEl3+wwJW6GrsM652vbQ8xN/DVLWcN+WfZa5PaGnfg6KnT5m3pi02VHwOeL0V06dG9womAXiNX
	wT6cmyOaXL74KzhEtqqsmx6gg7hLsMhIDBOh2TF1hnvUYabBuhIz5C+d3bhkPWEI8H9DmdqTTFM
	ikqp8IT3UeWJlwavOVNEhhpq2E7y67Gcq2isDcKWSGbrcZgxk0KBUthCmGGKNgEa1yt6cgO3iuE
	o+XKgpqqZMmDMdmB7NDrfe96dDBV23UMbPR85h4GyVTRlgmael/pLfRxEStNQtb2jSh5fY9JWd+
	cOdajulAkUPfyHr9lJQWr+D+RjVFkcN17unnWgT9vE4RHEBG97jBqrC116F2KgQ61nlH6JQIekx
	Mesm5CsUfKJMo5Cue5e47EyvS2NDpaNZahLdKYarogN3RKatEeTVvyvZXmZhJ3zE29JEPeWPalH
	NAoKQ3GzO67XP4MtkGcmhDeUp6/MoktjPyjoEMwmrqyZUOlYs4PB8OeR8vYMGoeDA1fUJmZoF5p
	M3fr8c+EjeT+HNe3fegVSrtwXXeI4AmLku5ZeMTq05XKFiphHkUAD4fVxmQwvkty26+uYe9ZL41
	KNe/aesI0KT43odKxVd3PY01H9phyxnR5o8uS0Rx8Ldrvm28cDNVIHcvih4qfZDGEAhj1lOf3Wm
	Wb+UarLmMYzHpUF5XlsQkwTSzIA0P5BbLx2KxV3rrdUpQ4OGtBfHvR
X-Received: by 2002:a05:6820:820:b0:6f8:c10b:7776 with SMTP id 006d021491bc7-71b39623f72mr5968918eaf.78.1795295109546;
        Sat, 21 Nov 2026 13:05:09 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4635728eaf.13.2026.11.21.13.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:05:09 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 21 Nov 2026 14:03:19 -0700
Subject: [PATCH v12 4/7] dmaengine: dw: use virt-dma for descriptor and
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
Message-Id: <20261121-submit-dw-dma-synchronize-v1-v12-4-f51eb635209d@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

The status getter can invoke a client's completion callback while polling
the hardware. An 8250 RX timeout calls it with the port lock held, and the
callback takes that same lock. Termination also lacks a synchronization
hook to wait for callbacks already detached from the channel's queues.

Serge Semin proposed leaving transfer completion to the controller
tasklet [1]. Clients such as catpt poll with the controller interrupt
masked, so the status getter still needs to process RAW.XFER and
advance software-LLP blocks.

Use virt-dma for transaction queues, cookie completion and callback
delivery. Keep the active transaction and hardware state under vc.lock.
Run client callbacks only from the per-channel virt-dma tasklet.

An 8250 RX timeout consumes the transfer length minus the reported
residue. On a bus error, source reads do not establish how many bytes
reached the destination. Credit only whole blocks whose completion the
driver observed while advancing a software-linked transfer. For a
hardware-linked transfer, treat the whole buffer as unconfirmed.

Report the abort and the same residue to result callbacks and status
pollers, even after another transfer completes. Reserve the error record
during preparation, when clients can still handle allocation failure.
Use the normal virt-dma submission path; neither submission nor fault
reporting needs to allocate. Keep only failed cookies after descriptor
release, until the cookie is reused or the channel is released.

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
the selected channel's callbacks. DMAengine calls it before releasing
channel resources. Exclude the controller tasklet while clearing channel
configuration and powering down, and let a pending run return without
register access after the last channel has been released.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and enable submission from callback")
Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240911184710.4207-2-fancer.lancer@gmail.com [1]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/Kconfig |   1 +
 drivers/dma/dw/core.c  | 502 +++++++++++++++++++++++++------------------------
 drivers/dma/dw/regs.h  |  26 ++-
 3 files changed, 273 insertions(+), 256 deletions(-)

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
index 3df696e41ff2..d00d0d53f6ba 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -41,35 +42,6 @@
 
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
-	spin_lock_irqsave(&dwc->vc.lock, flags);
-	cookie = dma_cookie_assign(tx);
-
-	/*
-	 * REVISIT: We should attempt to chain as many descriptors as
-	 * possible, perhaps even appending to those already submitted
-	 * for DMA. But this is hard to do in a race-free manner.
-	 */
-
-	list_add_tail(&desc->desc_node, &dwc->queue);
-	spin_unlock_irqrestore(&dwc->vc.lock, flags);
-	dev_vdbg(dmaengine_chan_dev(tx->chan), "%s: queued %u\n",
-		 __func__, desc->txd.cookie);
-
-	return cookie;
-}
-
 static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
 {
 	struct dw_dma *dw = to_dw_dma(dwc->vc.chan.device);
@@ -80,12 +52,8 @@ static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
 	if (!desc)
 		return NULL;
 
-	dwc->descs_allocated++;
 	INIT_LIST_HEAD(&desc->tx_list);
-	dma_async_tx_descriptor_init(&desc->txd, &dwc->vc.chan);
-	desc->txd.tx_submit = dwc_tx_submit;
-	desc->txd.flags = DMA_CTRL_ACK;
-	desc->txd.phys = phys;
+	desc->vd.tx.phys = phys;
 	return desc;
 }
 
@@ -97,14 +65,86 @@ static void dwc_desc_put(struct dw_dma_chan *dwc, struct dw_desc *desc)
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
+	kfree(desc->error);
+	dma_pool_free(dw->desc_pool, desc, desc->vd.tx.phys);
+}
+
+static void dwc_desc_free(struct virt_dma_desc *vd)
+{
+	struct dw_dma_chan *dwc = to_dw_dma_chan(vd->tx.chan);
+
+	dwc_desc_put(dwc, vd_to_dw_desc(vd));
+}
+
+static struct dma_async_tx_descriptor *
+dwc_tx_prep(struct dw_dma_chan *dwc, struct dw_desc *desc, unsigned long flags)
+{
+	if (flags & DMA_CTRL_REUSE)
+		goto err;
+
+	/* Reserve a record now so neither submission nor error completion can fail. */
+	desc->error = kmalloc_obj(*desc->error, GFP_ATOMIC);
+	if (desc->error)
+		return vchan_tx_prep(&dwc->vc, &desc->vd, flags);
+err:
+	dwc_desc_put(dwc, desc);
+	return NULL;
+}
+
+static int dwc_error_cmp(const void *key, const struct rb_node *node)
+{
+	const struct dw_dma_error *error = rb_entry(node, struct dw_dma_error, node);
+
+	return *(const dma_cookie_t *)key - error->cookie;
+}
+
+static int dwc_error_cmp_nodes(struct rb_node *a, const struct rb_node *b)
+{
+	return dwc_error_cmp(&rb_entry(a, struct dw_dma_error, node)->cookie, b);
+}
+
+static void dwc_retire_cookie(struct dw_dma_chan *dwc, struct virt_dma_desc *vd)
+{
+	struct dw_desc *desc = vd_to_dw_desc(vd);
+	struct dw_dma_error *error = desc->error;
+	struct rb_node *old;
+
+	lockdep_assert_held(&dwc->vc.lock);
+	/* A numeric cookie may still have an error from before it wrapped. */
+	if (vd->tx_result.result == DMA_TRANS_ABORTED) {
+		error->cookie = vd->tx.cookie;
+		error->residue = vd->tx_result.residue;
+		old = rb_find_add(&error->node, &dwc->errors, dwc_error_cmp_nodes);
+		if (!old) {
+			desc->error = NULL;
+			return;
+		}
+		rb_entry(old, struct dw_dma_error, node)->residue = error->residue;
+	} else {
+		old = rb_find(&vd->tx.cookie, &dwc->errors, dwc_error_cmp);
+		if (old) {
+			rb_erase(old, &dwc->errors);
+			kfree(rb_entry(old, struct dw_dma_error, node));
+		}
+	}
+}
+
+static void dwc_free_errors(struct dw_dma_chan *dwc)
+{
+	struct dw_dma_error *error, *next;
+	struct rb_root errors;
+
+	scoped_guard(spinlock_irqsave, &dwc->vc.lock) {
+		errors = dwc->errors;
+		dwc->errors = RB_ROOT;
+	}
+	rbtree_postorder_for_each_entry_safe(error, next, &errors, node)
+		kfree(error);
 }
 
 static void dwc_initialize(struct dw_dma_chan *dwc)
@@ -209,7 +249,7 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 
 	dwc_initialize(dwc);
 
-	channel_writel(dwc, LLP, first->txd.phys | lms);
+	channel_writel(dwc, LLP, first->vd.tx.phys | lms);
 	channel_writel(dwc, CTL_LO, DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN);
 	channel_writel(dwc, CTL_HI, 0);
 	channel_set_bit(dw, CH_EN, dwc->mask);
@@ -217,47 +257,20 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 
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
-	dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "%s: started %u\n", __func__, desc->txd.cookie);
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
-	dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "descriptor %u complete\n", txd->cookie);
-
-	spin_lock_irqsave(&dwc->vc.lock, flags);
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
-	spin_unlock_irqrestore(&dwc->vc.lock, flags);
-
-	dmaengine_desc_callback_invoke(&cb, NULL);
-}
-
 /* Returns how many bytes were already received from source */
 static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 {
@@ -270,121 +283,78 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 
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
-	spin_lock_irqsave(&dwc->vc.lock, flags);
-	llp = channel_readl(dwc, LLP);
-	status_xfer = dma_readl(dw, RAW.XFER);
-
-	if (status_xfer & dwc->mask) {
-		/* Everything we've submitted is done */
-		dma_writel(dw, CLEAR.XFER, dwc->mask);
-		if (list_empty(&dwc->active_list)) {
-			spin_unlock_irqrestore(&dwc->vc.lock, flags);
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
 
-				spin_unlock_irqrestore(&dwc->vc.lock, flags);
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
-			dev_err(dmaengine_chan_dev(&dwc->vc.chan),
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
-		spin_unlock_irqrestore(&dwc->vc.lock, flags);
+		/* Try to continue after resetting the channel... */
+		dwc_chan_disable(dw, dwc);
+	}
 
-		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
-			list_del_init(&desc->desc_node);
-			dwc_descriptor_complete(dwc, desc, true);
-		}
+	dwc->desc = NULL;
+	dwc_retire_cookie(dwc, &desc->vd);
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
-		spin_unlock_irqrestore(&dwc->vc.lock, flags);
+	desc->residue = desc->total_len;
+	if (desc->vd.tx.phys == DWC_LLP_LOC(llp))
 		return;
-	}
 
-	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
-		dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "%s: soft LLP mode\n", __func__);
-		spin_unlock_irqrestore(&dwc->vc.lock, flags);
+	if (lli_read(desc, llp) == llp) {
+		desc->residue -= dwc_get_sent(dwc);
 		return;
 	}
 
-	dev_vdbg(dmaengine_chan_dev(&dwc->vc.chan), "%s: llp=%pad\n", __func__, &llp);
-
-	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
-		/* Initial residue value */
-		desc->residue = desc->total_len;
-
-		/* Check first descriptors addr */
-		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
-			spin_unlock_irqrestore(&dwc->vc.lock, flags);
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
-			spin_unlock_irqrestore(&dwc->vc.lock, flags);
 			return;
 		}
-
-		desc->residue -= desc->len;
-		list_for_each_entry(child, &desc->tx_list, desc_node) {
-			if (lli_read(child, llp) == llp) {
-				/* Currently in progress */
-				desc->residue -= dwc_get_sent(dwc);
-				spin_unlock_irqrestore(&dwc->vc.lock, flags);
-				return;
-			}
-			desc->residue -= child->len;
-		}
-
+		desc->residue -= child->len;
 	}
-
-	/* Residue describes source reads; only RAW.XFER completes a transfer. */
-	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
@@ -401,26 +371,26 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
 	struct dw_desc *bad_desc;
 	struct dw_desc *child;
-	unsigned long flags;
+	size_t residue;
+	bool soft_llp;
 
-	spin_lock_irqsave(&dwc->vc.lock, flags);
+	lockdep_assert_held(&dwc->vc.lock);
 
 	/* Termination may have cleared the error since the tasklet sampled it. */
 	if (!(dma_readl(dw, RAW.ERROR) & dwc->mask))
-		goto unlock;
+		return;
 
 	dwc_chan_disable(dw, dwc);
-	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
-	if (list_empty(&dwc->active_list))
-		goto unlock;
+	soft_llp = test_and_clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
+	if (!dwc->desc)
+		return;
 
-	/*
-	 * The descriptor currently at the head of the active list is
-	 * borked. Since we don't have any way to report errors, we'll
-	 * just have to scream loudly and try to carry on.
-	 */
-	bad_desc = dwc_first_active(dwc);
-	list_del_init(&bad_desc->desc_node);
+	bad_desc = dwc->desc;
+	/* On a bus error only previous software-LLP completions confirm delivery. */
+	residue = soft_llp ? bad_desc->residue : bad_desc->total_len;
+	bad_desc->vd.tx_result.residue = min_t(size_t, residue, U32_MAX);
+	bad_desc->vd.tx_result.result = DMA_TRANS_ABORTED;
+	dwc->desc = NULL;
 	dwc_dostart_first_queued(dwc);
 
 	/*
@@ -431,42 +401,48 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	 * random memory locations.
 	 */
 	dev_WARN(dmaengine_chan_dev(&dwc->vc.chan), "Bad descriptor submitted for DMA!\n"
-				       "  cookie: %d\n", bad_desc->txd.cookie);
+				       "  cookie: %d\n", bad_desc->vd.tx.cookie);
 	dwc_dump_lli(dwc, bad_desc);
-	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
+	list_for_each_entry(child, &bad_desc->tx_list, vd.node)
 		dwc_dump_lli(dwc, child);
 
-	spin_unlock_irqrestore(&dwc->vc.lock, flags);
+	dwc_retire_cookie(dwc, &bad_desc->vd);
+	vchan_cookie_complete(&bad_desc->vd);
+}
 
-	/* Pretend the descriptor completed successfully */
-	dwc_descriptor_complete(dwc, bad_desc, true);
-	return;
+static void dwc_handle_channel(struct dw_dma *dw, struct dw_dma_chan *dwc)
+{
+	lockdep_assert_held(&dwc->vc.lock);
 
-unlock:
-	spin_unlock_irqrestore(&dwc->vc.lock, flags);
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
+	/* The snapshot selects work; recheck events under the channel lock. */
+	status = dma_readl(dw, RAW.XFER) | dma_readl(dw, RAW.ERROR);
 
 	for (i = 0; i < dw->dma.chancnt; i++) {
 		dwc = &dw->chan[i];
-		if (test_bit(DW_DMA_IS_CYCLIC, &dwc->flags))
-			dev_vdbg(dw->dma.dev, "Cyclic xfer is not implemented\n");
-		else if (status_err & (1 << i))
-			dwc_handle_error(dw, dwc);
-		else if (status_xfer & (1 << i))
-			dwc_scan_descriptors(dw, dwc);
+		if (!(status & dwc->mask))
+			continue;
+
+		spin_lock_irqsave(&dwc->vc.lock, flags);
+		dwc_handle_channel(dw, dwc);
+		spin_unlock_irqrestore(&dwc->vc.lock, flags);
 	}
 
 	/* Re-enable interrupts */
@@ -574,8 +550,8 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
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
@@ -586,10 +562,9 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 
 	prev->lli.llp = 0;
 	lli_clear(prev, ctllo, DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN);
-	first->txd.flags = flags;
 	first->total_len = len;
 
-	return &first->txd;
+	return dwc_tx_prep(dwc, first, flags);
 
 err_desc_get:
 	dwc_desc_put(dwc, first);
@@ -662,8 +637,8 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			if (!first) {
 				first = desc;
 			} else {
-				lli_write(prev, llp, desc->txd.phys | lms);
-				list_add_tail(&desc->desc_node, &first->tx_list);
+				lli_write(prev, llp, desc->vd.tx.phys | lms);
+				list_add_tail(&desc->vd.node, &first->tx_list);
 			}
 			prev = desc;
 
@@ -711,8 +686,8 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			if (!first) {
 				first = desc;
 			} else {
-				lli_write(prev, llp, desc->txd.phys | lms);
-				list_add_tail(&desc->desc_node, &first->tx_list);
+				lli_write(prev, llp, desc->vd.tx.phys | lms);
+				list_add_tail(&desc->vd.node, &first->tx_list);
 			}
 			prev = desc;
 
@@ -736,7 +711,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	lli_clear(prev, ctllo, DWC_CTLL_LLP_D_EN | DWC_CTLL_LLP_S_EN);
 	first->total_len = total_len;
 
-	return &first->txd;
+	return dwc_tx_prep(dwc, first, flags);
 
 err_desc_get:
 	dev_err(dmaengine_chan_dev(chan),
@@ -923,7 +898,7 @@ static int dwc_terminate_all(struct dma_chan *chan)
 {
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 	struct dw_dma		*dw = to_dw_dma(chan->device);
-	struct dw_desc		*desc, *_desc;
+	struct virt_dma_desc	*vd;
 	unsigned long		flags;
 	LIST_HEAD(list);
 
@@ -937,26 +912,40 @@ static int dwc_terminate_all(struct dma_chan *chan)
 
 	dwc_chan_resume(dwc, true);
 
-	/* active_list entries will end up before queued entries */
-	list_splice_init(&dwc->queue, &list);
-	list_splice_init(&dwc->active_list, &list);
+	if (dwc->desc) {
+		dwc_retire_cookie(dwc, &dwc->desc->vd);
+		dma_cookie_complete(&dwc->desc->vd.tx);
+		vchan_terminate_vdesc(&dwc->desc->vd);
+		dwc->desc = NULL;
+	}
+	list_for_each_entry(vd, &dwc->vc.desc_issued, node) {
+		dwc_retire_cookie(dwc, vd);
+		dma_cookie_complete(&vd->tx);
+	}
+	list_for_each_entry(vd, &dwc->vc.desc_submitted, node) {
+		dwc_retire_cookie(dwc, vd);
+		dma_cookie_complete(&vd->tx);
+	}
+	vchan_get_all_descriptors(&dwc->vc, &list);
 
 	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 
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
 
-	list_for_each_entry(desc, &dwc->active_list, desc_node)
-		if (desc->txd.cookie == c)
-			return desc;
+	vchan_synchronize(&dwc->vc);
+}
+
+static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
+{
+	if (dwc->desc && dwc->desc->vd.tx.cookie == c)
+		return dwc->desc;
 
 	return NULL;
 }
@@ -965,14 +954,13 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 				      enum dma_status *status)
 {
 	struct dw_desc *desc;
-	unsigned long flags;
 	u32 residue;
 
-	spin_lock_irqsave(&dwc->vc.lock, flags);
+	lockdep_assert_held(&dwc->vc.lock);
 
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
-		if (desc == dwc_first_active(dwc)) {
+		if (desc == dwc->desc) {
 			residue = desc->residue;
 			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
 				residue -= dwc_get_sent(dwc);
@@ -985,29 +973,48 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 		residue = 0;
 	}
 
-	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 	return residue;
 }
 
+static enum dma_status
+dwc_cookie_status(struct dw_dma_chan *dwc, dma_cookie_t cookie, struct dma_tx_state *state)
+{
+	enum dma_status status = dma_cookie_status(&dwc->vc.chan, cookie, state);
+	struct rb_node *node;
+
+	if (status != DMA_COMPLETE || cookie < DMA_MIN_COOKIE)
+		return status;
+
+	node = rb_find(&cookie, &dwc->errors, dwc_error_cmp);
+	if (!node)
+		return DMA_COMPLETE;
+
+	dma_set_residue(state, rb_entry(node, struct dw_dma_error, node)->residue);
+	return DMA_ERROR;
+}
+
 static enum dma_status
 dwc_tx_status(struct dma_chan *chan,
 	      dma_cookie_t cookie,
 	      struct dma_tx_state *txstate)
 {
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
+	struct dw_dma		*dw = to_dw_dma(chan->device);
 	enum dma_status		ret;
 
-	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE)
+	guard(spinlock_irqsave)(&dwc->vc.lock);
+
+	ret = dwc_cookie_status(dwc, cookie, txstate);
+	if (ret != DMA_IN_PROGRESS)
 		return ret;
 
-	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
+	/* Poll completion even when the client has masked the controller IRQ. */
+	dwc_handle_channel(dw, dwc);
 
-	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE)
-		return ret;
+	ret = dwc_cookie_status(dwc, cookie, txstate);
+	if (ret == DMA_IN_PROGRESS)
+		dma_set_residue(txstate, dwc_get_residue_and_status(dwc, cookie, &ret));
 
-	dma_set_residue(txstate, dwc_get_residue_and_status(dwc, cookie, &ret));
 	return ret;
 }
 
@@ -1017,7 +1024,7 @@ static void dwc_issue_pending(struct dma_chan *chan)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&dwc->vc.lock, flags);
-	if (list_empty(&dwc->active_list))
+	if (vchan_issue_pending(&dwc->vc) && !dwc->desc)
 		dwc_dostart_first_queued(dwc);
 	spin_unlock_irqrestore(&dwc->vc.lock, flags);
 }
@@ -1086,14 +1093,18 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 	unsigned long		flags;
 
-	dev_dbg(dmaengine_chan_dev(chan), "%s: descs allocated=%u\n", __func__,
-			dwc->descs_allocated);
+	/* The controller tasklet also accesses channel registers. */
+	tasklet_disable(&dw->tasklet);
 
 	/* ASSERT:  channel is idle */
-	BUG_ON(!list_empty(&dwc->active_list));
-	BUG_ON(!list_empty(&dwc->queue));
+	BUG_ON(dwc->desc);
+	BUG_ON(!list_empty(&dwc->vc.desc_issued));
+	BUG_ON(!list_empty(&dwc->vc.desc_submitted));
 	BUG_ON(dma_readl(to_dw_dma(chan->device), CH_EN) & dwc->mask);
 
+	vchan_free_chan_resources(&dwc->vc);
+	dwc_free_errors(dwc);
+
 	spin_lock_irqsave(&dwc->vc.lock, flags);
 
 	/* Clear custom channel configuration */
@@ -1111,6 +1122,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
+	tasklet_enable(&dw->tasklet);
+
 	dev_vdbg(dmaengine_chan_dev(chan), "%s: done\n", __func__);
 }
 
@@ -1221,13 +1234,11 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	for (i = 0; i < pdata->nr_channels; i++) {
 		struct dw_dma_chan	*dwc = &dw->chan[i];
 
-		dwc->vc.chan.device = &dw->dma;
-		dma_cookie_init(&dwc->vc.chan);
-		if (pdata->chan_allocation_order == CHAN_ALLOCATION_ASCENDING)
-			list_add_tail(&dwc->vc.chan.device_node,
-					&dw->dma.channels);
-		else
-			list_add(&dwc->vc.chan.device_node, &dw->dma.channels);
+		dwc->vc.desc_free = dwc_desc_free;
+		dwc->errors = RB_ROOT;
+		vchan_init(&dwc->vc, &dw->dma);
+		if (pdata->chan_allocation_order != CHAN_ALLOCATION_ASCENDING)
+			list_move(&dwc->vc.chan.device_node, &dw->dma.channels);
 
 		/* 7 is highest priority & 0 is lowest. */
 		if (pdata->chan_priority == CHAN_PRIORITY_ASCENDING)
@@ -1236,12 +1247,8 @@ int do_dma_probe(struct dw_dma_chip *chip)
 			dwc->priority = i;
 
 		dwc->ch_regs = &__dw_regs(dw)->CHAN[i];
-		spin_lock_init(&dwc->vc.lock);
 		dwc->mask = 1 << i;
 
-		INIT_LIST_HEAD(&dwc->active_list);
-		INIT_LIST_HEAD(&dwc->queue);
-
 		channel_clear_bit(dw, CH_EN, dwc->mask);
 
 		dwc->direction = DMA_TRANS_NONE;
@@ -1306,6 +1313,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
 	dw->dma.device_pause = dwc_pause;
 	dw->dma.device_resume = dwc_resume;
 	dw->dma.device_terminate_all = dwc_terminate_all;
+	dw->dma.device_synchronize = dwc_synchronize;
 
 	dw->dma.device_tx_status = dwc_tx_status;
 	dw->dma.device_issue_pending = dwc_issue_pending;
@@ -1359,6 +1367,8 @@ int do_dma_remove(struct dw_dma_chip *chip)
 
 	list_for_each_entry_safe(dwc, _dwc, &dw->dma.channels,
 			vc.chan.device_node) {
+		vchan_synchronize(&dwc->vc);
+		dwc_free_errors(dwc);
 		list_del(&dwc->vc.chan.device_node);
 		channel_clear_bit(dw, CH_EN, dwc->mask);
 	}
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index f47b42d638dd..7b15276d158f 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/dmaengine.h>
+#include <linux/rbtree.h>
 
 #include <linux/io-64-nonatomic-hi-lo.h>
 
@@ -276,10 +277,8 @@ struct dw_dma_chan {
 
 	/* these other elements are all protected by vc.lock */
 	unsigned long		flags;
-	struct list_head	active_list;
-	struct list_head	queue;
-
-	unsigned int		descs_allocated;
+	struct dw_desc		*desc;
+	struct rb_root		errors;
 
 	/* hardware configuration */
 	unsigned int		block_size;
@@ -380,6 +379,12 @@ struct dw_lli {
 	__le32		dstat;
 };
 
+struct dw_dma_error {
+	struct rb_node		node;
+	dma_cookie_t		cookie;
+	u32			residue;
+};
+
 struct dw_desc {
 	/* FIRST values the hardware uses */
 	struct dw_lli			lli;
@@ -390,18 +395,19 @@ struct dw_desc {
 #define lli_write(d, reg, v)		((d)->lli.reg = cpu_to_le32(v))
 
 	/* THEN values for driver housekeeping */
-	struct list_head		desc_node;
+	/* Only the first block is submitted to virt-dma. */
 	struct list_head		tx_list;
-	struct dma_async_tx_descriptor	txd;
+	struct virt_dma_desc		vd;
+	struct dw_dma_error		*error;
 	size_t				len;
 	size_t				total_len;
-	u32				residue;
+	size_t				residue;
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

