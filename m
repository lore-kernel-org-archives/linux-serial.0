Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955744;
	b=bYW3RipxwTvTz/p7mGvczC8xZ5dkR1gU8jqo7BGdayYqdxqg+bqPokjlaj8Hb4XgeU0C
	 nyiyN0Pu0sA7/kJr9/MzoNNzlftcWEq23Cg/MHOPQXKijlF+QyuUz8fAsIjZ4cB0YnEBq
	 D6BOuBHCKEJbBZV5kGnFNLHXh3JPj9H1H/kMleTbsKmttVhGZWrx7cONMLuHsG1ufvI1c
	 F6CKBdJW0UmQ9ZFNxTlWACF46o7ItdjDktWg+IqN/kSXIGTR8ovmChwhBeqvbDy+nVDPX
	 qsGA7rTHIGXsYFyNkNyc3yQY4Jl168BmNdSFqxhFXNvDWyKaqzCzNP7x5CiIRL22/Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=iY/l2Qob4QC9vkcI8Jblc4yEj4ONwem3K51NxL0p+u5uEl+TAqxAGOMHLoK1A5FnfK/L
	 JuqAnFVTHWDpw7GRf3Gg0rCzegSa/OR3UpnTvrud7h4ADF/pZKg8tPWm0MEABPIrVjGbI
	 +Gram5F2Qtzpmpe9O2NwA4iqvYKyV0144vG9hFk2WSoNNjLf/Tz0smvRRyaKpArXplktS
	 svywOevh482WTgT109wquLLir1d8I/fpPP7cwZi5tpMhFJkkWR7iTexzbnbm7JW7EKyIo
	 /yCrt1TYhBBT/JHjeq6jI1Nv8GzAj9zmbWiNroTzx4AmP/PnkKAHGP8BtUQDKRe0CgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqs5FAtb;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D4606A8A3
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 22:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A4D4606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqs5FAtb
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4adf4431ca0so104752fac.2
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 14:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955742; x=1795560542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=hqs5FAtb/l2lFZVbNANYpUobM0kxuJ4ncJAfURemCBqRlXF469IVUDfOOPy+rQ297p
         XlnXZ5DDxt/8PERRhtvJLa+Zue5BebERINoyUEkReDe5nfkwNyp49NtXluCSdh7/I5To
         h8FFH/rPNuhPVlJwJyI3wHenK6msmV4Xc3ONfyB4AI6jOA4EG4RTnQi5r4XXjW+6UrMz
         tfZ7/s2nYG8y9qzMb0Kyg5KphJGMPKq4knV+ghbi6geUXfsaoFrPz8hFeiSSYfJjX6cY
         5SnCO3SyIG44N99/GjMx5qu4oq/PCq2qpCaDFGla0K9tInS+N8DCf70jgIPuRgkf1HzW
         wggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955742; x=1795560542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=gSQFH1tUMuwea/uQ2AWidvaqXUy4BZcs1naKOvsBOfJRiuuCs0kAojnas6kwi3YGh8
         dcYBS77lsPyTNrGgeeKJ17LYS9MzHUUs6oU3eFK2E8jNo/yMITz52DrD4CFuTfoL6hk8
         KFxUMwcWCkRlK/fYAo6yfEMcuv5rccWjED+UQCZ+3IS3B6UDd12no+84jQjhCbAkqT+1
         NtX8t8XXnQoFNegYXWgJdLfgfFK8FTaqf6Z2OnjpQCOK33jropGSTpYK8WgVpCEvAtD9
         X9H7CbrE48b+JvciIS1Z9VTykjVjxWFv8p35L7eNzPxzkNPXqu3c2wpkYLouFJ8RpJRp
         zSaA==
X-Forwarded-Encrypted: i=1; AL+hErHB64PYTebnH8xGqySC40GG3UK1BoUfen63LcEYMJu1LpXCAs6I2SezEqJ0Q/oHjsvkktBDNZ9Oys6gJeI=@vger.kernel.org
X-Gm-Message-State: APuU4Z82AxKAEhE78NNbaaer8mo+QraHQgwJ/Z9Av9WK/5ZwX4DwTVdN
	kxnvPOHG3Hf+ffHC3YZ/m41lMfvPA4yY/ZmeRUmDDMd/dDUdEGZHDTTx
X-Gm-Gg: AYBFou3y/GdIM8UHc4h1d891UvXyRmojnAkQIctJjc1dAZil1rz1pHTvxVj1p0FwCrh
	XlHWwczU/noMiLkCK1zDrWhyBPrc5Q7ROd1zkC+zWx7LfWIgubAO51PQP4uQtfddVy+R09SVmPe
	HlGX2Sv1Usx/xdoXQdrTL4fI/y2gwDrSh7WBFiS8YqglVWiAv1VqOihDoEipkGxf6MOhvIrvc6u
	84JFh0wIdGxbhC3cTNUabgQxadli9NLNXbFbV5DlcV8cVN8pgiozVo7bFQwikK8C6YH2bEfUjve
	I0AAk7k3V6GKD7gGSr5xxL0nBGl3GQneqiyCkl4jvVkdVBqf9rW8qZOcBpcwppmwJMevuBSMH3k
	i0rgzyfSyTISZHfN+NlfiLLBOzELi/HAtVh31lS6f2S1SRVNy1oNxmXDO9OyN3Q8nhQTqXDm+MJ
	2T/PlFu4wsaCL+DceKx0FyFOAM5gAhhAZk5La8S3xiGIp0qvJt3788PiJpWGQa50NbgxqAay96l
	qZgti30FrfOC23Ybc+wjdCeWTKVzEk832nOT87h310CSTPkpC9qdGZ8p9fTJTvoowc+f3fY+yKr
	X//WvEZS80mJeNEQtm3vcMuVR/xgmzV2P//+4fSUz1LwcUTXsAamOJmFhQYh5jphlXPKDq+opB9
	d047Nnh78p6DLGtJVYEIKiKRmuliKGmN2OyQLijqpq3bE7HKlyS/4vuVARk3iOE3IPvcmr3ILiV
	vbtfOARyYVB9gOstEVh7iH+XB3ZMBxVUSsOe9XC3IvRlU3w3uX2HqvSRf5Q/+5uQ8P3TIVe73Wr
	A==
X-Received: by 2002:a05:6808:3086:b0:4c3:d087:4446 with SMTP id 5614622812f47-5773d02801fmr1580025b6e.42.1794955742318;
        Tue, 17 Nov 2026 14:49:02 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74560af5fsm583066fac.16.2026.11.17.14.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:49:01 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:48:37 -0700
Subject: [PATCH v9 2/6] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261117-submit-dw-dma-synchronize-v1-v9-2-7dc066ed0bcf@gmail.com>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
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

