Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202963;
	b=ze3IFvf9131fOdpov0J896dUCmpE6ndlIVj4wUuIpsMdkypzG9d6IlWjAXXIpg/2h9Z+
	 AHCWqjnqUivClaTDRc97vqqIiCdlXbGLELdyzckQQX7w625vBpgZGKexlXfpb+ZKn3Kjc
	 PuL9HxGsSXMDAx55Vw1hwqZ7DmFZgaxutho+04RmaIzRy1bJ/HAJRUeHNXd4qsVwLzGrQ
	 gzT9DVvPJvHXHBTcrp+lu1r+uNxAR1nRdn91pRO6DgX1BpMexseQaa0WY06VoTqzZ67UH
	 lARpl9oJ/iuEPDCUNy3okcDztwXdFYV+u9lhQ6YdWv5Z4+RTMCyKoYu0TB8Lf7+FKew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
	b=MH8C21zwPn8Uo2jkYY2t/tC6wnp6dTqec9eIwm51o36GVe1I8fvp0TE9C9OqQcrjQo5L
	 /fuPlYeTbK+CjoewEgb2RAOKB6pHPhmUlhE0kVD6oLBbqDhTZytC392Ai8CrRYkcdJrgv
	 OmBLx3zeTIyK+6e2IN0bAHdoJeW0ffu2a6nxp/iKZ3ZEKW+YQ2GkU+i5EDWqC76rtLiFP
	 4kTQFioDT1TbJYQrbbKgKuXT9wzIT3YNvzKrSzvOih7GwiOnC3UjS3sM9uVONU+Mcdl78
	 n0+NRk3xhcthcDPZ+HyJrWmhAkwBVInfoBWojIvhNYvrBsmOCWaJJrcdU/R+Qxw3IWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxBc0xzO;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE0606A6EE
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAEE0606A6EE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yxBc0xzO
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4ada9579947so862566fac.1
        for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202959; x=1795807759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=yxBc0xzOKmBIWEOBHLRK1tFyhtnnv5644LBOx9SMQWs6sgRS1N+vCo/XDahyFK9BXU
         /bLmFKQqTod+l4OjVGI88MQdPn68K4IbGyMTNytT1zDjjy5HYrGwQjjrgJUu2b6c/jfF
         t1gDrHd2obm8vQdl5RwncEKNQsw/uivdqhVT+cja1L3C9SaNfTTphJFclG4eFWNLpuYF
         CiG88XvqHTRFJVYbrgJacV0VPkE6ObpZnXngLafy6HWUmFVB/mCq/L4V5BBcGN0YROyy
         gApPGjVuhYhnv6QkYNbduMyAhO1E8KwunQxlKT1zjwdK/uSkoJXPkIMK9YruN/RZldiB
         KsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202959; x=1795807759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oL/d63e2xaO/P/OLh85rsbWKHpvbqFNY1ZyDh443Xs=;
        b=rLfm3fZhRH7zYzJM/JtUc4fAyX5jopq497XPHeNiJqG/CNCOgQMzoaVTDoF+Engx75
         js6iyLpCQ5JFJBvbGR2Pt+qZhbLf5WIhNSWKpl/33w3pa3kyo4kJrXdAM471KCaUA82p
         IgMf8Dsi0nfoCMaLANonsqWS0lsQ7SEv4+RuDBRc3DTkjkvkXJXh0CWkg5FIj9ZoVfRh
         F8b8FqorsQT3GhG1ehP/QySGtq3Gw0i2GPa5Xxip72L8ktGNSJBVmEfM0hT4Uq+frgg6
         a9961Q97kzJlAPRUhSbP07fCLakbwN5CWVJH1iUEWuybf9QeHcc0mDw2JRPmwLJjm+Ei
         pBqw==
X-Forwarded-Encrypted: i=1; AL+hErHYyRWPvrlV+9ed7MZQpq/ux1/UZCkecLGRlLxMpW1okmkEWay9kuXS+6IRTJYrCQt5JgQiArdzCQV3f6o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+U8UJ9645BzhOXyp5w5JGqF9tF77NlqDztmYXNHqEszavSysVW
	tCFE6RVBOgTmgtgECQ956P7aMQ3qpFTG8R+pZQSDkxZiICr/rGeCdWIZ
X-Gm-Gg: AYBFou10qFUr9Yd+CjHpBWY+OUM70R7nztKns2sqdzBHnlvD0TgjVcqdwQtSZA6E7Fj
	1AW1MTsXoOy+tH1E1yCQru8PyxzoUQAUdMSbapDPrSLntxTfvgPC+3/MiqEuBPVcQLtTG9dbNcc
	h1dx9vREr+Q1sjr2TaJTRUlEYQF1Sk+rIfdfc+W81WguQmjMdfLA31yvot8dDdvVV61JefhUGUC
	7xDpJMHhbFZOispbrJX1ImzKSUEv4BjKdF8JuNgsdzfEkBOvGsAQjiJcpLmWFRuBsqR0jhFwmfh
	/YjvB4RtmHB2+Y/cSTrUp/sl9NMuRkY0AWHJ1hn4/nGQ6vb9SXOs3TF8IrLoz68/O3yErp2QtZP
	5k0euOllMWkHIkL4VRe39BPsifneKzsWbRQsaCqtla5uHoGxph4bfkgbF381Zv+BDaelrUYiSfC
	uGivEZef5vTzFGleVn6nJC/hkzCSr7jum998y1OIZmQGfsZpJuHNaAObBF9Gkfp7FF4H5vC5uKQ
	MPnh69b3UR2gXSDddVgZJYE964hiaougpF+iJTK2sQqEzi/JGQ8tCiLylrBq2T+6s9Uf6ISJAv2
	H6LTzr1b1x0+Oah0fBUeO/5No8kQ5elUaUU6n/0xnh+5bSSZUCfcGGUaZ8un6kCMklwI81cOJFa
	GjOICxb3YSQyGsr4Avg1XXWQu0VOcfpMXAZsnIEejvwTwCOGUaWGWnu/SSkurHFKmhOqz3NGzL4
	/VwbFdq/r3kUokFFhD8jshxRVgEmcrBNRiKcGrhKeea5PtUOQqXd87
X-Received: by 2002:a05:6870:e0c9:b0:4bb:3128:ada6 with SMTP id 586e51a60fabf-4bc803ddd0emr3956657fac.9.1795202958656;
        Fri, 20 Nov 2026 11:29:18 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm3434498fac.8.2026.11.20.11.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:29:18 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:29:07 -0700
Subject: [PATCH v11 1/7] dmaengine: dw: Fix XFER bit set, but channel not
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
Message-Id: <20261120-submit-dw-dma-synchronize-v1-v11-1-9b9166bc2cc7@gmail.com>
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

