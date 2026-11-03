Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744778;
	b=HhfkhaDW1rYjRQsgg1dbQrdYsGmultnCpQJvSMU/83d9nZsB4a6+z38nITowWc9+c+94
	 Gwiv3rec85SNEgABeqdqcVhqWjnUGDxY58BovgCH2PFeLtAvLQiYeY+FnbNTWBR6j14Vf
	 U0VGHGM9hqgdNMer2KGp0fgQZOJx7i3rAmMjOcNr2f+7aDrpI2Rk9AKNJb81pXccNlJPL
	 ypk1gg2tcl3hcyDIhxq9pIgorscc7aJaDz37amOVrxRp8qTWX9DF8AF7HVOg7mZubOusI
	 +E0qGMZD9PlAcH+WkV3J1uODmhZiJ8M+0Xierrnrvyw5nK8NBRmmUu4YtC4Z7CYtjLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=qFf6ZpxclvnskwvFTzMQBgHXFVZl7E9bm0G+UmZZXQ4lw/PHUisg2mrbzFsxSkbIHS5W
	 bE82DVKrOxFm2it96LvbgPUXTjkE/WGG+m2BDWwUGymAlZ849lLPnsVRhIXjUfJ9/NMKu
	 Dluxzq8FTM688Y5f01/oGmhuC33oYqEr9jvWD1RWWyOyL+/XML283bk2OprJzSCmKgu1U
	 p6w+O+bkjPn3RbwQLp2lzH4DsWP67/tsGbaeOHF7xp7jgOpOWaipWv4njno2fTeZenO+t
	 0xBmq+YTxc4LaPehYgCCBeEIHOd+6r3o0BOT3rkoXRzydBxwAVWM97ecQ9d47JF/36w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwbQUKik;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F3606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B0F3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwbQUKik
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4f699fe49b3so87630b6e.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744777; x=1794349577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=WwbQUKik78jDIWjrBN+nnQlQ8h2Fmd6FieVI4srUDjQ4kET0EcWXa2CDIiGktyoEo5
         GYb6byH1esLZt50+yeCEwRxLs9rz9vNHOfZZx83+Rfj2eEmJ8oW7GvaLyCMkXg2rAv4+
         fuNmNuILlHorwi3AXxBRufDMYflIa5Qq5ErAAYZTTBeyf95knNshSI0+DBpnTl0Iu4xk
         WpoEU6XdFrUvHEW3pySwCNeAQq/I9iAbxjV6jDrt+cSaUkB6xoDGNI4GNjn+49jrUXbY
         zM7Y3m42mJEp1M0aa7CRZ1I39WLAzRG3Ov9st09yaJoUSUaXv6o8vCCA7cWaDO8ylIlB
         jDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744777; x=1794349577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=Il/TAsx+vqTBEeBo28p6R1VfnSrB/1HwAJ+//rR0Di0eArhgH4zijIZMNttOsqfOO7
         G3seG9WrwrFV3EoE0Au63cRrVQXHsfp4RP3I0jipM+SXNKT+JPG2Y8+BaUkU3kAKfKQF
         m+EeOA3oWWefWSIAvb+PYyB0DFarrBss6zX7O0qbt2KMW+wf4tAgrY6hwhaFsnZc3RlE
         JnYcS2Wdp7ukUGtf4gOTsZ2R8WTbnspsG4Z+ijK/jmt0mtrhABO/+g/nWcvu9wXCZGt1
         RqADqcXnQ0yKkVON+H/RRwN/eIcKC19h9mVXff2A3AeDRWvTE1atnob0rC3/EplEbL7Y
         ZhqA==
X-Forwarded-Encrypted: i=1; AKwUvBwi2w/qSp+2pf8u6wbpPCiBCoSGn6KIWbsixHPzGrTHxpwgRCBPESEJC5d2yUCFga/wRFq45fpM3fWW29Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ecRRkrrmDxRV/udF6bhmc7UduiTbz19Wv2sjsFH8Gv6vgeAFn
	3e9Mhmm4nbml819rtr/TB/ZX5fNufRtWwNvN3XdnGRoI02TSkXyAQziS
X-Gm-Gg: AYBFou1nVvoAfGVq9ghD4/Z5eTgCVBfwJ8rO8PhJSWoE9TagaPaICQX/ENr+rNT1JKH
	3Uw+pyljsXUXCfTvLFfcfEP7O+hToMBGQw/A5jP/C16+TyQ+jqPHF4nMAiesZNSbOzxNnJpcVJZ
	8PEipLpYrqrVN/RBGjqeznPMNg9SIPrK2w/BimQLLPqfxAXvNqU1mHSEuQv7JvbANXDXTD/A/Bn
	9Us45EjnE7bFZ1ZKhFHAnAXq0QwMsyJAvE1B4Suk0IMoEfcuKOXLGw3IkLjdjo/EZa8baF26Qsu
	YLMfAsCm8fO/WLBPkRSTcwJ7gUjBuFYAmu4VQ6kJHHRmQE8ubhL500vozBsKvjcSFFtBCr72CqZ
	l4VgQtoPEm5IpvIbe5yOeXIpAz9sgg+2k/Av9hiYIj2cRtmL2gL1Gdr3nzmrfIn0VoYgvlNncXJ
	pfOaInYO3BWJUgFbYSvU7jdnoxZE6TkZ0CgO7uyGyKyx8dLj6+M4+15lrWMwxJzssEChz4Efn0s
	TED//2SjkhIjY54vkH+mCfaNRfSy0pCHyMmRf2uy91CX//TrTCxL2Sa043EJnPQDT8efvE9UU4Z
	iLixo0Dch6l1FcBRYA1K2vksIOemTkrOxvKRPPt+DWswq4tiwLQ/eJ3GB6wYuZ3e8YNUIZDAM+7
	EC0aCUPL6f2gE37f+WUwNg35+W7Gjcdl3ZGfycbBlFS8fmiURBNZWIzIbh6HhRRbJkC9uws8QgO
	W28CDHgusSikhulDtJQO4zuww+Cfuh4apOgtd8UGlmVFlNsBxR7H3VUZ7IKsUdhSXPRzjTu9Jy
X-Received: by 2002:a05:6808:6408:b0:4d6:9283:1df2 with SMTP id 5614622812f47-5640de79c53mr9577178b6e.61.1793744777140;
        Tue, 03 Nov 2026 14:26:17 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:16 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:03 -0700
Subject: [PATCH v6 01/10] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-1-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
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

