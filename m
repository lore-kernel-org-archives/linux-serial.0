Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648067;
	b=WNRyYZRZnD8H2yhiX8ztdB2+UYribp8lbmhandS3ueyEXMIyW1tZQjAN2lHaa6e8Fs8i
	 Q2E0cN7+lRcRdt9bTt8LXoVWgW9mkV1ePPKjx/RHlAV8lChFIKly0to/Q9NsaXzimuH/Z
	 wOCbYSWNy1+y6I2Y8uRMHEw0dMhAMcF0lfYB3kFTrcGWF62C9xNb8swylK5ZKMUdNoKFy
	 pcx43zGvmjU5NzNqnTfYNeFmdyt2OIErG/qqeXm86imZzvMQVY63GD7TkmSrqGPPv/iFS
	 Lw4Bm8k53J0BqBcev5C5TEFNqMu7+UTc/VYXkZfCc9i6dZPSFVt8Zf6wtSZO4k9/ruA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=we0IY7azuqrxgazeOlN6J6HzN84gYfiRNJJDQ0SPzXc=;
	b=yoNmP8EdDxK3o1IesGmVWeHONqskm4hCaxithsS7DufJMcmRsghAJEx+1LCxl+EQRS/N
	 waea98io7kj1z1MfcbFRc/IVyMZTRHLG8zjGCkukYvr9MPVmnUflwCThZVDVLxV4EZ38S
	 k/JiwTUZKAz7zQibceZBMVVxd1Wvnamgkdrc1ym7Df7PEBCmz+uX68QHZkadZNNyYUVxC
	 Wpoueyy675haTs7MsA7VlzNdRcLIjfE125KL2+afc+H9ciat2NLil01MSXz3a/5zCZfKU
	 whT9HsZldRGn8kowsxfB3ebRUayGh8RSn+MJTrL6R2pwexkZxJY7sddKf0vQNrKdXXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhbnuhEY;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD3606EE8E
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23AD3606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhbnuhEY
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-843ea301d60so2433694a34.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648065; x=1794252865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=we0IY7azuqrxgazeOlN6J6HzN84gYfiRNJJDQ0SPzXc=;
        b=OhbnuhEY5hQumMRRHARHrab+5rBbDHoVSPboSFMXgqrUiLEDA3eUOUhUk7f3wSjZDf
         o3ZjR7qxhdyOowh14jY/EVOjlgvT+MJ1WOAHUeuNIwW2y0GDz6hpkWc7g63h9vxHmfj/
         9b+TImu/vOmqEvg46VftQACpb7dqnua8Mni11fiYhoc3Ao2oKOwyBQqlyNOZaHHl781F
         OPGRYvzsvDaD00FztxS4zx54t2mbqU2a9US4lPttUd51xPBKIBF9mMZuvJM4Iz6GjygL
         KCuxnlSoBu8GJNHH7iP5r4gYcAEQ9Xx29FOVkRd/SwXuE2mD4JwTIga2nSR/UlzE/tJF
         9DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648065; x=1794252865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=we0IY7azuqrxgazeOlN6J6HzN84gYfiRNJJDQ0SPzXc=;
        b=TwDdVimtJ1BAJXx2stmVYI97ZKjV13sQO3TXW7LuUsGOVYQPakyJf4FpwphftyD0zy
         XSwmkwv22Lcmt8EjfdRPmAJC/jPdkrgc5o4OnERhfeAMTv0FtCgbQQl3ZUErEyx8UVpt
         Vk6WL0u91Pf+vjdFnu97TYSdYnybj1PR88E1xQzWXk/t7x4rEM5DKsULeKRotGWHSZ0k
         FyfKI4X0+4YjcJATApakq8Gjdjop6wTX3LIRv8AIz7k/A8XrWYkTnZev+uXKBKEhnPGI
         wncMuw2wWaBiIadbPNXmcV9ZLFmdXzM/Kk/id03LQLSiJvurAtm8CUsW6+Vw94pPDD8r
         /UKg==
X-Forwarded-Encrypted: i=1; AKwUvByOqCyJhk4kf1rAQQyWTXbODW932OUlsUx+KbudwUP85z/Zs9T1z26OLMcED/lHQLFaPd084e4xnSVy5RQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBUxjafjPOhk5CJGheDFTV51beQLfrRj1iZ6haJsRglyNEd89r
	OJDKjgMDenKPxBCJPhlxaPCPQSHm5jrtV/mowedz2eCr9j7JnignGtMi
X-Gm-Gg: AYBFou2u4Hz738bQ5+BFR+x3pcfTYHattZ6XV1XEVbll6KUF9u+r09iPhB86cq6Bpy4
	ZA4JADyndYsZ7f4TaNbW6QnUqCTmwNETZHW4rM95sluRo57UeMV2AOJ0AVt9NVYK0RJU6nsNELX
	qVGjX9pUzXFNFfZujWfeRo0Ow5KugA70wBAKcF/5qMP4YEecuBiqEUyTVhd9PJ8+Ctq5Bwzta8c
	kzYiFUUg0pui0PnlwXLnxYBixv6orDzXtq14wOZuP6OxJMa5yhGuvA5tR5RCsvDJZNXeUP9/2/Y
	XTeVXCJy8AE3lXTZlErKfxPq+oGpYoinE2ENqIRFUp128vKTyQbk52v0gOUU2Mlo+IGPJtNrPPT
	WI83HJ5Nm55q4L5NqzPNaOUIF3ao6ojINEkNYdWbfRq0lItuLjnV07iE4UGs+28RxcQCGPO7JZ8
	SNy/vYPGaAyS5iNyuvAyAKNqVl1RAsVefwGWLmIEO7bWuAj7O/wiWuTSTmLBc2RW7uVwjovWOrL
	j2aWu+WOVTbRHgg9JT+pprimOVlbdIt7oijBEUUAC+FnKhbk2uww3ej72qj1D0miOFI4OQAbjBC
	M40ysiYDwIyCn4lV2R/IvjVgP7bRcaGVZPEitPva/0s3cIkJEZqZPV24Cec1NFsR5fmyMk/SI46
	l1LKVF8mNsTYqhVGBuMj1PfSOwzXjfl5sSkJQYVdnW1yBSXJkAnUBlFzPblEhrdp+pJpRcFFoYR
	bVx0xekXG4D/Ivu7F6tjBEOEH8lqRxFtygXSkJ9WoAPfbmX8E3ofnO
X-Received: by 2002:a05:6808:178b:b0:4e9:cbdd:457d with SMTP id 5614622812f47-5640dcb7433mr7328390b6e.11.1793648065100;
        Mon, 02 Nov 2026 11:34:25 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:24 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:18 -0700
Subject: [PATCH v5 06/10] dmaengine: dw: simplify transfer-complete
 handling
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-6-d3207758fbf9@gmail.com>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
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
X-Mailer: b4 0.15.2

With hardware-LLP residue handled by the status getter, the descriptor
scanner only needs to process transfer-complete events. Return through a
common unlock path when no event or active descriptor remains, and flatten
the completion handling.

Only one transaction is active on a channel. Detach that descriptor before
starting the next queued transfer, keeping cookie completion under the
channel lock and client notification outside it. Preserve software-LLP
block advancement before completing the transaction.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---

Changelog RFC:
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.
---
 drivers/dma/dw/core.c | 92 +++++++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 54 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 0d6b5bd8ea6b..e198c9f45f0b 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -271,74 +271,58 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
 	struct dw_desc *desc, *_desc;
 	struct dw_desc *child;
-	u32 status_xfer;
 	unsigned long flags;
 	LIST_HEAD(list);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	status_xfer = dma_readl(dw, RAW.XFER);
-
-	if (status_xfer & dwc->mask) {
-		/* Everything we've submitted is done */
-		dma_writel(dw, CLEAR.XFER, dwc->mask);
-		if (list_empty(&dwc->active_list)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return;
-		}
-
-		if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
-			struct list_head *head, *active = dwc->tx_node_active;
-
-			/*
-			 * We are inside first active descriptor.
-			 * Otherwise something is really wrong.
-			 */
-			desc = dwc_first_active(dwc);
-
-			head = &desc->tx_list;
-			if (active != head) {
-				/* Update residue to reflect last sent descriptor */
-				if (active == head->next)
-					desc->residue -= desc->len;
-				else
-					desc->residue -= to_dw_desc(active->prev)->len;
 
-				child = to_dw_desc(active);
-
-				/* Submit next block */
-				dwc_do_single_block(dwc, child);
+	if (!(dma_readl(dw, RAW.XFER) & dwc->mask))
+		goto unlock;
 
-				spin_unlock_irqrestore(&dwc->lock, flags);
-				return;
-			}
+	dma_writel(dw, CLEAR.XFER, dwc->mask);
+	if (list_empty(&dwc->active_list))
+		goto unlock;
 
-			/* We are done here */
-			clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
+	desc = dwc_first_active(dwc);
+	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
+		struct list_head *head = &desc->tx_list;
+		struct list_head *active = dwc->tx_node_active;
+
+		if (active != head) {
+			/* Update residue to reflect last sent descriptor. */
+			if (active == head->next)
+				desc->residue -= desc->len;
+			else
+				desc->residue -= to_dw_desc(active->prev)->len;
+
+			child = to_dw_desc(active);
+
+			/* Submit next block, including for polled transfers. */
+			dwc_do_single_block(dwc, child);
+			goto unlock;
 		}
 
-		if (dma_readl(dw, CH_EN) & dwc->mask) {
-			dev_err(dmaengine_chan_dev(&dwc->chan),
-				"BUG: XFER bit set, but channel not idle!\n");
-
-			/* Try to continue after resetting the channel... */
-			dwc_chan_disable(dw, dwc);
-		}
+		clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
+	}
 
-		/* Detach the completed transfer before starting queued work. */
-		list_splice_init(&dwc->active_list, &list);
-		list_for_each_entry(desc, &list, desc_node)
-			dma_cookie_complete(&desc->txd);
-		dwc_dostart_first_queued(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
+	if (dma_readl(dw, CH_EN) & dwc->mask) {
+		dev_err(dmaengine_chan_dev(&dwc->chan),
+			"BUG: XFER bit set, but channel not idle!\n");
 
-		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
-			list_del_init(&desc->desc_node);
-			dwc_descriptor_free(dwc, desc, true);
-		}
-		return;
+		/* Try to continue after resetting the channel... */
+		dwc_chan_disable(dw, dwc);
 	}
 
+	dma_cookie_complete(&desc->txd);
+	list_move_tail(&desc->desc_node, &list);
+	dwc_dostart_first_queued(dwc);
+unlock:
 	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
+		list_del_init(&desc->desc_node);
+		dwc_descriptor_free(dwc, desc, true);
+	}
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)

-- 
2.53.0

