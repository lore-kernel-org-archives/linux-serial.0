Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082549;
	b=1bn6aETLAIgUEjbVRSD3fjAK7xTzpjeNVBiru7rGBd1bOw2rcfUi5JSm2NflHpBG4n6/
	 ArSNXswJFkzACb+QjzSXdx4rlXlxNnHfe3Zu753IseP8SlYbtVuPRkr/5uQHumJPei3fQ
	 w8qML5YOjjhQ/V+RP8R9mbXjlVgPUSY/nNdhlC//sD4WftJVOSbgy3fbso19H6qbqQVe7
	 KNGg1QA28bSLIEF0DMW6EZPyzapnzFK9EzTZKUEY/00wjWgsC3ewpArAiJYG1/UizpCpT
	 oPK37f3B761aBIK81CuvVYHNHDjOEVZnXtqBIyZ+Vy3PPZaElSm4BJZzxgZZ3pT36kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=356D+3ubKAshJYqMH+02JSaRy+Edfc5ufxPInZWkICO1qJmzq0J8o3eIYi+ZkIv8vtl/
	 41fDE3t794TogiOCyfZ3LJ83XA42xAX2suS0LWzN+HUu/cHdRqRdcqGVkzqKnNisyYfna
	 yEqYg+av9KXG3/YOJ1Yx/lHpbRA/TZGUHvujU++HOiMlJW+PSwvfi9neJFJcVr9NeFRvL
	 aBosrlpk/ymhRr46e58cVYnpglxyOEW8PIolZLrJyChHHgAV/VSHHuCxqYsojsByE2O9I
	 DztdGc6ipIyenoOOSYC66qjJcBMWXHGprVGqHeBrYkEP2qxE2tYmSEbkXzaxyUndvAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VriFb/Io";
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510C606A331
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E510C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VriFb/Io
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-71ad099391dso1120307eaf.3
        for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 02:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082548; x=1795687348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=VriFb/IomSMBKuss1NsRbwU1chZvjnuX9Ca7VX/RdWqqw1ULA7Fq2reX1LFXnkmx5C
         cw1bhkGPr8zB3cGPUQGh+xktyd8LYWZ02lHLHLWpihBPZ2nkJU27xAlWAfWHFJvNJ6xP
         svV1nIO3CQxoWaA10MULknSp5aHtzyCAdFMJutinY5/QBJAndCv3OecE7sE9NLB+hPxq
         fOnVJ04Vwh1mYdia92I8LWmdpwPH1PmqYhP4iESEIlFVqgHd3pLmkyYGUsZBpadc5Hbd
         Xd5wFtEhnScMRaNr8MIShJ96owOPI6bLblQlp9RSJnqiYQtVLQXpslJgw15oRQmvM7Sq
         OkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082548; x=1795687348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=x4yaAMY1DrX7n+h+5aYAy9r+/dsddeebr5+4t0+79e8PZhEy6vQOapdtIIAKtxbDHJ
         S9KwEtyJyUyFK3CoyuCFwmaOU8Yhu7mgXvfcB0bkw83NHO+aBhVZ7duKxlwToRzJv3VX
         qY0MQC9Th0pSvfzke82q6OPHfoGCM9+IILcM7L947+frIl6dU1Dqiv4gMRfDQMxi3TMJ
         ZODXAemvInjy2nIi3AXUMIc9Ey48NL8SuCl/RpntpAOnuv3SNwKkIxKUcakdXvHsGI3L
         6n/JSiOa57Hwi8OvxsSfWp/Z0X4rgETGmrEsqLlH2H1M+sqir6qIvLOcaycn3YR7G/f7
         f5Mw==
X-Forwarded-Encrypted: i=1; AL+hErFqoxctv48uxmJmHZCTZe//vQiwNaG26ez/VBttdg3p3Nr3m6omLHZ7xDsn3HCKvBnCWrKVOsocFHeJF1I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NIbnss5pNdOlQ7lcuMAhijnPlGLv4sVyKIIcj3R2zONf1hgUG
	Y8gJL4wwWgy9uhFnDK0t5UoeJK/96ZDZKl6LFNrq8EuZSdp3/Av0d5rk
X-Gm-Gg: AYBFou1pYc3wB6aj51GyXknjk5N7pp18aFbLxrctX3AzdhxgMq0osxjD3FjRusxGLYo
	thq/En/xbovuHPJJvlWoKbeUjB33/tcZc5T/LCLHfwUG/cgBuYCk2AydnCV/Xwqzn88QQ+O9fm2
	PIH12Lygpl9ls/a9TY+NAzogeXBNa/sMBI3kyhmwqQTmj/XJ3KXWomGKiH0cABAFmjKnbFA8HhY
	lExCasMXmoTswzTGRmfB+xGZJnBGw8IsiZrgt1kKhfwRG3GkoD9Q3KJn+cukm53rVFqMzf2/4sn
	XKIzcnziDBbiTi1VzJOjgI+ZsQYHgOLgoqdCLqd9jJSRc/NIy7ZMWwXzw4PpNu7brBWJyWZEdy/
	hZSrfVMYTM8RhKwRtWee0VCyc1QKl+KHZ4jYoLApGQPGoVgJsl7LtBRNDPTpryl8pzP8+5u0oaf
	+MXXAv9tLSw3F68jNglaU1IOHfHZ7/TcJOHcMHy45gmVid5/rocYtIq1SBXyuzGvTDltQjzzfvJ
	6XhK0XFYq8I6pafvea7jjhs/D6lT0MTacVpXyw6t7jy9efc/4Zhx3V2uoHBJNt9ymB3l/wigfXo
	8ASSz0ihkQx7tYt7dTF0V+ufLznnCOxqtldNHUFpeNzjgKSgPP9i/6GBrriHaHWcvImSZMqv8u+
	dDYcBeGlDhufIzraKmSMGQnlVD9Vfv7rlnLdJs0vbiTMpjj70G8RKGGB9sm0trfVztLAYUDwUqk
	1FTQRBm6sjHEFFN3z8kZF+Z3VXQFJYDLAP2N3eDNg4nQbuXaQfwTQoWwsASg3eHBb2VRalwNmeK
	A==
X-Received: by 2002:a05:6820:1ca8:b0:716:bf0d:7010 with SMTP id 006d021491bc7-71b297992demr2068946eaf.2.1795082547849;
        Thu, 19 Nov 2026 02:02:27 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b18fbb9a8sm3906194eaf.0.2026.11.19.02.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:02:27 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 03:01:35 -0700
Subject: [PATCH v10 1/7] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261119-submit-dw-dma-synchronize-v1-v10-1-3a737597a0d1@gmail.com>
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

