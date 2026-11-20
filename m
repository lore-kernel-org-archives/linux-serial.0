Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202966;
	b=gnGbpRFaOVuuxWjBQQes7zZQ2C9lTH03UmvMND7s0c1iCRpfsl3kNpTna2S/Q44y3VzO
	 yHhp1aELxW53x9mxPx2Vj+f4bKv6oaoeKckzFZ9HdMy1uEJT+KxxeobZr/59EYU4gDxlU
	 KscNGSRQz3lVVxkCCbALueOCOjxf3B+JAHNC+udwkFP4yZbanpJw4/ECQIGXU5+Bvnw4f
	 kWrubYwwogCn5u6CNXemR3VX0mhRJqSI1gYkI3BnlrvF8CVXyerfL+vYuSxmOlMr1vLnF
	 QXUwLxCsoehQJaPCPKday9M+H9SUlHduMUrJ0i8fdEiH43rIC+GimukKPyoSyeqh9mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=P+uR6LSFUuS82mC117S1N7GIewTkAQxRxMN6R5yzzdI=;
	b=c5X02jzhSeDGp3eOZyeFiBl1XbAtZbTdDRv06rocSh92wXTkd6G5h6VmOe4JvR3oGOcB
	 5tCQ/baDZEg4udFU2Yi0GdYxeftMH9LWPcIdwJhmAE7GHAJrDLxkXYQBFC8PYh063Ct0r
	 6077dGYPvk6AlstBvS2NVhWh7kUZWgE6LQoHUTI6GuEzBTFCq4Hl6N66BSswrpmPdCYkm
	 2kx/4xfOWbPhiIuMwDe1spgj9HXBcN6/3Q745KUqUhlLuOCvqiMfGaC6CrG6alJRvyMxY
	 +1yelRH9bff1s3Cz5zLbfqsbpM7a4OZA+WGTm9FinNo7bq/dkMBmAKXa9KLqnb1j9tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IiWIgmAC;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2356960A260B
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2356960A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IiWIgmAC
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4b5138f0991so1324309fac.1
        for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 11:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202963; x=1795807763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P+uR6LSFUuS82mC117S1N7GIewTkAQxRxMN6R5yzzdI=;
        b=IiWIgmACyebbT9WvoWjjV4QCmCn8NN58c1DAhYi/wI/dT+vfl+dYfVUv4YyzduE/Oe
         n4ovgbxRJYWG7zMomXcHMRVjGF2Q3VXgRBnzmxoyRmLrAvnMyqk229YauYXT6CbrHK7F
         99yBShRRMpV93TKuEZXfYfsEkQwAiRXN2f2u4XyHU3H/sZRFbwOZ1MDDMZz0DjMJmKd2
         b0GdLn2oA+z84Gr7Fu7vaVk6Rb6UFFTZTwM4+/Hbb7eOqStIaxZ77YOQajEzzbX/fZ8z
         yLAZ/JOvokZBbQ13uBpo+WVvvyWbklQnvLOnJ9SoQJErJe4iUUND/QHohUyqzpa6Oyum
         9MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202963; x=1795807763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+uR6LSFUuS82mC117S1N7GIewTkAQxRxMN6R5yzzdI=;
        b=dGC2PbfHdt0+33B9LrIzWv3srKVcgJOiIP64Eo3LrAqR+/Pufo2N2h/mVzVDdNTUIv
         u6B1Yr+pnFE25wnhBmEZNTbSF3bDtL2ygMP7kTgLBs2jLhyAxFUb4kn35upATdmSPo/a
         Vn6X6/+cKreYiPlXCskIPGn2K9eFb2eGuWjtOXG3wu/8FIM6dDMpC2N2usyUZ20X7gkF
         Hu4SRVLqVYIC7nVaWveCQWJT1XjOMmRhUkr8f5ISVBNh2mxLstIcGXgnpk7yglHPaWxN
         dWHtGL9FppVM+sLBkaFYQCqaPqvMrPYJscW1yVi29BSURu4wPxDqV1+qwedpiaPoSidX
         7IIQ==
X-Forwarded-Encrypted: i=1; AL+hErGsuJwtPiQlMbgh4CiHBybPgbf8pqAflWikX9F4rv0jOD4qRkv7QaEOTOPmxnV1DB/voEyoiXc64pLTDM4=@vger.kernel.org
X-Gm-Message-State: APuU4Z83PIilUaun2r5eudk54BkD4GM6ObE0KWf7KDhQ1IeXSGZS4dCx
	cIQ1FV5C8gRNTLBEAVZz7yBp5HBb9P8r6Ho6jjGYNSSJsI6LgwH4uAzo
X-Gm-Gg: AYBFou0VkO4Sn3vlNHDPuuNbby9mBv3i84qdY4j5XWlZ7ukhU1LaS6IbLz5Wechaw9A
	Srn4BioqSbBgUxiq726f5dYL/1cgleFLGZLv7wxQdp268dTUzkndQ311zI/vRYctQ8BLOPwN3aD
	UQ5td9oZ7YQlnPMu7XfNrYJpupUPAHHvFwIhPeBrtBjtcr2Cpt+yoR2adloNMU0x/LXpxzbwuV1
	/RSOv+Ra02LMv7+gFvsbQumfqMiDj9fDc645AY5OYEKOo89VnkhyRyNmVYzDDvbhizHDT7NOcwE
	SR/XqdfROt5Ut/BhObBm8T4oHrcTj/ck/zRKl5fOEyefyX5n0vW2wCN8WOkHcI+b3NeKQS2xkRU
	/lP89Ue2S/S4IOKC8zLrO0AXsONwG/0CsjgH5PiPfWbkH7YnbuvP/+f3R9PcTuBl7pQuiLOfIVR
	cM0TuxtbZkzkqlmq58nsPrK1+lHEHS/xPoj3pK5AI6pNslh5iZ1IXi0KWXPNO7132Qn2yKde3HB
	IKpIqqQa1jIzDEzgDaIr/Y65FxGeZUewW2MGvq75/kPxy723D2BKGPcYwLr8ew5UZqS/JE/JIcE
	fhJABiCJFufI1TKeulsUb8SFaPGn3Kl7JdqbEBJK/q/bS0K2w8qeNU4GDBC9aCcjplDnwbS4EaV
	JuKpMt3M65p25WmwfHxgtIFtAfileuRqjg4TQwcm+ER4+7ofbprOv+z8PyCpFqL7TI9ycYEA+sY
	9rUMCjT27nlV1qFGy/ARIOugrYfCsQ44FnveNNXXrYZg+zb//BmZ5q
X-Received: by 2002:a05:6808:2229:b0:564:3e9e:b4b1 with SMTP id 5614622812f47-5797c0b7852mr4356033b6e.18.1795202963128;
        Fri, 20 Nov 2026 11:29:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm3434498fac.8.2026.11.20.11.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:29:22 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:29:11 -0700
Subject: [PATCH v11 5/7] dmaengine: dw: extract hardware-LLP residue
 calculation
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
Message-Id: <20261120-submit-dw-dma-synchronize-v1-v11-5-9b9166bc2cc7@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

From: Serge Semin <fancer.lancer@gmail.com>

Move the hardware-LLP residue calculation into
dwc_get_hard_llp_desc_residue() so it can be reused independently of
completion handling.

Keep the scanner's LLP snapshot, descriptor updates and early returns
unchanged. Only one transaction is active, so the helper updates its
cached residue directly without reporting a completion indication.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: extract the calculation for the single active virt-dma transaction]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 0d2407c6472b..b556a39a24a9 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -281,6 +281,30 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
 }
 
+static void dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
+					  struct dw_desc *desc, dma_addr_t llp)
+{
+	struct dw_desc *child;
+
+	desc->residue = desc->total_len;
+	if (desc->vd.tx.phys == DWC_LLP_LOC(llp))
+		return;
+
+	if (lli_read(desc, llp) == llp) {
+		desc->residue -= dwc_get_sent(dwc);
+		return;
+	}
+
+	desc->residue -= desc->len;
+	list_for_each_entry(child, &desc->tx_list, vd.node) {
+		if (lli_read(child, llp) == llp) {
+			desc->residue -= dwc_get_sent(dwc);
+			return;
+		}
+		desc->residue -= child->len;
+	}
+}
+
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
 	struct dw_desc *desc;
@@ -338,23 +362,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	if (!desc || test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
 		return;
 
-	desc->residue = desc->total_len;
-	if (desc->vd.tx.phys == DWC_LLP_LOC(llp))
-		return;
-
-	if (lli_read(desc, llp) == llp) {
-		desc->residue -= dwc_get_sent(dwc);
-		return;
-	}
-
-	desc->residue -= desc->len;
-	list_for_each_entry(child, &desc->tx_list, vd.node) {
-		if (lli_read(child, llp) == llp) {
-			desc->residue -= dwc_get_sent(dwc);
-			return;
-		}
-		desc->residue -= child->len;
-	}
+	dwc_get_hard_llp_desc_residue(dwc, desc, llp);
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)

-- 
2.53.0

