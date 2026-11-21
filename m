Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295108;
	b=GIVOW2Q4uT/JbR+QCtqLSdsuVOpI9thaFGWoZ5Bng7mbeDijQu9RDWxw6quGLB3oeUcf
	 zrvVo3tcJ6rzz7HL5pfvDcyCQtRCqdl52wdamuOz6rxyh/H6P4/JePwgnpEBTCdB1/OmT
	 hvCai6YyReqzwHk91RKkUFJpegpXZnBRkB0+/kuHpAypJvHjJb4pjrcf/6KfKESA3O5xa
	 cCRgdPrH8XUQbORGNfjYuTsPEqToEFUV0yVN6apyA86U6D8hdMIF5XP8TAjvIQS+RtgYh
	 mdwWYjRHfr14U3OXLE8osCDyyiIHPOFaeivSEa2XOjGCahxUzv251Tc8TBJq9/R8grg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295108;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=wmAhG8DTr1Z+B2Zu1a0dqxc1ixeeYagNIV7rPFruZVdwE3p0zh3HRobCTe/Ix5tqoI48
	 WjvPLMAIRxzEOF/nfVTJ0T3ojFPA1iRyH4xckkiG89iDcsgXVduEtap75sj49odig6dJh
	 O8W/SeM99DLK/2N6Zacp0xq95Qm39sCb1crBzETpu1/l5K+Lp38lO8fQKfuEzHyGMrA7N
	 bRLzth6sMNCq4fbs0pq6DmYe0zD5HtYuXGzhJeJyETeN7bX6+28iP/YBTxSjw4IGcCx3k
	 QFNl1xx4Gk5Cu26YyQ+Go+JpsI2/zn2c08XhCDmt3kbdU1Iiz0xgrfF5Qst4nEf6yMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ScglfkVr;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F4606A680
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 21:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E18F4606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ScglfkVr
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6ddef424972so1719326eaf.3
        for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 13:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795295107; x=1795899907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=ScglfkVrQoDBqFhOeralbC4w/qT4T6PObOz6mK+IdCelxDotSwRIhwn2xFhIq58UCw
         9Ws9TLsKxgZ+df5vHvYjs7AfVWtkqkmO4z5IYuDMwTB53bvSWCWrm80PVAD8qVLFE1bi
         51aAiOrtNxJrb//NaKrtnDcPW2DSoWag4FYoSMSILeZxKZvwxDKAlpKCqWzFhPtciMvl
         2um69p/pZRns+nP59bF0WvIurw3GI1OdbFyPBnYiXd1Vc2FifLWKuactqr5GgX83VGxv
         iMDbEynITUiVK78dkIMLSTi864Jh9Lbw6F1+P+vkJ7DAZWwCM1maohG/hTKi9roYkkRC
         N77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795295107; x=1795899907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=oW2cJt5YKpnbwScnGZrNHIgPR4Wk9XX2sFftCNPJ9yEAKuHNENpyObFkSiZ0GkiUBn
         yZyIZH2qwDtr6JOfmLsr/av+USocKaXuLN3pBWhfZq7nsrm/cTgzryxfH/XAs4aX13Gj
         ZIqbvyD1BHxMpom80t+zjIKdXsicdW+2fDT2hd1DDK0G+KbtPwBfMkBpZQH9/tYREHYx
         LdaGddz06dxzjzesxCRpJBXBnVTj3hMzRQH6fjh6lumilD0Hgw7jVnF7JYLymKDA+62g
         W1ujTgsi/V+hiAmQR1itfkxn0JLLKb7q3pud2e68+YeePLtvoe77J8+mBvPkktPYbqdU
         ZqmA==
X-Forwarded-Encrypted: i=1; AL+hErEsxuq5WIscLFawnR8RBa75HpgnDHxrTq2WSAqvgKdYGZZucYi4YtnYYqjMHmONsuqPuroCMwWuwvcj5+Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rkRRmANZsIy+0VeCENEp4FXhv+v7i8oO1NRPG9lU3geJ1XoBD
	X93qDBKH6qtZDhkjvcKuV7Om4GxX9ZBGSWUnjZDYbH951lN6i170xw71
X-Gm-Gg: AZFdTZeNtEMECrHezJ+7pHefQbSmtcTpScumMJfb3VhsDUHbuerjzHQ1dkRwKs+hXIl
	X/d6hh17bZ/OeERub10+YsZxQ3fa/lzrJC3gcytsNW9P6Mk13bOx465zQAqW79ptKX4rL5NPnxG
	aQbljgimchtWnK534WyQ0ul43KUJVt2theEcrM60k/BWAwrZ6iXSQw5DvgLnzd9aykI0spEKsD9
	X8ORc22CrJlubJ0bwMkZ0ETyquoiUj9y/z6UBwxO/3KNoZUTT1eqR3Ird8tn7X/A2hgjL+4yNMI
	E80riuMCV+Y69FD16bGbJoFyLXPEn4tYKzUUy4v2tuxa9WYYN5JwwVcwvydjRDzT35WxcZkJ06+
	wR76kkha1SDTQnpe3+rKH2CY16vL6RboY/C6LmyNJ9E2OHpAETIqHqoLFo+VCt6QDkC7Gb78HCj
	/QrAYCpJ7uqYPcrB2OVu9CXIXFv1Li2FFwHDaY4xynJl1IbnadhZNKHKmss4cHn1UQ6VjeBBnia
	pfWiSyyEXCQv1EBhj4/NncDeENrr16P1OlpLZ3QK4B/XPUfitzubygzdrR2r/gwx8g2J2cJdWhQ
	VIl+TP7k/HXsH8hZJKWZq4s0z4L1XKP7+b0W8aeCALlmE3rrFt2nzGkXZT2AIWzQm/nMf83Rxfh
	wij2GDCKy1AvAbfNc4nIrZFqMcrR8heYMe4m77NbyVE1X0WADxtqtXV/FdTuZuYvatITiiJcddX
	Vnbl456CAIx3jk7Fg5cJECaqjvwdBOiCN4Xr5s9/uSKqwEtFmcTyFa
X-Received: by 2002:a05:6820:5081:b0:71a:e645:ddc3 with SMTP id 006d021491bc7-71b39483a3bmr4673731eaf.34.1795295106782;
        Sat, 21 Nov 2026 13:05:06 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4635728eaf.13.2026.11.21.13.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:05:06 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 21 Nov 2026 14:03:17 -0700
Subject: [PATCH v12 2/7] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261121-submit-dw-dma-synchronize-v1-v12-2-f51eb635209d@gmail.com>
References: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
In-Reply-To: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
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

