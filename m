Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955752;
	b=nmcV4no431I3ZV2b1h3jNU4tVann+4OSvajv3CSwCcLfU2pDSNawynyNQEag5bIo+9e5
	 9N8zBDS3ec9k3FgA3/oGh4py2FZUZJvyS7fspzo9kZxH/isQtrRXVl6mL0oz/TcDmdrz0
	 sxs+lo2AGwAu9XiRIIDVt0FEAzsmVc3ycGGZNgR7eZfAPpyH3JBzPeod20+WgOnPcthLL
	 5ebWKU1ZN3AnJLrHhH9xJvta0XtRRGNPWB5uwL3t9FPeEzCTbIUFdwNEq28XGpqODxKg0
	 0+26pz7CBrNhpXp5mN56bttjkzoewcL2f6dUDv+QHnyMcvAVySCMhqtr4ywwlpPrFhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=k4Qm7XpfJ4IaAnPaVRdhRvip1Jdg3xw+SpQe4yTzGGQ=;
	b=PzW70oswhrrFX/GAEN5KtM/uT3wk30XBoMvEre54S3+6q9jFsL8QcFlNwjLtIx1YXhg4
	 K5wa39TZuonDWtqAJscmri5La4Cyd3Bxml411nHwwj8fCM9cB0Svzn5C0fCK9D/hof47/
	 v9OuLP6WrKo2+2Zl0GQPovtcIAnOE8d71obdl/5yNwTk1wMf5GvXG9zHVoDPmWhTRloRR
	 JY1xTmkQpbl69b+sVdIdEG0yoqZKoHiaPqR8qPe/6eoeW8b9GGw91x1xIRqaaE1FfirDZ
	 NMwIfJjcEY9kNu9jRdUvYcXeWQrwGzVd/wyiB4/2JR+5b5yIYoX++TNlITAcFN5ZIWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PcwrOPy3;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0557606A8AB
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 22:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0557606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PcwrOPy3
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-48eee44b908so223442fac.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 14:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794955751; x=1795560551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k4Qm7XpfJ4IaAnPaVRdhRvip1Jdg3xw+SpQe4yTzGGQ=;
        b=PcwrOPy3tfi3YBg8v5BHLPacqa4Td08uSUMN6sTMXCUIRMVBFU0iUEooEMj2SWEqLZ
         zXlwALAmDbfl86YT3JmsMoeUpVm2mCP+trIJhMj8bvOQjrGYGtgP2z+G43mSEWRN9teR
         JhMPLX+NEdQv4vbBfnEVSh7rUZlShSX/6NR4yFEuWXTL0eX+/+u14h8hHqBL/SlEM28c
         P9km1wHqaeOSrIpkNIoiX3N3TPYTq99ghrE0V2/OZDo7CA/+S7MwKVMnM3OINxV9XdKX
         nAD2227a7/DYkwBSGKsGxWZQP79S+NhVi0P7S5Z8G0smZSgYa35O/rJx0/w+yMbJe8lY
         CYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794955751; x=1795560551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4Qm7XpfJ4IaAnPaVRdhRvip1Jdg3xw+SpQe4yTzGGQ=;
        b=HPcqskrMLD8hMJB0mT+pREKENouWzC/fhVFXhGrSgpqRMoK+GmoB2W1IPd7CMUMMCf
         nP28Ft4G0bhnuK3miR+RsrNtAwihGg2NX2+OYyU+2IWtDRXGJ5pUohvq3YJg3PwE5Myw
         nsYfbw6aGwYdQuEsnBog2oOlL3m0btg5fvN2/mRvRjAQwSxbP9jd3Qc/WhzVHvVRfqLe
         B91Yt5C8R9dKZ3q4aiQL+mm4JiyYsrCF19M7YW8cM9sSR3hRCWHZezBWnyU8vbO8ekns
         2G1QBp0zmU2oXRnmvMifEZSwonAB9bSzMsVjH/AId9Ey9Dg4PMrMUNFu1lcU4nrpptBW
         BIhw==
X-Forwarded-Encrypted: i=1; AL+hErElqswTXKmsfTlf05paHfmNZROk/iXc5X8p+j/usqa0a3jNiHwEjQ7MJfP3n/pME1Clzs40BHY+GLGwpx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ash5YHWykZjeVTh49NewHpe6LqvpzrlI6YNj+LU5jMuiM/RXQ
	zb0TLi5WtM4My5PoAQvtmByyGtrCwNwYelooClaHgcaZbhkJS8HTmXG2
X-Gm-Gg: AYBFou08YVjeS4sujKiH1cAxV3rSFPZsAl0N1i9+ggaFJvmdIRVJMpKKZE9nlROAwHJ
	Lo8f12BoEPJROHnwyYhKUs4HO6ekZtzt1KIh0uhBpV/1e3oQpnafWsEGHgKjfB70r2ndOOYHWc9
	QIgrFLqz/0QwABFYMb7dzg7npr/pKnKiVrEXKYPhXO6ei/2EumJ2P5ISheodVFkZrVxL0CfrQXY
	rPM/b1uEw4ZDmJgkmj6g8dG2WL0XOHB7uwxl5BwC7Gb0LRubP0u7hoVcnw7wbwN4LNX0rpK/XVs
	FrJSpOixxKww3KoSuzisQzypPmKSetVIvD5mf/j0PfhYO/t5t7W0ATYQYvBED69xquJAH8KlNaW
	Tm13HZIx1q2T8JPHJiUEY/706oGisAi7H2Elk58+JCAIxOXEtZLKBK7vNuvFqdYGN+pR1XgxOWl
	vQRiI77cCBlTDbhXTS/Q8KoO154JXREXbs+n978c0+CIXHhSv9z9drlsSN7rQG+JMP6B0BgUCz6
	00FKpe2/HoLLtVKJWhWriy1bkHum2r0jJcK5HC2kk9RZJsr31qYMQfoq6qB6Opi9XAUyqFdBsg2
	/bF9DrKb8tkvaaY9hpV3qfrAvAnN3dK5qx9LI1xNmO0LX78JRhBKHxjrigVHjoa8TSRAwJq4Nbx
	0snjcb4AKBuI4el09P1JyBM+SUQJCG0+hb1/bA7CRDEAIGrlDhZgukegfD/xgpxLaCPHQutx6w6
	+KZplnTtXiiI7x1p58QmJEppVmZEup6YhlzXSVdQwSCCbNzmirUyc=
X-Received: by 2002:a05:6870:17a7:b0:4a8:ffd4:9a6c with SMTP id 586e51a60fabf-4b75d850d84mr521682fac.45.1794955750772;
        Tue, 17 Nov 2026 14:49:10 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b74560af5fsm583066fac.16.2026.11.17.14.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:49:09 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 17 Nov 2026 15:48:41 -0700
Subject: [PATCH v9 6/6] dmaengine: dw: report residue for queued transfers
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
Message-Id: <20261117-submit-dw-dma-synchronize-v1-v9-6-7dc066ed0bcf@gmail.com>
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
index c138008d7cb0..1786dbe2e850 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -867,9 +867,19 @@ static void dwc_synchronize(struct dma_chan *chan)
 
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

