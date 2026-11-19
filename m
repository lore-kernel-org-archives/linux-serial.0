Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082555;
	b=mEmNKU0PGWl91Sy2s/GwHSwn+qmhMeA2KEPJIdnwSdjpIbLoKmk6Svyh7a7MSaItZt/E
	 SRHR7IOnsmBckqddljdtiWKQdPq4hZetRsgMC/Hwd4ciJhcpcCZXPuObEFNRRCBfS4EiV
	 XJISs/KT52/69Urozsct9ILo3MdPcDQsCW4JmQR78gKKdg5aqoWdycycKWZrakP+QSzij
	 PTI8XVhPMCwCAZ6I0nhmNF3XXLftwF/kssGu1Us39Iksi2qnfmhjSZM/jCsAnAZ3eUdk/
	 YnUvv2sKjn9Q9TxzE9pirh0M06F86NfWFFcCqbfndrKwDrN6aetDAVygaHcmn+5LX9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=6MNqx8SelieMagco0tCtX+Et6uyqf4e8xNdGXpW/e7g=;
	b=mvm76R5cxlLHeYJZ4CnQOZFBDGKgVV+qKCBygWVQzqjcpFX95OKYl8eLFJ2BV5BH1vA2
	 rJVLa/207BuRZgWp9ZHb4OdO04FV4BMGrRPddhT4ikkdYNv32F4cYajxgKujvCJAAJP90
	 SLFC9cs9VR1IGVZPt3v1P7RR1uLfPtfJxuCbYP4QU1DluClsUuY6+C58jnib3NJy6PRSs
	 tWfAL+Qa2tkEIXnGxc4lNZoWp3JIF5UgZCCR8ZT7kahhnl1a/PJyChfGIZMpBh4U3x/qW
	 hjPE+l404R64RTq5+Mnt+tyYCn0Y3QivMqzR32bc8PWVcob9Za1fTtMXDgaElrlnrAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqKCasXB;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F560A262B
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 763F560A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqKCasXB
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6de2f213b7aso946842eaf.0
        for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 02:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082554; x=1795687354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MNqx8SelieMagco0tCtX+Et6uyqf4e8xNdGXpW/e7g=;
        b=UqKCasXBDO0hLpycOtrLJqwUIDTf/hQ6qud9KSXX4mQviejJB9wmD+uX3qhmUW8hPS
         8vjLJEKhzphDLngcZOvczQ2rG0Elta2BtCDAVMiL1Zkovx+K5kkTBj7ksSJiEV2TRDgj
         eCq+v6N/8VRgxfUqGxeAzZBjcXOp1tpmNE0RteZpSsZThgOBrMsA56T+CSUJDMiHTySt
         PIdBQn+dhkAujUG/2xTDFxHShwyiR63D7Y1S/G8GvO7lXm9XZ2Jfs10Ky5r8nBRxYCaF
         hSkDCKK81qqsPmi8UsD0W0ACucUo4c/sm20nkaMMRjyIjXIjUGvn6jLAvwD7LfqN1jDc
         ow5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082554; x=1795687354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6MNqx8SelieMagco0tCtX+Et6uyqf4e8xNdGXpW/e7g=;
        b=IXOu+1j9ASbXso+HzhYdO0jOP4slUPuGd8bfkdStjy+XcCjhgttUzaad31TzGmX/bf
         I6mcL5zHsFyCHnft+mMPo34g1JQ83fVSdr/5nBCf3fg3P731dEh6O6Wz0W53Q4K0xLwo
         SX1AOMSnZd2jsSFkpOTus4zoZgurFhx7GUGLQ0dbZcNwpqL2KPLVWlLvJIr4ZnBFud76
         6c/tR4oEqo1CFB3FMSZGXjJYKmbrII7PV/XEzmWNJg1tXtt3NvORv+zQ8feJWaCIEp9A
         1F9Kn0a9DwPoPgxpuVAuS4GZSn6f4E0wUehXyP9FETz4N43mBCq8mkbXmnKbVLzwoQVH
         ApEg==
X-Forwarded-Encrypted: i=1; AL+hErEZX60JXRiqDmaoOtxzC3GCUJt73lAZLCeAewsybpiGOX/EKObRF5oE9qhvhIhSyCmdAtX1uHssSZ7YpV8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oEgJbrV+edXd/wm2kD9YpdzPAeWP09WIm0sXYFhqpWo3K5Sws
	AueBQmHXYuPS/nIi612prhvApDTnV0hn0yUUeZzDe83IEBCD/4DeflhZ
X-Gm-Gg: AYBFou0DrMJ7XoAhsz/HSv9UjSnV/TxJ9tMBYaC9DLTQ/ZRRKcHXcTUBq86Jk2PW7OY
	A1/wJCrKyiRePuO/eDnqy2EbnnbhK5EZ9eMLdWaEVtXvkQIbIsryOipavWVL5Hs7aEL0QWYDcFY
	nqnDLZ5wNKeFoBNRfK6+ac2msGcdbE5TzJfT4A22vb5VMSYxZQRe0wnRRDTIBaqNKMAlQaatJtH
	yfPQdVGpmINpBw62v8q2dXwcRPCQ5P24qW48Oj+bv/wEgkPSY/kbdlHbW+4/q5oNb3xEDNDAVDK
	TrmFEcFSonMrgLnqUDP3EFR88iDiJe2NcrfvA22qVt3pPzhI+jnh69WlADeS1x/ZhX15yQ5cdb0
	Y0t+j0nT12OZU85lXDkodM99IMtAIROaRo36pO+XreIyZN4qIhtUIhJV56++oaQjQvxR5sEnrgc
	4akmtLpQet+7Qgl9s7MdviJXGW7uT0huEKslypEzC2Fn79fLqDzEf1sm+wgil/kvUMVqCm3EZPH
	b2vVO8dlDDrnbYhAs1ZJ8VSXr1u4rXm0jAEhUyn3rDcPr4AT86RrQ+lKg2zLhsmZI4+dnL8BbHt
	Ze5mthJmac3/TqHQa5+ktAStdcKwIps7eCtj3CA48FMoqJOerD0iFNUPRHTyoM5mhv2F3msJjm/
	jIDkMsPdQRJ23dvRst0B9GvqPkgOrJnv8RCINg74LG7jADmmWrldYj1nf3AgvjgL9tOe64Eafrx
	DHTpPk2Y2NhFyMZaxADzOlw3Wnt0UY11teEq0um/1wBQ8eNCogHo10
X-Received: by 2002:a05:6820:16a1:b0:71b:1c49:5f22 with SMTP id 006d021491bc7-71b1c496c08mr3044704eaf.42.1795082554397;
        Thu, 19 Nov 2026 02:02:34 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b18fbb9a8sm3906194eaf.0.2026.11.19.02.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:02:33 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 03:01:40 -0700
Subject: [PATCH v10 6/7] dmaengine: dw: calculate residue in the status
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
Message-Id: <20261119-submit-dw-dma-synchronize-v1-v10-6-3a737597a0d1@gmail.com>
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
index b556a39a24a9..7a66dc75c546 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -281,41 +281,41 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
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
@@ -355,14 +355,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	dwc_retire_cookie(dwc, &desc->vd);
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
@@ -967,9 +959,10 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
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

