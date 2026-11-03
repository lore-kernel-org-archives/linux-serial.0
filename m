Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744782;
	b=u1ZMPtrj6zO//mBLkNNCaSLIstmVYBY2tznmKhaFfm/PJHNSLxpXFU0Yt8IJe4hW4Yvl
	 ZhQ0pcqYUMOVzLmm/tZ5PgAzGBlBZ18TzD7KtJtSajtjWfYGYAQYl223K65vE+fr+eKQj
	 I9+6TILVfsWQ+lG/CD1Yo6bhIQAHbv6V1717RfxDLRsPtHYM2FdDWKvbFmSp6kUoZEpjw
	 b5tGr9wqhDURa81Jortfe8NDC5kuQpXNf6thOe127suhNryS5RhApomJoZ9X1Q9N8TZBE
	 4SPkuHv1Hcc7QtfGWwL4F5dNMWtSK4zMp8yRxDSxtSum8/Jxgj2BiZw9/GeqVgP4s4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=53Mxv6Sk+QV15vE2tUEyM3M6ZRlSEp1NTwwg3jt+yx4=;
	b=VWQEX3hs0DcshFSobKDkKLZj7MFhRaQigfMeu450EDFaQDWAz6yHzfTI+Em/uzDeuCuq
	 D0YQXQXaZHDFW/XkR6vETSTl7s3eM0G4i/Z6Ck52Yna7nm0vFKowMrBJfR+rLT6+L/Yt4
	 aJj4KjQ/V7BtCeJ1JPX24qq6c37m/XuwJ0kBrI2sl78JCnGK95hcETV6Qs1y5p6tnhI54
	 iIpFNFD8ojM3657ddp4sAYmf1E7iW6hDvA1RVQSJ2t56kGhh8KvbeTwj3uA65lgBs955S
	 bhYoSeWti1JXyDY1r5X+fjv+Fa47VLufYgjVeuTz5M4/jMCePSDEcgXryfdypIZLdgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jpqcMezn;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4F606D828
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACF4F606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jpqcMezn
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-53656465d1dso52393b6e.2
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744781; x=1794349581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=53Mxv6Sk+QV15vE2tUEyM3M6ZRlSEp1NTwwg3jt+yx4=;
        b=jpqcMeznvYhVooDMyNV9kX9spxN3n0M/xsJWgGWyKsIda13X7kTZbKJHk9gFrEbbi/
         YBNufG3ENVGo0jGoqG6f2nSVZwsalTV23KZ6K7hf8unEjh4hfBm6SHGs8joX6dJCgcLO
         AukjPVONFeug11OR+g7KK4XHH+ElkHT3ah+ec344LEmr8CLi0Sl3TL4pSmPdIegGNVtb
         1JRs74h0UGpkip8UC/9QLYLqSOb95GR0gzuEitUy/lFukTt/qfUY/wvQVRE9WDbilrZY
         RyKypMKnzE9AegSM+yZ6MsdzH59JGEWthRmDGLu3qEfWQXS4op2P8pBZlI4ipM/zrdK+
         aB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744781; x=1794349581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=53Mxv6Sk+QV15vE2tUEyM3M6ZRlSEp1NTwwg3jt+yx4=;
        b=DNXBNvbaTKKEAoseAlh+7fodENbrWCdnBuI0LDBWx4kT8TxJLRL4vuKQlywe9rLZap
         unNN+fk16pQK4/k8xHM+QYZHhsBxkGLE82y4P6Nt4hOVuP/lNj+Bvo4gVjvSawS7sR4y
         ++pEmvfk/GL0V6ZuHS3uuwNVMUYVjOCF003Qx9FnbguYIWaDl/4fnbenWlzFjD5faGSj
         1U67E6YoVX+UwNtitDfubsEsJzTVa5m4h8tHuqWIV/nBXUsKrKp/xoY2sc1fAee57T0s
         5cEJuygMRtB51BzVW63q1pbV1zYQ2+ZxV07IZHSM3G7ULA/XeWHycHn3DrxRiCspXwcy
         EpsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAAvRxF9kwdFhD5skM7BVdkJfMPeVQwV2UohlXgdG/aBWj6etdgb3w6Pk2ETVOVGkNILZAdeC/EIJPEg0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Oc0HCahcrvNsFhexJ2dC+gXZwkgsGZrKLNm20/5KRbBtHJvYy
	7UaynAeVNCtDpdadQ3rfaSaMBwzGd/xPGaLb/RTCqWKeUs+6NBf9qQ96
X-Gm-Gg: AYBFou1auh/Bc2eGdsdIrAw4+tKuf4K3KOtJAOZvjueOjSeHakcbhgENoN1nc0OQl+o
	lgzLitSykJaN9g6GSvcR8QXF3BJJfQZz9KyudxZkFEKkZh1CGMLjAzE2oYs+LjCH41jE4QyLNLu
	Mk4IawsgTtZhJtcG3KSEgnKDoR1Ro0ByOyUC/O1+yEzETjK68QfkNOIlggPtagPsdD39C0coBoA
	O/WuUHoy9rwe1Up85mrEV273lSHiWhwC+XR8301dwdyCajVwvH5KVSI5Iv2ztdUUSL9OmR0lLmt
	EvZBlxaMUB5axQwm8B15b08vvb6ID57Jt/1HZfxdal+V4AB/c+CRLIR/AaREzBw40//7VpKCnRe
	tZnXTnBLrmvb9eKHFzh345cnpq5izUa31+fgIc6y1j9VxqBIv/I4TmIXWu7SXI9KxFM5TsDZS82
	5GsShi2yy4udhz+4zD/3ZS/EdENwisf2d69pOokY8VZM8/z1XJ+6JdugGrGLLmBvT6Q7/umfZeU
	RPVxAyayps39tdRA41BmW0Ko+BcZtObsqNXeaSB5/f2d+O88QlJNfIkCtzVntWUxiWHH36YANVo
	yuay+pE+VL56bte8B1aBjBIGY8HMCBDL1YwUY96bn6zpgBgd6PVNlMo9hApIEbV8Sn6jCB8AmEJ
	BBHV7h8rGkfQwXkZ5UVq3rMeBv2GoXfTWYJYQel6BKtAKPk6BY5X1j/LYG8lbWZXFvIrj1Yk4B/
	LaPKdBs+ot8Q/msYE3dqfe041lRH8x5yjiXabByy+vADVg85uDcIk=
X-Received: by 2002:a05:6808:5387:b0:4bc:cf33:7024 with SMTP id 5614622812f47-5640dddcbf6mr9361158b6e.42.1793744780622;
        Tue, 03 Nov 2026 14:26:20 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:06 -0700
Subject: [PATCH v6 04/10] dmaengine: dw: extract hardware-LLP residue
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-4-2ee0c348224d@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

From: Serge Semin <fancer.lancer@gmail.com>

Move the hardware-LLP residue calculation into
dwc_get_hard_llp_desc_residue() so it can be reused independently of
completion handling.

Keep the scanner's LLP snapshot, descriptor updates and early returns
unchanged. The helper reports whether it found the current descriptor,
including when that descriptor has zero residue, rather than using the
residue value as a completion indication.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: extract the calculation without changing scanner behavior]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 58 +++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 2d69fab06601..5a1caca7ad68 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -267,6 +267,38 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
 }
 
+static bool dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
+				       struct dw_desc *desc, dma_addr_t llp)
+{
+	struct dw_desc *child;
+
+	/* Initial residue value */
+	desc->residue = desc->total_len;
+
+	/* Check first descriptors addr */
+	if (desc->txd.phys == DWC_LLP_LOC(llp))
+		return true;
+
+	/* Check first descriptors llp */
+	if (lli_read(desc, llp) == llp) {
+		/* This one is currently in progress */
+		desc->residue -= dwc_get_sent(dwc);
+		return true;
+	}
+
+	desc->residue -= desc->len;
+	list_for_each_entry(child, &desc->tx_list, desc_node) {
+		if (lli_read(child, llp) == llp) {
+			/* Currently in progress */
+			desc->residue -= dwc_get_sent(dwc);
+			return true;
+		}
+		desc->residue -= child->len;
+	}
+
+	return false;
+}
+
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
 	dma_addr_t llp;
@@ -354,34 +386,10 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
 
 	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
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
-			desc->residue -= dwc_get_sent(dwc);
+		if (dwc_get_hard_llp_desc_residue(dwc, desc, llp)) {
 			spin_unlock_irqrestore(&dwc->lock, flags);
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
 	}
 
 	/* Residue describes source reads; only RAW.XFER completes a transfer. */

-- 
2.53.0

