Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727184;
	b=R8bYiW4AOLe65ygJE9DpWtq7DU827rMQRTicd0aJ3kWcJrGd+KLzAb0nv7MmVgFAEqbf
	 k6zSKcU0r1GdJesLIHLH4JRc11PBiYIxIMCuOXwpOL5Ji837IdzAPgVTa8tTBwgTA6s5v
	 YB4Na96lMqBw4R5ZIvUNg9rCh4U+xLlvodOo1JAp2A28fPSGhfWggAR2NQxbYtS6OqS6e
	 Is39E5HUwW+TJn1eWxjOzjr0WLoeURjUrYHKArp+PMTr+6yeBVLn+Fagux3zBWRM7qkxg
	 2uh0C9zwQvijDblbHm0R6uy76mQ7IueSJbw08gyL/yQid/9JG6XgK74UrChOLxFh0dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=lWAhURQCLtTut6FMMnnHr5k7wrt4nlJkfg/cCZyzixzlRKa/3SGE3pDWqGbZKCLb7Rkv
	 JaP7W+/W/vw4qI5dTlH+jhmbnFHceCV6ZR2DK6XC+qmqFlDujO0jTKCj2+jZFcqlfIEaQ
	 TqpzDBDXVxSkc5A0OpXtjQo1dbrYOjOcgqZSIbLFXQXlDn42hAtlsCLOznh1yEOU8PQy/
	 vvvoGiUzY3PTeUly1plhLVZNIqBjTBTa37Gbb0gT0keDFzN7mgW829YBqImBVw15svu/a
	 xC8xNRlCAG14W5DJPNqba25I9HQ9jlAA3b207vsYmM3WGeo/xhB+eZBV9qPTogqstyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xrz58Soe;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10FF606A890
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B10FF606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xrz58Soe
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-703be215729so765055eaf.1
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794727183; x=1795331983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=Xrz58Soe6mVRrL1DqwdKRygaPBSGaJEq7xhHj0c++hmICPBmBOcPadHiJWj1z+iT0M
         dQGFrvd/VdkQRYlAyPbIY4o7oBeUdhO/zV/m2YqENIxD1b5vW5CYkfWySGU5CV6RU+xD
         xRYeR/oKqtiMa2ScTfRYwFB1IWvgxUk5ZDeoHeJa/uhd2AbKPS43nsDnvGHbYgWb/J1a
         uOikHHJlCJQgIECMrY5P3J8VulRZpnMAAusb6nqJW451uY73CRYWSEVaQzK0m0EqZ12U
         M5QEYPeYfeVW94CG1ougP0Ml4QedH+3iugWeKl4BYQNqIJIFyfxPfWW4uWjGURMdwCQD
         KPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794727183; x=1795331983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=YR4oAUwjIyhDRdW4tf/RV0PTlfGoEo4ClTSR+2tWYvPL2EX0XDlLmbx3Fkj3VYCW2r
         1t7oYTZz9xz5GE8xIWdz2YwlqEd23xSUbBLdMSdmInxKcjLxJ9q3yd/kyeQVm5A+aIKc
         clwQD7RfijGf/bG+cVSl/gDcJ9+u58lJQZ+U9L4LW8IELzJFORKta9TpeJhirEl+94yJ
         3tfMl6XgLNjOBqovw+AWPspMU546W9c54ind1pXeMHIDBo4ufxCIPAkHpj/CNDWZy0xv
         P1GRxtb5Bl47lb4DtcDZis+Le0ZQlu8S9KR8/koU3M3PLN8izYqHn6BlB3jj4KM47GRA
         onnQ==
X-Forwarded-Encrypted: i=1; AL+hErEgylQaWoNtgxthHhfFUfmF7eHGfRHtd8h8EFL9Q8VqIjq7UNJ6tfQlkPkj581ie66WJcPC10FKEF5u7es=@vger.kernel.org
X-Gm-Message-State: APuU4Z+t6rJeL2Hr+QMzKk4Mgyw6SKqEFvm4CQJN6rnN+OjoHibOZFiB
	pgBE5XuXp4Ie0eWgjAGTQ0Rm0alycbMXIZugsYh7BCKAmXa+Yz7uJrpM
X-Gm-Gg: AYBFou3B/5y4S3KBXHrKgHXe6HuOs0927PX01jUg8eJhpq86tycQfdUm/oZjU3v/0iU
	EW3iuUyhzVPgxOu6HJH5z55k2YFUYSmKnMitEaGMEFGpa8LD6JHSPuEJOtS2IIGc66BzEZ2SmeX
	8a65Yzb/NdZ70dlBdn6hPJLUrJwtelccGxju0A+76BMk++s0gRrrv7jQ9sAocfGfj/vG0mCX2J4
	IgxhM3CC/kj7rhbqLQ6gtIvQTUnDmhknUefS/HodDTT79R/wgUFY8FsvZRi5cOenr1x6n36pcCW
	lwqBWI4MfE6bqHhQRfKizzKfVwY54d7pQcCrCAiAeu29p71zK+D+Dxi0NzG+jvmRdSLr+A/uRHu
	PUGJWLFtd74lF2ppYL6KqQpwIZc7Gkjl4Nu6UUhb0mgb5smmHgrOcNIjRpxyp63QBcV+ikzxqbI
	0AP81taTWRnrZwvI+R4mLA9SsXhqPx30atx1R5cCBBYWvmHqcpND8kp6pJg2ZFsGt/VIn9b8PbQ
	35B6/aoR2Jclwi1RmJqyy1fxtD+gybZ0PRotaY4wgs3kxzbny1ssGaaCy31dhcIh7FUWKh99N4z
	luebWTQyZYQOtH5zb6NxXwuATSZ62diS4v5q4EKUhUHD3pAqr1cK3MOuRDU9cBeOGFGN+Kemj16
	j0xOUFo8XGrYzipOWaG/zF6OOt02x0ZZ6ZtOtDYuXtQTDbLbKaCW0f/JH8U6pUA+X4VjqttM9OL
	OuukqLOetIwmShj/FH8XaL5+0X1MQLTiFTgaXKwkjw8/G3/fZGazSU
X-Received: by 2002:a05:6820:2485:b0:70a:549:292e with SMTP id 006d021491bc7-71ab4f908f5mr3485508eaf.28.1794727182620;
        Sat, 14 Nov 2026 23:19:42 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm1145321eaf.8.2026.11.14.23.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:19:42 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 15 Nov 2026 00:19:35 -0700
Subject: [PATCH v7 02/10] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261115-submit-dw-dma-synchronize-v1-v7-2-8d58f3d49e4d@gmail.com>
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

