Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082554;
	b=BjnmrqiP6yWqDjVVoUfVABKk7m0kBH3Pm046TfUQXRzjHfykCp24IdXbi9JaMei5CRX0
	 UfouqKlCEEgN0xLiC9wxaAsxhdpPnwVrerUNBWVbNaHT0OcSzg/Z7uUSeLCt+qo2/k884
	 E/fz6rMB7rQvg9wrWihcehrqM1iLcZPSmvSsz5MadGN6cygTAOmINSTeho1fzUNVQWtL8
	 R5LnaNzJ2Kq3be8wUfuTvnxa0P1OoevU/+rD2XVgC5hknot+6oBz6LfzF7hkhk3sSIogn
	 gbFJthaSeqQd0kDzzS6TDVcf0HZzpruOpn8K9buUlW47QOgfvPhgct/yzshpTq9aiyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=P+uR6LSFUuS82mC117S1N7GIewTkAQxRxMN6R5yzzdI=;
	b=JCLtva1vFLQpoDjB+rcnYwKhvgzRWMaXyGsy2KgN4v8vcmF5ECyv/T8ci4OSJL6ST0RA
	 CMekl2jtI7Cda71Dm349wvyE1WvtUqbB+MA4ir0a4sdQ6n3AVFmQayE4h++iZjgIOP8Sa
	 PLIqG61Y2axlyI/IiaILofrGlN/Y7Bv7f4GfEpJ4IAOaQe3LBHgOShDm7h9vLBcsd/Pau
	 RQFlb/ZISo+GJQNJnIMf2iKX/WT1Q1npnp9nN2y0bqznY0T5TtBS1knDPrDwrm74yrJ4b
	 EQsdUlnFX5spHMWe0FvukkpHIzY8bQjvr3lMRlhDi6XwYc+DnbDZoIoLsoIPSjEl0sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cP6joHov;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B229606A33C
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 10:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B229606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cP6joHov
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-71ab5e64742so1255543eaf.3
        for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 02:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082553; x=1795687353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P+uR6LSFUuS82mC117S1N7GIewTkAQxRxMN6R5yzzdI=;
        b=cP6joHovQZxfV43Gj96NVapePF4F1oLgVJtWAla1AWdzBfxMQwA9jaN5Io5yxybHn1
         fVOFwfLb8NYuqrrwLt57r9meftxKoiWP3sgfCdZcBbBmyCuT718TuqYIR8ONvnzB8OSK
         OG6JsPd8IzNj2CzXWh7JUicQsOW+HgU+rJIX5oJlxOGBQIiOcrzf4EV2Y9Y0EKmHfsQs
         tuqz6xntkRNn6hz+gFoivwpsu7J9bkp640K9+1l3Wq/JMZ1WAi5fulfez+bGBvfhmL14
         h61m6Sa8RCzsjxzMlyGQGfu57E+/xvW0an9G/WJNgurm1+Fk11xbYE2Sx/xH/QzEA8dX
         ALXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082553; x=1795687353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+uR6LSFUuS82mC117S1N7GIewTkAQxRxMN6R5yzzdI=;
        b=Q2vJz8PAh017Oqvmg8QFygGE2ATJElFdkDXIsZWKs9rG3MlmN8onSCCFRw4RUW6+NJ
         ewV8JhaEY0mhX5M8b9a5UAb0l1mUhXviJHSOZYWpTCXhs1qGXgeT0cYBYrqAchxOAoxz
         CO9sUHHb9eYR2xuor+TbCkO9RVArVcuWl6fMsCUwPqqseNIf+nFLqNKdEdfAds8cd4Ei
         r9Mivx/EwS6lZ5kMZH7r/z2lxYYHWCTHSFbZwo/Ma4TLSq9G/xf4RV7SmZbE7FecSPZ8
         hYODxcPvIDCgKSdbd5TNbCXO5Wa5jpw4XzArr9Z3e8oimZQzRjggq7/GUr1Ezfz9va5v
         aWvw==
X-Forwarded-Encrypted: i=1; AL+hErFaWYQHBh7+QdrBd3IGzsn6ofj3inCIrFEN4Y/rIRoI0e6A3c5TbA18FXdWRGhmde13jAGpURyX522oCA0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/x1kFLqDPFcQ05WA0TUZ/frO14iPeJRWXgoDhl8Wf58bsTePSw
	LHpPfa9/WheG5lhoCDlgv42eYj6nsJ0NbcHZV8g35kebdtcpxxMn4HKX
X-Gm-Gg: AYBFou1dg6Urc/GROK/RQtDq/BE5W0lN4Wi+Ej0zkMP50sWPJmhXz+ExA6kft8beXKY
	m8NtnB+C02i6QoHp6gfH57AiI/QaRGv6+2nIuHE+jjR2hRnzAdLPHhVEBNYvMk7hYbPBacxYU9l
	bD7b9mVyKeeF0YY6/bd+IgJnCMH527fRWrOtmL8a4IDDAscd/ODvNqJtUaV3Hqu69RcvFMdITTg
	COh0XYK3I8bJyIEhwZd290ivZdAJbFv5Hs+e2sIurydh7ccO32/itBqjhPQtrgWv5BE9oLycXJx
	Bu0tYo7jvBT+SF9Tjz5ucf7DNnoSSg8ssezDeMtt5lYlc7wO1tWgGDOO3hcIXyTbAFn3ELAkfcj
	AQm8qcUwdl9kfFOOsN5UvBACl3cqT8ste1c08bhg2wT2O/LYGppC9UQBejjmn7XO5vmEn70LvQ0
	Nhk2uZJ2rYRb+SZQxPjD4Y4jQc3+2aon8MFuGneEHlhWyQfgZpWVcmTfF4Gp1U+wtSYicliXYi+
	XNF9UO6oSTgO2i8Y1K0tg+mDIFDurUlUrahMHJTRXNQobWwhUQ1DD5w5AngoVP+47rs7rGrljB8
	cBecAhOwiKNaT1PSXiVR7IHb49nU+bEnhVGMMBD7udiT+M6JG1exgAZ+6lp4Bp1L57hETloQpHc
	loFg2abfJlzRb/oNBJjHxEG50A5A2GsZJhgnzUuwRk7f2IYL2HIXYsmPMG84XvUI3UcJAp6wE+x
	JvlghN5IS92KlPEt+J9evlk+kKaCoFeaEQAYIri62dX624sqCfUQ1h
X-Received: by 2002:a05:6820:c5cb:20b0:71a:fa49:2f33 with SMTP id 006d021491bc7-71b1848ea22mr2638874eaf.41.1795082553010;
        Thu, 19 Nov 2026 02:02:33 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b18fbb9a8sm3906194eaf.0.2026.11.19.02.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:02:32 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 03:01:39 -0700
Subject: [PATCH v10 5/7] dmaengine: dw: extract hardware-LLP residue
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
Message-Id: <20261119-submit-dw-dma-synchronize-v1-v10-5-3a737597a0d1@gmail.com>
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
index 0d2407c6472b..b556a39a24a9 100644
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

