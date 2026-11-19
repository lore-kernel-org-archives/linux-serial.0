Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082550;
	b=QPbz7hRve+UJdWzIjV12Q0s59WfDnhEP/SoP9Z8LPFGYxn9fEt6N0/D3WQCM3m2lzBYO
	 DbGpkgvpQOILK4bJCPsBQc7+xyq7TR+vY+nWY6pr4gLwfhKJ8/yUVIL1w7WnDjfkq7Jt5
	 2CwcID6Gl1/jOh51NyHfuWcWCt8bjRnFHLEauOKCUQ9Oi1l/0ANs9j7WSroe6IUBXliSe
	 lZUN8p036vCAMUpja3V4pkO0bjt1BTAvRWF+nmMz8Bcbk+Vp5uQFST4ECRrmP2vCczC0W
	 +I4LBfkekD8lMLBfZLUDR4njgdfsR7JXiY4dZTSbMR/wBuEq43wZ/cuTuIVZd4AqIVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=DijnZkiCvTKZI0X+y0LoiPVfnkpxzFlu2JSp670NsMCMoZ10xLr/EHqEKf5wFFEawfOq
	 j6TxigUQhVkZEecipe2bm6DFOAHQibB8ZqOowyypVSx8J+aXQEyaVo6FEG0htmD0PGUhC
	 44okzWJcQlt1l7ouC18kQEsdzoFlIhv0vc/PvYxeIqK/2Qsru7Pn1vMFQUmkj3cBMLVyN
	 pXHFuEYSqZNu3pxlMLmWc4xxAaA+ebZ3Nq1/p6GKAfCBfSy2cLlDR+ZWCT/s+GgJPh5Wr
	 rrKDjbn5MJ5Vaci3aEZetTva1k6IQ8kspfs41rwB3i0EoWnRsFf8DSOCxGyTLsd6izQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JrK1ZFEH;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A64606A339
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A64606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JrK1ZFEH
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-70b875f6f13so1727411eaf.0
        for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 02:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082549; x=1795687349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=JrK1ZFEHOpFtaoo/a2oCwxsveMnQt5RFF5F9ruEezsTy1vL94EGMT4gp2WTbCQkR/q
         bKFzZCJeSHz7grx17qtAZEgaRZQ2Du6VYubvaxZoj6mtrVtaoS8L+KG/MQ0qLiehpdYA
         fyQHRJsYuC0NbxloGvrh6j+/3Xb6JDJ+89TnfIp1Hbq6Snbnkge6NF4X0PoVmjJBejK0
         W3JRaGdCKuc9eMMyRfiecjkjQlTY7GJN4mMLxmi70wiie+Y+fEWs8StYwDFH/V7I/VIu
         hbKKJFPL+J1Jm9hxeQ3MMEpL6mdV9yPFvheTLDNKAW4tZi1r+/GfKOJkWjFLL44Wu42z
         UrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082549; x=1795687349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=nkS+kQ/tB7w/5AjmqeZybDBCGAL+dcj/zIa5wWV6emwbXs85/4GkSACmd4OYZQuNAG
         k4gpkFGeYifZ6ggW6G2PzUb3i+ot7bxEqNshmenNn8EyAdAdHosCgT0FDpSv5m9gjdMe
         Ra2go0oZIP2aT3bjPuPno9zxekfunsRJBQ2dmXjA97pj/ytdaAoeQ8TBypDSCD+BGLqD
         YjehbtgiO4i/w113c34I0vzBArXkQaZ4+YZbRmCREeRGohe4hKsWRdcr6tOdPRwuoRz8
         K+IpzhkZ1ZQ9zeNYV3FqbVbvVhePgzyUi4o44oEwpuSPunj8HDJLJHs1rGfMAHmBWW/4
         jrqQ==
X-Forwarded-Encrypted: i=1; AL+hErETCzdM7eztayc3axbleMQ+MdZf+wlyGPaebHVsGe6UUpsf/5TJoyI98zF7ST4EXbRlRA9C2MC4NlXJFiU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m6X0tEOvwq4QFC23LQhKsgb2SWlU8Aj8NS3Aj1V6mYbjp5uFE
	fvlimX2PI3q90LSe6mCwmIMbOHa/CmrEcOOUnQ+aJxgrzLGFlaUtNkwQ
X-Gm-Gg: AYBFou0cfo/5tiWj4SuB4pNHEyQhWDjqY/l1DSeKU+dt+F2zkz8flamDqWtjzjJXlsJ
	MPwwzVq/ZbwjnTXLYt3/+D/MezH11OrvbtEcftbxYlrXrm6KQvq9aCL2qOaFPzCWo/ZP2qcTA7E
	D873QfKA4sr2OXT26kEqx8npBN0HeSu2Mzl/FW3SN6oVPuBt4pizK6hLnxJ/Sllii/BT6/pFWD2
	aZwcXrG/KpizsIYSyLBRIDo0lFXbpnkYfnEqBR07mOyHl/jugHAoxXioLtEU0YIeueaZqpU76S8
	D9U4RrA5QbpnLeAPQg7xqYG1iMEdmHtWlyX+4XPXAj+pdaR8f/CSKxDUg/XjDZVkzdxAzErGKvK
	y+77LWMoJSwqvmIHTlJyJlIjtTaQXiCJkoxW0KzO8r24DCojuQ/X+yB4xJ0iadcRsRvXlbM4rU0
	bsXRAiviBpa7qQ4rqlgSa2QGiUX98rg+7HRlivFW9VUUQybhfX/X4wPSRaIFV0gVDTQIuU2b6rw
	kMXIFWc5yjdwCVFFRg7xTf4CE/lbh6DBU+cToPEe1QwFRy9NZ25lsPBrSHYoj7rPz+Fr6EpP11N
	b1ZZ0RNoVAPL/5v0ckQs4HbGMSSMzZjwqLLVkjAxKdkoq7p51X3DJK1jJgpws5t0bU+fx+cu/c4
	49WyZgmyqL04fBzyL1r66cU/hEB+ggj8/TlR0P3+Gom4m3uv0oxLF8xc66DlQrB7wvBAo9UUS0W
	ZMxa1GsaC5d7QHLIRDT5B4Jxx1TXg+m99UaKcDSJ/ku6yh9X9LB57a
X-Received: by 2002:a05:6820:1388:b0:6fb:b922:8d30 with SMTP id 006d021491bc7-71b182af0b8mr4808799eaf.2.1795082549183;
        Thu, 19 Nov 2026 02:02:29 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b18fbb9a8sm3906194eaf.0.2026.11.19.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:02:28 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 03:01:36 -0700
Subject: [PATCH v10 2/7] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261119-submit-dw-dma-synchronize-v1-v10-2-3a737597a0d1@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.17-dev

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

