Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648065;
	b=q9HaxRa19BRzPCxjwlA9LhAnmXNZLdmwYX+yIvl7Hpar0c8JHbRLea55Q3UQqE/SPO8H
	 B8zmzS8hHX/M34yfh53g8deOAurTqkpk6+m9LMllraeWpFkBKItTraktxINWg437yEFpW
	 RFH/A/ZrDZwxM0aBHZzdAz9RPPrYw2Mri5ttxOQXBgmBfQZxsUhCB3mYKernODJNd3HS+
	 pnpj+cHOmDIaeOP8m3zvhgvVn4pJjLBCY5FNjOqBNHg7MESHeTJltzCCSkKzcfnbTCt/p
	 kCYX6XAJowRc6DhhOsI8AT8poJavgdQTY8O3TBM2SofCnI5IfFcJA6vjRg7NAH5Du5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=DzyeQhcNwNETnkmir5YGLg/TCJo3K7P6T54Vfd2MVK4=;
	b=ZHlE+RQmRVozy9WD7LowFGec2dJxYbKhNDLf7J8Nf/AXpjSwI37gPO43QULmS1oEk52Y
	 Wt98xXNU0jTGHffF9OdpvXGmR7eUoF+FbYDDl1OtOPasPHlOulpIlAHdBCouUpumghFcX
	 uqhbNZWBU09VF5ymh2NhpK86uqWjH5fBL1+qvnNV0tjL2q/rGJPk6bIZ1qzViiDPBIMZt
	 AMKC4xtzGpJPK6rZIJ5YiInhxfmnUnU/4pJzPDEXl6CUL2lTAHoqqmeW3WDNdXw8xi4XG
	 FK7JFTErwWQJX0646hbENJVX2qaiaqI//b2J7DAr/QO9m56MsuP3IVTvcooe1pCnQuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tzDHT2nT;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24385606A338
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24385606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tzDHT2nT
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4a76f63b243so3898174fac.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648063; x=1794252863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DzyeQhcNwNETnkmir5YGLg/TCJo3K7P6T54Vfd2MVK4=;
        b=tzDHT2nT9L3e91K4uJShuCHF1FzLra85E7U15csPvHypdzE+ZVMxuvELUxTnr5g5Hx
         8rnv9Ji3wlxbp2OjXuTvSt0lx5+wg1kqUesCrneqGaAI315GilIR/jT1bNyhf5ZLrGGa
         ivrJimj8CqXE1/KAQYAYvQNg9HTGU8gWB5rwYQxXKZ53PXTZksTMW0Q/CyAm5Xr16woO
         V0IcOU0xUFBsQLjfc18Zi9rmAsX4Ci5+IgU6cGyDHrmL2xdJEcxACG8hVQ/yKGj0E048
         lZFt/mzkVQGR5g9LSRQjWG8wutDrCN6P0ZwbhZMEm/UO0sxtsTt2LvRrD893X69Akilg
         HD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648063; x=1794252863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DzyeQhcNwNETnkmir5YGLg/TCJo3K7P6T54Vfd2MVK4=;
        b=YlAT8sCktO6cEMKX4EIPsTyhwIE9TL5wE2dL3FOosNj/huqn/iQonlQJZt4hqkkcms
         7+yJ0TifWmzzwNH0Xw7KnvrA8VOv1W5mEbXOxFYewnPP3uwwrM9I8T9LNOEO2VvK0Bta
         IfRMsMaZHJZd4gjbBOIGzv1rs5GxwmIdC7573kcM1VdNgTSVguTSiaDI4ew95qPJz9mE
         FzJWA1w1WDRpP/4NBQT+O1sQrLu59WJWEbmexmXqph6Qpdwqbi58gpf9t9h5tgr2o7QG
         xQg0Z8KFiZGBHjT83bERo8YPRjcUzeFkdwLQ2bwrx6DAh9EILAJ6our+p/vdyUHgGLAD
         j7Bw==
X-Forwarded-Encrypted: i=1; AKwUvBwR9g+riBTQraqJYdYRJ3FUiMGgZJf407d5jVZnRHrfAgLNBdMfm1vc1NWzfyERrCaspwQ/RDcgK5PcMbU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLl4Jg5KVKxXrIm7uLkfoB4Wkw1zuYOMtp4RQGIlwQX8keSgsM4
	EbZV9n/WBGNSkWwBFIX+EdncMFYiqcuHmQ8aVfq05owkoaJtp89+G4wN
X-Gm-Gg: AYBFou3qxXsq2Ha+DJ1cMzYvEozwvCEtV81YyZMZWtZn8buVmg3xJc55YxqkIJEh3DX
	7x7S6YNazDpLdaCG1oDMwSuNG7+lVUwHMqQeCXOzFcJoJet9Ng78g43xRUNXl7U9CgUN9kYhzzP
	6oVsQulEcQxLQpM15rH3lBiybomwV54H6b5+k7mcAjW7B2Ud5FqjU2aKdSvU0vnIVlQb9ACcPa9
	U/CzZm55Q8wa2CTEOTde74w+9t37uvp7fpor/faHzDeHnlLUeqRjRYXV+u8pBaE3wn5yM3JfJjV
	JTfILqGNUjiGnOv9GTBpVXiwYBcOUETOb5WGdT1tSmo+zmR6loh6QX+AZstdiYq+3JlsvwE3R8x
	XN/r5YDOvPIQ9nABYk6+05Sk5qo6ftN9R5etxQpr+2z8Ok4wy7iber85G/B9bRwPc7EqTrI5hde
	IGVs0AbLV15B8vFYIFs93vayKhXxjKvS/wJoHehWyd91a7RXXBtqw6dVQt6BCr3VMgHCXvoHe8Y
	Jm+zafxdjCmgYHL6E9jtscHL9EyiJX4cJCHcAS4Af3ilIAuJOQsIQzl1aw5mNt5HLNRYBtoQHk/
	oeEX3k/jBBUc/mLNxbjF2ADZxAJLpt6AfZyHDubrNwM7RG+BStXcfJg6U8NdBkDRfwQU1HCbfRh
	zx1vszB/IAFKpBbDa6e8A1RoUsg2X+X2UUjxD6pYxYt3Gu/LLSEdP87HjCAvAj7lQgPCTXB5BR2
	gFt0kt+bMMrFc+YFn13615IB1jXtny7/ddTlZequ8EnL6F4egA9+E=
X-Received: by 2002:a05:6808:1904:b0:4b8:46e3:e223 with SMTP id 5614622812f47-5640debc697mr4798058b6e.15.1793648063113;
        Mon, 02 Nov 2026 11:34:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:22 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:16 -0700
Subject: [PATCH v5 04/10] dmaengine: dw: extract hardware-LLP residue
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-4-d3207758fbf9@gmail.com>
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

Changelog RFC:
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.
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

