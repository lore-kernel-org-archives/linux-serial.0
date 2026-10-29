Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312995;
	b=Hpm17DvkG2Wgfquk5mGHoDraAbpc48bPxA+dIDcXko1ddXbv/YohBuuPHaVuJZGQ3C48
	 WGfGxJzivCoe0uWAcYYIKzPVjxzVJHah9+EbLOmIjKTzafUPz3K3O9dLoa7cdbzP+UikH
	 r03zIjiVPSiaLp+BuUqRMXpHZeLNjMHsaAW2YCSX8noTh3BKiciG+/Pl0BB1IMN+YXDRS
	 H4edHFA/65KXYc9Zm3gMVWxVHoAC+zHh5v9ouPG1op4CTz0Or4qsxQwrbLYSWkTmMNOJC
	 8Vtu0aorbsQBvJQ0NIHQpWCvN1xe7pJ6XK2zH6mwSj1FubPfX0FMFIgvwWD/VI158jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=94WZMClHJfI/hK5hnDLaJYjY1fIJ24YVjNi0D7Blgz4=;
	b=33IjWxg3mrV9VGzn5lPE0umNrxx6AukrK11n7mpAtMEhT8io0oMr4QyyLBgo9l5wOC4z
	 ss4Kg7k5sI5MP34r8v+r/Brd7nemy+wKUMswzVKTGXupBPK85sWa2Zx294RPUThA4E1ht
	 9kM3P2Vg+Ppqyl83lnFmhEQ6W6zdq82X1r+3kHzOrBA8OKEAzHa+E9kGcecs5ittwXubY
	 0i/TiEiZbTNeQxQS/0bcf8uiM2VkrXDR1ypHLg+qQ3RvGbwCbmFeOXt1IoYhQ695NHW1L
	 yW0j1Osj0yNGlKIfjqsQeOhBzfgUHxk4r80kH8v8vVBIXg5v3PPXG/zA+bpqCPM2NGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JcfI8QcX;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEC7606A31F
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEEC7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JcfI8QcX
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-84a248254f4so122254a34.0
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793312993; x=1793917793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=94WZMClHJfI/hK5hnDLaJYjY1fIJ24YVjNi0D7Blgz4=;
        b=JcfI8QcX0MkbuJpYSDzzNklIPIfn0nH7EJu8TYdFgebu+YQVrQhDw+mvk1wGbaKMGq
         xXY8+WzzD737OMw3GX0zgsKKqQ9YH4TuqEoT1YoDbARN6o1chKnJcJoPFErnm+vJ+FSm
         mZ9oUf/MyGxkQ7u9HVFZdxFYzHEVrB9+L31XZQKFeX/f1nZAj+yXbzHI+oWBCQBke45s
         ceFmyKnZfwWgN3YGJP+6huiuqz8HgijQwNUpOeyOEvATYJyRFxub0h0P59AjByjU3Sxg
         /sfcdJ/FPTo+xawFPEj749PiJlPbsg9E3yRB4iGMhZpW/uN7xGBhaqqoCq4yVJUqjKXs
         hntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312993; x=1793917793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=94WZMClHJfI/hK5hnDLaJYjY1fIJ24YVjNi0D7Blgz4=;
        b=Ah5HGUnTakFS08cK5UfWWm1pOY7dV0X9e/4tG/fgS4ovdy9XUjtvnBDU1EsXy8Zx/r
         J6gKBjlYR7+/nW9N4Qr2JgldNVL30/m6pt/GoXtKCaa8hlfVwwbcxSBJanw/dI0pQ7L7
         OcM94VQRc+WQFRKTyyEEwn2tHvNTH//UyiWeHXezqC0aIFfzIcFkX3/75X3D27P9lWbT
         kZnybt44VPwUhh+q8ybJfYoIn7Gwv3jt9mLS392vTVMlbTqjt+kHaLnj5p+XQB0OfP5Z
         g88CzMi+o7IpBzDoEwJtKiU1mXEsIrSobwpEebRQFyXhPuKwnpW9cmoKIPc+4/pIf19/
         dMHA==
X-Forwarded-Encrypted: i=1; AKwUvBzpRxLNdvDlN0CfjNF6SBx7M6OrFsH1j70gBFcJ6YaPDPzxQeM9UDjlhX5BrIYthDow8vG+siLQqYeJY3A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFu+7IcfYZUPpGwSDzDz+hnCcUuEx4X+RVjG3z82JSOyKDzX/T
	aeO506vVf671j1QLFR07DCmDGwG26f3Zm4a9vrvB9mAEWyuyeHosEOO0
X-Gm-Gg: AYBFou1brTMlZoS5P0EwPmpPXlkZNx7K9JZ1+XRsdQfkXrGLYzVWdRRoVz2jp+Nv6if
	EQ056yeai2cnghLHBuEakop9p+V7eOEekEDBiYpHqjNFSMpjkzW9KNeiMQc3RSlAzAxT3rPrncF
	3Kw/CVqsjQbwt1xqlTu3z4TjlKujjMOXMQRbe8q+eOOI2+ZtnYZCk6O1U0Bmj7JBE9Kv4ilRJzY
	S8YauT6Oqoqtyk/mbDeWgL++NklcJEjOlfMGSG8Rlc9e1EIFl2huAvQJl7I4xME53Xqa4YtAMrT
	0zaXg6xmHs7/KFYCQQAgxJOh+n95ylwQj8Vr3w0VyfG3DFYGw/uZNgkIt5NxSsTL1/zR2ub2KI5
	kbG07SsreStptE/PCgGe0hYKS+m1fXrnMzH4CcaThsLddHsqWGvyxikoI/uKqIK195Pr720p6hR
	5SMuQadZwbrTOv7G8kL25b7prUt/QZFGT730/v3Lf/5/H9zxt8qukkgHmuPcV+Ru3z1N59KMEr8
	I5sT9JOjOHNLRi/NzvyRRieqMNLHXREytciYqxAhFhsCZ4ag5O5KTHv5IzmHMokozUDt0WkJfcd
	7bWrfZHpZQ8Nl+pHTlfdOI2DW5synC/MKiyV0mmNiaTAkCzEtmKjymgcabHIPzgSE9f1JK4nAyR
	54/YYA2mS9H17VQYxDrre0x4lKDIRYGcb1CigHjMqiYcYnJ/e8qNu+RzYR4kWiECKcB86+wYlDq
	uq1AZzDSC0kMCvRlNFG1z8MHcyP5OM8uRI8KUVeVFOLUrvyNhoDSfF
X-Received: by 2002:a05:6808:1244:b0:510:7dc8:5ff7 with SMTP id 5614622812f47-5640deea651mr505285b6e.19.1793312993474;
        Thu, 29 Oct 2026 15:29:53 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm236130b6e.2.2026.10.29.15.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:29:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 16:29:39 -0600
Subject: [PATCH v4 5/7] dmaengine: dw: drain the tasklet before releasing
 channel resources
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
Message-Id: <20261029-submit-dw-dma-synchronize-v1-v4-5-fea447d9f285@gmail.com>
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

The controller tasklet invokes callbacks after dropping the channel lock.
Releasing a channel can therefore clear its configuration and disable the
controller while that tasklet run is still using them.

Disable the tasklet before clearing channel resources and re-enable it
after updating the controller's in-use mask. This waits for an executing
run while preserving pending schedules for the other channels. Have a
pending run return before accessing registers when the last channel has
already been released.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 1d6419e1cd3c..3bda85adbeee 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -398,6 +398,10 @@ static void dw_dma_tasklet(struct tasklet_struct *t)
 	u32 status_err;
 	unsigned int i;
 
+	/* Channel release may have drained a polled completion before this run. */
+	if (!dw->in_use)
+		return;
+
 	status_xfer = dma_readl(dw, RAW.XFER);
 	status_err = dma_readl(dw, RAW.ERROR);
 
@@ -1067,6 +1071,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 	unsigned long		flags;
 
+	tasklet_disable(&dw->tasklet);
+
 	dev_dbg(chan2dev(chan), "%s: descs allocated=%u\n", __func__,
 			dwc->descs_allocated);
 
@@ -1092,6 +1098,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
+	tasklet_enable(&dw->tasklet);
+
 	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
 }
 

-- 
2.53.0

