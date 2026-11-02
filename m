Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648067;
	b=RXcvUtQWjjCIzYzzJvd84YGA+zM/L0ZkN3oG16XUxTuN9zT4ZXgZy69/mIwdzxPivD4k
	 3IC65unEjdfFOkA8kw0zBw92GT3SwwXsUpch9XAC/zQ4JDpC+v/RGkxDL5wy+v0pYUoxt
	 qEXbsIa9nv226c6EUX7jQGj42xvfXaU3V5OW5YkjR/PvnDk7IoPLigzvLeCVZlpkj0zdF
	 bTjnhtxBKTXUYD0PBh3tk5b3Q72HdMaVlTPgVGa7KowR2Q0J4AzOdvIq+ZH55XLgtV7Aq
	 i6VE6XkUfj5U2wBszEeYeEc32gLRv9j4mH3tco+C/bHhdIrTjri0ODoHBPORUwTQLjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1CHohurHwGW0s3Zm6Rv+GbWfGWzISEwRaF9a5zGiOwM=;
	b=Gn1bxGg3QpftKVAZvgPj253JH0lphutt9WFJE7o1mGuzHR2QTPJM9o6ycpqfraKfnWV8
	 M+5RDHvaDcRNa3zadEIFvFvAyIQX3rhqd+Hgz7ebven6VermwWWvYMVD4zhNqtbGBkLn8
	 EmJV/eX1HSdj9RNOspHAHo7sOtz5S5D2jsp+vW9hVc1DjplhojawzFyiqv18MPoEadBKG
	 QA6nkvBM3m/mgJuSlsH7cY2vYLwb05a0/Ak/vU60qpMRctICvv30bQVUSl/E/ClrlqM32
	 y+aSgi69kZh5+XuaPuCZOvZucQcwMkJ+TH0c9i4yIHVdKSiFhLzUzUtr0w1KWHnNNHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdjD3gzW;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F930606EEAD
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F930606EEAD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdjD3gzW
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a451915d8aso2627143b6e.2
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648066; x=1794252866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CHohurHwGW0s3Zm6Rv+GbWfGWzISEwRaF9a5zGiOwM=;
        b=sdjD3gzW91d/Yiofsx/4ymGX7zchBWu44Xh0qiZRbHLso9tI5+BU16O/HChBvG5dxW
         1MRsdtju6i3dw8lmSCvReHAu6mKtST8cclRlFhLPufQjCKlif68GPo7d49XAw5OXImcn
         CxzTbliT13pYgN0rqr9Ak7znACLFtYlV1aia4ar0Lb2s08bjShTlL+PltykxUXIn7jJ0
         TIn/D90TDYLKWKYn3RDwaMW05UER2+YNFVPmjOIPif398NrCc0lZn4EWGZRpeoKygfqR
         jnn5degMOYZAvL0JqUvJqGuPRaO4EY9CnKxVpszoxisio+WoHIj0Pu/nht+yGxICYP2R
         eXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648066; x=1794252866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CHohurHwGW0s3Zm6Rv+GbWfGWzISEwRaF9a5zGiOwM=;
        b=AzrufUPEo+n6yM6zTgnRjIgJeLyXVzcHxZK6xJDwZdFofzk4hEzWdJUC3gb6xgVIyQ
         UxZ9XXC3dtLZVkjp8HGa0f9c+vTFYGkIaiaK3gI3RS56+q1EH1OwifDcHvuc2Q5xoBnX
         aF4OwSPepk84Y9ukBJCl2ERk5/BeP0Drjko6pN4+vQFA5s7D8Z+3+OeKpZsGuMG5dP9s
         kby6p0UBPFGH0TlKMFhB4Q//VLTjTdPosEkW4gTdX0v6VZCQRGzWbSNM7PPwRP5h5JWb
         78T3RwesrC4p4PRgGim5vRSde974hFdLmr58pqn9k1VEhmciC44oG2Y2z5EtH3zw+JNF
         c78w==
X-Forwarded-Encrypted: i=1; AKwUvByTSbw0rU9j6g089VXm8oLtvxNWYAYFEJrXC8XYX/dgxasz06WnYmFg/qEHKXgXfUtyPSBu/GzsGcCg32U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJn+wK8wyAHHwyQJRYG/iOmRNX/89JdZJ/dkMwQtT6JRp2Qyj6C
	Qy7KaMI3E1UETi4Cvrjg+8PEP3ya6ge6Y0TdmZtH8tR0YuOhhUeUmA8Y
X-Gm-Gg: AYBFou2aWsH6syakBbsjOmgJsWn5bfxl4YpcDTtjBqUOLRi8nHFje8YJfLrySlg/Jpc
	RGzzIk1h7bJsm40V4SzKlmCCSLzwPveQQ/8nOPSjZ8J02seEx1yyzc8Ewuuw3C5wJPOL6zdUA+p
	zZJjNvMUo+vzN5kKiQBHSsKqu+vk+r/t36ikXgUelf4CKhyYoyBqdQFgBgtTp3SDvq8YPJ5XBtN
	WLoTq5Oq2M1cskjNto7OZjap4fuAEg2ATTBelzBafXKfsdN1QgrTlS6N6x26iXPcyhqCkaSMjhA
	hY3YhQbNe+0/J4i2Bscel7m7QLbeNYJEQ4YNOXGyJw6h0zhR9pvXlMvA73fIa/U64mQL+J7BENI
	HoAfX6l4FMqdpk9F6lrcWDMne+dX+zqYdwzJaUyANjUYRPuzcq2VWltZnd63zLlZyFanBk/euCW
	i8z6UKVz9xUlfCF72pkFdRhGbwioCOu7caT/QKtkbRXcFfqOVgCZ8PjLMFWXfmkkVRS3SQe3Ue4
	rvfzQdjOoYH7PozAXeo6N6w0H17pED37I4dSImNo8ZBMan7cHTCuK0eWGrJAD+8I01pykqiwKhm
	qJsgN8lzXD+weXcpwRowcAbs9UABswpApbfIkbCPCFfGpLHsKwqIVgVW8phsT+krkpBPpt9X9gk
	gteHjSB3p5DzM+MsAR6G6VW+L6LL5nxQewy5k7EJweGILIfkTUP0YVO/dIZW362ZjdUbeBEfbsu
	ZfTi71ScGvSOfeN83iPggwlnyqidJEfWSgy/6qjFSGGoC4x2ptw1ib013nK6+Tg6ZUPYRKDs5t
X-Received: by 2002:a05:6808:2382:b0:4cb:abff:3db9 with SMTP id 5614622812f47-5640d916930mr7379458b6e.9.1793648066236;
        Mon, 02 Nov 2026 11:34:26 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm8558249b6e.3.2026.11.02.11.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:34:25 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:34:19 -0700
Subject: [PATCH v5 07/10] dmaengine: dw: report residue for queued
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
Message-Id: <20261102-submit-dw-dma-synchronize-v1-v5-7-d3207758fbf9@gmail.com>
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

Changelog RFC:
- Instead of just dropping the dwc_scan_descriptors() method invocation
  calculate the residue in the Tx-status getter.
---
 drivers/dma/dw/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index e198c9f45f0b..0fd49ff9257f 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -901,6 +901,10 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
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

