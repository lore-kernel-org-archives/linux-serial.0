Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744781;
	b=m2MQCYGXdIf28UYGAGyKctCeRotLUtL76Pkwdej8Yz70/GE8BrvrpNgISq+4QaHcPbGd
	 tyj6pmNXhn1rIzw5aA1zE9u84t+UhYyOIJR0m9sGaMHQEcvLmp2t2MGjj0oyZaSwGy8CC
	 VwTRWPHFqdW1F/tJtRkj5JwD3JgtwSrD1x71uwhnuWyhOivyjpBzs4Ib1Vfz3mIYyjre6
	 x6L5bMFJ/sG4jPNUPSbCsdThjBSl8YUbMu3pLpabyZDGPWFLWugRrXnaFoIBF4gyl7pad
	 sF7nRzj2IMkcdGugXXzstdGxlx9PMfq1X+BSycfid7udDQ1aCmPHDeUKsrzlkJDiEQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
	b=m+XK7UIyTmnvx7qBWQYR6qUZKGXMVftJ/wCm5GyQXIIvvk79MlKhKyMN1jsRxXh1Ne0s
	 I9S9ZobXSGKZ/SUTDJGxf/jd9oC7yFZhuB5Z48zAL0ixR95aDgfR7gfII5LYynbNKEQNy
	 v51idWC+MxMlv1FHPglgMJO/TenZyDlTgHoEx825kmmkDnSPWE6UF9Pn2o/lXwU5eyjNw
	 LL+JKcSmrQXNX10uThuJYsAxYBZ3twRjcG5slTyjS+EHGjdmpoQ7jLXmSmym/wcdIhn1h
	 +ilKdiwa3EKJz48zmH+3prCimL3x45b4Elg5aKMh8CxkMHL5r5+tsaVG5DmeoAZtiMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ye5kw4kj;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4CB606D818
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC4CB606D818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ye5kw4kj
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-55e02e89f78so41341b6e.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744780; x=1794349580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
        b=ye5kw4kjGGe7+/gf0E6QUPsAkFR79TW0mqaYRgXOAZFGmalCnrKeb3pR+XCwVu+Nw4
         S32jdRZj5zVrsnrHFqb840JRPJLku78XABiOX0OHJ2DXAKoIu0AOXMjIeCxa5aMAskds
         tdbpTWp/v8WYA2WwWEDI88oGDzR0QFsPSYWfcBcYYoYivSwCs+n4vzLSVzyVSMtuyirD
         t+wrPv+Rr1M6UdYU8L/dj+8EkZkofMtDwAK64Y220j+916bc668QzPM71a0nV922c1qv
         sN7FrYFFviy19miUif0fByCCzIy4mZR5Y1f4h7SUWEnntqxJsGmEB8iXSLi9ndOV/Mpj
         6KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744780; x=1794349580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
        b=FZl0zJNFyM6jFY+nRJlgDSmVm/Ez/xfZaDuSvUxviEfquLHWp9KI2U6Ygdplcc8BDW
         zrb0hfYz4OWQp0Llp7hUz/2R6vUaWpRmmfMELIJ7i/sn1Z1ZL91hvCS648rkMyeuUN3L
         KaDaLFnPgq0854iRiw8t+btuM6uweEwukeTAnDkI723TEvZv17V/5iF28bI/2NN7Tac2
         cDu09ContxAmB19Dq603MCWctOPBhjQZib3QPyBxPP/PUzBgC9amLYK7WfzY19I8hVO5
         u2CxLh6UTsxx91Bc4ocCxALoAUbBscsbbmdlTdUxz5ffdFZ3d6UOkxUZRmbNSNzkHqdp
         S8Cg==
X-Forwarded-Encrypted: i=1; AKwUvBztdoMzDA7LBfAjdCVyfZs4FKXjRTKqvf68tSCtdlCiqwbilijjkzjBKsNE0qFqmqH24RxWlZB05p/D2Bg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AwQP3d0D8lIKyMxIhKN+XyKFEMS9KFIzIUryfhGWL/fF+18jO
	yMAk80M2wWIh9Nszl6cuws1zwhW6M4YAQccgx4kTVGQh2cU4IVhcYEQG
X-Gm-Gg: AYBFou20vkxVU6T8r4/TvqTefxhgBzgT6y4HKMTnp6p0yIJMGnjnxi9UDKz6Q3Gfynb
	hfTQe1gQCNJ15FS9i2v7K8TCco6tDWvNHzNqF8tm2BIf2qNYbzSAPF/El0dNkD/Zw+q+0gJP10Y
	x3EoR9ZUpEhqhkYmI8AtLR6ht0/KSfqV2tUAh8HNxC3d2wFkQ38KQqt1VrlmFHcnUZwJCgdTEM4
	hzDOZT9H+3kxm2xL2xIoInoS09BU3CNEnDPIbJlt49PtrJUHv/bZn+tNsXpJ1OJf30rhmKzy+fP
	nnHMJd9Zme5WstafaCJGRS6TOt1zABtBuOXb7cAHRwaQ2u0YFh1BlOmGDx7ZeOBINz/TEPEqDXX
	8Z/MI862alkyOcnwGrInz7Ul/B1glW0yGkraT1xhS+8l7qJ3rfxhIMBdG/FtecpSUWCS/TVhJzk
	xeIIf1cC3uUphUL0zwUkfre35LZkYaGR2MxXaRR0hoeYpfrLdtL97Qg1xmqp5MrGbadr9nvwYo8
	4aCftQCcoV4+/t6fYXKWlIUl1lGV3fHBpWH9dvuk3tB7D16+A9Tq26qYEbMXBoPylNmSrtjUXzd
	xtGXLrYD887lcUOkSMJliHnIoDIcYkeNbkndZYAsRrxQPSY9OvfFVgn8zKtvLaRC2dO8e0YSm22
	TeM0/PLl2+4kwWBhcaoV56wF+kvtZnL4flS6cwe+UckE/EbcQp6S1d56dGSN/LJ6+5bmAew6sCl
	BE/9oPUGnN/HZ3BZLvHJBLWZw2197XkbMGIlQIHjFtOMaf0A4xOmY=
X-Received: by 2002:a05:6808:1828:b0:4f1:6ab6:8fc0 with SMTP id 5614622812f47-5640dc2923dmr11066087b6e.15.1793744779632;
        Tue, 03 Nov 2026 14:26:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:05 -0700
Subject: [PATCH v6 03/10] dmaengine: dw: complete cookies before releasing
 the channel lock
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-3-2ee0c348224d@gmail.com>
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

Completion detaches a descriptor from the active list under the channel
lock, but updates its cookie later when freeing it. Termination can take
the lock in between and complete newer descriptors. Completing the older
cookie afterwards moves completed_cookie backwards and makes an already
terminated transfer appear outstanding again.

Complete cookies while detaching descriptors in the completion, error
recovery and termination paths. Keep the active-before-queued ordering
when terminating so completed_cookie advances in submission order.
Descriptor freeing and client notification no longer update cookies.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index f7ca9da5af90..2d69fab06601 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -231,18 +231,17 @@ static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
 /*----------------------------------------------------------------------*/
 
 static void
-dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
-		bool callback_required)
+dwc_descriptor_free(struct dw_dma_chan *dwc, struct dw_desc *desc,
+		    bool callback_required)
 {
 	struct dma_async_tx_descriptor	*txd = &desc->txd;
 	struct dw_desc			*child;
 	unsigned long			flags;
 	struct dmaengine_desc_callback	cb;
 
-	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
+	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "freeing descriptor %p\n", desc);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dma_cookie_complete(txd);
 	if (callback_required)
 		dmaengine_desc_get_callback(txd, &cb);
 	else
@@ -329,12 +328,14 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 		/* Detach the completed transfer before starting queued work. */
 		list_splice_init(&dwc->active_list, &list);
+		list_for_each_entry(desc, &list, desc_node)
+			dma_cookie_complete(&desc->txd);
 		dwc_dostart_first_queued(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 
 		list_for_each_entry_safe(desc, _desc, &list, desc_node) {
 			list_del_init(&desc->desc_node);
-			dwc_descriptor_complete(dwc, desc, true);
+			dwc_descriptor_free(dwc, desc, true);
 		}
 		return;
 	}
@@ -436,10 +437,11 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
 		dwc_dump_lli(dwc, child);
 
+	/* Pretend the descriptor completed successfully */
+	dma_cookie_complete(&bad_desc->txd);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	/* Pretend the descriptor completed successfully */
-	dwc_descriptor_complete(dwc, bad_desc, true);
+	dwc_descriptor_free(dwc, bad_desc, true);
 	return;
 
 unlock:
@@ -940,12 +942,16 @@ static int dwc_terminate_all(struct dma_chan *chan)
 	/* active_list entries will end up before queued entries */
 	list_splice_init(&dwc->queue, &list);
 	list_splice_init(&dwc->active_list, &list);
+	list_for_each_entry(desc, &list, desc_node)
+		dma_cookie_complete(&desc->txd);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	/* Flush all pending and queued descriptors */
-	list_for_each_entry_safe(desc, _desc, &list, desc_node)
-		dwc_descriptor_complete(dwc, desc, false);
+	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
+		list_del_init(&desc->desc_node);
+		dwc_descriptor_free(dwc, desc, false);
+	}
 
 	return 0;
 }

-- 
2.53.0

