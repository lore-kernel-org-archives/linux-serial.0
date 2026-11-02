Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648065;
	b=u4E4I3O+TVB+LCHSqGyXnlZAooh0MWYFPG0Y6pjt0YbtGKheHT8iGSDMn76r3MtshVsz
	 febqve2zPyOHcxIZ4MHNirNkemvUQT09OUvC8TBK7D9yw/KYevDMXWcOuCpQhRnbVgTb8
	 aZeONKRwGgO7fESndfIvmMt5EypjhjdOfDYgUxgV5StnutNwDFqJHT5MdfGGvjzAGQeIb
	 XHmH7C5PMqcZB1hA5jY33FHzCCG60fkuEG1RiqjKQVXkrLZG/mkyNVWUMQjCjp9+OxkU7
	 A96mmfnZsw1yVl1Ep8Pf6w+9dcNL4boMoXASibMiBpOkx77ajoxqvwCWWSpyhWvdKqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=agNDJFmBlWFHJhILToH5SF3NXKWRpvo2zlMNjhJMbMs=;
	b=ITi/KXtmbv6YvgPt1+X5g8VN7dtPlOxIuZRE4uh56n3ju+DyLyqDZ/ZR/TGsDZnD8gWk
	 lWXllP+nyTr3rNnNUueE2Qal590+9RQ1TYenZGdAN3VS1oO7lSdcHlKGZvHZVyZb9Fvfx
	 BfzgGv2npIesmAFwuKrzGtMT/dSTB2OLrQAJXyG6myqxGamD+VVOEOcf8iF2Chb7ECgy/
	 DPrtCp9TZbUUL5qKD09REawlc2tpNbWO44BPeVqQOqal6VhYaWZsM8+aNZomEYJ3NB0yc
	 G6WeKA0zKLsY/SWb48ME+vHKTMODb1ypjlSoe0puutS0ETq9kKt/2DPj08BNb7lXsdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqaUjlDM;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B5606D83B
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 460B5606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqaUjlDM
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-53ec92375d2so1634383b6e.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648064; x=1794252864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=agNDJFmBlWFHJhILToH5SF3NXKWRpvo2zlMNjhJMbMs=;
        b=BqaUjlDM6OViKO6/VVgcXKROePzaH7UZZ2A3iXotgq8gkMk1Xs657geU2m42LDYKKj
         jYznvZqRbRs8KfvMvOXIuaxIvgnrySAB9TDWSmvM8aMPtXlloxmG6ERM+QDAIQe8RSkl
         Vm7W99mYxaGWYYDMI8WyVC0qHFjlcLYZerXC2fTYbeU8tPqQ9FUQiIfMVt9mpysUs7pI
         PfK+kiMvx2r0sZ7eaORG1pxgCAc6FtGzkvwb0aouCae+htjhne7rl7lOLIlzxsc22QW/
         JC8o1az6hps29R4PERGirQ+eXVCpUWHiV4ljPBQ4U1amGF2qJYzbz5Vk+J3oBj2Rz7GB
         xhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648064; x=1794252864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=agNDJFmBlWFHJhILToH5SF3NXKWRpvo2zlMNjhJMbMs=;
        b=P2VbbaxMb03qeUlEinZkdapVMMNHIb1NhLf/zB/Q1hrTMpk4el1THYfCD0roUZXs2G
         LjQObIR3SbYmKX3HP7zORRzhIjoMn/gjX+rd8O/eCEWbvcftd5SN+kjzWwrgjl3cQb7l
         oZIGPtx/xstj1t26aJrwLwim/OFh1sPn1P1IFf72JWVUtJOX8upl3KSBGnOracdnVaJm
         LKd4rFJlUFwTDy4CwUAp71pEqvLj/Tb3Y9ZFLS9iwq856Tr9nWQR8LdIGvW/snE920+j
         nZKradTZbziR0/rwCoQOFQpTVXAqy4kQgCCo61WI7Ig6sIQkDA+9g2o+bNc/m+PNo4wS
         y0yg==
X-Forwarded-Encrypted: i=1; AKwUvBwFtvX5KWus3OU8ufj+OlB50eIiLuK/Gv4amjnvl3xAdOK/hfdmG9nU+2cUhdnAj5p6BIImv1YoLbIgIKY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQJfwuKb6nPBVwRUv90XPqMK/dANao1tE5yrKXAtZQxF6Trw0D
	WL961ShqmHalrUKTTZf+1kXu/2DMdBB+3Z03UKjUVNFQzPPhxjXDwzO7
X-Gm-Gg: AYBFou1yb28hJ3b8kWeF3b5PieRNw38pxZYDQ5THVUJ+s+0L0HisUDt9PAf2k1C20vm
	dqYrHFNltMvvFmLyp/ppVtxkKjmul6EgzawYmynt+4cN/OP3cnd3OkKRELYAQsZxCjZRJh6unBD
	ro2LGAwhDnE4GiP6NyfNB7KfEdKpwjcKgnTAOBzHZ99Ph10wFhe0Bwou4gMRZhKH1Gq1/J3En7n
	kR9FI9uIX80mt+lHcU3B25nYzMkFVs0Imfrv64HhHBJYYfE+p2d+3oANbVbKDUWRm/jOsMHE6/N
	jljL0gum1csbOI3MXsi4aGLhNMiDMEnkzrrd8wQEU3SDUt756rdcsDIyXFRXpGWZYp2dYjC1hrc
	0o4Hpf6tBmwKzIUSbTPws8ML+1PgSvbSsMbggYxKVa4p50Sj/uWJ8+pURct/ieWm7RkrYR/uC/0
	f0NcJO2D6wYDQQxbJq4PGV3q78SbsjQF5yViu/ePeeHuyiAq2Rye4NtHqNdX0e8TyVcrcJ1D19q
	OfaagrDWM+zljBTJ//Fte2ignzfWPCi9QThri9oV7bJAY35RM3Ls70UKb5J3gVrkC2P55j7Lbhq
	jsgEujqNYYOsMy4R3TxTV/wFOT6IcFcAvI4GJmYqJFnef9zaa/aIClRHx1pmjEpx4jbvZp5DZgx
	+DrE9fRsyw2C7xPpQSYNAkojQP65BHRp8WuAP7u8zZtYVpB2SejFV8qt3QC5qlUx0mGLu0Y7r2p
	CUueFMB1afvw9GqXYrv1dJXuvkZyG5qK0zbho5Y70a4uu2PNHXawWIKdGlef3yUGjWXpiItO9m
X-Received: by 2002:a05:6808:3206:b0:522:1ac7:a573 with SMTP id 5614622812f47-5640dddbb38mr7810512b6e.43.1793648064189;
        Mon, 02 Nov 2026 11:34:24 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:17 -0700
Subject: [PATCH v5 05/10] dmaengine: dw: calculate residue in the status
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-5-d3207758fbf9@gmail.com>
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

Changelog RFC:
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.
---
 drivers/dma/dw/core.c | 88 ++++++++++++++++++---------------------------------
 1 file changed, 31 insertions(+), 57 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 5a1caca7ad68..0d6b5bd8ea6b 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -267,41 +267,8 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
 }
 
-static bool dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
-				       struct dw_desc *desc, dma_addr_t llp)
-{
-	struct dw_desc *child;
-
-	/* Initial residue value */
-	desc->residue = desc->total_len;
-
-	/* Check first descriptors addr */
-	if (desc->txd.phys == DWC_LLP_LOC(llp))
-		return true;
-
-	/* Check first descriptors llp */
-	if (lli_read(desc, llp) == llp) {
-		/* This one is currently in progress */
-		desc->residue -= dwc_get_sent(dwc);
-		return true;
-	}
-
-	desc->residue -= desc->len;
-	list_for_each_entry(child, &desc->tx_list, desc_node) {
-		if (lli_read(child, llp) == llp) {
-			/* Currently in progress */
-			desc->residue -= dwc_get_sent(dwc);
-			return true;
-		}
-		desc->residue -= child->len;
-	}
-
-	return false;
-}
-
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
-	dma_addr_t llp;
 	struct dw_desc *desc, *_desc;
 	struct dw_desc *child;
 	u32 status_xfer;
@@ -309,7 +276,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	LIST_HEAD(list);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	llp = channel_readl(dwc, LLP);
 	status_xfer = dma_readl(dw, RAW.XFER);
 
 	if (status_xfer & dwc->mask) {
@@ -372,27 +338,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
 
@@ -975,6 +920,32 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 	return NULL;
 }
 
+static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
+{
+	u32 residue = desc->total_len;
+	struct dw_desc *child;
+	dma_addr_t llp;
+
+	llp = channel_readl(dwc, LLP);
+
+	/* The first descriptor may still be waiting to be fetched. */
+	if (desc->txd.phys == DWC_LLP_LOC(llp))
+		return residue;
+
+	if (lli_read(desc, llp) == llp)
+		return residue - dwc_get_sent(dwc);
+
+	residue -= desc->len;
+	list_for_each_entry(child, &desc->tx_list, desc_node) {
+		if (lli_read(child, llp) == llp)
+			return residue - dwc_get_sent(dwc);
+
+		residue -= child->len;
+	}
+
+	return residue;
+}
+
 static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cookie,
 				      enum dma_status *status)
 {
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

