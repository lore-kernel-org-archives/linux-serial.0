Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9554AA1CE
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331373; cv=none; b=sqBGJA7apG1zcDV6GWu/1ssG+v3dudw/jfxpnW6h0duNGQi/M4+JsUgr5S/+2ZlKedW0hkGkWx1Z/F/DrzTanIHnYjB7uTwTvoKCkR413M7JsWSk/4B+axpjiFo7JDp8nDI1NSxUq2/W3XNrq6pgWTsYJE1mziG8ThTwKq0IMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331373; c=relaxed/simple;
	bh=zpl50vYkYsZSmjFnlHACLXORChUB5b5D6PYRX3WesnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Akwx/y3cN3L1X0Ics9s341xuVwksq52E1Q6XgwoIMM6X+Fv9tDxZNfehomBFAJJrCGrmclNbIBMeDDNKXZx9EroX9n57zU4+XC8SPGS++qTKw9lIhgTMBttM/6vDP2eQtHUm914CHxi5tSth4PgHlPN1wfmCyBuzdxnpTWYEl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQUV0KNb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQUV0KNb"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c413dea9ca6so195040966b.2
        for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331369; x=1792936169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMxj8Cuy1L8WOHlx+WIj2otsX/xN7hQdQoq5GYxc9Ao=;
        b=MQUV0KNbEROblxzdWv38Htdt3SaFMxh1VliYdx/1B6U2dh5Cfmmwk1NdVVx69AI1iu
         CkecRTcLhELPEnaa99rBoQMP/ibyz2E8xXlkXY1pwxVbRFE/PlJeJrGowTDcSP2Z774w
         Kb4u6hZ3YoUcKE0GByrobYGDcgc+e41FU2etPeKphy0d7R5ZccxV9ozE2b6xZmudmszK
         6zDSMFrEzx7qcrpIivpmuTdJrSnUM2XMwrHilQDC6Ei9CMuLNmdWjuFSBSp0n+LwSuHh
         BhgT6IlCF7VBdFG7YHqdy1bhMEDeXCTt/OSd9eVnvW+PpOs/fp9pnTXEKX5TpXHLJ+3R
         FiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331369; x=1792936169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lMxj8Cuy1L8WOHlx+WIj2otsX/xN7hQdQoq5GYxc9Ao=;
        b=hUqN6RDnd6VGOBkCP88sSrc6VcKyaFj/PGz90MCBIS67jxVP05vMfOTjg2A00NCZmr
         Lo1qPVffA4CsMUlwqqQDULtgbIqKlhtdElJ6niZouQycVX6zPAXZBQg4eY/EIdVyp6RK
         VBLzNJDeUwO50egVzZNKDpsZFk/0Pvrs2nmCI//+5opu20X15iidkxPZNB5ZT0Z6qSoc
         SPK+lo9vs80PsJk5BXYoYmFhkDsUj990LTEFIseNiH2jyBExqrnG2g7BRpqkZXIo+ah0
         aqYaroAbIb0NuT35VK3YVghGpwlZMhNtDSkrDoNjiiAPXvKiPzc0oVrZEIZpFGNiEQ7s
         y+tA==
X-Forwarded-Encrypted: i=1; AKwUvByzwgaw4fl+HF5wKqLyfnZMr4bDvibSUSZV+wKOzbGfqjJ8NKZvZnMGuXF0l6AeScIsDgb8+NNBzS8W2TI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwANtrqJvxZm1h8oH7lkj/M7Ypj2J2od2WjPQZ3lCcLFD07PXn
	MjQGqV/zSdNf9f+BN0dvYgnPxI33sg5bLRCkdawoR7BcEkUTZs4PYN/x
X-Gm-Gg: AYBFou1t8ndtS+hpkABPadPzpU0M5HXTIZ4i+h4nOitUwULf0Bt6p/zK2+zq8znR8pV
	G30pzheorVXumNjY7VEZQqEwrudhjA00whEA9XatFNobKSNa86ZtVx/g/gfyVf5UI50z+w0J6wo
	5WcFEEfUOH3waY6lnbAN4fWnL8u9iDmVOmRjfeOPMgYwEi5ghegHe+vFuarukIcQvtn7XRbum9w
	ZP2kOrm2XstHzYC7geocloE1gTrv/cBsKNKXCpDm2a+0RDuTzZhXbj71RDk7RFFermplFGzbwKc
	EQpkK6m5Pg/vWRbcE45lY9RZevjjt7OTPAYWfHqaP216LKFTxti1vsS8slH9lZSCh0iJSh/uhYf
	bqyKH+SvrG1gJWrB9zTSGd71kojF9b75zI/2rixJmsuLb3p5sfutheksKlkdpzuQnXJTVz+DFY9
	2Kbj48s/L3pPV7BoXDeURZiSLDt8X2UHSdqZXg49ufqppkDK4AzwZZNraV5GMOzsTDigQe/0k54
	2qgiG1jidZk3kFTT8guON3nYP56e0HcmlE1zSzY
X-Received: by 2002:a17:907:c80e:b0:c44:16ad:c31d with SMTP id a640c23a62f3a-c4416adc6afmr28611766b.4.1792331369203;
        Sun, 18 Oct 2026 06:49:29 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:27 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 01/10] sparc64: return from the generic clear_page implementation
Date: Sun, 18 Oct 2026 15:45:03 +0200
Message-ID: <20261018134738.1016106-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENclear_page falls through into generic_patch_pageops after clearing
its page. The patcher then rewrites kernel text on each invocation.
This executes 45 extra instructions, including six stores and three
FLUSH instructions, before returning.

Return once the clear loop completes, as GENcopy_page does. This affects
processors using the generic page-operation fallback.

Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin/store-init support.")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/lib/GENpage.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/lib/GENpage.S b/arch/sparc/lib/GENpage.S
index c143c4d1de3f..6ce11108e143 100644
--- a/arch/sparc/lib/GENpage.S
+++ b/arch/sparc/lib/GENpage.S
@@ -48,6 +48,9 @@ GENclear_user_page:
 	bne,pt	%xcc, 1b
 	 add	%o0, 64, %o0
 
+	retl
+	 nop
+
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
 #define GEN_DO_PATCH(OLD, NEW)	\
-- 
2.43.0

