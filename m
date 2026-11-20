Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202962;
	b=WAVTD8zW1xjOXAOtGOaX4mLY5HPlJEG5dp2nqb+lAm6hGhlQjzJk8g0rruMLv2TVeIR5
	 xwaVZBWd4ChMObpNxgeuIHePzordYlwrszKHaK96rrZ4BnCI8qyY30BbBiKEiEJYX4BQM
	 AnsFYmPvLSNkzpH4Z7bwu7tRbBd5aGnRjCea4vnRGD/G29NC0L5vz+H12OxA73p7ePaO0
	 Yb/V+QegU+MWLE35nH/IGLUmJhUherqOBHINYjtfIMyC9Tn5wQe/p2QgjPXuigejwu9MH
	 4L5SJrmP51myb0yg/4UufFXmpsDtIcvo/Jb+hIpJWz0NEE18NwSHST2EXlBJxkCUHNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
	b=cbZ+4LmYgtwEjBhJ8/JgYmNw41ptiz1jQ2h2msPDzyxDvxeuxH4RxttfhhpCAgtnvrGl
	 xy4VllD8lwQaidmwwwnsDuJV1V7EkZs5zJ2vjIcV4WzN9NuTQRvTgwcaZW8p3LOyuk3pV
	 axofPyCN7KHVW456CVKqnWGf32nguy6b8QQn7iA0ZVlAJheQkRdTXIVtcoT6S/8ar2KIp
	 cPynWTtl1M0t+QXVfL6ahG4i+hlxreNMS0r2Dl3AoxwFLf+E1HNwJo0+jHAIMElFGhStL
	 B+c644AYQBR3dVGgulMFkkVnuP7mwzwEy/A8KFwdDsBezcq16Kk3QpePBnVx2WtVCuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GEOB0blT;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B3606A6F6
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F20B3606A6F6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GEOB0blT
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-57728d87699so564487b6e.2
        for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 11:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202960; x=1795807760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=GEOB0blTq1pdOAK1AAs4SvedVsy9ZgE9IV6E9LjdV6BFVFLwS256U0naIqpqYOFlEP
         i2k1T+PSD/ANlTcK6J8nw2UgAXL5pdrvabNAvOltMG6QQXMcudk0c08rY3nnfWiVKt/7
         12rFq/m1fcZMf6G9Y4lq4gBWQYgOMXGJAQaPaVZ7qfooKNaXVgS8f9SpmbVION3h0+MX
         qLG+G3MiX/mpSBs9TFKssUrhJGTWy/VMGidxkUyha0B7wm7VBR6adtVJT6cpT0q9/Wo+
         2xxoBaebcN68gy1ia2rZCqTqMHICDWNiZxCEYnJhOOZw9nKJoSxqBActdTpxH9Z9YdcL
         qTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202960; x=1795807760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2UBcR5n5u6jJuSGCUmpdlBoEKk3jjjMEO5gyi3TM8=;
        b=uvwz2JtWJnuQZeVu7GtlSFNmfwPfzttZD7n0CRMrr01cN2aStyK/kI+YnoHhHC4w4V
         JC4HGcqLA8OErkIASSGIlkH7gsgJZM3lu6ZBzfzeeTqkKjkSO/JVQxVRmLPAn5bNIEit
         RmgOAwtHNh4RuHxPYGgA0+dN7d4ueagtdPStKpOpD6OHucgX72on8ogBaRVTIDow/HPr
         Z+/+7x8Nx8ozwfBmNQp2Qf/m0hIh+ti3l6LeS3BH4Zb1r9r2yDf+imxp6HJte70MAkIY
         P4iabIRqgljS3zdH6YOopKXtjzdIWoaqfr95mke74L20an43SGu+C8CruViAnB9uVAgP
         vdfA==
X-Forwarded-Encrypted: i=1; AL+hErEm0Px8tWDHKKRQJHXWp+VWdCnZ1wnFCPiQEe/Ofbz9NwH1Sr0rZEZqXzADbTNXIuvht0Ok8UaNcOCH3gU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9P6byvEBvoRyf1xk6ipJAES9nLu4e1FuhLn/lLc4RU9/pK6biz
	yxpSd4RBePPgXm9YwWVlrC6bUmZuoFEasX8MtrMouc4ZCAxYm+3ugMfq
X-Gm-Gg: AYBFou2kE1P0/RlfzNqSSpJq7fyU1HtTHksYQbupxyKj1j/uuySnj2soZyzx4hbLiLT
	E+0y48/tcrygeZ/XNsZg5nobh+0HBDxVANJ6YL8m5LDi9tTNVAvRankc3lw8tC48v89Ucjwb9n+
	xbzh1Oac6PL1btwQg4xSK29Q6T/qJBdA0Ddq6OlZeptGn6yhqcSZlZ80njSdDmbvKklyARQBwfc
	z2sDL1CXhAvQQ7Hjao6liaTF6eUdNDnObcN0u15q4vMEHXQH/y1UgsvGzp58ECXiiDOE4FeBVr9
	N2ajigilqk5VGgckwLeeHVp5WMtbwoPTKsg7WKeBficz4oTqYjMEsTQXJtj/UGfXNHM06288viP
	XZtZXzErSihOE6P/E3P4gn5VylL1yFoDKmk6mL8zlDPsxDvVSJVqf0yagPhSznVdw3B9z1J8rre
	jOjBH4jWFG9O8DLKOU3Fbj8OR8UrBzk+S0uQh6+TdrtZ6B9FH0K0vPuWDPsNqL+SDSyPgbkGmeH
	BsYQbjiLtD5MIPItxzfyXzz0kAHxP3+XOU1cIVgU7giDB3hx4VlyN5UeE9U0v5mhBMbibeIE6Rw
	LQYzuw3F8jLuZNujBG99Pte/Qn3dFNwh5BvXEraHjON00zygU3ezDdfIDijBmdLKMwsKcQdf7d+
	KKdKc3An7uWp4aGH+JUzoG4rbvGngOeKtdCfZaPHl740p9PWypRU/4FBWF4WJXygtNVuqHtbKGK
	LE4Apz5KA8Mnm4khtuTVn5pjnYaplpIrkZ6aotrs943Kb7GodJHU4Sz4qhFcjlB/gb/3TtJ44Ss
	g==
X-Received: by 2002:a05:6808:301e:b0:4ec:d580:2440 with SMTP id 5614622812f47-57a0bb73636mr4665554b6e.54.1795202959832;
        Fri, 20 Nov 2026 11:29:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm3434498fac.8.2026.11.20.11.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:29:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:29:08 -0700
Subject: [PATCH v11 2/7] dmaengine: dw: serialize error recovery with
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
Message-Id: <20261120-submit-dw-dma-synchronize-v1-v11-2-9b9166bc2cc7@gmail.com>
References: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
In-Reply-To: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
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

