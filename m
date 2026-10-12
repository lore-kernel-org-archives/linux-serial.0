Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE773B0AD4
	for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830930; cv=none; b=Ut7/EozDXKzk45DmuOvxTOLyhMAilCvDc1QTictc75jzPf1xPpZKAbB+2kwbDk4o1WmOJJv/DZT5emFVcKZww/2bICkRiqkxadQqE4IInF5pmos21JOMzHeXj86UxptjbWhWaQGXr/Mvdis9qwc2gFZKMvEWnsG11fAh+ye8SaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830930; c=relaxed/simple;
	bh=MgWJ382pjc3YS/Qw5ey/WYCKDvLWKApPLBvDgAkCkd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwiBJWmlIzvsRkqvoeH8a/w6AxRNgu+y7EBj8wLZp+1R2f1CchQRXp0mUIGgOxqTnc6MiZdadAj5PThWxuf+pOk/zs8SNvSdh6aae0clxHzBc4F6hTLmYIyHS7bTyFwwYnGB7B8aBmUsOyrkgTtbjbt9BUcTr4oN83MTiBYShYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdbaUwuH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdbaUwuH"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2e7131b94eso174781366b.1
        for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830926; x=1792435726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9MMUbPpbght9b1/Zf38zQrWJao2xsdGIO4miz4qhmM=;
        b=RdbaUwuHIu6iNJGzZh2xdR3mcbEjQev7Yjr1pT/aRT9QEe+1ClJZ9ldQSyix+3RRYE
         wRI2KIXuDI7pK7r9Exdm0mHYiYotpOJa7MuOHj3mOLbkjKNapkMPbNYJ5+YTZa6xR0j6
         MA+7xoZ3CKYNPP0EL1Srr/M7kqN8oW66iIfZZwKX2dnNHdWDv6nCk/f2h3ELvJD9We55
         LENISBn+kLSxxdaitnLTnkCJ7tjMaHQeW2r6cHDFMINy/mnsAeIlKBnZaOdey034EXgf
         kxgw2hC/18SCJAFJ3Yc9D9p13zyYzxTH8G+XdyrEXyTorkX+gOR+UB1BfmygDq+Iz8nN
         ywtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830926; x=1792435726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z9MMUbPpbght9b1/Zf38zQrWJao2xsdGIO4miz4qhmM=;
        b=kjD54nBrtIYeec+gqCQo4wk335bh6qeLL8ljfoE6nKBcXnyyFWDdLPLTwYYwrZyPOn
         wh+sx7zzSkJ+TXUKbPZsrfxA8NbkOxd9/yZ/GWLFdJfOOzqkSGC3/liUbnuMa2U8H2gf
         DnwLdpQGtD8usovf4+sqk8DwvyobYfnO0bZ6KKmxZOhBht2oQXm+cEf946NWzEKHNGWt
         XlavwqBpBUPr+QmEyY8OALc/LZx1Sx7qUoH4XJyZFEIQcCL0rC4kF06+28qi47U/Hj1U
         J4Mfeg0LG5oEyqdgXkIkuSIWZK/hTieYsFPW/shJqOM9h+UHNIqrH+viu9MBk0T25pEu
         sZGw==
X-Forwarded-Encrypted: i=1; AKwUvBz/ZSp+9VyZe5emja+2tyamXDbaVrSjmFTU4IWsighXXtNkuV0xDpbLcKg2nIUnb8yboTvsq+T7rkJ1IYo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyAK6IRcS6Of04O+vMLHR3REbDINUgjAHZbUZzYNcBhnOlprda
	84wf1J/NPBHcNevIRaPxJFAI+fvLNWbyAqj3H9rfTTcph4l1LpKK/geV
X-Gm-Gg: AYBFou3TlIl/JtfG4eY8bmAUo4VpndkbxYPHM656s+zANaTcTR3yqVgN/yi6FurKCp7
	qkn4VyBZbGzt01MI1vqnuGGxf/0aaMhROQSGHwYARiojwF0ayyEe5LOn/wa7qNruIWE1PLIe+/S
	4GPODV4ThD7MzCeUUsKaHjNHUFw969lubEAnZqEEodn8VK7yC5WTQ85AlmOmre6XQ1mjNXTLsvT
	Nv8RZ3Ex013LfTspjrZ+XHYuBWSuCEVPDkw8fTy00JPXWWpF7JLe41JQ986NjFHQdh7Zsv93Rwz
	y1iLqdRoEdYLGBStB5VnraxoP+P/mUokGSU/ZQfyZNYQ+RMB2D2DDWNUQBujBJ33xAR0UCGdh66
	SsL6e5gwE0WpKvzNK+2IqRD1v0DZFJLkFrzRcBQvKpo8J0MWZbBBEbFkNOdFGxWeg1qjbO6SqlD
	f2Kg9dDxLlKlaB4mREL4lPO2JARvNSsY4glFi3lgOX8xjoB4vD3ImO0xyHog1zJqB8HyOyz/2Mu
	cDXTbkRATnl1p2sSwnOgZ+SCNOZZT3x/+60is7q
X-Received: by 2002:a17:907:608f:b0:c2e:33f5:766d with SMTP id a640c23a62f3a-c31a9d0fceemr1026790066b.4.1791830926364;
        Mon, 12 Oct 2026 11:48:46 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:44 -0700 (PDT)
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
Subject: [PATCH v3 1/8] sparc64: return from the generic clear_page implementation
Date: Mon, 12 Oct 2026 20:48:02 +0200
Message-ID: <20261012184826.986050-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENclear_page falls through into generic_patch_pageops after clearing
its page. The patcher then rewrites kernel text on each invocation.
Return to the caller once the clear loop completes, as GENcopy_page does.
This affects processors using the generic page-operation fallback.

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
