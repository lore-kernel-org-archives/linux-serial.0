Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202973;
	b=Pt18nYgJoV1zsrb6IpFlJ3uVP783dErAjPUdeZoG5hOms7raZuFvkgn+kFeQkyjy6CZT
	 GEtYypm6HeqvfpGcm1HkYj6KNMVGyaHJaBjoEKvNL8vvf+iZfY3Gh9SF5FiPHdlbrywA6
	 TAEDRp9+QX/gu5PbVhgUp0daK9tYATQ+CmWPicRyTdQeyUUTrkSBU74sbtYqgQOufncGm
	 07jRwJtW8H+lMfgvxFT8CT29iO/MVWbzuvcM+8aMqngGHt9RJNjdx9VUjYgdAop0o9YO0
	 Fr6DESr5w2q+H5ltxiS+0WC2XyvHNoib+5++Kv5cI1EZ6EZ6EJmG/o4VJuyC+bo36SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
	b=ff5WDGdSVV/Swk1uJ9F2Ef8pthL1vo6aq6R/swnXJo+Milyg83wlE13HHQZxYjDw3Ihc
	 TlJde+1IBxEp41Q5UWyzONWSYl3uyh1WB/1wMFIhQ/s/k/eytlwiZI8erDXK3JOrl9XfY
	 SfW2E5hQT8k57S1jv4mIefp2lXBkNvel+LgK5LkaNCthqWJFdCLy8fT/Qr0+EanKJcK2R
	 hf4qRosEUHzoXWAk7nxXg5EvJjGPcWEynA/bWzQi2zXL94unKNhuz8KvyEc9sKYdlvzPC
	 8A+doLC9Hm845E0PNw4yUvYjNy4lf5qpbAh1Ne83rAB8DPbxFgd4lNvJqglUVSfwzFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AMc/O9rv";
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669D606A6F9
	for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 19:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8669D606A6F9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMc/O9rv
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-716b58a4365so798759eaf.3
        for <linux-serial@vger.kernel.org>; Fri, 20 Nov 2026 11:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202965; x=1795807765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
        b=AMc/O9rvrWAOFSHNAZc0dEv5FdYm+9X8d3+iGUjnqCUmleO2ZoOaXnA79f2QfP6zA0
         0A4ZwFdx5PpMdIqbCMlzik05E5roocUnTUWgap9FrqK4nBdbDKch4p/jENyuBXwlrKAp
         Jrt3w46wyVyIsLUTCUKO5JfqAAsPy5anDy/tKp7xp5ojFRCpO5tsgrg6/WVxL1SUTew0
         seL/FvxrjA9arO+1xGAlecaMB/p3YeWal23LRSa/vJiy6cf2P35umEn3i4QgV457o73L
         BeO5mvZRLCgwwy7quIVn05j2JSz545+fhRj/2Y2TJH/szJMv+0NLPqOzqhn8MCLOdm1T
         RDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202965; x=1795807765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgAhw8d5YaKxhipigIjxpyoY1rnfpWAZBnQgXb85Z0s=;
        b=NRVjPN8k94uY+77RK8s1SrraMzx+9r2Rg3QSzwDcrUdfOFjqAJqFyDrus6NyOFaVHa
         PIFlBU+72CPfqzzfYuVoZCbpBNEOp6FHjx+GfzLvro/lLjxvNZzDD8LXEExKwv2rlt3X
         IVsVLbUFi4qurN8ZllMpULaIehOPXsEhPL8nXDz6zTwoZZv+70qLKosY4mE4eoZRxTRE
         nolZt2w3WhVwl2Qf2bu+CPRgZNzVouV/yPWzB9fR1T3wp0k7pOvkU+zK/WA+AV93jEhO
         UvYd2FZwqQyKT/11i8wIfnrslW/TuDUR2rAZdYYZZJy0hwvJHD7+hCrLrBCs4egudVmM
         Tn4w==
X-Forwarded-Encrypted: i=1; AL+hErFoCMEAeyw72EOxsY9glpR5dmtDurVPYNA5cPJGWbjv42f1J9dHkz42Ewyb88MRUPB1NTgB2mfKCYHWIKk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/M57CnGzSD0iFYrw+wHr34xAmh2G1XBCKCcuN+uaXxBh78CXCG
	c13VA99oyzxCXplIBHFQGF9vQ+PlLbA9nM3lLYgxUzR0UdCk9sR/jAK5tr7ZK2GC
X-Gm-Gg: AYBFou2vMocZvbeakfidpEI8HMpgSoom0m6pxiEDUr4EeeOP6ztVSujkadkpLd7NYQ8
	seK4PZzbM7CRV97kkgR10smXutpURLCE/eKMjuISeHjmznukVG5l5dMH6Fi0Nxomw72+PAcf/K8
	7vdw0W+mtrr8zKzJaqPSreMk9hjlgRfffSsvvAuxINf/eHZ8kTqJi8I2wSn9xNVOe4zuoZSFeUC
	AXo2uTJZB5Kb9ADChlpPIVeGRRFKpCbLsFvRvWb8Ya3+8Ob33aerW5CLSAKM4kBgcaRpRe1bD4+
	dUXzyqnE6ah221GIvCGKsOa5ksztpwuAWlSPsJLu4jlzyFalbqdU/J872Xojszu/nvXTah+hx+J
	lLrpxLk8Ivpu+QwqjECPWHQR3RX4LWmtSVHULN8w0fft8dYQ3mYg8bH0Iy2cgYKMw5oggBrrTTa
	kcXE54HhWJyRkKj5MTMQkNdVzGmywMVuCj6pjyfLv785nxYEZFLfCkHAoto7pl6HyljfldAJiD8
	TM4f4ltzm2CF/CIH4w/fA2xn2Z7JVblKV5QLPDRtkaU3yTX2GIWXlnGRBsiCSRRtsn69NC/V35H
	lNdl7jsJtQEUzNsvapRayMe1nnQoGF85ccAWsf6I2n+v/vlCdlfpj4c2tg4tHeCCx0CqTJpns+4
	DaI2u4NtIjXxgWzCMHad1f717dJ/pJ60QvCJqjl8VLUVPR4pY9CYbIBEo4NNQyQ7sLom/t18rn4
	M8iGBkPn1/nhrBD0R793NHiikHZIiODRB+JFh2W6CaFRbmQ7DcihYu
X-Received: by 2002:a05:6820:c451:10b0:71a:f8c9:c6bc with SMTP id 006d021491bc7-71b39507d6fmr2684229eaf.55.1795202965405;
        Fri, 20 Nov 2026 11:29:25 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm3434498fac.8.2026.11.20.11.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:29:24 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 12:29:13 -0700
Subject: [PATCH v11 7/7] dmaengine: dw: report residue for queued transfers
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
Message-Id: <20261120-submit-dw-dma-synchronize-v1-v11-7-9b9166bc2cc7@gmail.com>
References: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
In-Reply-To: <20261120-submit-dw-dma-synchronize-v1-v11-0-9b9166bc2cc7@gmail.com>
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

