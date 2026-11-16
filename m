Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826390;
	b=m2E/0oPz8L4p1T4nxIFI9A7ocdTbjSPHuLfhMQvrvE3rMZbnr0igtcYZ/avIOtCdqE1z
	 MW3IpaCOfvtGiGDI3cfjiueNTSJ2/3rq5mYKaNnt0B0TqSJtK8F/DBz5klsUJXM7fR+zd
	 KWZPF6NsK2pUz2g1j5gik9Fk2DtYqeT6MMeYIB/Gh4ubZY7/PhXDPBNg0n0Pd3QEP1jAO
	 etsrZ5WgTjx6/5d/LJQICaTjk8qZCywlzcijpyXZVowKqae1eTsSZjbfDliUankkV+zb8
	 nedjfAB4BWfRijh/gitk1x2hNH4m+G76vFg3yt4GqNWfKIhhW5zb0uJp7JzZ9zUDtug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=t5hHzWFY8QOCU0RYZOwwYvawpWnrIbJa8B0acXUTVWs=;
	b=CxpoJPafYa4qg1sulgzzbiAgdbkXCYWDzR5fQ6ZnuZ4k7o7viZb9NQ1bXAld0m2V781i
	 SuB4WXZMyOPzGru6+Ijhf4rQ03vOgjt+EQFIJSRt/+CLtiuTFB7e2ByPLM1aBNKdSHEtK
	 q+ZGsrO0JYIaxEd78ocivN4uaIdcqQXvknxJxLH+GnwsAvKrl5L6SqNceDn1Lw2DBzcw5
	 c2THt771PfzU41AuKB1bQ9gfAqeaT5B83x4xIqqI9U8KrfpSw32kIacg3mPuvJ9nWpMgg
	 JwJu7zUvaHuOXurlasWir3Bkg9wibwSVonZzO4R4A5ICv+oWns2idbT33k4LemqMzYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uF3d0HFY;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D9606A8B7
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 10:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 255D9606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uF3d0HFY
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-85ac281604dso2520754a34.0
        for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 02:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826389; x=1795431189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5hHzWFY8QOCU0RYZOwwYvawpWnrIbJa8B0acXUTVWs=;
        b=uF3d0HFYUTmJUh5kgskypMm2Ak3E/pN05uZNT7oQ+q8AcsWOviUYcar4iAFxio3LRl
         W83h6YZyUt62Bejbm9gVitEJwl2mx3K01IeTqbJMCQATfVKgZAZT2Aw2IdBiZFwCTjTx
         exOF+gY+7p5OXk3V5aRqLR/Emo56toAYbG88Aox6O1ONkFNT6SkBwNAgV3fqQ+BmXbrX
         umlqmR8SpnerjC5JzNybWH0tBr+M9JB7CO39K49WCzefoJyGyYnF3XR72NdVQk14K9mE
         cgWuEPsQXPrcJK483oSrTkJuEbnltKu1b+NyTNkLQMJXMpPa63XBuhTBl2wFnvzzhSEm
         Jk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826389; x=1795431189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5hHzWFY8QOCU0RYZOwwYvawpWnrIbJa8B0acXUTVWs=;
        b=hD85BHpTTfl21sYmXfCmoG3k57QjkQk3gNwob3znzoZQPe99nsf0ZpmTvZfh8X7Rsk
         NSMmbLhKWHReuxFO14blubcDv8apMfvbaXu56HrEvcMxlpgQ6E9EqAYLbJ2RXGilhf8W
         dgqfCbe+xUy0tvzyaq4nhsDpa8IQJ1rXFuZRAO/i9AOVW2nJsgOobIxv13W6ZEO2ZnEt
         tywUriCKzoJ6I3bDYV32nqK+JBomNUfsNPGUu3k/g1yWygOY3utR57jPAujVhwSGjl+c
         SrZ0cQilFLypRnPCLKmAdClU1G4AKOIXm/6q3yId0r/NPN8XdIcxYTEqJbiS08BWFq1+
         8mgg==
X-Forwarded-Encrypted: i=1; AL+hErEVlIfLkM3MudXt5QpGumlAzD5DUxnuU49VROgdiCnPjl/nR5Y7jb0GUy6PkUits8x0iDRPCXEwi+Wl4qI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GUd/kXgBLqU6DVUsHJqQk77hfPSeWYwZ2QdYlvMn0lgJ6kKTF
	Uy0TQR53BxTb00us9FobepG4CZCFEWZbLfk2PoMOQM26CyU4DEWphi2EfAYvLZma
X-Gm-Gg: AYBFou1fidvuE+8C11HNInfyCUo+hTN2IUylGJbQ68XCa8Vis3dEi68W2G2rA7RujqB
	JfSqDNr0vvJbZDUOeQqWOZ+7gYu3foGm1XZEST7jyHAzClhMeMCf4V9f6MTCld7N8QuFki37huV
	3Uauyl6/egaF7kSrdF2+6mlPb2FLj+AiREVcGWRzP3LoRVgLOdJIev5gvZRyWUbdkr5u7uti1Dr
	yGEoFvOhIAeUEbOXQc9cvF+pZZYZ2DhGydQ8JljurJkgUkU8/nZBjZatjtpxP24gNe8rrB1qI4H
	c8Nl60qM2wPxy3jMpxQRN57vzf1gO7MUMCO9teKRZAUsoDvMistXH4pEtSuMx2XEUMYaSeZHI3W
	vnHihpm+V6D6c9VgIZfGjPqKs2IDNX9POlqIi0rVIG+0vSOo4ZIvZm8HGsvUDwYf6gu6G/htvLQ
	7t1qgbLIPk3o4x8An+7gG94M5oBxXVgWDqCC/8ZVuo4mulXD+oZwjOzrhDUxoZ1mnTlKTpLCFVx
	OiNEjGgIO1b9PYmityJJfeSr/yokBmYjwm+BclkgWaF/2f5jt+gfcEohBUXUvN/jVYL0w5tapN6
	Wmo7Bz6t0PXJFZXupy7Foq2x4mrfUGs6CMwX3tNyggnrylygFPtd7lXHLINV3g+2dvCr7/75QIH
	yqyRXZSq534/kctKN19LOcJNLkYbr4E/dyhYZZZdcqHccDvZDeQ4uKLV9GIFeOxGtU+ttnzxSvH
	5XX9lyY1+Ar9x5HQokAsL4HnZhyceiHS0RhOCb2me2yHohRqLL6RU=
X-Received: by 2002:a05:6830:4125:b0:862:c685:84b9 with SMTP id 46e09a7af769-862c685a077mr2638283a34.10.1794826389152;
        Mon, 16 Nov 2026 02:53:09 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862b08b8b5bsm5555546a34.5.2026.11.16.02.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:53:08 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 16 Nov 2026 03:52:32 -0700
Subject: [PATCH v8 4/6] dmaengine: dw: extract hardware-LLP residue
 calculation
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
Message-Id: <20261116-submit-dw-dma-synchronize-v1-v8-4-4a82d64fcd1a@gmail.com>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
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
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

From: Serge Semin <fancer.lancer@gmail.com>

Move the hardware-LLP residue calculation into
dwc_get_hard_llp_desc_residue() so it can be reused independently of
completion handling.

Keep the scanner's LLP snapshot, descriptor updates and early returns
unchanged. Only one transaction is active, so the helper updates its
cached residue directly without reporting a completion indication.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: extract the calculation for the single active virt-dma transaction]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 982a4b9bd678..504b6ddeccd4 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -214,6 +214,30 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
 }
 
+static void dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
+					  struct dw_desc *desc, dma_addr_t llp)
+{
+	struct dw_desc *child;
+
+	desc->residue = desc->total_len;
+	if (desc->vd.tx.phys == DWC_LLP_LOC(llp))
+		return;
+
+	if (lli_read(desc, llp) == llp) {
+		desc->residue -= dwc_get_sent(dwc);
+		return;
+	}
+
+	desc->residue -= desc->len;
+	list_for_each_entry(child, &desc->tx_list, vd.node) {
+		if (lli_read(child, llp) == llp) {
+			desc->residue -= dwc_get_sent(dwc);
+			return;
+		}
+		desc->residue -= child->len;
+	}
+}
+
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
 	struct dw_desc *desc;
@@ -270,23 +294,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	if (!desc || test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
 		return;
 
-	desc->residue = desc->total_len;
-	if (desc->vd.tx.phys == DWC_LLP_LOC(llp))
-		return;
-
-	if (lli_read(desc, llp) == llp) {
-		desc->residue -= dwc_get_sent(dwc);
-		return;
-	}
-
-	desc->residue -= desc->len;
-	list_for_each_entry(child, &desc->tx_list, vd.node) {
-		if (lli_read(child, llp) == llp) {
-			desc->residue -= dwc_get_sent(dwc);
-			return;
-		}
-		desc->residue -= child->len;
-	}
+	dwc_get_hard_llp_desc_residue(dwc, desc, llp);
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)

-- 
2.53.0

