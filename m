Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826393;
	b=XhCv/TmsJvmmXbi9Nezlt1BE8J0BmJetHqAUvn/QCa+hLAtdRHfFbm8PcQcDdYJFOtue
	 PqewYyOtaCAn8FH91YbyVHzb6i7ez1Xo8d+kKujof/l29rPpAbG98z3Rf/3NQW4c8jxUa
	 7u2v16iw0UFTdHaB+hLY/2xzrYco8diPIdiqBF04gpa+yj7XVkriLE7MTIpZXmi6fXp5z
	 BClrhENb1RL0OnagsewpNkcKFsJ7fz8H2ERNcACjRWOlp8IyDiNTUEnBgc6Ao4BMxgRJz
	 weC9BKJXYDp442+ZzFJhdDlg1KqW91KYJ/cu20DtrYCLukeNerXbdkjwMPltNDb6zqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=D0gFB7DdC88teePcUFhLAHdEAYFbs34TNYi+C0CiCcI=;
	b=BNlBGBxcJn5nOfxNy+t24HmctbOOas6d4ZimZ+xzTJgUg0FydgHr+YKxn+7Vn9ShFte4
	 wCXj/F1tAULSftk3WP1OaGAo4dtHlFEw1yaGV7eC6ixOtTGX6lhLNpQl/3cj1JIMnU/Jm
	 cjpeO2acMahBhk8UfI0cg6LGoVmB0UC/VQ26JghtY5iAQqf/IAav1SavtsMxxd/Cie1fh
	 oTmfdbO6F2YBezaLZ6ApLo8YBdK+5GUha99qXy6VxQmm4aIl64Pt6KLv7pZC8rJwCoGRK
	 q63AL9WzVtZRnRmKU1apaVPcYwq529COgS/7U7Asnrj4w6W9cNlkZMTYe/WnEYJrmCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fMUofNYN;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD560A261B
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 10:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AFD560A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fMUofNYN
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-84a248254f4so2464466a34.0
        for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 02:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826392; x=1795431192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0gFB7DdC88teePcUFhLAHdEAYFbs34TNYi+C0CiCcI=;
        b=fMUofNYN7W1CyGO7ZvAF2FWAa2qYJcu4r4eowj57uVHPp3ByNFlMHPfRkGCA4jU7FN
         O8hbQpzvjUUjro5m8khTqFBV7CSBaumnQz8MsGatmHSRCKKF4NBjtYbD0wIRF/d+EqgD
         XcbcKNluWfhEIjUa81KzsXUH/YE6dCclSHOrbf80Kz/p1DTl+RDjYboCmkbZ61Uvpkjz
         jQhN7nNrRFcYTMTRRiIYOSp55YG80l0Vn+HVQkP0KLb94CjlgMxkAaawwH6TOpIA2QQH
         slKH4k3tzGsiYbMloOdqaa+9deaXiPf3fQp4ettzDL4c7sNL5HaK/ngKNDMTCc9HW4kk
         nXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826392; x=1795431192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D0gFB7DdC88teePcUFhLAHdEAYFbs34TNYi+C0CiCcI=;
        b=NH3rKNrjA12mzswzTgHrWRxhUNGur/EXpVJ6/NlhsppYiAIeAEEukoUlJ/GHauxRkL
         a/ANdGBWTeKSc2L4iL+a5nueEITf6fCQ0DK7yqLi7DsejdmV/3IhAADc1uNnAzUdWJt6
         YxmShaBSZrO9+8f37teH+YE+n+lZ0CWpWPAlIU+CTZhAZecl4GjIbnn+ojvriOr9fdp+
         PrkVxYch+b9QCdp8NN1ZGne/HwGGlwiuxvAp+tins8FrU0EXbL81BdIc3yva5dWrT4r5
         24n/gnKfBRkM3VFSIwHlRN5NLMmjSDnIAHAHK5G+zjXv3RPKEeQ3kTmLVRkrims41taB
         5h0g==
X-Forwarded-Encrypted: i=1; AL+hErE6OxxAv5TCnGX91gbS5fJDP7Dc+2UxbRTf8OVIBxgFaqKgzKESTLQTtFUmpua0yvnOnCNnRD7Jn789+eQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vd1wSr26ulolq/KtcphFm1UqGek03cHUi7/eVnzjFcfarIovg
	+lU/3y6RJSfSVPb1KiK7b+jH7akrFlltltLdGOHAPXsCI2p1fqtJLFui
X-Gm-Gg: AYBFou19DEmJ6MEMgnhkDxiCFaswXomAzUSh1HKyC9HerFDLgq5M8+gbLCPqAbsGoQ5
	nXG8YEkzLG4SHtVqcKLqteghKNeXX4Re9WiT7GlU+X0JO8ah3a9JYf6DjsCAzbdl0QWwwSseq6X
	3zvHL8RoGuwFwEBZwU7Wv5dPiHc42w1KgzjSNjFxx2c22DqavTeou9xaK+o3oEJJ2iYPlwVHvk+
	kwFxDz7FKo24byym28G/p3lPGI4prUPAtwM9pBh7/GH/tZc629XhyHAEkHUxi7GTeqtO/2gDFgB
	LAnfDZWtuTP/FyNeIJd7h/tIIpImt/Ku/ZgO4LIb2+SJLPcee0paIiqWHZzTtaRsTKDiS77D8RS
	jTnepl/BhJPs/rIHvhKVYPGrIX0IcQtumuGp+OAHux2nMhdiQfgu49bwvUK+8whXiawa9z7cKFv
	Vsmqm9TbEXBfL1IwTchc7IaeomlRIN0GytZVFTcKlEqk73J55XFTRgv5E25KW+u47w4tlCjE++N
	lIkqTDQfHQIIZyHUeXsbX09knB/axnAf1+gzCXLEmbQ0/E1KK6fBszpHKJUEV0YrESzN1ntY2Lz
	rUaBGz5GWkn9eKGtlMU0+ieG6968VuTIFO7wHCk2dUQiLK0dkf/I0tzs6+eoYbPgB8jGTKFt4IO
	o1geukle+nikogyo0FoXl1X4WwfCD9EzkR9fF0iJ/oxzdlXORBTJhKfA6113K1UsCymbmSnjEZ2
	LxcJ8i8Q1+Umr5VBB7arMrfs5W/mlkETUan3CIt2s/Pqzf2oQb8CQ=
X-Received: by 2002:a05:6830:854b:10b0:862:b9dc:183b with SMTP id 46e09a7af769-862b9dc1e62mr2195212a34.27.1794826391709;
        Mon, 16 Nov 2026 02:53:11 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862b08b8b5bsm5555546a34.5.2026.11.16.02.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:53:11 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 16 Nov 2026 03:52:34 -0700
Subject: [PATCH v8 6/6] dmaengine: dw: report residue for queued transfers
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
Message-Id: <20261116-submit-dw-dma-synchronize-v1-v8-6-4a82d64fcd1a@gmail.com>
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
index 565d01c9a29a..5a7be765a0c5 100644
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

