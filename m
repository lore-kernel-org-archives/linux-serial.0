Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955750;
	b=hS4u5zQYKynL0952lQViuX17ao1zFArudUM6PVXARCkprWuUjj6TVBkYum0I6gf6h7j+
	 olaHLGnIPU1E4VJQub0K+uSItw5bToqDDz4AJ3ZPe7tm0YkpK8JITaSIiIhJo4EVC30Kk
	 xMF4YXIXSIiiXOmLJCcjMPE+Ag7uyfk68kclLyIf1gZUzXLm99C8PnWtExftKstAAKcYA
	 J7xj4j6LZF6BYUjS3BOIRqyku19woUSThX5ryPp35c2Y4rL8BHZFuO66x42xban4bHcm3
	 M04Al2jEq33gG+hicE96a2Dy0LZ7URLI0+igxGHEhAdZs73QA8njxqoWinHZ7dxeaPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=zxc17WVo0gYUnTOtZw1pyN8QC3Vommte57dKv0ZbhgA=;
	b=asn0lT8D2EDA1qqly5aVx9PSpqW15djn7tmp1aPBZ7Qn2ze4d32XPFg3vtfH8pKsQrSr
	 RBuB2K/uow0/WISIklAgIa7ndxe125ZU4ykuzxPpe72oa2S6QL9Zfc1vp9L+AX8v+C4E/
	 qoHcAOJelE4cfdZCw/E3VtkznG37RAc0JcL5gzucIJAbDEueUqVJLbvV6VuzJoXzabdr3
	 yxTgKFYbyGzTBTI+B6NV/s5jZ6QYs+Jm0P6ipMtQvQnQkivsRFMD109UVyAVdPwYN6a+v
	 Szy7+OMAwN5Au1/N3Hzsb4olOQq6FnXyFYN6hWWqwAhik5+EQL/GgqJ2O7z2j71vpnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tCok0Ar/";
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E1606A332
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 22:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB0E1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCok0Ar/
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-71ae5389c00so241232eaf.2
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 14:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955749; x=1795560549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zxc17WVo0gYUnTOtZw1pyN8QC3Vommte57dKv0ZbhgA=;
        b=tCok0Ar/JeKM2kOPQ/6MQ9xT0UiZ5MgjXtMfKNPMMawSO2jl/jdaEBKRcchyPk435x
         w/JMWw7I+PxT6Py8cy0uhMaBI4xe4/Bk2su3tZC0a7h3Q8foasppdZOrLkq2UsA6qgbk
         W8a62ol9q6gSVmHxcYWEA1Mvsw0HRNibTJmrGg65+4jcvImB8I13iCDmAt8atape8/LQ
         YmnQh/1JzJvL9yrGA9kPAr+Lau5zz4dsclfevCazeZCYq1yG+qSVBWgsWjqKmY3M7L99
         //P4Km2IoaF6Be37pzEfNhKG3iTm94aGpxX7ecqQFPpS+sydvmYeMkpgjCey/g+4EvnS
         0P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955749; x=1795560549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zxc17WVo0gYUnTOtZw1pyN8QC3Vommte57dKv0ZbhgA=;
        b=z0Yb2F+AZz2nGnRIYvDanUh3S8x8aiNFNGjih/ZcUX+WoFnHjC1TAQyaEUSan8ZgNv
         av2TCXKWkbVvsGq2ww28jUdWl0x5XJJ2/9u/Rkn+iPwj5SkAzd2QXfZ6HNfxpBS23e9H
         qA6yrMSpg+Ly6E7m442RAToMDpwpf75Y2u4/tg73JfgUqNVMwxpSGYd7Jj82l3snpoam
         a7l+27sDbH0x9sD+1ans5xUgaDsRvWoLO1doThB2I+fqNbQHvxeOUKVGb81TFmS9gWiu
         fY9VBuvNg54gSL7REUxyBSPAZwiYT9/u5Q4xcUYlrt6tclO1MEHCbP5oDLHQ85T32M0g
         NN6g==
X-Forwarded-Encrypted: i=1; AL+hErGMajzyAAToVxeOKEQMYZywXX0Qx+rq7z4iV3nrO/IOocefl2XHJUxAQgk4NwULxNNgHxmfSIvdr612AfI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YW0ebAni/sVcY4aZcOd9ENtVTL42xuBEFIVlL9RlntMKqbuSO
	1Tx46McM07FOtY+nXcVVCmb65fjL2yPUAOnf6DzuEqO4iaG+TluyEk9T
X-Gm-Gg: AYBFou2B8PnsEruQBxBwOHPjl7seDKzzfXJPoUj28NmO9umKcv66BmCcUMUEMtTlCTj
	MDXwgJw+Qo39hp4th9EhiPIcFuA96XmEFQ/S31zahclqYaSlyux1yrCdf9IT1PA8FYC36G0C8+t
	0sZZYeagg+c2H66jmKKhtaDLGiS0a5/Nz8TKsWsxTSu1eY0y5Q8UkhXSQB81Prs1Q7gsp9vd57F
	a3p70So96fmwpxFUCRr69JXc7BekEgHP9aKW6mCb42KZ8bHWYG1w59A4xTmad5IXqD4fD6Nw9rm
	ZFDvBxwTvqHO9BpLO95+OaWZRhWOY6RVxcwkZo9HLd/Jy8dEN/sARFGO+Ryd6VvwJiNBVuxAI8X
	2Ccppz7RU5X2D/CEK8CW78QuJExs4jKQEYdESBTewt+g5GQUr2FCMAwqVOh/p3FbNUpOlB7FuDx
	3o/0bvc/zHhMGSj28BTiTATwWzgFGtgVsYlCkCPR81q3/SBdouCF6aH5ghpmh0A7+EsVZfo6akV
	q+98fEgIu6cL5gQKH1lkRYGj/6Cn8YhxdPAIHhw4ctuHVXpxCsspPc5WPalVpetEqArbRChNCL5
	hAuD67UhRxa5iG6NNdjgtYL6vK2l0rfcXig3X8iwuGSJti01EB2IkJFYi8REp84UF6b9pOIgMMJ
	zPsRNHRCSS8dSVmeb3ukBj+Q8DBN3P3WVIEOPvxmN8phDySmLylim6D0eLLGGrAteXpYxM4TZ7k
	0On5vFt27Fd+VbsaUim5rRvp+akpLrZm5shpo4tlHFqkZAbEsng2I=
X-Received: by 2002:a05:6808:c133:b0:568:3866:d1c8 with SMTP id 5614622812f47-5774122a39emr1396230b6e.42.1794955748915;
        Tue, 17 Nov 2026 14:49:08 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74560af5fsm583066fac.16.2026.11.17.14.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:49:07 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:48:40 -0700
Subject: [PATCH v9 5/6] dmaengine: dw: calculate residue in the status
 getter
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
Message-Id: <20261117-submit-dw-dma-synchronize-v1-v9-5-7dc066ed0bcf@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

From: Serge Semin <fancer.lancer@gmail.com>

Calculate hardware-LLP residue while looking up the requested cookie under
the channel lock. The descriptor scanner updates cached residue only when
no transfer-complete event is pending. If a status query completes the
current transaction and starts the next one, that new transaction's cached
residue has not been initialized and a query for its cookie reports zero.

Have dwc_get_hard_llp_desc_residue() return a local residue value from a
fresh LLP snapshot. Keep the persistent residue field for software-LLP
block accounting, subtracting the current block's progress when reporting
status. The descriptor scanner continues to advance software-LLP blocks
and complete cookies from RAW.XFER, including for polled transfers.

Fixes: 4702d5244ca9 ("dw_dmac: return proper residue value")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: retain polled completion and software-LLP progress]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 504b6ddeccd4..c138008d7cb0 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -214,41 +214,41 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
 }
 
-static void dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
-					  struct dw_desc *desc, dma_addr_t llp)
+static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
 {
+	u32 residue = desc->total_len;
 	struct dw_desc *child;
+	dma_addr_t llp;
+
+	llp = channel_readl(dwc, LLP);
 
-	desc->residue = desc->total_len;
+	/* The first descriptor may still be waiting to be fetched. */
 	if (desc->vd.tx.phys == DWC_LLP_LOC(llp))
-		return;
+		return residue;
 
-	if (lli_read(desc, llp) == llp) {
-		desc->residue -= dwc_get_sent(dwc);
-		return;
-	}
+	if (lli_read(desc, llp) == llp)
+		return residue - dwc_get_sent(dwc);
 
-	desc->residue -= desc->len;
+	residue -= desc->len;
 	list_for_each_entry(child, &desc->tx_list, vd.node) {
-		if (lli_read(child, llp) == llp) {
-			desc->residue -= dwc_get_sent(dwc);
-			return;
-		}
-		desc->residue -= child->len;
+		if (lli_read(child, llp) == llp)
+			return residue - dwc_get_sent(dwc);
+
+		residue -= child->len;
 	}
+
+	return residue;
 }
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
 	struct dw_desc *desc;
 	struct dw_desc *child;
-	dma_addr_t llp;
 
 	lockdep_assert_held(&dwc->vc.lock);
 
-	llp = channel_readl(dwc, LLP);
 	if (!(dma_readl(dw, RAW.XFER) & dwc->mask))
-		goto residue;
+		return;
 
 	dma_writel(dw, CLEAR.XFER, dwc->mask);
 	if (!dwc->desc)
@@ -287,14 +287,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	dwc->desc = NULL;
 	vchan_cookie_complete(&desc->vd);
 	dwc_dostart_first_queued(dwc);
-	return;
-
-residue:
-	desc = dwc->desc;
-	if (!desc || test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
-		return;
-
-	dwc_get_hard_llp_desc_residue(dwc, desc, llp);
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
@@ -892,9 +884,10 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
 		if (desc == dwc->desc) {
-			residue = desc->residue;
-			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
-				residue -= dwc_get_sent(dwc);
+			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
+				residue = desc->residue - dwc_get_sent(dwc);
+			else
+				residue = dwc_get_hard_llp_desc_residue(dwc, desc);
 			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
 				*status = DMA_PAUSED;
 		} else {

-- 
2.53.0

