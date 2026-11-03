Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744785;
	b=AFaWPM5bFzM0hRk+FJtNqllbDQ/pk4aCK7KXB/5A3SKUR+GZDAaKBqH2VnbcuiT+5ChB
	 TXw1aigT599dWYdSX4HH+ngiUGzBvHkswNw40OIzHQ+chPcWqirhiFmZHWYQjGXnSNPtr
	 iBaiehh9ipgrgLQXmzYx1MRGTgYckQnFdBBKSeMp6WBwSNmAC9uutLH8Tt0IkLu5Nr1Kf
	 0KLuXmMBPQN9kS2SI7UDs1xC3RZux4oO5MtA/0a6o8dDW7fQzKlyFKsfbej2PLdTf11B+
	 3KmKz6flxVXRM9m8n46cdP82ZJBa3jTC4XyCw6pVQhZk/FMq0pK2CBa4zdPIf/qAWvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=6B8/kguaSg2buIHgi80qhLVJe9NS42NHDxy6rcmAb7Q=;
	b=W5/h+uPtFNkOyE7cnpqH8USXK+yaX88VEfSOOcQL5Xhs+F68xHr14cD+1zA0D0doE2GG
	 w+TrYTK/OGAW1J/RLOWg8khN0z3jnpAd6QjeDoIDKFg0ppRLfTqfTzS2XlNKkAacpPK7A
	 mfj10YvAnk1DyDjTqlz9aL1LqRA+0N0au8jVVbZZfJ5b58g0/dpKiU+X83JqtMwjlbsV9
	 mp3QP/oHp4Fo1EkVEzCJlK4xid3VObeocjpV92Bb5RYeMRnJok5+dCVqmwTSmiIDwF68V
	 3k1Fn5ZFlwKa5HFfQu42j2/69k0Qwui/G7bgjqqW6Jd8cK+o7DB/cP/F0dPWwQm7Wfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dKKvJtHq;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C6B606EE8F
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C6B606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dKKvJtHq
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-56431524c22so44739b6e.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 14:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744784; x=1794349584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6B8/kguaSg2buIHgi80qhLVJe9NS42NHDxy6rcmAb7Q=;
        b=dKKvJtHqdm+dQxArWG5tGxKUXakQohe4whh+UM5E2qaRZ1J7QSOeRNuNLDWDinX5Mx
         lQQZ7H8qQ4R82unXTabFMRowb/yFBo0l2/EmGQqhYmRvPI/+EWwwF1Aj7pkymA8foqX0
         KVODrDZ/s5scJCvp+Q5XBT/oAMbGAz5freabTv85aaA/PCxkoG0VwMuip7KhxDJYT4oo
         Al4baaX65eKEWob2gjxWTk+jiwgPaf5wMaldkqcxAJAASNvnJSBK8dDwxlGSzyKG/kp7
         c6JoJGR+S5phFX07DUxJTrVmvztBj9YllLtye7LHgx2E1CsyI+i0DGjlLrb4gKT7SQxy
         Qq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744784; x=1794349584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6B8/kguaSg2buIHgi80qhLVJe9NS42NHDxy6rcmAb7Q=;
        b=lgjA6M/4ttlmF995eQUzS/6KRd/dxgtRIT+hfNHq3r8CemJKp+S+EtUtMAywNKt9vx
         HbEIjZe3cLG/WRJFlX10ff+JDGj47ovF+qyMLunRgTfMlci7h8LBK9Az2AtnA3qKgg+O
         JfOh6ZAvaFqGimOfHu/3pB3VkHn4sG2YQ53zD6eE26bq1mySe7it7dyAsE3fthTSAmnP
         HcYhcqDIjeloVf1NssmuqPM4UpPCXUrXdgxTGXWUefwuUOJn8e29yqE72pOkES1piw5J
         Fo23qo8Ys2nLE3JSt1990P50C9HoH59zkrz2kcUNqbphzkbwvuC8nQM72qlPa9iU2uQI
         zaeg==
X-Forwarded-Encrypted: i=1; AKwUvBzcKHl47lsnknL8IrhywhqErWNj6bKuZJxn0ujuQLfoXCaWGfYxP0aeKDe+fg8aVz0uhC76OFztmFmEyP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fqkYwNm96oTKGstRy/yen0XGBR6rtzYkX6ZT/x3wva1zKAaUP
	0zTgR0UKyZb1bl/l0smUkSfuzZA46b2tCX0DPyL/psNV4Uegu9vNyRcC
X-Gm-Gg: AYBFou3ATvjNVdf6rtYrpjdII4MLwZCi7nol5Js2ItNiXdHisCriJ/1TjQi7Xyufc3e
	J3YknFwvcZ88ZuEQxbw5ZR86O/bjBC6GTkP0zgQPthLmbP1a5+kfuCrTOSRLdK9+RS7BIeG4Dmp
	XLvK2YhJspNzseqQ/Q0CVk4SjyUdIoPmQTK2+v2uIDKVENRmGzBjSkOudQAOAKbleLHFg83PVrl
	ATZ25T9SbTKUaiauRBJPxGDj67nsyjaMe8JAsxKOjMLBdy90wItv/An85HFOVRyeFbCtdtxdZyB
	87j0Q7RynwEePHF7ELfs6EqkfB6lWrfx1CURXHQL2YRtw3bZRHpsMNlUK3SwWaOUolyLrc8GEJc
	mABSbl2BnjPLQ9E1mnzLxN4YBQkAVr9V2mraCkw0fwG2b4ovGia1ldeEZD/fDX24bMvEPUF0ckU
	GyiaGTn8YqFwNHcv+9C4Aytwyxdc4QDM3f6at4qm29bNsDkmD/4oQlH5iMhQOyL9qjkkNmPx3it
	CXNxwV+hqrsiYzGXaZYDVvNDJNEGW2jAHDiaPW+MMFeox7SGl2fgVAZW9yRPJEJzypyuGdc3qOf
	r3K0nb9G9jwXlxmF2Pn0beWe0O1SzuAeZY9GXF6jkXutppe+vy2Pmiqtq9IOUeGdH6SzKXgjJuI
	15lex3Q3sONZG9nDlg0TBWN2jzOoFon3qaXYnwmggF4JCUL4N175DG12ZWHuWmhUm0xO+Tu0ZA7
	r6ebMm2zC1rFAoN6z2PzeGhV7wiHy0KKk7DMhTpWDR48puVwRe31s=
X-Received: by 2002:a05:6808:f12:b0:4f7:d324:bc5e with SMTP id 5614622812f47-5640de72cdfmr9730628b6e.58.1793744783949;
        Tue, 03 Nov 2026 14:26:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9ef58b1sm128435b6e.3.2026.11.03.14.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:26:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 15:26:09 -0700
Subject: [PATCH v6 07/10] dmaengine: dw: report residue for queued
 transfers
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
Message-Id: <20261103-submit-dw-dma-synchronize-v1-v6-7-2ee0c348224d@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

A submitted transfer may still be queued behind the active transaction.
dwc_find_desc() only searches the active list, so a status query reports
zero residue for the queued cookie even though none of its data has been
transferred.

Search the queue as well. The status getter already reports total_len for
a descriptor that is not the active transaction, giving queued transfers
their full remaining length.

Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 3cc8579f8829..c602ea01cb83 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -927,6 +927,10 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 		if (desc->txd.cookie == c)
 			return desc;
 
+	list_for_each_entry(desc, &dwc->queue, desc_node)
+		if (desc->txd.cookie == c)
+			return desc;
+
 	return NULL;
 }
 

-- 
2.53.0

