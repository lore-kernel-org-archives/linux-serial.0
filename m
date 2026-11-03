Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744780;
	b=L15EZJXG2rZSCQIZUEMDtpAKHCdx9a1bRZo89YG83LP3XXBKqKiBSZT2JQKltIG4qDT8
	 SLnbR/qGsECALbju3eRU2/TqVxj5AuCmAvjq0IZgMANcgOWQXPOlE35FeXjuwIEtW0Qa1
	 pZrBeLH4qViaeyTKHjqShEpN8vjnx+SfO/QNNPciy8zAbo/ovIpCWS4miUeStlPIXOs9g
	 tV8q/OTymac9mYar5NMngqNTtmXCCU/PKPzPlDOz5Hr575s7uK+QDNW2Z0vni3+3unh6u
	 4NPQVYzSaC3mqpWYh3+xRd3AnsqdN8GOk3wrH6XTr0fJS7Uq7iDh/oLcGwmR0mDmDdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=rnm7Ji4KCoaoTLxVH/1zbEylntiY88vX2Jlyw+Gy41Oj043I1mlo7C6b7mMfWdL3em+O
	 eHVi/B0TyqmeLevBP2VCL/kY765d93AheRDR1hj6Zs6Sips5k28bdhtFtNuE/ri10eMBr
	 4KRTH9R0HC2/upf0MWERM2ZXmLCs/oLw5sEFW+KKsBoCbKgI6JJ2dploLmn/QujU6MjD/
	 wRoSNsEyxxEA0dd9slxoJmzmMe6oFxXfNA07StNR1h6q0s4DV3HQUDr1GPawntw+4buct
	 c0pIbWebLVvSG55pvgqmjFTz2UWND+mA9JZamA2XJWfNrScAFpEJrBmvaplf/97g9TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tFMaa7U/";
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B54606A334
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66B54606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tFMaa7U/
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4f55a53898cso61452b6e.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744778; x=1794349578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=tFMaa7U/EPvWCJKXZ6ZVDPzrLj96GdU0G3vCTU6OXsFkiS8ic9DdBhM9e93NiUpipL
         u0+hBeddxPHKptEdjYPJNPcM6b1HiJdMGK1iDdsdJNyqkwmtswRYumFyAp0pgSUOzd8t
         OCsGp3isgWHB1ReFTUu/BqDlPxHxAuB7kK+TdOH7hpnR2ZLarblJV/EvBJ+UbCHACsTh
         UiigkxjrTsmr0Qzz6BXt7PZ4GgQWYTC6ArpAk5tUCIwahRnqdAwky8wic5jsAbpYFsDS
         s03ltWCGE+Fr7LISzrztj4xyjjlG36r6biFlqdVeY3Fpn0LkS+PSQeLsb8Q8u2hAoSjR
         8wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744778; x=1794349578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=KNUUHqQsjdwAqZrudwlazioXMEj9BRXwXnnkb3vYjprN7B1aEqStujJGm9PwHgpuhK
         lPU4NJ/5X4woWu2WzXbSjyl84or//tyKugA2nSjLgdUaMcumnEEstYsLFGIKw5iuMkX2
         YFy/vtx59qOh9+Dv6NgD7x5zFio158b1u7cW6iwspbxV6/oBTZNEVUguFbUKDnUiw3GJ
         2+knpD/9BdFOvjCaJodzUB3Jd5TAqKnenHrPYYxXxKMab3Yy+yYx0MRsXqzXSWph7pH7
         /XoXPzCT6fmZ1IL06FxyMHoUvkibmYBijpKB/p7C6liYpxNLmfg2P8rgvuDSc/S5GSNu
         6aVw==
X-Forwarded-Encrypted: i=1; AKwUvBxKf+2NiIUV0YZSZbC6EZ0Y72Mbzqy4/nmBH5QJ1aU0E+eM1aBDCvJ42+GSAKPWCiHIvHJW+IznUwLE7nQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+H5g2pPaG2I8Xs+vJsOlNWggbjq6os8lwh/8bNxx/ZNiKilhtQ
	1J/fvrVdkVU9+qRKPA2BaGRK0FOHwnmqUrdefc258qXxoLRwppoRwFHM
X-Gm-Gg: AYBFou1LvzMkNepbaoDrUO12DHgfp8n2xVXwK8ExgI+DlOcl0IGtAowj1N9rd+nf86i
	b03bO4tC0RNBmGdBm4dj7VlwVZeuZXQI/rV8rI5uiEPvGFNgYsjtHqBXJ+Il6VR+VtiiKtgT/wh
	lSG43u3/2bKfhhnfB34a30cHmESNMNFhD4Y10RTpEqiXMqQnACxXJ2lzH3i1ApzI7X6XrzBbM81
	7dqFIy5cN6b+7NM8pY2mA1v3COOkG99Lcrk1nqJ6XrG4ehljUoECCN5uQRnEBqAZXdgZw576oYX
	oTEWWTV9BGsmM4KmroD2iY4lAf3HF+oEcmBiHJFjVBbCXLr7qlaf5rHP6HXUOB5A/Y1ZEqSV7w+
	z7l/k2b3DTlbjZmLVowFocWzxh2dPZSK1nByo/gUHQLB7DRZMP9ogZh23lPHiunCqe/INQNKe7n
	j3rXrY56+tyG3MPIbHYNqXE661AUY1wZr9doorQ9JeKquEA21jbMwH0XSpkTSlRKkC+Elt0igVJ
	qe3HTOkAVzr1/Ohjkzf+y6KB2m6TsaqVJRggW0ud4swb38Q7LwhlIBCvYz4G/I5/Y0z5A3epR6c
	wldwVSIOPVmOX38IWTVMBwRAGuigllSfibra4XTUwF3KaHBtxRGhxB7RWCJEek7jxw4OwR+48L9
	3QWZLqqp8ItMofd7BFmPuDe/ipsEcLFBG4iDgFTYCBXZDkRUI+pe+RSyp7hPiHHqSRC7ObMyPPZ
	gvNkTKWAb2pg9iJs45HfdEY2gdpYjvt9fcR+fSWLmR6NhatZ6hl4JtGVzWANxNS4vK+M8fCD+x
X-Received: by 2002:a05:6808:2207:b0:4e8:92e5:db5b with SMTP id 5614622812f47-5640de625e5mr10539802b6e.54.1793744778356;
        Tue, 03 Nov 2026 14:26:18 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:17 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:04 -0700
Subject: [PATCH v6 02/10] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-2-2ee0c348224d@gmail.com>
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

