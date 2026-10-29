Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312991;
	b=fv673UhN1utx5WGnT/UW8ZyUo8fLARFOLqGI8UeqOrj9wexkw98vRUIJpBraxaEKeiwy
	 sd9bmaT7EB4XW/J8JUXSG7iVryKmYLfk8mWMJECbR4H6uiKSTuzvpTmivaUAFYGWTqIBI
	 mQyF7UVQvMI0Ap1wxeeTTO9dkfAQ+57nyw0h3FwXU9NOG17gCbmu6XDpt1toZfaYXqN99
	 t1IVU2PbUsnlhCq7A34ZWVe0Q79Nsl3WnSoxJsud/sRq8aVhpZZMfbgtZUopkoMy0v3tU
	 SSJl91pYtNGsvarxnI/o9hN7oJ0RI43zqKvSRPvl4NGev8Pv+pUL1uGtM7Dm1FleL+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=WfY8c5mvIozvo8fZqoEeqzCcOy78ENTaP61rU6ASEDE=;
	b=maxJnszkpwUAIoOQOx8L+BTNLs1vRhQV/3qikCLwd/Klk0/mzCGBv+ufLdvbk12T7f8A
	 GVKvgjuAAeEM8nm9PurxtdJPgmmjFznD/jEFtYGK+yyFAZUhDGZF2v9Kk8X0Sp9MHye5a
	 hPzFLtENLIz/gssWig8yZMM1Wg0Oxb0vnIXbZ4vt6r+mQcy/tEx+I2FYN43ie4NxBEJt4
	 IQPMAwuqlVnkyqtaSmVtObeatQTzzyRPABvL3C59qV+MjolXWHNpuCFMQEzSNRDC5ufXE
	 yfPOSygSXvqXDPJCAyojjXX4M2c5lJbjZp6UzZFpaWzd8xsgtHr6m6LCLwac3gbRxIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCKII17x;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC00606A321
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC00606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCKII17x
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-70059e4dab6so39617eaf.3
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312990; x=1793917790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WfY8c5mvIozvo8fZqoEeqzCcOy78ENTaP61rU6ASEDE=;
        b=WCKII17x6k3IcI+BdpSh5/L0F4hXyUAX01UzKcgwftNpct61Eqdm9jgKeNlCrYcSVc
         +yr75ydP2Sr67TGzDUdc8rUUsA6F2LUsru1XeaXZw9klt6XiRTwbqxg536IH5gEpp9WZ
         ePa1u/d5DZnoN9NtxkDpnBokS4AJ+2WOrekc+DoaHTORwdFb2OvMl4DzlMaEQGgZFFqI
         lnTY0qL+2ONhBtO/XbAF6Y2zjzkJ+T3iIbceA0DBVf27DlzmV+3HFaxE5faRTNSmnHIw
         RleIb/7vKJ7E4nGSUSWo1UpCni6cG75JxbCr5U2SOcMmJD76jpEyxxSE3exstuS5B1yA
         mNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312990; x=1793917790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WfY8c5mvIozvo8fZqoEeqzCcOy78ENTaP61rU6ASEDE=;
        b=MqhY/2QzEggqG/BBzYwurG+KY0RVHyVax84vVVPiM/wexZBfvYUo5drE2DRV7C20Wm
         +YLdQmdW+Y3AmNZ1JMgn0FiVVEDb4ALjoZAl+XRxrQIncj3GuFsXogOV9ZherIV29pgG
         h0KwZuTVy+VbEOnc6anD+N8iZw8ihG8m+Q4YkMoTuzqAIG+N7jLcOubOl/zLcJKuhJ9p
         FBVw+3CfmNt8H+rZG11rOKi2iW/WMspmOYqftuMKbhfT6gM5QkgTYP/0GWptuXuSfIDo
         dOS4d3bnQHOuvOKIZham93G5sQ83wWa1S7sEGwSB0MZ3d4fUW5wMVPdW76X8xB0cXXjE
         dOfA==
X-Forwarded-Encrypted: i=1; AKwUvBy08uy4Mq/WWKTs539JyqeDWfJ6P4X6Vi26Oj334XJEE+n17M5M4HiNsIWAGKxO6BBrWSs9kMy4A/i7iOQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7nqREXoBjyXJgrW2oblCKVDP0l2FC26QAWHVDDmQGW1dfhl1x
	j2hYt0I0QCHmF8Ji/OIdJkCEgSlcOaeM2zqRKgnVB4UKVeYmfugW4xJN
X-Gm-Gg: AYBFou2K8gxK1xcxvh0nEuICxYGqTbknq18K6bLrHUli/r2CMztWjOvFBeHsH/bXaQ3
	DnTNE7oCZn9ySntxsLs1mMdJngR2bIA7GDS8pyjx3zcZclPWIoFCbcLkakO0mPHGCdyZHz9dYKc
	QXZBgOr1dwxoNah5yONZrtePL8HKQB//bRg0tyPscQGQwE5ah7pF9Hz+TyGoQulw60oMTxhQo2I
	AsAkd4jkD3FjYUKGOcqhalBbKOKUdIx98sv4I9HSuomBoEp3by6KQsjwtf44CgCDrEysMOPAVQJ
	XpiojsHtNR3fUvLZ6IDehpb8L0Kratt9d62DicHyMxHd8gDaNDHj2QoQTBhgrByFbrBcTbUtZDM
	NMS/M1+3RM5FctZ3CNX9iAFPgF6ro2oLhOVVXLp8a2fvmuyNpYfuo6/fXe/Viajhjw1vq2w75JT
	+OxdEvzacfwBcLJjSfzhoM15740IVOxX2oLL8dL30kU1SrCCotsoMjfBuLdbKHrBBC3Nq78JcUY
	DGxb2plpMbVhQ7zw2qF4GKFtTCdIJ7M0c6NXBAwSg2WzWjgJULPdb++512AmoYWRhTiyzzgwGBw
	0BTvyy+2oyl5+bwvMiBCnMJSMR0tIOv50wD21hgmryPO/qzBUMEKW9g7lxvqSmJs/lbbbBU4SWS
	+bEsvMbZRZUk47mGrH/dvTNWffBULiciAIha6PWPlqh4v4cvjGiql11glqyAGUOZdyBkqv8V4xI
	qhnT5u8nQmpTkVUNXkrEsmrjEeXLt6uiZi3zip1Av3Lk2woRTjyQ77Ck4kX+qnMKY7fW6kyivUQ
	w==
X-Received: by 2002:a05:6808:c40a:b0:4f6:243:cb9d with SMTP id 5614622812f47-5640e048f30mr442523b6e.61.1793312990244;
        Thu, 29 Oct 2026 15:29:50 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm236130b6e.2.2026.10.29.15.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:29:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 16:29:36 -0600
Subject: [PATCH v4 2/7] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261029-submit-dw-dma-synchronize-v1-v4-2-fea447d9f285@gmail.com>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 07a5f5105787..51c5460b4670 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -408,10 +408,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -419,12 +426,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -443,6 +445,10 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
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

