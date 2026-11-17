Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955748;
	b=UGhfZ/ouWl243uxZTTWbt+n9BSWXC+2OTkqH/VfMjL7a0VLNHMfRW4NOv1h0mC6KhQFX
	 JbaIohe7RFLkAffkhs05+1uuNAfb1z4doqh41WsR2dondC9uxnkH6D/TJZbiG+N2Qy3NV
	 C9098G5+uJZo0weCgdyQOF1Kjnr2EY5yOBl9/KIjkGEwzdQW1+wLRyGkb00//m29FG6cZ
	 MBPUtKqcAaPbbFNHxqJrQmzaWa4ZW2jJvE+Sy2ka8ybxxqFR2Z5QMB2N47CBmomVK+KA/
	 Z/cQYsQOCC5EjXCPbXp2mRQLmWgWWV3Lk127HI2FXh4DDVXXwcABEXv3I/lHTwOcXYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=t5hHzWFY8QOCU0RYZOwwYvawpWnrIbJa8B0acXUTVWs=;
	b=vf+EKgGSVfX/+Q8t8X9pApvZamPW/+aWqfsZ6+fwdZildhQy4oeQEWgduMcJMX94BVWQ
	 tq5pJebNFf5mxpLF5+pUTHQaWADUR22hvijKDTN4lyYd0krxRm6WtqlIXiIZarYUT6Txy
	 nQ1OUuRFrBoal41PeDPeSEmVDzLo5mEAi40jQfCiPkH+vLnq/w6Pm/zmUxh0pjCTEwghM
	 ks8PMSGTbonQlJR7peFsnTRw28lSJfuIZHSOsXqOOq8lSbjTmvDDK+D/w2Z92h6UaP9Rt
	 Jr1oCePR0iSvjTlEIlaUxiilDcj2WDlFX1p4GxS+djZZbSSJoxNCB3vxm2pFaEY5k/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AyEalmPB;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C6606A88D
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 22:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 119C6606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AyEalmPB
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-49429181ce9so253626fac.0
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 14:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955747; x=1795560547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5hHzWFY8QOCU0RYZOwwYvawpWnrIbJa8B0acXUTVWs=;
        b=AyEalmPBMPz0b3MRazrgpn1GqD0jzv+rVAzxdGw50a8lsVqTI4DPBFMO+k0JYVDsmf
         z3/KU2ytnbK8urMj+N0WXVskL2/lyD1NVm0TvGSdssJbTWG/AONgYRKcWNxEr4Jny4ze
         1ROzfDVlSZjvYvxH9ksiWmjhvbef4NbE2y7UzD4HgqAuQHPID+OLueOELoVcBOhXmBSX
         P8z1lS33wbW1gz5rUmp8rZaW+9RNKw31NCfGWrN/DBiALPijM0YIVkouEU1m6aqqvPcn
         utQPa71Szxni148rJqxKscHx0JBB5+exfBRUXdS6V92e91rYSiwrYOI6frB9X8LPkDNf
         QiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955747; x=1795560547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5hHzWFY8QOCU0RYZOwwYvawpWnrIbJa8B0acXUTVWs=;
        b=AVSN8rroFtgWZP8XBtpUcrIhJh9K8ahGyhqsxT4P+Fq67B5DjTFXH64X0pHoCeyiG6
         r4OU2sAOzESq4fwSuVq9oYicJGjJ6lB2TDucQePiYY1Wk6MhKjZzhrctwTrytIMWThAu
         O/Jb/jpzX+zUM5ocr83X73Di95MgJD3phYrWkkYwaGmOqPSUEuwicYbiI2Zm9K5TajzG
         lsTCU9gt5Oqh/TBNLnAa8lLtEPwgdTcOnBqqGbexFmnMVuzdFT6D4O1e1TSrdK/plPsc
         0h7QxaBOxvSG/6Wpvk1iw99LIbe1PeEskqH2VDPocO1uxU6lNu1oEp4ukn+4Umpsdm/e
         5Uxg==
X-Forwarded-Encrypted: i=1; AL+hErHzYci2SeQMJ/DVZIexdPznZy/4uEF7MH1I7zCEgdyc5JItr9AUc+BcG6C3hJfEc9XrcfilaDYcwQNnI6Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z98R+aLNOmw6cYuB9MGoms8wB0Iu8chgL50iFcGBPpUh5y8pEtB
	F9oNdqRjpg6N3XrYhQFQ+0oHu6CITKVx/tzf2TresZ+O31OFrB9zqMPG
X-Gm-Gg: AYBFou28jNt0C40LkTWx5w0OeaVajrB96Lccmrog9E9nu/Sq4jsQWYsW3NWtrF0EkPC
	rpm7xEakgJ7ZEw0DFCn/uj/BZWbZJO04Pdy++MLXovHsT+XST+RM2Xa7FnW5HSYSp3sNVOFN62q
	pdxYMzSvfWBvbLtbay6j0qf8uLfAng/DStktbDi8kqfetmc5J+HhZKJEw4DdISEeAlfAdC4/vG3
	WOABpY3eIEYimVKvL2zMGJPD1GtgvfV3/z2vFMWNOf6SmLlD2pX21BnqwV5gDM4UYhIHkNX3efR
	8nOPOI1P0jZD64mvvhp5bq54oYgC7L1F6udtkMe+FLEKQhzqhPl4VGBQCMr+k/36XEqbgGXw8Gv
	MPVS7bRFpc2Mv1Pk4HX0bqJGDV5uE1GH6nXb0mV1lbsQHy1h7E4/h4PpHXOTHqzHNEr5WtC3lnG
	sgZy197ECuN/m8rcMkC3ayDhqlECAe/TfSY1vR7BYnHGGm2L6+XZ9Pe2IbpOJCAOTx2ONSLTXa0
	sPJpzcCtxSUfhvBPHZ3+6aEdtn/AIApNfXPYzikbp5VKs0o01ywTWFiuiNh8+Ep/rch5Ew2KgW8
	poQtcKtVYhi++/pyzspo3mI7HwCbJnIoHhU6ELlxa84DI6XaSFbv9NdQqaThPMm2ud8/STG7YS/
	1ChX9ye2n8kbVUS1gPuo2n9HZqgIDFGQduVKV2hvFSycSueFnfVkiaTBNVmyfANK9HPWrOyr3p3
	U/SVNGN9tnthpOhpqIKBQbNV5irk7ODi5p3olB5FVaNCFQ1ss8k5U=
X-Received: by 2002:a05:6870:c0d0:b0:4ad:5d5c:29f8 with SMTP id 586e51a60fabf-4b7627ad063mr526790fac.53.1794955746828;
        Tue, 17 Nov 2026 14:49:06 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74560af5fsm583066fac.16.2026.11.17.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:49:05 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:48:39 -0700
Subject: [PATCH v9 4/6] dmaengine: dw: extract hardware-LLP residue
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
Message-Id: <20261117-submit-dw-dma-synchronize-v1-v9-4-7dc066ed0bcf@gmail.com>
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

