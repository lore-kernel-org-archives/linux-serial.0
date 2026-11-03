Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744783;
	b=qd6BiQ/SEf4fOJJeoTDGJOaZgtKiWP6nie3jiaSXx1njHpfz8aLWJuYYgBZNdh7WXKCn
	 7Czd9V2Ln9giIL2KYeBdsE8N7nzu//2pXh3cLRRNOA3NmyFod37IRrVXx1RaPFVIWbMOW
	 +iLEYR1nk91GwRmqjsJswLCTKniWp/bpZm/wdlty81UfJXimVf3wQLUiJAxjdGzIG3nM4
	 hucXuI13QEoUlKhCpdHcFZz5Scgc+QpDylQ6UCR8hDbtMLojDdLPMyiEJ70mrBdbGUker
	 CA1tUAMs1nRYwVp1sBaun6gFD4Km2mFHs4o/bm4Gxuh74g41M5Y2T44R8+qDZlzzwWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=NThV1TPzbyl8VwtDNaRPOEfbfjp++pfmcEFzeBnkmuo=;
	b=iXS3qCUXTch/Mni23XSx1fehIw96piqkr3H2FV1rP6fHi6zpGesYYw7rbCMjakgc32A4
	 HougyRwA0h8sWzHs+yR5264D5nwDwUBh9Sg0D7C+sJYtfpI7MJeHif+OtzOevNXHPjKH4
	 EraFcoamnyoGoXt5Sm0VwOKDlG+8stc0Qrqe1ZpC8QXuFjf7p5zi23Wxr8m+CfBZdVi4J
	 2jLghfK3yaRQDWF4VzByyVjw0RNMarbVjYTkeW5NRNRZYiGbwT9orOR6e/6ioyo93wz19
	 4tWr0Fqc5Fza9PulqyQ5q3Iy2l1/bqbPwE4BcMxZv2+HZa/odhVVc0OZcWf6MSQx91w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcCVoY1+;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DAB606D828
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9DAB606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcCVoY1+
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-83bbcfba0ffso71433a34.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744782; x=1794349582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NThV1TPzbyl8VwtDNaRPOEfbfjp++pfmcEFzeBnkmuo=;
        b=RcCVoY1+op2uWII/J+lWXIqcTV1rWYFPEaGfvOByppSNijrTg2ZeUVrs/MhEeUTjge
         Ikcx/UPolZjb1zOlDimmdn8z8JoyGOD3VF7wd5Vjzr6GU8ebSarflkdbxGkzADBbxLFZ
         2JUKonW8qNbdrVIAJKCV1vj47aAhF6IdIN8KOzNiZgzrIypFVQ9Ag/watlaG7mRySRHd
         Mw50j84JZEEVtLlcGFl2hgU4P8xvqEGLfuk2DgkX0HV0HQDeyYoG5CMRj5t/rIueplE9
         en93CG8vue+3E/hQzAN3sh8XKu4qlSMRdz1jD/yF8QK6JYG/Bku4Q2YcFn6KWNtxxdQN
         LlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744782; x=1794349582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NThV1TPzbyl8VwtDNaRPOEfbfjp++pfmcEFzeBnkmuo=;
        b=NwNf42B2zkXloLKuiowBzF0ja2Mg5DoZr5Hz66QfzBH5MZKt9Kp3a1e88lWGIDDAWo
         WaoG3FjhQ+yMaS3RU/K9JISQuqAa5gy5DmlKvVD9J83BpeIIXs5mDsnvnsdYdMCWPVtL
         ydPQzCZr1CLUf1J+Pbbwr5F2aJCRGdK2Ls4acFJukCwqCMKGZ5DIp91kPZi3lNZGDl1m
         FjVXmFhX3jusfotu5/wffrHtBvIw4y35KB8IaOj8u/5B2hOS53/hh+qv5FuNIhCt3sj+
         64zdI3isVdz8RjKgbCYU9JoDwXak4wKSvQKnAKlQltzGVmxvOaZIM8Km4lv7a1Nwzhp6
         Dpeg==
X-Forwarded-Encrypted: i=1; AKwUvBwAOjs64ATA1yUaColD2oo/rhOOSqWqx6Bxa+sBz9CbkF8B0CTZGJ1AwbOqidcqmPr/yHhVULBQrneq7Vg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NGINTS3TfL6TEQCS5jYD216ClfRCaH+eauS36jAWq82Q6Enky
	B81s4lp/WT2wMh5HjpZC4fB9DI0rrXCy25PBAuhvP4+cBKA2VVGQLpHJ
X-Gm-Gg: AYBFou1Vt3BM1u9dqt25usK0+wqAcorhomrlRAFJnK4t5QJUQaC5rom80Im+akSYBsQ
	W06fdmSp6ydueKgoRXOB/SCCyt8ydvELu/6ElHgwV7SWcgDzN1RmcgtGjQvDtsfB4XFLXPaYdOR
	WEDS+4zZ8Uz50xDc9X2zOKBRy+WLfJeNEVj/SXdyuOYBmy8JDKp0Zyxi4lZg/H5Ca/Aj12svTRq
	h4oZ6VHkacSZkW/SjtdxJ7wZIWHpTIiiq5jvvNKsBS2E3LSaVQSo5Kj7ncTkgi75cPr81iLn7Bm
	bD3Lyz3DFz07U0thGHz58Ko5YWwuarwS0GzMdZPs89u2BMxCHd7rcPlKlA+nSe7m1GTdZHTSKRh
	zzu6gHAllIxOXYocMcd7JLxwZ9d1blhWyCt3jOn7TgFxUHCzjYVFn+f9Jf8I1J9vf8EnXmd3Th0
	Fp2x+7ugdlvHUV1fJvFoGxovZYtqOrhU6sOzAo6yiqkk/a7vQs1GbXOvKHIqwIpV5ICF3bMW20g
	VtMenywOw7XOrh1OiO7xeUGbBXv0zwLzJorGbKjgPwJlnMHYf1trBWtk/HYL3tl4lMcY+v3/bMg
	3EULuHPOl6472Rue37PymN78FniICsh6qFhgTMj2M0ohRXPf2xEdLfsqaYIaSoCiOfWf+BeetZr
	RVw9yCghlbBPyAH4SodF6NV30uX39l/fxzlMRMO9eSTe8zM/dd6d8csUokURrN0KyRHh3Og2wCp
	mtGwge+jYv+8+4aOSvJSOKme10jjKXAZulznfv5JGRe2KZ30+p4e4=
X-Received: by 2002:a05:6808:1494:b0:503:8f9d:f11a with SMTP id 5614622812f47-5640dd9c1demr9657792b6e.29.1793744781799;
        Tue, 03 Nov 2026 14:26:21 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:07 -0700
Subject: [PATCH v6 05/10] dmaengine: dw: calculate residue in the status
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-5-2ee0c348224d@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

From: Serge Semin <fancer.lancer@gmail.com>

Calculate hardware-LLP residue while looking up the requested cookie under
the channel lock. The scanner and the status getter currently take that
lock separately, allowing a descriptor to start between the scanner's
residue update and the status query.

Have dwc_get_hard_llp_desc_residue() return a local residue value from a
fresh LLP snapshot. Keep the persistent residue field for software-LLP
block accounting, subtracting the current block's progress when reporting
status. The descriptor scanner continues to advance software-LLP blocks
and complete cookies from RAW.XFER, including for polled transfers.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: retain polled completion and software-LLP progress]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 64 +++++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 45 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 5a1caca7ad68..d9127337c849 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -267,41 +267,34 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
 }
 
-static bool dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
-				       struct dw_desc *desc, dma_addr_t llp)
+static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
 {
+	u32 residue = desc->total_len;
 	struct dw_desc *child;
+	dma_addr_t llp;
 
-	/* Initial residue value */
-	desc->residue = desc->total_len;
+	llp = channel_readl(dwc, LLP);
 
-	/* Check first descriptors addr */
+	/* The first descriptor may still be waiting to be fetched. */
 	if (desc->txd.phys == DWC_LLP_LOC(llp))
-		return true;
+		return residue;
 
-	/* Check first descriptors llp */
-	if (lli_read(desc, llp) == llp) {
-		/* This one is currently in progress */
-		desc->residue -= dwc_get_sent(dwc);
-		return true;
-	}
+	if (lli_read(desc, llp) == llp)
+		return residue - dwc_get_sent(dwc);
 
-	desc->residue -= desc->len;
+	residue -= desc->len;
 	list_for_each_entry(child, &desc->tx_list, desc_node) {
-		if (lli_read(child, llp) == llp) {
-			/* Currently in progress */
-			desc->residue -= dwc_get_sent(dwc);
-			return true;
-		}
-		desc->residue -= child->len;
+		if (lli_read(child, llp) == llp)
+			return residue - dwc_get_sent(dwc);
+
+		residue -= child->len;
 	}
 
-	return false;
+	return residue;
 }
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
-	dma_addr_t llp;
 	struct dw_desc *desc, *_desc;
 	struct dw_desc *child;
 	u32 status_xfer;
@@ -309,7 +302,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	LIST_HEAD(list);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	llp = channel_readl(dwc, LLP);
 	status_xfer = dma_readl(dw, RAW.XFER);
 
 	if (status_xfer & dwc->mask) {
@@ -372,27 +364,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		return;
 	}
 
-	if (list_empty(&dwc->active_list)) {
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		return;
-	}
-
-	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
-		dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		return;
-	}
-
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
-
-	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
-		if (dwc_get_hard_llp_desc_residue(dwc, desc, llp)) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return;
-		}
-	}
-
-	/* Residue describes source reads; only RAW.XFER completes a transfer. */
 	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
@@ -987,9 +958,12 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
 		if (desc == dwc_first_active(dwc)) {
-			residue = desc->residue;
-			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
+			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
+				residue = desc->residue;
 				residue -= dwc_get_sent(dwc);
+			} else {
+				residue = dwc_get_hard_llp_desc_residue(dwc, desc);
+			}
 			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
 				*status = DMA_PAUSED;
 		} else {

-- 
2.53.0

