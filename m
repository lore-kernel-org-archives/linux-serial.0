Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295112;
	b=rghLKwGpYo5yPbKWcAuXV1dGpc5rEXEyHh45wX+BP+kK91Ynv8v5iiK3kyX7UcnLbgrp
	 F0biNMXmR1jm43x+HJRl4Xkg4xwzF7iczJLQ9t3qj3VsS7Ho12X3JoX5ctM0UYYvGtYuF
	 TQf1PU2hS0Zlw7Eq21ulr8cR/62oRzNEjTQyHbvd2FaLEzpO7yZ/xhqrJPVRhEDJXo++A
	 ZC841GxT8uitrGHgi+uAUdduEpaq6Azd3Dorx3DJRO1FGT9k901EiDl19S+4I9RVv03D2
	 s+9d6punp4tb2j6SvbPzSQCLS5c2QSWV2p3f9XWG00i7jX8GF6y1+IpaqxAamJ0tioA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=hOkDAm5C9odfejCA066hItzRaUywPpsZ5Ql9NYpuEuI=;
	b=ZcUIk17eIzOUhig9aBWgzbbyEh2J+0P00M2BoSIIoV0qQB588T5Kcn87/baqQEYdY2Pa
	 t8F4iGCFskE70BZ4fcHeDgimYvZW79j0lkCK46vY6WQe6u1ilQP5Q4zZFUD2W0mWqw+F1
	 dAP9XvwUoJXrapBiyDDddmB+wq9EMlUNXYt/QTm6Sm3B3sm3JjhA0IwFnLBw7MNWjb+3U
	 y3V2iXmT0t474/AVZ5/vVjSUZ457G0Jor9N8A/8VUO1/r56XFx5FWnYeXIsO/k1GiWUkE
	 mbfYKCQR7vClXtNsMmjMSBGdhGr4iCxsT8RyQuhYlIiezw04L5a9iHsvkEEoSZUCprA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ECwppMr2;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3A606A687
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 21:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7E3A606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ECwppMr2
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-71ad5f20016so1420713eaf.1
        for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 13:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795295111; x=1795899911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hOkDAm5C9odfejCA066hItzRaUywPpsZ5Ql9NYpuEuI=;
        b=ECwppMr2iaiCweGgzYOx7H7vE6IhmGHoV4YCRSdYTUoxAbF2pnJ23mtJtPA5l3ixC8
         uKnHiVm8xs1Sc8yiFFwsGqku4NvLIc8D0eNZz+w7Fhq22JSfR4tEY2bIJP2DARGpRqqw
         cqr66VI32gJhgkMcw8ZA/ruQx/1/LddgYcpwqCJibhFP3fTnaa2vcZTElH+xtKUPN4nV
         s+IrnIcv2lBYKzJfsOtRcHECIsE2jNwfh8vyzqO4cyVb4o05sfv11zee1zAPH5xLCGia
         v/Dxl/1ldB1GAj62QQv/3+H3cfkOcRAIwReHn38d7Tfd28sDvM1D8KP+HHYcO3Nd9LSu
         3VJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795295111; x=1795899911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hOkDAm5C9odfejCA066hItzRaUywPpsZ5Ql9NYpuEuI=;
        b=xpUCIWM2Y8npjOrM6r047TU7QTLyHxwb1vPLp26gTBE0CRL5HbK5vTkMX4EXvRP6a5
         tacGuBC2IMvj4p3wGQTUxOHyqZs0qq4SDWUn7ANid8WIAKMd0vzrz5RqPgvHEtRZ/Bi+
         nUlPa1X2ePLDWxv4IHvtuyfsKHPGrr7iDtPIYyPmiBVxMChLaP2hi/jBtJYdVXaLERrF
         33HlxZbv9xhlGIk6mqGabTn8euA9ihA2YkjQOZ45I6+l6TXKM6bjhBDSWRINbqTCrlwc
         vYxgaZ5kwzfShhYKOFDGO0TJ6OfDRWjhk01qvnfKj0kwsAoHgM3Ko7k1EXC3i7fMyuNR
         Om+A==
X-Forwarded-Encrypted: i=1; AL+hErHKZsQUjFflO9Nb9MHNP6BvyyONN7Ga63wlbpnrLb4Ku3LdcGOKooEx0OTdp+O3JAKsMps9qyUv+4Qz0+U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8etHU8Za1wtAddgyNNqzk4UtcOfpeG4RZ3GVcrzwxclJeTOF1r
	oydEIaEP65Gom0tQtfmRHry0BNlDTc2r+I4xsZt8sL+QgLwkeTXUBk2B
X-Gm-Gg: AZFdTZed3nhc6Rbay+HRewNvFV7isAXDC7RbNgUXIY//CklFLaDu2WzzUhiYHxT4an6
	ayRXZ6eme6jZZ8JQYvKBWkcCOsAo6w/vwDSJwxBZDjHkmkT3B4BoRKlP1lRCFqQRtTsaOmzLVzx
	aaeE333k4En3dIuM6AtWnRGILjfWmHMrPKWWoQRH2VWZIAt3AaOfOFwCPXpiK8K7yfQPimEWq/l
	V9Gyq+VJt8mAQaEJ0XU3xeF+jh8xBQm/NLexG7agVIvnBj2SujPut16cIjgG7WcCn49GaIwoBVl
	+uY/QZX+JOOhrpoMeE2RzC5UNUfNJsH4pmA+qTK2mcl+TxPXikxD2uuA/1uEBsMrNFSH3EkzJ5B
	SRTj3Na9laNuiO6f+isrx3bac4VWMdXTfhlSHd4QK0rDs9v2xsy9zUhDcRDDkPEyjYuwqOmZgsZ
	66gTO481+asCwWbdtfYsb9zcUkKLEaisoOGpnrn6zaGw1nubBhA6Svxj5oev5ZzxiUEHtKX3xwm
	VMu9a7JOrjQtlzdEoeS6YE41oeZA+865rPujkXhNyhN/kEogVr1ixhqe4d/5DcEQ9RULYH8dokT
	etQbKmABwvjtbabqPpCSHyjcPuW/n9tx2EafCPpnD0fELDPMvpjjQPxpsI245IBS1VpfaHULRJE
	vspGfeQiMvjZjNINf2cpRvsT5qEo3QMJM+fZqGZBUBH7vFoFi+cBgz8Ko8NRJmwu5Tu6DTODg5+
	02H4IbDDXUAKqyn4HTlsqLzZvEENHeOHSdSES6UnRMEU15tlE0IcYx
X-Received: by 2002:a05:6820:f021:b0:71b:1715:7ce1 with SMTP id 006d021491bc7-71b39043d0dmr6285699eaf.0.1795295110819;
        Sat, 21 Nov 2026 13:05:10 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4635728eaf.13.2026.11.21.13.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:05:10 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 21 Nov 2026 14:03:20 -0700
Subject: [PATCH v12 5/7] dmaengine: dw: extract hardware-LLP residue
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
Message-Id: <20261121-submit-dw-dma-synchronize-v1-v12-5-f51eb635209d@gmail.com>
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
index d00d0d53f6ba..150823544f40 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -281,6 +281,30 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
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
@@ -338,23 +362,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
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

