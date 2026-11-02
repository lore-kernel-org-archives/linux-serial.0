Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648062;
	b=Kns17Dpy8ZqDX8OixKe4DbBLxtBlcQCuVH1mOtIDOcaYiSLxcoxTRfOPbG40GSMRnvNs
	 wWpKEodjnSMDvfFWDNc0sSzSxp3Xb8Pbcy0uT8B3XZ1/WP0qZg3G1kUobFXYuILiXmALT
	 kwNhZOYvJHcl33xw1O6L4A75VWqwdBXwn3Kp6/7AMvvjolZSM7DLoMLRNNFt0OMvfeTSR
	 +O5Fw+3O0ZDHFSE+xjm6hp8ocj7iBurmRD1Wws8nrU404qnyrXKnu45F2FexkFjcJLxzb
	 Wnpey9PpHyNtZwJv19m+/ZarDLAMU/kG0xXf7ryHBOkMvcMZje2FH4woPtt7voUjNqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=pbtv4Z8H6VEyX7h2geeAFawrqROMHFyY2V23g5NPPFzdJ816D/vwlRbrj2FnZrrgWUf0
	 BZVGbwCs2F3lYT5IQh6jFhLMkRM2wowTbh77yXEX6bQtopqqWWW9EgHxGRFaZb/ypGloH
	 F1DkgQclGHhXXFYis6f/rroo1aEjIthzNCRV/hOUnRC66/wiib/up0rKWxE2ZaVSqWD0O
	 BxVQnwWH0962ur4lEQjqijo9mHpPFFG6MjguZYHoFjJx0mP++yq1GMIYi0CnDVOctAIEr
	 X1fqrw3IhEKiJ4HMVHopEJoE1SK3FTELbOcOaUWKmgkAIfJxd//hooEk9TPPBP3oHSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h0yJUUbj;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF1606D816
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06EF1606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h0yJUUbj
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4b28d9537bcso2471857b6e.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648061; x=1794252861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=h0yJUUbjstn8n0lPMZb2BE7TQtnBcd7AjiPCy5Za2PFXpMbWiPRPEUAR3nxKRQRIRU
         IHc7q36oNA8OzxDC9sdg9ozvovc++jE1fEuB1D9drsvaMpjc4g8kTD+Jd7BLcEWRHWti
         BoUycOYQIiQbwZOuObVYf+XY7/LC6Y7NHPIEyGdxnfsX9OxyKj6ObXEjWe1ta1/CDno8
         r+b19zNJGWoiNtz1K9MpYYDv/OcCfMQemBYW4PIY1wIdRuOXp4qx3KPvDaFPcoanTelz
         McjMRvBAg6xVWnlZ5P1d6DLDD+OW2D1GHBb6HNtggdnSLguDawyCkuVntdjtGQjbUezQ
         eayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648061; x=1794252861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=mWci1BsVFve36UKERZVrgSAAW6npQVnepxFpDSo+iZHc7d6lrr38/laxSk4xCjCLkK
         dFcMc2X9kiny0Dwl6zKtQ73b3tlB8tcA4jTr+2pIeAO8HRu9K2dg8spqSQb4gee0rIv9
         fpnfL/9tRQoVRbzPpWp8rYxRfd4LJemGQqEJI6YVbcYOraLo9ll5YqBW6FJvQr9gbr5Y
         Rlk6IZywSbWQ+sMJxjLTAK5s5rAQBZq/xUDylnKfBIVMiPDGx1yXLM0O497J2SydQBoA
         1hbrmf0DGMCWt5YBssWN6DmMRxV0huFrFZJNHY7tA/97xuUK7blLstga+nzmA/8+5/vS
         VXrA==
X-Forwarded-Encrypted: i=1; AKwUvByLI3fJfp+s9cq7qGKvNwDP0vHZQusuuheUzjEbMG3QZpJBg4JXMzOjSOm/F9Yv9styqjEkKO/zmhVz1dM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/1UYrDMqOsTEy3o44PW4Rqf2dBvFiFfbx9Fxt9hUSFt0jI+k8
	vRYa2JeB8Dt9YAOM1bv5pK+jSCgsl417Gqsch5grD9w8H3p/TBp4wg+dJY1kTw==
X-Gm-Gg: AYBFou2gOKcZIUBFD2PUrCG6IxNU4V5BmaVBU6DyX0fFPbgRyEHASStzhf9tm5Jaj8G
	I0/+kmOPRPHe/8me13e4SRtIIRKmR7DI9twfVmq7xiE+Ih8QGAWYUlPJp9pvjWKGlyMIXJ8M8TM
	rQ1Qy0VU2qzluZNOa8s1ehaRCOYKgNGImZrF1GIcTII5AKqIltf3tUJdOAgXvimvaSy7yJOkyxO
	WrVe5yzf+8Yqc/YjM8fayGP9TSGpbMfa9ZZU2VcvLSJ72TjJZjCsVwKO0GCUspltplIDBP7bDP6
	EbULKElJ5MTYbu0Fept2guB4Ea1s0xO8ly56vox496kHvbJo3dcUKbxDHgtauCrpRnektiz3XAG
	VWbsc9TKJxm1LRE6i9w+QAdXxnJvTSDMOijEorU2y8xUF7Ih4yxp8JLAr+CPAdGuem34/O57QR8
	u9pQ4YtbbPGNRYzNvp5T1Dh9NXLwqUKa2aPWgJ/Q4TdTXfMi9LDknQ737sWGV3yFQnifrLZdlWv
	1Zdp+U9Sxi2QXdBu56En+j3ynUtIFTiaamIRBwHtZvAIr2VQdZ02QpeLkh7jUZWbOzyEiub5raL
	KqGJWngWzY2me51gdbu06vqDUNgSQVEm/jp7OVRD6WYwA2NSnwrS5YetF1u3db3Qvl128ME0/L3
	ZjkK4rGRitKtOXWOoydPoh0tptuBzVrhkIScPIXCI02DmCSkvsHVpHNkQHMIAF4eAWa+HXurVg9
	mTqGp2sdLgQvwPPUiBbmJIaQyE6JcuwrjkfC/Fw76lP2wmXHITFBaMpQMiYs6vxMeV32yX9owu
X-Received: by 2002:a05:6808:1304:b0:50d:26fc:e6d3 with SMTP id 5614622812f47-563efbee16emr7279840b6e.43.1793648060817;
        Mon, 02 Nov 2026 11:34:20 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:14 -0700
Subject: [PATCH v5 02/10] dmaengine: dw: serialize error recovery with
 channel termination
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-2-d3207758fbf9@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2

The tasklet samples RAW.ERROR before taking the channel lock. A
concurrent termination can empty the active list before dwc_handle_error()
uses that cached error to select a descriptor. The list head is then
interpreted as a descriptor. Even with an active descriptor, moving
queue.next unconditionally can put an empty queue's head on the active
list and pass it to dwc_dostart().

Recheck the error status under the channel lock and stop the channel
before selecting its failed descriptor. Only one transaction is issued
at a time, so take that descriptor directly instead of scanning for
completions first. The scan can otherwise complete it and start queued
work before the error handler has identified the failed transaction.

Detach the failed descriptor under the same lock and use the queued-start
helper, which leaves an empty queue alone. Clear the software-LLP flag
before restarting so a failed multiblock transfer does not prevent the
next transaction from starting. Keep the completion callback outside the
lock, with the detached descriptor owned by the tasklet.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Fixes: f336e42f73d9 ("dw_dmac: Move single descriptor from dwc->queue to dwc->active_list in dwc_complete_all")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 2a9db9e39f5f..f7ca9da5af90 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -403,10 +403,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	struct dw_desc *child;
 	unsigned long flags;
 
-	dwc_scan_descriptors(dw, dwc);
-
 	spin_lock_irqsave(&dwc->lock, flags);
 
+	/* Termination may have cleared the error since the tasklet sampled it. */
+	if (!(dma_readl(dw, RAW.ERROR) & dwc->mask))
+		goto unlock;
+
+	dwc_chan_disable(dw, dwc);
+	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
+	if (list_empty(&dwc->active_list))
+		goto unlock;
+
 	/*
 	 * The descriptor currently at the head of the active list is
 	 * borked. Since we don't have any way to report errors, we'll
@@ -414,12 +421,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	 */
 	bad_desc = dwc_first_active(dwc);
 	list_del_init(&bad_desc->desc_node);
-	list_move(dwc->queue.next, dwc->active_list.prev);
-
-	/* Clear the error flag and try to restart the controller */
-	dma_writel(dw, CLEAR.ERROR, dwc->mask);
-	if (!list_empty(&dwc->active_list))
-		dwc_dostart(dwc, dwc_first_active(dwc));
+	dwc_dostart_first_queued(dwc);
 
 	/*
 	 * WARN may seem harsh, but since this only happens
@@ -438,6 +440,10 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 	/* Pretend the descriptor completed successfully */
 	dwc_descriptor_complete(dwc, bad_desc, true);
+	return;
+
+unlock:
+	spin_unlock_irqrestore(&dwc->lock, flags);
 }
 
 static void dw_dma_tasklet(struct tasklet_struct *t)

-- 
2.53.0

