Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695173;
	b=CE9qtpfpJSVHi+EEpavvLK0Vu7ePQl8RUdP4IiSi8pGJbw1Lln8Cz8GbAE5PpAEpa9Xj
	 riN04JjzhB3oEZmyqgSJFLWIbcd38k16MOQlBmWCHMHgcolxSiETZvl6RTtMpdlsf/teg
	 THmF6tLmjU05c8jrV6aFn/r+pcROkuaeGVIrdCTh90Sl4mvHdyWPUeNHvl56be8MUsIBV
	 nsABWUJYagP/6RV20ixDuN7I2yuHFVGXmyotaRwwmTtTFcqgZxdRusyBIEx8wZQYL5ws3
	 +szELO8uK/wLpMWnQB6Q5CYX3J7akzlqHegC663K/xpVhm1CWhI1pvlyu8RKyWfFiZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZNy7GlryTQX1/7R0dXcIMAHqMyL4o5XmS9vSyRLbpSw=;
	b=JqpeMVE6aP3cE/9WE5eGsIlNHgMVViKtVTPbcwKBNNFq/8NmTNenfIDWZvALy3JmD1cP
	 DpAH2sJdXbL18xZ+yhmzloFjBGYwQBNJ6oNQrIpfORJ604pPE4+cRMsmWhfuc4XgdIc3Y
	 mg270d3s1IcENYy4UhezzWidxCCJNVLucqTlE3p+lUcr0jVemrzjAy2SQaJwe30CrWoxD
	 YF68UdJrvKasBTjiZkTetAvCTvMkOfE0lBVBtF9uIIg/FGpzCWXJZOfQeMc+8zOdKbyBQ
	 cQfO5TlwbJo2ZLMO93zGQc4ciJY6SzPOZzk5uDDxl6qDdLqNA2U7HYfzjSEZHBollLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YEUJjpDc;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B095606A332
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 18:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B095606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YEUJjpDc
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6de2f213b7aso70284eaf.0
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695172; x=1793299972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZNy7GlryTQX1/7R0dXcIMAHqMyL4o5XmS9vSyRLbpSw=;
        b=YEUJjpDcSywgbdSCg2CHm0rj4zicRED03tF52qYohnYatMax3GbXi6/+uiPr2HF+K6
         WzpNWntxa6F7YJwEiWCt3LtrBL7g9pkjFIb2gg61F/oFaD0XS5ZMM1Ug6SWWVaEbi44J
         xGlmdnFT7E7GcwiB/8FWCT+wEUJylOKeJNXnWcR18hXmnDunvRCPY+GQndRCOGzQJAqM
         HiAFd+mc6iDrSHlZv+hvHw92OIYbJivuUMSvK300ucHLRDc8D2Lg06CnvQUnJTPjy5/z
         bCG3QqKyxrJONZ1vOR2wz2X6rcevGzGvXX2BWWMJUT9osIfZxXQG0ruwfLjWlBwBrh6f
         6doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695172; x=1793299972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZNy7GlryTQX1/7R0dXcIMAHqMyL4o5XmS9vSyRLbpSw=;
        b=L/6XOptfcyplSBK26wwEv1IsSkUnn5N5ZaSwnJtsjVXWI7pWMdT69V74XizlKRaHPt
         CStJjtvsEU1jfHoKMMQPuQ99xpR8nbcZLt6LnjcrFTt42eb4HjJJnkvuoMnSA3T+JJCc
         qm8jcfgTeGpALR4TCNR05GKBLsbxXWu6UsACvswtpF6MlL0E89ZzJbNRmLpL7PDCdv/u
         LA52VSpfMi99FLqcQNQwn8+i3l6g0jkV1RK9iluFzSYNm5r6QGDkfo51uM60ESasex3n
         3Mhnp2Vnh5mIKjPj9pmbBC4biD9oVINGu2/rhs1m/zQcQREvpRyWKuSQQ1NAlo+0xzqy
         suwg==
X-Forwarded-Encrypted: i=1; AKwUvByZ6wu3YgXYzneYcaXfbrPADHDctAuRp/JYQmaqn4aYy2dLtvf1D9yMgnVPBhE4m1d4ncO56l/2b1d7g1U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBSmkrz08j7rHX3N6puAbKhn6ogAL4Cyv6Vk1FgSms1v4my1xG
	jAfd2614UZNtknSNS97SgJmyqH23vlAmCPey/wiEtdJRz6SywgvVbX1X
X-Gm-Gg: AYBFou3j9sAIfUPYFJcFL3eTjqo7l33uFEOz7JiqbVyEXvvxk68FQRL7Q8xAm8cUzWb
	Uz65Nbj3a8HJMT1BGR8nSdhVebSxLSZPsdOVRTKLZWqvtiqknTwdAPosTImES7Ypgydq3UYySBW
	9XDttsL0zeBx74WvzEzc9n7IiEu/j/GLQ4RIymSSNYLnSLccOwX4QWRZ2TzzlT/V0+79+ljAdLF
	NnFkXZnPUeD0jWz2vx/yxuYvL7BaL/SFUk8YYLvWzsXXqdTccPNHcAH2pBUfj0CmPs/5+hjrMo+
	Ub5IxD6p2iamBJXzkm/YOCxkcQ/thLte7rkMZw+NSy3P3/JDVS18MrTlUt+HX1a2udJfpRE2uTL
	sBvBxDflOQVWAua+v2fEEKzP5h91xLAQ0RK7+zXyqVipGaIKCp1sDscOLe2MCoBZw/VrxKkrpoq
	bUOe6yr8conz7myWyAyZ+etqoRTkvpRBTWEM+ldKztdZSqn8e11gLUHBM+SnDhetYkz06a84gr0
	zBhAGCBtyZib0GOv9KsJmeRxG4p3KQe/LW2wbJNowwC0hhtf3dW6uCq8WPBb01ssHnxjAtQPvQm
	qQjhGZBDCp+uMzRYGb80v7uFjJYJv9Tp+wL2o+SQ+2MPbuESWM3Nkr3GzuEZc5FO+b7UEs96uRS
	IZVOqy4IgWM4Qh0hMHivIklimFk25qJADnijD3lKhwLcrV4bSXV7tv2bt+SEjWY5gLrGv2jSU59
	4ow+XG
X-Received: by 2002:a05:6820:198d:b0:6f4:80f6:6ae7 with SMTP id 006d021491bc7-70b88ab7462mr231021eaf.67.1792695172346;
        Thu, 22 Oct 2026 11:52:52 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84f7703d288sm536083a34.4.2026.10.22.11.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:52:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 12:52:49 -0600
Subject: [PATCH v2 2/4] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261022-submit-dw-dma-synchronize-v1-v2-2-5244e94dca8c@gmail.com>
References: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
In-Reply-To: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
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

There are two places need to be altered in order to fix the problem.
1. Clear the IRQs in the dwc_chan_disable() method. That will prevent the
   dwc_scan_descriptors() method call in case if the DMA-transfer is
   restarted in the middle of the two-staged IRQs-handling procedure.
2. Move the dwc_complete_all() code to being executed inseparably (in the
   same atomic section) from the DMA-descriptors scanning procedure. That
   will prevent the DMA-transfer restarts after the DMA-transfer completion
   was spotted but before the actual completion is executed.

Fixes: 69cea5a00d31 ("dmaengine/dw_dmac: Replace spin_lock* with irqsave variants and enable submission from callback")
Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 54 ++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index af1871646eb9..fbc46cbfe259 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -143,6 +143,12 @@ static inline void dwc_chan_disable(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -259,34 +265,6 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
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
@@ -303,6 +281,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	struct dw_desc *child;
 	u32 status_xfer;
 	unsigned long flags;
+	LIST_HEAD(list);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	status_xfer = dma_readl(dw, RAW.XFER);
@@ -341,9 +320,26 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
 		}
 
+		/*
+		 * No more active descriptors left to handle. So submit the
+		 * queued descriptors and finish up the already handled ones.
+		 */
+		if (dma_readl(dw, CH_EN) & dwc->mask) {
+			dev_err(chan2dev(&dwc->chan),
+				"BUG: XFER bit set, but channel not idle!\n");
+
+			/* Try to continue after resetting the channel... */
+			dwc_chan_disable(dw, dwc);
+		}
+
+		list_splice_init(&dwc->active_list, &list);
+		dwc_dostart_first_queued(dwc);
+
 		spin_unlock_irqrestore(&dwc->lock, flags);
 
-		dwc_complete_all(dw, dwc);
+		list_for_each_entry_safe(desc, _desc, &list, desc_node)
+			dwc_descriptor_complete(dwc, desc, true);
+
 		return;
 	}
 

-- 
2.53.0

