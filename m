Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082556;
	b=PDGJpkNOttoOrIonvRqj83QSKCIJFan5j0fcEbqCFxwVrzmCRsDwrZRHVlAc93ZW/Sdt
	 Ix2HqmytT8tOaYbid94R0qVB2o93lfblA3NZZmIGzOtYV9VQ6Mm+iOL0U32MaNs3zEXKS
	 roFFD2Xs+SNTeyaPVdNbHO+TjWHRt8rMsg5UB8YbweUc1kC0Y8xWRrzCxsmr2MBgPolUn
	 xFYY9pI9t21FvQHcf6wLzddT0X0dXXKJKt8wWLzpo+xqWIVB2YE86rvnTegrwDrrka/KZ
	 I6Y0lhBPqUigQyF0dNRiNMbBXMgFn3H8P4FAukA3GzB76Kb/+S+1sQzCaGSSu2ZXuCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
	b=1zfxdEjPyzw8OlAFJAVQkXB6UpsO5xH3rWfU6rbtCRczEFpMsARTzawq+jJk+98chGNs
	 EQNWjy2uK0sKNwCMxDSTOBJqzWHkWyS9kIVW8UzZP+OCllgPGgePaszDyOnnP8sDnki49
	 lqDP6oxV1Re0GolBrggf1DLHpC8ceAfds4qmf9drQAf7xLafXlMmGeA1cPR3IqGmF8HxO
	 27rwtiK7kF0I1K8Hwtn8rQu96yGqegvb1sCdBlU6ZcYikitpA1efUZXcrhSVFtIfy8ual
	 qFi+h1OA2av/owloqk7K7Isp1gv5/WKcQuxPX7+Qiqi1+lkaY6UJBtAkn5DJqfRCVAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdTIfOeL;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4860A260A
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD4860A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdTIfOeL
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-70b875f6f13so1727463eaf.0
        for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 02:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082555; x=1795687355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
        b=zdTIfOeL/7d+RS4Zt6Awzo6rb6wnu6WousZ/R88LlA3yr0tZDPkSAtaCaKBBXX/qb9
         NpQrleP8lK5nW65IK+0le216BnWWjIgMO5H1Gw9I9zt3VnnHGdJibzVKovL3Cc860dpJ
         r2/SR6Eq0um1536Nfu5IE0PQcAhb+W7DQn/tkfXU08UyncERGTkE3Mx8D1bOGB0vC3x4
         3OzPFY1bVX3GYIERM1dUI76jQscxbzQzTNZZm6vWAGCOBlDfUQKGuD/tDUPgTU/2FXD4
         hLEsyXsYcEuVyi+A5m9H7sHe1V4Ug8hj2zL3/TAMqS5QoWQdyzlBuf+hU/vSMvIuQfJf
         LL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082555; x=1795687355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
        b=XpEjNDIuYYpF2AaYekvYGadrMtrEmT848+0QfsmdUivvpnKxZJ+WB0FfiwdceZ9kVU
         LSjR2LOnP2zGzCIkjOoqCQPMX+/GEcXqolgt7y0XNATPVdpD2R2hWUef9yUbabWaH5Pa
         +yiXA1qAigZvRHpM6emApHb0/59YWRYy/3EOpq6fSt8xK2XPX3xeaqqM4iPaV1rtNVRQ
         dGBruK9IeHtF3xUuJsUQeVF5v6KUP7C5gLmiMVmhF1gnyrNdimb2cQ1rA9HS0W7KbWZT
         nas5mKgIiMzkU0s0+L2iyo59OgWgzcrreR538HNR7vhkObXafevTRkBR/e+txPWND7G6
         Bgog==
X-Forwarded-Encrypted: i=1; AL+hErGNuxEEZEBeNRnq4ZhKeB8b6NECYfV7zriHOAvqos43BZfdKX/wzTMaIh5yAisedd+WNisyK2D61dteRhM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NyY1U+VF/smCEdV4MWrtgPFgW0pCu122+XP+hYjstn2IcUOc0
	mcTOv0ekh6SrhP5v1CQVjuY/F/JrOgwZjhKCv6Om5p4aBXSSXJOln6Gu
X-Gm-Gg: AYBFou2aH/nFhggh7T9I9sWcnPiro7vfjyN5hjJCGn8MDEUnX3c8P4ckJ4sknPJV1al
	128mtRmdqFF2RtgnaTh/SDkuPYotws1tKeYtcJ648WkS7HNL24KN0G1uUlieG7tZ5wbBZhroxtO
	qVa5UrDRSYH2HO+T9gj/S/Sm/6AEFkxKituK66na3sxCV9InHSAMzB2Kf3bP/TjboEEADuHewbP
	vbxSH+oFlkxxdPfWfMlB9axv0QVzN8D4rcQ0SLdYWvx73p4bdgr7+dAxDKOwiCHlhsAC4rxGzsC
	qOID4Di74+MUa6bPSgy8NMs6BzWAt4AMYhMMpZGJVWBssbMfo9kTwFtOlCp2NaLOiY2FuJ2BQNT
	ETKXjHg/ew1XnrxPpg1GR2zRBFqU0mRH16ePi+4oamVDex2DNrPsGUFV1hjLz3w0y4oDx23q8bD
	U9dYfTTR7EiowKkazl0zSrRBu9HaXt2ecO8KMx72i5URnkTHIImmabstAXB8xaa/R2BY4aJwr/x
	ScIu1CSD20oiSpJCsOS0uO5y0YtCuh4QXH8Un53JDMXvNqtWpRHRjjTWa0UFPBtyFcixMOw5luP
	Tgc+ZX3a27bLA9LKuGl7q+DU9CDMDSiGDVshjXJ3lOXD3ItJ1CtR4tyccGc8vBMVnnXfYzfGqL7
	XYQT54iDBDxbP+129XXkhYo7NcmhmcaxxrluAfhpKABCexm1LNiR6+p7XrIimHyBtolLxWkfUzA
	dAiiz4eETNhfShU1kicSFrd3efpZINWJfSYtKHDh8Oo51w4tLTnj6X
X-Received: by 2002:a05:6820:1690:b0:718:984a:50cd with SMTP id 006d021491bc7-71b18476360mr4278894eaf.25.1795082555567;
        Thu, 19 Nov 2026 02:02:35 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b18fbb9a8sm3906194eaf.0.2026.11.19.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:02:35 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 03:01:41 -0700
Subject: [PATCH v10 7/7] dmaengine: dw: report residue for queued transfers
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
Message-Id: <20261119-submit-dw-dma-synchronize-v1-v10-7-3a737597a0d1@gmail.com>
References: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
In-Reply-To: <20261119-submit-dw-dma-synchronize-v1-v10-0-3a737597a0d1@gmail.com>
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
index 7a66dc75c546..f9761651c7ec 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -942,9 +942,19 @@ static void dwc_synchronize(struct dma_chan *chan)
 
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

