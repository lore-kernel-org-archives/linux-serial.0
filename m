Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727188;
	b=xF8oed8cHlIa9Lc2iBwmFG1DlOCYcpqcp4VfNQCkBC/5MmbL0ycwxTjtCL1UqoIKF6fq
	 TAlfr4C5t8wFSnnCNc2d1c+7eaJDz3JSYaFBFyhY/pUzPW/je+vxfBq4oGRHQTQNXtDOZ
	 nPzmMWjr26a3qcL9bcVxlljAsgDUMwoPFXIoWOpJWW9K6SI14no2dJWOb2YK5BTJQPkyX
	 jzupB/mdN8DIfwgeXGV088A2AVP830YL5AMxb62uV9Y4vNVGoYWwj3yOJDUCaWnxOmQ0y
	 puM0FglYXd4StTOWk1MheDEjUjfhyrN8pEKTrPwHgsLfE7+BVqBlLOI34cDPEyc2Png==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=dTZw+th+8Oe1DXeAcCeWuqBX9XGzYLMqzgYNqTgZsHI=;
	b=AgQxz18Gnm7HDfai5j5+tVIJ5PpaOHQWpUKnyFgoMz2mE6ACJw9kp7PA4GuCf0oOWcWi
	 cRVdcAvSuekYc0hWuAOKz7o2VKCZFp8I6tpCwGYuRNbtVRZ0d8MJ6SN8sGaZ+L6saYJRE
	 JMb3abJ8NKjm0sYNeXUWsAzuFS2U6h8YAezxwm65XbbYexi6zlXv8hiRqGl4hESxi4dgw
	 aErWmHJ/t1BHBAUfA1gFLTXxGQIxfu8ue0bB+WYjOmV8+ftnvKp3/bH57UcMVSg0axpSv
	 20qDsnmUrRCWuzbuOJoPIJiZeqPFCOs+nZr1w6Hl/+pK+x3QfokfzfUXTT5dg8QzUCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ck/EJRgd";
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD360A2602
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07FD360A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ck/EJRgd
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-71acdd32a53so412036eaf.3
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727187; x=1795331987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dTZw+th+8Oe1DXeAcCeWuqBX9XGzYLMqzgYNqTgZsHI=;
        b=ck/EJRgdKqGC7cXPITkzdHjaQLHvhByrX3uVCO7/7RrT7F8xvaxJYD868XZ5kzYi0R
         08JM4XEK3L6R2MHR4KsC1onDpWWIvEZ3/NWe/HdOTt/zDeIj1SiVLWY6MXYy+lGHWEL9
         C1Im4dZ0EDQ+SzQRHRUe1Yq44tks9mBZRPawFZOB0oL7PgfwxuGyHFyE0014fHiCpgoj
         DFeUj2I4dmwxjaDLgqgcI8ud1Hh37xNgdKtzUzHvsXLeUkI5TGYt/4TPCVi+aRgep75U
         DrQJRsIwwt3H56Cm9edMcuQUGtL11d3OUoROlJTctxKyeqiUtDSy2JV2Ox612UvYj5R8
         lntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727187; x=1795331987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dTZw+th+8Oe1DXeAcCeWuqBX9XGzYLMqzgYNqTgZsHI=;
        b=fLzEQt7rxp4/ZSz/nR090TRJ4OeIr8PhtmAICp6Y2iPJZJ+DdN5oMjZ2KQ6hAXqUxZ
         MOyMn7xpmPNkH/bPl3FBG9GBz4SB/FtQm8FSpwJjd7wT12bYgNHONqw2TeZ4YBEB0dpy
         akieZk04Ul5bl7OD6u/Bfyt/Zh6ChZ6G7J/xh+2jf30fAaPpkMx+tDTrfGuId7jK0RKm
         upBxJS7GVU+AVMZSw8mN6DShyveeapYDdVndNuoetKD0Fl0Us2oi3FcPceTBePhZ5uNN
         rj6Sl3DrYaD7DCW+8mMZfB/XrSK7hhNRoZ8EyRp9BgIyUg88fg3mUPFTjUsNeqPebkzd
         WCYg==
X-Forwarded-Encrypted: i=1; AL+hErFDpacnMsx6OM0Z9S3yhIRnS3nVS7jewtqYPnfSKZ4COpsYk6NZvBmeaqOWOipjQXArcYTu34Z8irzMWMk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KQAqXDIVX/Stt4ddkFF9T0ksWGsCxqx16VI2d/cPCYJu+hfaw
	P8DPfJQJ+SEa+WBG4xZDcOVKuLsLuUxrrkxTUG8747eRg/1zh0W6cFPE
X-Gm-Gg: AYBFou16/Z23uc2XePNSWC0HeJ9/TqW9JbvZ21QgcqMptjpbQPKNNvr/fF/R5LEp9Ji
	2GEK/V1Ab3pP4sCz6CM+RqHCRf4CCp1zRMiXA82AGWlgZLyKYE+o0sbidwEzoFWoQKPCWSBVt56
	bB+uchWYDcdx6r3nRzB+fDNdxj1gziI+qwrnyd3X8z5hAJq7731SoS8VTK759zDHmiasNQqfKkj
	wVUl/q8yIFrryGpx8rkPcExq12qvQQshjZFPZlULBe1zohe4T6M8voMc6XreblVJgLL/XO6ttbp
	iCkQhufDWymGANW88Rwuw/XS5c/WX258bdVFg4HSdmVQtbVMqIzRqq4SrvPYGPutlZpv5MF1Uei
	Rj0SBoIl3YKEvzW+jWSCe0c0M/kOJoIppoVlf70DrJHERtCYfUzrbHma1uQEFkWhSKPtVZUGt3R
	jwK2yAVHQ8R3s5k143ZRzlIiybjzvZVl/rWcT9nUO1+eJyPO/eutkqsf+BLm/p7H2yz6nkyniWI
	My80ZpqmbF5BUPLCTQiGgVw1Vpg7pGMVgblj9eyDYHeljQKFBYs5Mj2FREUtFxnKtWn4LjvPeoI
	uGSGG9HjjkuV7wLBz/MjPxVHwoL2iDW5Nx9CzBnIMmn8zWWCKVNcUxv4HuLf/UzdL3DtkW77cu/
	FJsr2KdB3fWurbwMI8tlIp+qSn6ijcsWl6C+rX+DMOWzwCWg6VYax/nT2SXU25rckcvOuy5O9tq
	IFpv/obzxvXfB/dgJCsYgX/Hfs3x5GSLeb9ffaB/0JgOM1QABgXoI=
X-Received: by 2002:a05:6820:a29c:10b0:700:371e:ee02 with SMTP id 006d021491bc7-71ab50bdde3mr3199222eaf.53.1794727186924;
        Sat, 14 Nov 2026 23:19:46 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:46 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:38 -0700
Subject: [PATCH v7 05/10] dmaengine: dw: calculate residue in the status
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-5-8d58f3d49e4d@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 stable@vger.kernel.org
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

