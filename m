Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695174;
	b=CU3uC6ecJLv0ognLjQwezoiu9JaVXXjyyv944hDwMq+mfYHq+1O4lLJkR6PVtX4lJoWG
	 UwGThn5j8r4zkIdN9P0P/LDOnVO0OY1xAa8e0tv9E0p8jqQ4UuyOweeKVq7AE+yZynGQU
	 df5O11XEhXsM3tGnv3XWPvyZdYDFf2FHtE9QsDRPWtp6SVUqRfiGIaHpofBm0JnT5eFqF
	 aHRv0kmkJXgzA+9Es4KdF7CBbvm1C1cnEwYU2q5vZthT1Igr2VEKIMOF9/ZhTb2K2c3Rp
	 3WbpqA8Wibsn6hVuchSP6LdpJDS7f83AGUTHHM6wlbPI/HEspP72qOtSycmlrzcAtXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=KbJm5SGXsdECTH4ZZRdz2rXhZWT5LUE28XcGXGMl8J0=;
	b=jJlDhgH5wJATF5c+j/tIM7HMJDE5Jbyl9mE8FCA30NZO2pERlze1M5hM5uz8AW3rbx+i
	 F5sb9nq0gy893Kz5QLostB8oqwLevaJAclxlWk1Qm1VSOra0ZJdJkpT7P3/MeK1G8JF11
	 4MRo4WLLQfplB8l3o7ku0NIt1Ke6ChFZ8VshKJH9WDezaWULFyY35Q40jp/T58SREyvas
	 Ro6e5fesXBq9AUgyFR+FoKT+hod2QYgh4KYFIFicf/o+T51gCPKxeDMdTdHcjshU2ferm
	 ui+DV6wUinIsWYDY9AVgrE+vswvzLdeuiRRhcnefpjwqlOC2W/XGLG65I+w5Au1TOtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LHfk67pa;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273760A260C
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 18:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6273760A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LHfk67pa
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-843a4ca671eso32778a34.2
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792695173; x=1793299973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KbJm5SGXsdECTH4ZZRdz2rXhZWT5LUE28XcGXGMl8J0=;
        b=LHfk67paldhYAuv9kaDjn79xOy88fVU3TrAO/kbwW0obhlMHE6xLXBCW5C4DA1VdB2
         Iw3znsq3xbanboqW47ChizQwQ1P+jW+7oqaxabGNJsORuLtagLQje/CiEjdwKYyACitU
         2qWZ640MRg0bZvZfhRlqiE1LD7CyusNqHWQt/SXf9Bvx2hYW074YifX4NxL/lfHHWIfw
         j0QrmROhLNGxriITCFflR1/JLkvCptktrFO8569G19CO/0Lec2O9r+jampJ1pP5YSGnn
         vFFigWaIXQmYMs4E/L7/TTU3FyklrXgYlounseFxb8HLmpOhVynKXXELqrYg3y/9HjH4
         4zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695173; x=1793299973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KbJm5SGXsdECTH4ZZRdz2rXhZWT5LUE28XcGXGMl8J0=;
        b=IfbCPvZgwkjiJ9lnROJOX6MIluuLapsvG9kyTY04dM5FeM0TBOdssy2UYAQR7+/SqT
         DESleOUDyISllAsWxdTCQoF8hxxVt2cFaOTHRBCChSjD7mC/WkejW3za/jWHquqI4YmJ
         VxtmUr+kIavrXbyzhwRiN8XPJq/8xwkp6pw5ppuilA+a5J8bm9G6ixsbNcfclb7W5o+w
         avWMGjH9BizW+LcsGGrB6QMzWGmROLR+DTcfAGy/Bu/3QMH3qLBrtaO2L9Wj+fJCpj/5
         J/s+HH3vm6mDydHW0RlRqxAJqWJmmWOjvI6i65+tO2NhYnRqyp1hyD4j2qkjMdox25aV
         i65g==
X-Forwarded-Encrypted: i=1; AKwUvBzGviGYgZKVwU4v4FegxvLXh+mcSy//cOV3MOpaU9FnO2NjZ3AskyDeXD4KfV8m2lfufJzLDtULFDS0do0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMUD7XDT/rx0y17POM4vgRhFPGawlL0oT6fM3Y6xtiJHF5Ymxf
	RzYNqQ35Cb8p286Cul0AHlXQbFbjnMcZGAAy1nJTSCqvQcGX/h8Xpvzs
X-Gm-Gg: AYBFou2jfvAd4TcWYB941fShdZRsDwGPTz/Sl3v+c4mi7k0AGbiCulS7UR5Vdqg4LWM
	nnH48aEmyG3hH0jscX7nbBrmmbWFLCLqr42ISwasj/ekEDX8VmXDgzMbE1SOT0rYec3mj7IMrgD
	ATarxNih12Gmaw49A4ygfuKfEv0hUXKX377d9ZZd7SbZRXmHt3CYaArflRFl21PwBlFEF34feVJ
	K3QloDPKyLL+UEfnqiRhJ5CRmF7Jlq3gtxgCm0Dpg5QQJB8xjYtEG/Mavv1TPuAKScCbZ3nWGKe
	YX4H1XPqI84HuFNT+ypZ+BRJVzUNifvQOrNHZD+tLPQgyhDGWuJPq80RVaWGzEJZeLJHZ9kdOkC
	GcKS6sGDbH9Jo4YzOfzib+r50W5EsbqvT+8bW3gNmCwqjHWQ7YNnibx3Iv1jwhwLPsm10a8N8BW
	f2JsPxWebGVomRq7s3Pa3zYTGPyummwKjEagL4jicsr5D0NvJkX+AW+I2SWaNz5a8yT36Pe2yp3
	2qOzR0rhs+Rk9jExJS9/9Vw//HhO+ecrdntuwjFaRpkNFzYQUIwqd+saMZrztz2xDQ3nuurQXPg
	GGyD0z11PeRGgEfyIQlh7NKj544Sy/pIPErQ4p8XzJJDhah8RlNqVnkPgJ0zBTCN8DVNdnMVutl
	bpWw8beshwwOwuYrGyCKuoGbj9MbdlXpskUFwsugwDv7gWnj7nLJroceRa7q80bdE+V+4ScgOVP
	z0sDU=
X-Received: by 2002:a05:6830:82ae:b0:804:d4b0:a36 with SMTP id 46e09a7af769-84d08f1169amr5063899a34.27.1792695173289;
        Thu, 22 Oct 2026 11:52:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84f7703d288sm536083a34.4.2026.10.22.11.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:52:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 22 Oct 2026 12:52:50 -0600
Subject: [PATCH v2 3/4] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261022-submit-dw-dma-synchronize-v1-v2-3-5244e94dca8c@gmail.com>
References: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
In-Reply-To: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
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
---
 drivers/dma/dw/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index fbc46cbfe259..1df028970c4a 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -395,10 +395,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -406,12 +413,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -430,6 +432,10 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
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

