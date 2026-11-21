Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295114;
	b=ygOaaeUUKYNt84Z0gx+NAocUhLCSt7/6FSa4cmWOwbtiqJ8cOWfnCf8HqS7/q0+0Kou7
	 bbJwtER+FHXsiGralGtfTMO57/7qaLVw61c2dQqy86MilZE16ZyASJFfwe4OMPebJfin8
	 u+y2m0EGVzNtAq0PmPpoZI7d92GExzHke79PVvZa4c7bGEUD9g2nyVUnhvIaLGeDIc1wH
	 Pw0hyspmys/haCLTUGSUHY0d5ft6v84JZAS80YQpdG3nPR8EHuHhWyvtSwDmryN1IyDbQ
	 Dc4IPNIGQPVKZYmBuBgyeWK+AsiOR7s34liamAdwYGcKEZqxPhfUPeFehudlDM1IZmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=NQnbPfOzKZsGZYbWuagccx5bm/OCUTvNG/34f4erQB8=;
	b=R+v7D2+pmYvZhX9rMWjUnsCROHb2irya+AgngKzHYjfadNYQjC21MnqiCr5oT7Fsoexk
	 Jkct7Z1GRSpkqTEQUWT4VbCYywq2MSZo5nQHYFx9RbO+KkEZwVmzDclf7RRtAqiRzLp75
	 t+pCpw461wCi7vGSjjfkGvt1p6AsGUJGaUDOwrPQSNbahZ4n8Ch2pSix/FcUtxalefZl5
	 x4COkeeLfxWhlceYzGES0FEHf6Fy4rN9JbgqoMharTcc+4cFHk64YJYj0smm9UkVsoFrd
	 4AygULjESU4Nu473/UxqEtE7l/zzWvk+K8ZIxBR8UAavwvdrNd8RYnVBZKnpy8i8vzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IX7vznIL;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920BD606A336
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 21:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 920BD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IX7vznIL
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6df7f544919so1269818eaf.1
        for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 13:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795295113; x=1795899913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NQnbPfOzKZsGZYbWuagccx5bm/OCUTvNG/34f4erQB8=;
        b=IX7vznILkd/CCVxwf4ciGJ2ED21G+VQpoY0/+tApV8+6vFo9BV1d6XlU9m2qYT9GZB
         jQ/J/iUxKWfpcq/LOwOJM+Id5MOyF0c+1zH0hgYpgnOkLPgwQ82Ky6YrCPcU89Rb6z6E
         LmX99YzDz1KCdkIIjjqBK+nq82jrRsCaxvlqKWILWmssSEElKScn6+/5xNRM7BEX4YNi
         wT/hZ7TAEqYIyprnRFra37qMWRfHx90t94makB9jOvKD/0E7tTbZcjcURQJ4hStg5E6q
         mbQqgqY32MST/9pW3kKW4FZHXllcQDZB/ztUBNSsC1vcbrBMkvfvXy12J6Y6GlHYl0c0
         K00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795295113; x=1795899913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NQnbPfOzKZsGZYbWuagccx5bm/OCUTvNG/34f4erQB8=;
        b=dLL/xy0RJ5Ge8nsz+9xhnr0m5QGRpAAjLEm3aX68qmWm7SUYElQFi6CnweZsvp6zKs
         cAEYABuftogUm4YyDvGrGHMDugdsjzowI9bVuGW+2p46jphPKlfQzYWasHdoUTFFqzAs
         GqBuneU01YkJlmWttg5mffpIaYOojJvXyUG0QyohIlZo+OBMc+9agVGyd1F35o1gBwt5
         WiA8IZ40wmuNrnw2ls5M1iiG5CH1FiLMMUz96g2tJWHj4EuL/VNAZTqZtQG5iLRk0/eW
         T8+vcswcy7HoGqeVF6X+Hc3mhhkIPlGXPLmgMwa/E+xsc78xkQAchHRixECjkmUrNg9h
         FDXg==
X-Forwarded-Encrypted: i=1; AL+hErHW1CsyHz1rk879ZxUmvbvN8yHfbZA5lCHu69hI5o67sLwmF3WAM0pxujU1fNjr8E+0h5YWyXPsD2Bp/3s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3VXZrQnppWfFNqxCZCvSGi067N7sfbtZibo5msh6UzHjcMvdR
	Nr0grrZ0cDLZHu6LRNvt/9+9HhtEbMKMhlK6rkgX2uGD+1NOqhjfyqg9
X-Gm-Gg: AZFdTZefD91NlRkiqoK42IF86UoFiNwxRoy141Dav80RStY1EY13D4XRFy4uli61+j/
	NH9FWmxMx90+YsA76SXpQHa6NfJCWwpaL5BtatpXDJIMn1QlVAt9Ljcbd2uAbsd52v8DhudUnFt
	uLQ1P/PvrHD1o3pEGeQEmo/J173blB0ZRqXQp9MrG/0X3rxQ2Z/W4obkcY41THLkYo0f6CqwG1D
	55WF38qUmMGWljCuZUZKH/x7jaRCLhwaSbMg6R4P6zwaZ8KC5txBu3GpA8WdNi8GkPoLK3hEVHq
	7v3EvXIEiajohvCtU3I5ZVIqQ0Av7AlNIJMx5eFZOmLFQLUC/aaTzxrxbeowZk26YTxepj4PZNq
	YqTLJuTTMHqhccz1ubTo02l7LIee9Bm5/FDouKl0GMhJGsOzgRE1M0vIdYQcsg+bptaV9UvEA2q
	GsQLat2zjrTkpgvbgHUIxaZMAqY9Ca1XwJfXP84hGeVmOPjLey19x4gVwcU6kz7/dM9EcEoyEG4
	v+qhin6tsuk5X389FmGH1L8H5PYSWbpCdqDxzY6xaDhfQWd4Uuw+82GakS80O7ANQL7rnu59dNt
	jzK8aqamA/wK3ilu3cFgdHXfp3UWwnOG8xsCOX/uWFjkDs05snQ0zPqBPOWj6OLXpEAE0mVfWj0
	LmOYUROCVHOaPWcduq3VyiXzZRWEyfghM87Rv3S3XEj4eZBc0yZRgnWgo8pPYrQ7AmJCKeyEWRb
	s9d62/qjBhLNjhjemWBSRqdELEO4bzqBt28y/RF3V/7S29T7RkXwa3
X-Received: by 2002:a05:6820:570b:20b0:71a:d8a5:4d1b with SMTP id 006d021491bc7-71b3947aef8mr4275597eaf.36.1795295113480;
        Sat, 21 Nov 2026 13:05:13 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4635728eaf.13.2026.11.21.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:05:12 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 21 Nov 2026 14:03:22 -0700
Subject: [PATCH v12 7/7] dmaengine: dw: report residue for queued transfers
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
Message-Id: <20261121-submit-dw-dma-synchronize-v1-v12-7-f51eb635209d@gmail.com>
References: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
In-Reply-To: <20261121-submit-dw-dma-synchronize-v1-v12-0-f51eb635209d@gmail.com>
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
X-Mailer: b4 0.17-dev

A submitted transfer may still be queued behind the active transaction.
dwc_find_desc() only checks the active descriptor, so a status query
reports zero residue for a queued cookie even though none of its data has
been transferred.

Search the issued and submitted queues as well. vchan_find_desc() covers
issued descriptors; submitted descriptors need a separate lookup. The
status getter already reports total_len for a descriptor that is not the
active transaction, giving queued transfers their full remaining length.

Fixes: b68fd0976286 ("dmaengine: dw: move residue to a descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 302ff591cde0..88c14575a604 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -944,9 +944,19 @@ static void dwc_synchronize(struct dma_chan *chan)
 
 static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
 {
+	struct virt_dma_desc *vd;
+
 	if (dwc->desc && dwc->desc->vd.tx.cookie == c)
 		return dwc->desc;
 
+	vd = vchan_find_desc(&dwc->vc, c);
+	if (vd)
+		return vd_to_dw_desc(vd);
+
+	list_for_each_entry(vd, &dwc->vc.desc_submitted, node)
+		if (vd->tx.cookie == c)
+			return vd_to_dw_desc(vd);
+
 	return NULL;
 }
 

-- 
2.53.0

