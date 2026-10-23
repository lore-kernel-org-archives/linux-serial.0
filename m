Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772854;
	b=1T3Jp2vOLd55XyyrHjX3qxXiAAGWbAmUyO/v07X16ss+7DNJ5l/8NtsJHEZVvVcPYkFu
	 +3DsAU4Qp22M7G6Z3MQhayAO1JRhmU6JBGd6VNrV5Fy7tVYdgcS/FEsj+vlvoabKVJeNp
	 S/8ZNR8DOcEX+ChCPUPMWAIThq9CfPCiR/eUO00bI0Qvj4Hgte0Mfqxdxxiv1yN7rKokg
	 6YpnzBtardjk13O+6oOGzeW2IOZmucQLIp3U4WdWg4RcIjblINwY5FNPevBljQP+wzuqA
	 d81GkRUM7VEcPyW1KEWLs29oAZ3lM8bzQYtA0gAid8XR+IZnOnSwL37IDNvLYhFc28A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=WWUMgnlvvc4Rsjza9ahfhnVgrFXzVeqndskQZgUZGQ0=;
	b=19X+wHJnBgbxkBabkAPycUf3McZiv/7q2BIVj0X3kSP0LkJPdSNHZNVij/xu01lvia+6
	 dMYo6kXPw5dhk0bDc22Ox3yw1YmPB1B2bsn9cGewU6dhMJt8U5zK0NQjij3TXEJnigxCD
	 FlJlXPpry7ErnQOH4keqpdrOEMk67PouGWDCcWjNmat9MPX8RVTmW/zDk5uT09RssQbDa
	 B9aKTpMUkNQXvxwdht3Fr+VCmbxbLJLRI6s+7ud30RZBj9ynLsoXVlEbCukv7wJd2Ol1n
	 a/ArI1Gozk1Cay+qm9GLZmlUSTU3o7cobBTIOie1zXH3sTPPM4YCEPtE29Lnk6zwZ2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZxHvOx9U;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF761606A32C
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 16:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF761606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZxHvOx9U
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6df5e315bd1so698219eaf.2
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772852; x=1793377652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WWUMgnlvvc4Rsjza9ahfhnVgrFXzVeqndskQZgUZGQ0=;
        b=ZxHvOx9UjjF0L60vXq2cgl0ZLlLnNEeM9HAj1UL8czJRhlGqbsZYgrdY38z6qTjteB
         6sptCw7UcIWiaZ/60EwOWCU6/UbLJHDBkKmU6g6QJTTI3+PDmwS6SXU6tp0l6uchOiQH
         GzIKTJsjd0QsJlFDuSyDGb5/h7FnHCSlAxcFJmfF7qz6sMQndCUjmjWNErx1tVZnD7xk
         wcNQGEAfj6d8S3T0ExNIRhEmgJCFAkJ94caS30rEzApxMIGIjBF6Nk+z3WRjhHaycCfl
         GEffbFpEw4H5fGNiF2Ks6bJmtmSOocmPP5lAv6NElASkIi6T4M4pVz7L2orkfDfBZxEY
         cKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772852; x=1793377652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWUMgnlvvc4Rsjza9ahfhnVgrFXzVeqndskQZgUZGQ0=;
        b=djk0QFklDIHmd1nT85fx5USqbNyoHS6eY/Vu69VA4VT3vzGa6/OrrUpUKwOVt1Utw+
         /+TxUJeCG1FSkuMF1QHLKw2QhUoDeXhY3SfUOYDZeEBPh/mXx0BWI6oFME4ewPwfqhZI
         UzLKAw/iBoOkWbyf5dy05YwqFSxIY3JHM1d1H1lmevMJ8rn6fGitr0J6gHmiRvrKcQBA
         zCHFVu1uFfUy3qQWdg+v0PiQmbiiMjMZvScNMb7XdOYBFsr1CsHf6Q1nAcaIj+fsaTly
         YtUOPOwK7dSJraAYMoVDvVSLjH13NawK3RMMlJXJfumscPD6urbeHjaf4oz6G/w5gosR
         2SJw==
X-Forwarded-Encrypted: i=1; AKwUvBw3xITdgTfha1mLczpCVbgVa2BeWNvERnGFUDR1WGWnStcSeW77aWv0djrUnvWhgBcjcTOQqzIkxWXt1iY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiHCVJul9kUU52KCPK5MFNIJcTNXU6TH4U+nGSdw16xPE6Qfv6
	M/lgQmZi+FGIFzMNaGEYz3e2u1Chi524gn5t908roQ3meLqlVzD+QNXN
X-Gm-Gg: AYBFou3/KI6tKQTKzakEpbbbve/1tVqUviIB70DJeAOPWdcEYxQWIS1qBkbx48TRdGF
	mSyYFUlOCb59TFvEgpL3y++OsUDVXZyllznkkXswFvcM5zyWL3nXcODWt8mKoGyQKmVBOFb3LaY
	ybJplP+zzYTaEihfOyKr1Z61bM3VwBe0sVZnPXbrsPed7j+NWK9/1GVRstA81MFnzYatstlgV8r
	NN487oAbP90KN6ZiMQdV7cziQcx6kvek0A3JmF+cNkWKtxhxpgAbAfcn2HCMsbVfJM5qEZH6G43
	1qL5jAsTldvDduEAEfNOhzw9KO7r8CKLEP8HOApplijowigocFVFHPZLh76lTbugmYPk84ukfUz
	8V3EJAlecIcyk0I5ly9YYaUTpomedhvFDtptq8nsP2/ozhP/x5CZFUjyBh8gI6zHDGFCryHzIcp
	yHInAGzGpX7ZVszyl8Lo6GIJr5TVevo+/QOPTEqRyZG3qhYM8d1csJRS/Lxl5GzsZ8P63rdX/Ur
	gUdFbvGiY76XPpspd+QOHMtx4QYXyETHvXQPYn4kOcGaW3s7MsjhYxZHomo/3gyD4S6b18JFRn5
	LWhfBtgr75T9CQtTMFmSy4L+se/GaToTGbRgDlegjf922eS35IiMymd6g19AKCGviGHjQ990ONh
	igJusyJMNYXGka8npdrh1DvnYQ7RS0WINDGuoYIgMzkdev9Gp5890dTHOJ/aB3+QNpxfyIJqUBL
	H0XGM=
X-Received: by 2002:a05:6820:612:b0:70b:960c:53d2 with SMTP id 006d021491bc7-70b960c6672mr938760eaf.1.1792772852613;
        Fri, 23 Oct 2026 09:27:32 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9aed3144sm372801eaf.12.2026.10.23.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:27:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 10:27:22 -0600
Subject: [PATCH v3 1/4] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261023-submit-dw-dma-synchronize-v1-v3-1-c62bf048f5ce@gmail.com>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Maciej Sosnowski <maciej.sosnowski@intel.com>, 
 Dan Williams <djbw@kernel.org>, 
 Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
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

