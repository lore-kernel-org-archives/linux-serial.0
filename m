Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313006;
	b=ooK2hLE45QbQq3jThsE14mwe8i+WpIBmokB2rtJzsyhlkUbSn+rhn1nuA6xScERMG2/r
	 lNA9nHQ1H2hdbInXTT2JaXvXNG9mo6Hgehe6QCjj1owiOZytfK8j8VPNAaIpWGSyMGeEw
	 foNP+42NlDLFjZ5BcD74og2XmH0UjRSSbTEe4Pz7n89dCgLTfriMvs7/L6tN/9S0a0MqC
	 a7erHkW07rFPP6WkuYstZOg4fnKJfEs9/AozhjGKRojBUkkqtJON6EsFM4b0NcwvUan9A
	 NUKWdcbAhWNj1UvKV+72KTXpNglMV0LtsvAmJLIC/PJiGtxTo/cgtpGYi3jSAr+xRxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=yCAhvvfFaIXRbwj4Slp/VrdUH7ygbm1KTvnKrDnSH20=;
	b=ovVg8LHsLK3QhitsuqYeQUvbTBc6R+8rB8scmjhyIsctjbJtx/whQVpkopAu26gO7T6d
	 JbF2M6XlwF3cglX+8Ef8Rs7mp9MnXxCYOc3w/jO2U6l/w8mHhPEfCGPzFMo+Azz/nvI3A
	 mGQMkI3m+RaEwyWnbC9qe/n5jV7qMY+5nqlcEnz8Z6GyRqVEpDAJj2vtCle2KTbmJOr7m
	 jpG8SLecq10RNL8CD2KWbuUFwPF2n9ZnzErebvElckChJtPz70XeYAeRYFW2F4/nwhIyr
	 YNbSpICWGAbkKC6JZI6vSk9iCKgTAlFTK/ir2nghPfuBTpwD7x13D5WlxGzquVhzcOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OxM1ucKg;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27900606A33A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27900606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OxM1ucKg
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-55650fe1f0dso52352b6e.2
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312991; x=1793917791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yCAhvvfFaIXRbwj4Slp/VrdUH7ygbm1KTvnKrDnSH20=;
        b=OxM1ucKgDXPG7sbLLGQmeUDyCJPtiza8J60dj2KfoAsXC3e3up735bPPc1uDnxeyVD
         vnK0PXPZ23856N0bPn0moU8dFPy7NvnEWibSy5TDuHuKxK1dPvDU8yHZcrnEj8E6gr9w
         t4NfyO9fsJO87rUfwicAk6gwAKS6fwpFXQW3qMrOMge+RR66yqlU5A7nalACnHKK9+fp
         0gY0n5gu5jFtkVMNbGVH28o/p13o7LjspXvqKnaM9SQEXZvDmwLZs7RpjAIw5T+5Sx/0
         PY9ypdK3uPJMkon9AMnoC4/YZGeKIQqK213YEyHJtmQ1yFHZ7iuSeobHbDddpU21jJgv
         rF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312991; x=1793917791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCAhvvfFaIXRbwj4Slp/VrdUH7ygbm1KTvnKrDnSH20=;
        b=ioYpNNtk23oRw/gP7U8sJdf3R64iRgyYNzC6kXzIt4RFVohMY3f1d0FlCCVNKdTl3E
         tm/wcIZd7KMQW9vyanP59Q8sCZoQCcj1PE+y7GQkSF2YGyJqlVL+BVIVSjQGSLY7SNKZ
         VsCkgICnTnyyPnGimauTI6cT1XKVzkgCbK0c6LPtv07PO48lN62tToY/YRfVoymLOcht
         alfo0hZaqYsYI1ximpD2zHZ+HmjYDzWwuh1v58yHau8ov4lmg/5KQrdJQ2EGU8mZ1mhC
         upBsvvB94rADBScvuWk6JHaRpAI5TYt03CL+4GtHn+zLNfBi9G9cgH/QvlpodZKvZ42L
         HjkA==
X-Forwarded-Encrypted: i=1; AKwUvBxzsQoq4/RKS5fktQRYJpp7L6d1A3zuaI0wAMz5DgvRVzBWArAHenFg0qMJXtkQzRdFbmC6csNx1iRh6Lg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRYSmn7vuk9/d7dsg5T67XQpjbcwheMWUokfNO2kSu+wXkYuxy
	yZSZUyvTK14OBYLuvu5V5nNuSjPHVvXuR/7GlRPyW3Yfi1XS74FPJT9T
X-Gm-Gg: AYBFou1ResKDaWOGtwi//Oxr4uPFeyzhmX8rLtIv15lIVBEH6f0HgZJGLgxsqAY3gUc
	QwJSLzjjoRdC8rEspFNmTAkSSzjNtBtJWkwAmkQuNaQpvRBkgXnNm1w+vosOFS0b9dGzYSsYwoh
	yJE+lb9XM9wtD7GWnyh0IzMpMSoBtMoxM5CmXjJYWZhikHRm5AplxJCzjEyMy5zLlfJwHew7CyQ
	59UlgqPqVkD/aVTCZxCFDcPZHbHiyvXS8RKxBWg9KGCS9TVx4v1VPQBYDhDqjkU6+SKmzGU9bW0
	qM9LiGU0qxGXurDWHcLsHhQDsNiBqZdbNLWOJwc6hKmBfx/N0css3qz+ZOKHGztzSftn6GYc7ZQ
	t7ZPN0V+iPIKiik5pdrnRPXYW3un8ayuHqsU9npvdG2+XsfPHzZAAaCXlDaUvfgkpWP3s1K+PCt
	YlegE55Z9Vq/pjMYbkFTmHfuGmuhbyeZoPUJl79jfCOxNnQJ0PPEtCTh2ELXT8JKTejs0tgozK/
	1uOmL6/Nj2NozMtg5IWyJ6stDY3MxcPOKzZEajkzlNTIbP+4ztwT9N3cKgAS+h5REh9nm93FU/E
	epeaP1VacYKwYW2J8PRLw9TytI8wWBdOVxQgVr2tFm64dWp7ZIQ1uOFT1STLn8kiHq8qpaHL2MY
	xrdjAKfs7z7YNeCQ44GXHid6/MxIUA4GL5D3W3U6JbnlGV0lsHL4yetpdHo5+yklZIW5YWUE71A
	/qmwIsgI4r/jmXjCunPkL1MQ+KFxyCzb73FnqqlCY5jJ3l+Hu1FupUUENO8HI2grEwot/LUjh9B
	Q==
X-Received: by 2002:a05:6808:3189:b0:55b:f88d:6ed4 with SMTP id 5614622812f47-5640dc19ccbmr440937b6e.22.1793312991208;
        Thu, 29 Oct 2026 15:29:51 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm236130b6e.2.2026.10.29.15.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:29:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 16:29:37 -0600
Subject: [PATCH v4 3/7] dmaengine: dw: complete cookies before releasing
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
Message-Id: <20261029-submit-dw-dma-synchronize-v1-v4-3-fea447d9f285@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
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
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 51c5460b4670..1f7afcd01565 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -236,18 +236,17 @@ static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
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
 
-	dev_vdbg(chan2dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
+	dev_vdbg(chan2dev(&dwc->chan), "freeing descriptor %p\n", desc);
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dma_cookie_complete(txd);
 	if (callback_required)
 		dmaengine_desc_get_callback(txd, &cb);
 	else
@@ -334,12 +333,14 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
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
@@ -441,10 +442,11 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
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
@@ -945,12 +947,16 @@ static int dwc_terminate_all(struct dma_chan *chan)
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

