Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648064;
	b=vMWQW20SBwoFTty7MTO+SXoF8cZgCYZkkW72oe5Ccr0geh5DZrcXWGKGayaFdZ1/r5S5
	 U3DowoT8DCcDqFXSPvF1/0McN4JTLUvA9OCd/fRYwEUX7K1IIbb5koHtop7uBuBqOuXB0
	 epgu6RUBcHd/WzBmTsgt/ofT9LyXZ6BiHFMWxzH6KbfHJUoMt20/UDsycTzw4s8ZjPjBR
	 lTutdAIJxoeL2bme62LZpd0oCwaUm8aodN2dLsFbVNR6PAzvhVFHJUGr8kDl1Dk7EhGqe
	 qAdJS7ibfNAewaWixnrpQC8UlFhl1FYngHLtPzK+4bZy9TrYL2N8OXP9bRl9Ucpqmtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
	b=gL08S7qIwN4gkvWyZCsjIcUsxXw8kXf2obr4O5Ol7RwfYgATCxd36vzlTNg9FY1u0boP
	 zFhcYHiGmsaMr8fYpPjtx/6BMkhgtNo/+o6STANkThqSoySvxzf2zn96LwYCFP7TRMG8r
	 CFjtf2Nqj5pdmrun+HI7h+l76bUZoZexcflPeT4VcuSxIX4XxB3lvhwABNgLxRK84BbTQ
	 8x4Q/IEEA4GEHvJ6jmxtK+Fw+tmhFMYCUbk7KbJTqJfxWWeISNHSJeJfzWDCoJ5uSc64m
	 QuuyRRvLWuMx2vYl+zEL2mVRh6p1jN9WgVelbkKx5hDdROS3xXei9m4pdYaHq5D4aJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uf0KrYoO;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E76606D81E
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E76606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uf0KrYoO
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-854b6e2e41fso2177965a34.3
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648062; x=1794252862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
        b=uf0KrYoOZIGx+PEW6J08xmJsV0DaUkL3TeViGjdoLyNBNJ3rOfiqa6+EEJwmjpA5aN
         ujFa8qwAYYAkVnazWyU4d6vPjmJ42rV41SJ24cWJRYyj++hxfHLg/NVwdNCY2NzRxUjX
         v4EmSAyHsLtgpiFvLgXlwOYq+s0pbvYhpP4OJaY+Ai9wZ1qyJaBTG8nfVkAxSPqz+49d
         EJPoK9m/5rpUHo89vkIfTPPk/LbH7mbGLRlClVCn1m0svzIOlzdVc6DLxwwPMEmSl0XQ
         i6moc5xZqMK0OqyZbpWB9ZG9Vo/W4mcsYmypv57fbCV1xmAsJaFG3c/pujNMIHZRkIak
         JFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648062; x=1794252862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clb16rj88aJbTcdYzcJEuHREx2BavzM+wmqbqo2G9WA=;
        b=cXhe985CtblyNYj4z1w2RfLQxFU2iwedc3pxKCYwk7nGblkrVSVbT8aGn2+P3pFwEO
         0IDcLNBrExI60r4xyTv+Yrug5PA77IlYFCk7alPAEWCRRp1V9pgupaNmz9E0B2scyjmM
         buZO4gjHPmUUDzjF1yeuHLthCQhWg+vXYqemhJeKN1+ZZO6sRzQ8AGG23wm3z+6sYjd9
         60PIHaSzacciRqawssTzoupLm9Y0WtwDBEFybF6WK/cm+vUrHOEMf9lG25E59wlXxrNl
         dySJmYRSXdyKZuK/btppdSLdC2GXLGOrY0/WN600SkbEoFr8ar4lVLc7Prqk6hwLu3GT
         XPuA==
X-Forwarded-Encrypted: i=1; AKwUvBxSKq6GIAmtc7FjcI3L6shSBUPH3uj6lv6zCJNFIPeAjqEYmtgnRs5XTwaDyBunQ9PHmUYgQ39d03W+nAA=@vger.kernel.org
X-Gm-Message-State: AFq9FYINCGUZdrHNy+8TFZqQ9fdbkPZN4vPn+w76FYvkO3yszJu7HFey
	vSkSowqDasXQKhke2iEXF8J2GVjgwKoQ5qvoSYknAY29/+k6+IFaSDnc
X-Gm-Gg: AYBFou0tQoJdIMylq6HZ2CNYytiWMZMbZE9pGK18brr/0pbiNoF2fm6MiagAao4is7B
	5n4568OL4XC0DV4VwxCWAtGwtf3Ef4uSF0WrpDxHVjVvigNzP6wokYDEIwtudwiYsAwInGRigPG
	EMf2FM7mb7n3iUeqKr+8N4/0iCktEFU+zmOfShLM9+fV+iu+wOd4ZLIrckIxqqaX9TP92Se144g
	eRQ4MOkfiyopCqza4epN2+lR2S9Zw4uWPa1bVgUvyjnlPWFQIKOyfpkvoYUckGEG2lwvvLbJJ2F
	DugsPirb3Xu1JF7OB7uwaMN7H69z1VeZZDUh/BcfZcySwwal8SXqtrlFnkcjqxikOsMGDrzgpyv
	8x4pmbcjed0P16GdqFlGY04qomQMrSzeIUtSV82gr1pFRthd7j+t2c436FP22yhdtLd5xu1sfDd
	yxwHp901Iu/32ZWlNqYBHgcQV1cua0b5ONN8FexLljPrXuolekpKSOYViYqpx63VygMBc/9WOC9
	LCd91eC1SFgE0yx9084MXqBe4sD8Di+qvvDgSmjY8MQOVuLTBkMXla76g7C4DoLGy0YebYrFdqg
	tbIR0gPmlWiJgRj21sis55jnwPX/UhsoxUDUNLIInTJo5DY77z0Tg9XSGVuEG9X/iJKBQ+E2C0N
	pRrXFCG8NMqSv3ayjm5YpCYI063NyZz2Q5Q4hNohaiG8PDW6tkyIpzF1Z4Doj43g7ZeruYkCSH1
	jzjH01nWQutvR31dULuNd4AWvbMh0qTBPikDac4nzIXSg9hfd0AUg=
X-Received: by 2002:a05:6808:1798:b0:561:fa43:1b17 with SMTP id 5614622812f47-5640de03ce9mr7895795b6e.42.1793648062116;
        Mon, 02 Nov 2026 11:34:22 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:15 -0700
Subject: [PATCH v5 03/10] dmaengine: dw: complete cookies before releasing
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-3-d3207758fbf9@gmail.com>
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

