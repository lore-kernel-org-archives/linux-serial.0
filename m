Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DC243FD06
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593185; cv=none; b=TpPhwoMaaQ28nm8eGN1mxpzPnV2Cz1KexAzgtnOx1Elj4YGn0VUxkJiJFcy4Wlq3qD55SXEtORxXG/neHZ4wvjd7VBWI6ZF+2Gbi2tNX5MPPkQmvevzuJnOaYQzKnIVmunNw1N9UK0OtcRK88ZEW+u38ztqp2zWAK19xBj0Ye/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593185; c=relaxed/simple;
	bh=XRQZB1JgmbvbFhZnhAsnmip/c0L2L+du13hr5NiGQuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEEUPy3s5dylrNENVJzSfSVlANSci0svRw6ULTYBLcYFxjQdlRT7IrOrv6XCAY9EH02VRpU8P0R2SS5YlZ2nkKV1k9yvv1Q4uJ50U6ycunG4VN6XoRP///5bpPBQDp3TZPi5CptoprwuJQSKTxqVue2Ue1UrUaoQX3mfiEB+vhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSAWAdGR; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSAWAdGR"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2ad8bf95bso4067025ad.0
        for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790593184; x=1791197984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7mh/86w7X/Fu/V88QblY8Kz/+S1umUNlcAg7+csYpTs=;
        b=JSAWAdGRFBhh3nSBZfVscpSZCiqz6+CJ2e08zPWrdakiElS/XMDM3ozccOEV0Tzby4
         ot54WIzbcm0jMX5o4Wr+xB3yuBpGvmjshQO+C7rIhA/MLHtq6JFMkP6QHrMcI9UDtejh
         yBdDIh6a/5zs/oDlJa6AqEgXZ+yQBUNhQ5aUcjJakdkK/NbHWlNqbq7ja0VLiRdT8cVp
         rc+/qdD0+uq0D2WvGproFbOZ8I9Jao9cLF6JcAtJjWDL8QBQqVI/Khp+vio6p3zerUAE
         Qjjz3eZX7CR4FAOl0703bVZiNTGtwstCrp5FCbhO7BVEpw89c2WudXkrnyJMw07A7okV
         IDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790593184; x=1791197984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mh/86w7X/Fu/V88QblY8Kz/+S1umUNlcAg7+csYpTs=;
        b=t0kJkKYdXLTis4c07/jr3h9jf14W4cmV5DGW6pY9aKn4hZjHge7lNs3mnyyYu4FuOO
         cVcR8EflPw4exs26hO/Qf599KRxDyMmn7ZYflaIiKWWZBTWwLodTSl8O4uIUqihiqQ3F
         LCR4RDM2Wq686t+wPR/7NSej+WwWM3ESrQjrX8dwRzwlQKPOSAbR2oPB0s0H5NcoBIap
         QzMdLYxPOoey3GNChl+Zk5Ef41vfUHioqEsrZvUwCZgpuUzqmuF0k5E4VLkVmY59gxRA
         7l3RBPSb647RqpB71N84vvRWMG+hwCbqXDVfZ5RdR3utfdzIHRkBwD68w1DMVGL/vRO3
         dpFw==
X-Gm-Message-State: AFq9FYL5JBGGExrGv1LBLfOrUPRA4Z0ySzBn2hfe56C0DGF/NYmPHV+C
	bb0gTw/iqTAZLnv0S/aAEPS8Ht7I2/ozGYZUtFAXjfbQcBviLpvvEEOd++snnT4MoxyeMQ==
X-Gm-Gg: AYBFou2bqZQLivda5aAz5NWgo+4md55CLrpvUo2WBczeE3IJqtTak8NKvrS0tsjLdq/
	Mt/hdZpjULlxEOedE2q4NnhcchbBCNDfJzPNJ1WAg0IyXpOmO1zotqa2QeKDfBdQ9UKWDp6Oboi
	nngGVQXpn09vTVQpv3bKejvK7zRlLMw2DoVeUJYpxMUZw0CkGrId1IUxImv87sNhsDEMYXfLSAR
	RVfD7G6rsggFLWjYyURiwM++kv+S2UdbbBZWF61vR4Onn3SnMa9FHtaT/XB5VM6S31la1fskHe4
	SGS6R2lWCzuntOYaxNecbettLQBxer+imx/sDSPTm9wZ47n03gCMuJcD2RX7kHKGQNuYMsMNfTl
	ZZRC4eeq3dAahrgMIXx/cL01ipLPKfpPEQjpUR5H8SIZTobNOB45bccZcK5pn3h2+vA4nPHeVXz
	lKXhW8A+Oxgqfa3ORgD1u1YOQJxHajv82cPoRItl4osdkWyRtydNBYuIzMMoe/tNTajAfGXYy4Y
	UMztFpa4wYqYC3Lgnx6WxsVWiDAi/HiLgTvk6Ii28nHRkFPQLnKaStF7gcah1jHKqHsuZr/Vaq5
	eng8tHkyZeeJ7Ti3QDVbULkBb5tKiNJvYKrtiGq2OCcfwoRYBr9sVjdSEj4Q3TsHAUlRfoU=
X-Received: by 2002:a17:903:32cc:b0:2dd:c100:943d with SMTP id d9443c01a7336-2df94c79e49mr69463255ad.59.1790593183696;
        Mon, 28 Sep 2026 03:59:43 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fbbd2asm39681665ad.12.2026.09.28.03.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:59:43 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: name the gregkh/tty tty-next branch
Date: Mon, 28 Sep 2026 18:59:40 +0800
Message-ID: <20260928105940.2186243-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T: entries for 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER and TTY
LAYER AND SERIAL DRIVERS name gregkh/tty without a branch.  The
repository's HEAD points to branch main, which mainline already
contains.  linux-next merges the tty-next branch of this repository
(Next/Trees).  Name that branch in both entries.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
This is part of a cleanup of all T: entries whose repository HEAD is
not where development happens: one patch per repository, sent in small
batches.  The plan is at [1], and why it goes out in batches at [2].

[1] https://lore.kernel.org/all/20260924033200.3615554-1-matthias.goergens@gmail.com/
[2] https://lore.kernel.org/all/20260924101844.2403008-1-matthias.goergens@gmail.com/

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 140eafcbbd78..cda86d5bd806 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -140,7 +140,7 @@ F:	drivers/net/ethernet/realtek/r8169*
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	linux-serial@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
 F:	drivers/tty/serial/8250*
 F:	include/linux/serial_8250.h
 
@@ -27813,7 +27813,7 @@ M:	Jiri Slaby <jirislaby@kernel.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-serial@vger.kernel.org
 S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
 F:	Documentation/devicetree/bindings/serial/
 F:	Documentation/driver-api/serial/
 F:	drivers/tty/

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.55.0

