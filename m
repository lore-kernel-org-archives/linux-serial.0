Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202973;
	b=Y6B7NTeSk5Z+f87Pbj7S0FzPdvZ32lq5+IO5hd8v5wXxBdv+RzNgjmYC+ZVi3lAZ8rmc
	 kb8whLwGrYEXEV7a/aDkrfvV7iio3AbcYgWuCdpfaF1XGYyZ2vg9ImoIuu4QagUiVDYj4
	 ERN0UqNx/dA65p+89tghILC2U6LO9IGgKhup0m7e2SlZUNhoBfGrqIKALofyJmF7+b5c1
	 NUy+KF4g/l6CBlPwcu+P3hten/rTE8HHFZVydXo+bMk383DNgeW3iuhGFF++34rJ+1F7F
	 SZHBzajQGy2z3aSD7U/RH8v4xOrW1MdipiQmxOOc5yCLRZg6+ZCXERn9eTh5hQQ7Jnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=6MNqx8SelieMagco0tCtX+Et6uyqf4e8xNdGXpW/e7g=;
	b=cJgwGr1l+8HVQlTmtVwLPhwDBmgjjysBZHRP3+rUY063slbDldHjUMT7Gssll+Pxns+w
	 DNJpvGSF6yedGub6rPfpICQDvbN5EQ32kEiS4o0kcuenNU+TISosd9KSZadbdAXOEC8tm
	 8e2795W7akk6ySmeJo/OgmOGIBHeHZ139r2+VI5UF6QgOzVZJYo4nXZqOm2Q8S7/MRttr
	 4I24IN9aANnkQ2DPqkIu+vmcqBpbdIlUt/SXg+5te6YTDxF0C3f2RuLST8cIG2AtVlQ5H
	 60k2UBz5N/2YGIJkglYmDBZDrSF5LgUmNJTniWjomOqGFIWlTBA9Y8MgSfDWslqqSHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VDDBoHPC;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94560A2612
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F94560A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VDDBoHPC
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-716b58a4365so798740eaf.3
        for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 11:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202964; x=1795807764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MNqx8SelieMagco0tCtX+Et6uyqf4e8xNdGXpW/e7g=;
        b=VDDBoHPC4r0P9LzupMd9R5QRJUsXTf7e6q6/7iPt7oKGKSmiWyNI+F6MiAX8Nekhgb
         kcBAiNXhLXJZeubUlcXynjabkPIjdi0lZGV2Z0QnOFxD+6Mw0uNuW7DxMdpNPYrjUIaC
         BN/N0vVY/GneOLwR6vUE+8EcP4FqE00cBUTz5ImMTy95rSwEcatFiZMCnWUw5cloYdVL
         PvBnAaOPclMcpC7DBf7OZ9eVlWwO2SuVtzMeZa5XYamXwWP86gVNathg14wxcBsE/EZb
         bbwj8+ZSem4jxLw8+AaZR07QDvN5hm6uWycCONLpqu6QQaEIqGqeXPCMJS0FoHSywfsv
         K/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202964; x=1795807764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6MNqx8SelieMagco0tCtX+Et6uyqf4e8xNdGXpW/e7g=;
        b=OAL8tvekahRy2jbJgQwo74KWrHt6Okeuy9yJQ+9LeLfZhuzL5GagCXp7VhiUkFT+41
         rnl8L+Hwzfg3gRk9p+I93pciZFXkTTk4RGrvsBPWv+rIVEqNUJ8qaUSpfSu66xtvtG6r
         7+L87aT3jkWP43I3X4dFMsqRZTfqlJ0/bPTI9UJzlewRp+VNmb5Mjo0MKzJiMIhJb69z
         +xlkITsfD1WpUc5SqNYR4OEI1q66HMPlOdoX/QUiGaoTlN4UVKuebPGweBWcgMGY+fbR
         6SWvABVm2V455SPfvYMxXKDSDDnSpihxTjBQV09xdtV5NLU7VUiklHLEXj0fGsvpgUto
         EOYw==
X-Forwarded-Encrypted: i=1; AL+hErFy0FG/8R3jqCyLAARFU6+A+eQll58+8PXE6f6TEnpdfb8jrdZYnjJ5SwvQLOr4nKsIr0669LyCDnE4P6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+y/I/8YMMQglhN/u9bwV+kIGDQ6t80kpRwNAErvCiR4nnkwxt
	xDnBquS/h4CIhh295jv0E+tYOWLkNJzDEOQnbjW78OJIAhLoMGBjT8FFe/mPACi/
X-Gm-Gg: AYBFou3vVxe+mwBAQLynkvSri4JpYfWtcJ97XUNx2W0mI0aDkRkEZgS8Sy/DW7SAOKT
	fLzRWESHQsRayQxo9QQCykVhO3zHxx5sXsmzVDPbAFIYslbdiLrSPo5+hd0jzCkDibeCtWxJ23G
	pNgpJp/nX+OBra5Xv4KhiLzxhbifpmK9PB4HoIKnFVsVjA6EyCT8Rjv7h0Lpmfpekl/Cd3NgkeX
	9uecWL67TuRqlewU7AoP1Bho1v87HeUcyomJJj1pH8crqE+W6IfEItTnfs4o2R1AYlsB46v4dko
	iYG7HHgzNMAiqD/B/LwNJJPGnbI6tpkHstmvYF7SEwF7u+NZgMNpm/Wqo821MaG2NEB8pRUSGMn
	rXhAJ4IDNaULeH+lWdDAlnxRLqcy1ML1w11WLU8g47RnQqGZn2grqxGBpOVQjzW/boBof0UFZng
	dbwKrHaIN1e5ApkY2GKvwcj0W0AAf5fkMGkBIN6lICUiVJ/AW+mkreaDzM/lcLeEm8krfIqg5HL
	MH5dg3yf+we1rAR+/41RJjQ4VkTA7Ra2ySJyvZ/XSzMIe4oaXWJuqS6oZvLrn1NnUJcDXnqt1dK
	LIVHmFJ9GwNbFH0tgCNPUwdbhr9kRrdtYPhFQur+J4uSmWTy7Dcr/Yq5cuj6JVE4cdwmIlnN971
	uNbECq6sX5h7KP8O99KLHoGhusNL9Vg7otDIs5NH4BvIIuJFX1VIlFoV0gsLZEopHwNnLEuzb1r
	KikrsIYSY6LYT1Fn2WokgMEUsqS12LrgaTHnLB/JkcFKwUp3Q1E3zH
X-Received: by 2002:a05:6820:55ca:10b0:71a:ee76:d7d1 with SMTP id 006d021491bc7-71b3953f78dmr2753238eaf.67.1795202964033;
        Fri, 20 Nov 2026 11:29:24 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm3434498fac.8.2026.11.20.11.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:29:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:29:12 -0700
Subject: [PATCH v11 6/7] dmaengine: dw: calculate residue in the status
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
Message-Id: <20261120-submit-dw-dma-synchronize-v1-v11-6-9b9166bc2cc7@gmail.com>
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

