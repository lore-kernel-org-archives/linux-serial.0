Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727186;
	b=I5zKOUMhY/DsKJpRtX20STfksmtpROyCDkrgUpBBF9KedWhaDqN0cn2DYSgdOEM/S2l3
	 +o9jGesJDYNTwYa06atV18EOY9MipjajS12KCf0EoKE9mUe+vw3hUmOaqe8a65+t0T3Vw
	 Uvp8USERmgZXqjmaUNFHjkVnQ5jvRj4ZxMNApVQNCojDpdRvg8Rb69GWAZfl3a0H39VA9
	 no4Va9Bbb8bzMTLGMWCjAJNdCDoE6nK+29hb63YfYxHLerNQUjsNu4Rl/471eB3svZI/B
	 QI35xaayjugfdkr+GZ2xP7dEFz4NgMulfCdUmmxksEPnNAX1GoLXCQOHzQHmgwL902w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=zAy+2tfRvtTehCJ0q+J+a30RAb0TsAI0p7oefFRsmAo=;
	b=xq+lzeW+teKYESvkjmOgt58AAex1ZUhIztV3+4l6xf54bCOna08JZoFaRmESTvfIpT05
	 WwPFx8KyRcnmMAmqaRo48eD0qkS7Khfxm+XkK0stll+pb58y04N3+4wNYiN0aRlMlZmMM
	 v+MNVSIpdvdtphVOutPze2NAGjAOoQoP4wDNz8NyuZd+U53IuEuQzsHNLu3J3LyNo2nj5
	 sdvKMtPkgd0vwSc/kqdtKOCxGAj5Q4PRzBZ8bF8eMflyyr3ax8ZQVKNJcITewuzcNrsg9
	 FOnEh7IxQnY5wF2GGzyZ7iGWlZ553sqXJodyrfWfdYwH7kpl8dXYcOGoJKDaMcH2V7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zRpjmk3n;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45E606A89C
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F45E606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zRpjmk3n
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-71ac798b8bbso1113975eaf.1
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727185; x=1795331985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zAy+2tfRvtTehCJ0q+J+a30RAb0TsAI0p7oefFRsmAo=;
        b=zRpjmk3nu6KU3OeTu9Y/9TNQULkJywoEkcO/jCfYyezVOF/MwUFS3CY8EsOdj1uE13
         co9br8t/leLffNqDJmvzTBe9yRnr8QF1il36Wo1IgSlZJNVOdbaC11e5BJEUwMenWtMq
         KJNwRg2K4jqBInXVCZQcu4oV2zvJ4axzj+8cTvrpPxuzdNE6R4OUpNyK6LNbnmFhAKUt
         Vi8kU5ur2Kve8T+D/mxSLx3FvdoyseeRjBJEPhye8T/1nSmgAEpfINhp862EW4DTvjZZ
         mYdQ7b0/TT43XOtCbphAZw0JKlPBwy/G0muvcMUAAdma57NLM7YKl03Ar96nh9r6bizU
         deqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727185; x=1795331985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zAy+2tfRvtTehCJ0q+J+a30RAb0TsAI0p7oefFRsmAo=;
        b=kcg3FpxpQ4R4dMfDxgtZsZYxWMfxAeNd8HyFlrzSEDe+6u1OEHBmbHWpl0q6LprB/g
         n6mmyjFSZft2p852ZGlsIZXwLwfvcjWqub/XaWeLckEz+XKnAigvMLx4LqWL72INZ9Ga
         BJPwx496hzBEb1MtVLWTa6zkK79sMi48PfXb+ArfGL/qYk9vFaYQtA8jlkiYLQCO9jEm
         LeqxnzONQq+YCxv41mQW4hv0X0l3eC7Fu4ovlH77zVnbMtG0lqhoh32s0CHssqHeGnX8
         6v+8ynmIpFpTuBg3VmX3TtZOIB26zMdW7qfzner3iMQG+r75OwYaAD4ION1wolODCwLf
         NS0Q==
X-Forwarded-Encrypted: i=1; AL+hErG4EAHjRUSG8qufpGfO5wRsUdfCDG43D9psqNRX8fzhujKx8rh3T+LAx9aqaYSXSitKzUy5BH2DobQFysY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OuTnVXsEqDsDiGC1o3qApOoM71Z4GWXq733eqgWlVzfFN5KlM
	p1w6ZPJynZuBAsDG13BNJWFNTNmpT1kC/x2c5XIf4kWyCO7vdkvIFC7O
X-Gm-Gg: AYBFou0kvNBr2I9lJjETfiWY0Eu1IlCVMPSAyKt0Yuk+SH++EjE6oCkiPwJQzIW39Y/
	S98wI4U74/TTYCW4KqLkVkufyGvdLDS69BjL0TjzigBe/4DCPCTEjRutEeb3EUMQ0auQOiaJ8sT
	1Y0JmPotMOMqsKg4uiKOL+u6Dr0XxOJe4fp60pd9+JA/9PgoaxgeuBw0jJJwLCvWrr5f6XnLvt7
	tGyT6wCc/tEnjhTvyhqb74jPTdjz2OPebRHZ2Af7B8ATQGqaPoXhaYOpR9Ug3P+WFMm4+obGS6c
	ERQ5050pJ7yRbTMVB7f9R+tbFmmRROP2LNThMucamJIiXVfbf7pa+rYVCINkkXjRxn1kK2TRxdN
	7NkftU7ARBdfO0bvpKEvJvwH4wx9j2dKF2KIanr3KY31+Dlrp7eiRgq1Ke0rYktBCPnoGKVmhYq
	kplV1mVic+1LixIe/tc4josr0RhPDI+imxMcyT2E6eUnK+IlluQmM0ozQzTxFBKB3NJpz+w+rKX
	5YNDEzkOvLE9U6CZpZr8vipi3lEcnkCQ4ovqBpmCRnioPX57RKuJrXDG9fWiem6djUPEs4Z/6cI
	Uhyu7saUW5jOixc1eaFP5FnQCP7zNz0MKG0hFz6t7J6lyMDnNrjOkIK/DLJy39Feh6UJ+1JWFWJ
	N3BdZBXhl7tQ3Zu/mFG+zyLwuAVeKLq/XhEwWvOrhYilkWwKSjC6ld9lbHuEnup3LG1FtSj6T/6
	NC4BIbaGKSxUSzn7EZVInbHxM5e6RimHwsBIUBriyAUiocpk8zmvE=
X-Received: by 2002:a05:6820:c0d9:20b0:71a:e7c1:d1bb with SMTP id 006d021491bc7-71ae7c1dd38mr505443eaf.71.1794727185421;
        Sat, 14 Nov 2026 23:19:45 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:44 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:37 -0700
Subject: [PATCH v7 04/10] dmaengine: dw: extract hardware-LLP residue
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-4-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

From: Serge Semin <fancer.lancer@gmail.com>

Move the hardware-LLP residue calculation into
dwc_get_hard_llp_desc_residue() so it can be reused independently of
completion handling.

Keep the scanner's LLP snapshot, descriptor updates and early returns
unchanged. The helper reports whether it found the current descriptor,
including when that descriptor has zero residue, rather than using the
residue value as a completion indication.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

