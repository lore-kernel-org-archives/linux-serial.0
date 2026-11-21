Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295114;
	b=YRqFJhu8S1lod58nOZT1R0mqjPItC90Gp+Jh7F0gs6F3EL5aOy1D/Awax2icp9gQ1KIG
	 k20OwglYsZN23GwNNDyS+bF2LfZU7llrrGh3bnYXnnWRlvGKKSKjtrj12eVCmsnfKhnFs
	 kG0s3ivvFS2pMToWRP7AAporYYxpFcwNY44AvuRGNEL5F+2WkNLUaABCfrWh/l1Ohc7X4
	 z33QnQlFYI5BcDpXN7HKb2npKKwFkLwsw8bVD+Nx9qL7vYiNEGNlk+zes+dyRA30R92/T
	 OJ2+7iLbwRnqD0Lbp7dCHapvn/WRJyJm6JF3svba78cgdXvli9ni8Jo7R5cZsdUXUwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=cwro0UOYQ0UfVNk2wuoQ24AVLO12akBtg7QGpsbV4Ik=;
	b=o9h3YwIIufonu+rvmaQk0IVxJNWdGyCmhXKg7wq6aIausC4zPqmBZVVf2NmGLuCM2WdQ
	 X1QkeWyN6PDEMEWRHjThJDEN5KX84iPwg5xaIpazJoAXpBnvEkEIleJ/wn4sLGMXoIT5A
	 GbVcbtUJ8o8pMTKmibMjwS4XQq4O1RUxI432yYDvohd1Jm31VJRxdJcomSt7hes+OsJJY
	 KoLIltcBbYgvqNab81PYSjcBhWVYFZDqlfrpXEbcEufBTZYl1tclbNZ1AEch11CG+h0FQ
	 KU5FiqEMTy8mJHDewakFq58tZjxlFvFkNmOZqNZqcBcJ7tEw60RLyxYwaiCYCcgfqPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cErZGLMi;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6EE606A68B
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 21:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA6EE606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cErZGLMi
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6e560e00a86so1351235eaf.1
        for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795295112; x=1795899912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwro0UOYQ0UfVNk2wuoQ24AVLO12akBtg7QGpsbV4Ik=;
        b=cErZGLMisGKbZOe4dhg3s3t4ErpTzA3AL2Payj/DvsLmP4xMMy7hLIjdZEXDL2v5Fv
         9K5cRzorsfp/6p21Deb5ASj6xAOsQeIXQhBAEEjN2yuexp7eyWYD9+JF99EV530uq6ZR
         qD+Le5nWOY4aVJ4M7cCqz/Gs35Zn0kXW/K0So9Pard1yrrZqH+klEGghLwsj88R6rpCL
         jTTw65DbJRYwskHrx4U2ZHPrb/U6VK18iyVOUuCxeJJtGyF4UhrPYxub9hlwYoy01nIB
         PFq+DeLMAQepE+h/AkzaiJQe1KegurKjtf6CsZNLIADAbH+SvSesuto8dPhTrLI4w1tK
         StCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795295112; x=1795899912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cwro0UOYQ0UfVNk2wuoQ24AVLO12akBtg7QGpsbV4Ik=;
        b=MImNpU3zFlY3ahhfEKmoHmPijJD2Le/W19G8tnYuedBkfT+O7pj9KfUKLE0OZIrWZX
         nYn0W4BgAle4+Cl6sQRC4jpdw6R8wBorVnX73ZH57+qZ4SVHDD0nswkV1OXVL5mXSBL5
         JSJGk0LEtFmA6SW/XxE0QTcZobzgm3fCkUDCAX4B0gHE7w6Noeybc9IcsyABzEtDm/LF
         IxFSpmoCrxz7W/JsV0SLE53tYKN7Mgedp07clRFL/JgAOD+Vy8ErECPStFWPFVxHCXaC
         hNWH9ZjHfciPYOHeL+y09dDvhcenB5usqNMXdFyT0Nt3cAetuUgOdqfWZVYyA+ciLmYc
         +U7Q==
X-Forwarded-Encrypted: i=1; AL+hErEBDrtMQ9CZmPSr8cnS4aExr8BLngYz06BotjagkKk1wycgu179RHiwW+3ajs86GkLU9fOhGIGFCCqFIdg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8suw0Zv/twBai7X9HmU4ly15yMWO0iXJ+ubCxkJaD3F7R5SYZ3
	yRbfZ9Zv91ZV62XQakdVq1025wwe3dcyixZZIPEx0UzA2HS0qM9Y0LO8
X-Gm-Gg: AZFdTZeAtQfde0K/feYsZN3yfffgp4L098vv11OX11KvVqUwEdujZDFvGSC4v3VS4lR
	Ov9ZbDI4QMePohzXJeXXmTQ2nWNDogYl5XC1oGumyItHPjbNPeqWFS/JipZWhHtASc6xTR11k/T
	TV6sEcehGdMiE+pi0u0Q0Snuyg5gihvzqMNPlDPoA6eLxiUtvHpgiSd3elYrW9cJiiaArScWStr
	VLlrHFbPcT1c3PZMqx6D6z+v27xwhVFyKhkb7vXVJAso/IS7cyAH1Ul9RJjJfZYvfBC4T7fzdMg
	hj5WdVk2l60lzONdKS6BTD9Zfx/JOK3n+JkoZSocTMgLUENncUNUzdjQ54IAjzIv6W+n+KIkPFH
	m65IxlHbns7WJ9htynorFetm8xGD9aYeB3kOGvOjl+ZFi7H1iz+exGdzOwVhofRF1GBT06sWWy3
	ZCRZ4WmaLfCNws/JG2zHU4BARxnJ5MzeKHYqnpHdng+OW++lnIjl//cYEt7aDaxMcQ0y8cheW22
	UrJGp0Jj+XkO7iTk/HTB2UEbYuOUZNYKgE2oQM0uWJitiqwXrXCZ2zz9eCUWez6TbhPmIacPh7n
	a038BMJxWQH8zhwWhQY/grzSfwO26EONjKiGRqjQZDcqqkuoYYlVy0HpKrIA++IzWgxj/Dp/8s3
	KpzEaMFDE4WSBgG1e2MwQLfvjvIlJjg2N4adTNThsuwX483YKCFdylp0J/QCzgykba+Zd2oDIRQ
	RKjaA205GnHCglKAm7RabrGKtAPvKHCaSBOs3GuTsC2xIdILst58Dv
X-Received: by 2002:a05:6820:2ad3:b0:71a:fb85:d07b with SMTP id 006d021491bc7-71b3959c733mr4998099eaf.54.1795295112153;
        Sat, 21 Nov 2026 13:05:12 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4635728eaf.13.2026.11.21.13.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:05:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 21 Nov 2026 14:03:21 -0700
Subject: [PATCH v12 6/7] dmaengine: dw: calculate residue in the status
 getter
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
Message-Id: <20261121-submit-dw-dma-synchronize-v1-v12-6-f51eb635209d@gmail.com>
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

From: Serge Semin <fancer.lancer@gmail.com>

Calculate hardware-LLP residue while looking up the requested cookie under
the channel lock. The descriptor scanner updates cached residue only when
no transfer-complete event is pending. If a status query completes the
current transaction and starts the next one, that new transaction's cached
residue has not been initialized and a query for its cookie reports zero.

Have dwc_get_hard_llp_desc_residue() return a local residue value from a
fresh LLP snapshot. Keep the persistent residue field for software-LLP
block accounting, subtracting the current block's progress when reporting
status. The descriptor scanner continues to advance software-LLP blocks
and complete cookies from RAW.XFER, including for polled transfers.

Fixes: 4702d5244ca9 ("dw_dmac: return proper residue value")
Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
[james: retain polled completion and software-LLP progress]
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw/core.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 150823544f40..302ff591cde0 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -281,41 +281,41 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
 	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
 }
 
-static void dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
-					  struct dw_desc *desc, dma_addr_t llp)
+static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
 {
+	u32 residue = desc->total_len;
 	struct dw_desc *child;
+	dma_addr_t llp;
+
+	llp = channel_readl(dwc, LLP);
 
-	desc->residue = desc->total_len;
+	/* The first descriptor may still be waiting to be fetched. */
 	if (desc->vd.tx.phys == DWC_LLP_LOC(llp))
-		return;
+		return residue;
 
-	if (lli_read(desc, llp) == llp) {
-		desc->residue -= dwc_get_sent(dwc);
-		return;
-	}
+	if (lli_read(desc, llp) == llp)
+		return residue - dwc_get_sent(dwc);
 
-	desc->residue -= desc->len;
+	residue -= desc->len;
 	list_for_each_entry(child, &desc->tx_list, vd.node) {
-		if (lli_read(child, llp) == llp) {
-			desc->residue -= dwc_get_sent(dwc);
-			return;
-		}
-		desc->residue -= child->len;
+		if (lli_read(child, llp) == llp)
+			return residue - dwc_get_sent(dwc);
+
+		residue -= child->len;
 	}
+
+	return residue;
 }
 
 static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 {
 	struct dw_desc *desc;
 	struct dw_desc *child;
-	dma_addr_t llp;
 
 	lockdep_assert_held(&dwc->vc.lock);
 
-	llp = channel_readl(dwc, LLP);
 	if (!(dma_readl(dw, RAW.XFER) & dwc->mask))
-		goto residue;
+		return;
 
 	dma_writel(dw, CLEAR.XFER, dwc->mask);
 	if (!dwc->desc)
@@ -355,14 +355,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	dwc_retire_cookie(dwc, &desc->vd);
 	vchan_cookie_complete(&desc->vd);
 	dwc_dostart_first_queued(dwc);
-	return;
-
-residue:
-	desc = dwc->desc;
-	if (!desc || test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
-		return;
-
-	dwc_get_hard_llp_desc_residue(dwc, desc, llp);
 }
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
@@ -969,9 +961,10 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
 	desc = dwc_find_desc(dwc, cookie);
 	if (desc) {
 		if (desc == dwc->desc) {
-			residue = desc->residue;
-			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
-				residue -= dwc_get_sent(dwc);
+			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
+				residue = desc->residue - dwc_get_sent(dwc);
+			else
+				residue = dwc_get_hard_llp_desc_residue(dwc, desc);
 			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
 				*status = DMA_PAUSED;
 		} else {

-- 
2.53.0

