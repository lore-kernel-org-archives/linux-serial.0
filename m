Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02DB37F742;
	Fri,  3 Jul 2026 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068442; cv=none; b=IDwtXtiwQ/9ziLfegb6huPc54uurLmDU664NcWm6LQNjiMjGSCMGrpMabVHHHO0D7lQIj8UKdKT22cmqMCUvl6zD4M6/y9mG6CPAS32TRdsi1ha1qC8F20/SjLoN4OhKuP/0fpJL6HkAjiB9abrhkYkspOCwQ4pxS9d+pT2krfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068442; c=relaxed/simple;
	bh=4OApoO8GCDqnujM95cVP95WRKACvgOgiUT+tvKkURzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIdtkGLZCv4vwvhXZeztiQ85iAWCXDW36G+BGZ68gDzUIKCA4NMsafH2N3L3UnkY4VIAqJv9+mwL8dhx4oWq9LdUx3evo/0p1rrEjIT+sk1OudfPHB41IMeUJafbK+ZFwyhHmOvwsEbq8l7MWmlqJD1vdVsEzXwQ8GeZX/BxEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsWy/Ijv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsWy/Ijv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476291F000E9;
	Fri,  3 Jul 2026 08:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783068441;
	bh=Du2Fkgbn8m3kZzeqKj7jP3ukCvkYWMsjbr1dkkJibdQ=;
	h=From:To:Cc:Subject:Date;
	b=hsWy/Ijv5xagLJxKx1JyU5leQuU5yX8rVd8sSRamPjj82UylgBhRlPG/CegRxZthb
	 rviiljTsCzuqBhSvKcyy78buPSsj6YTq4TTXIvySuOswx3fkDkyFPa/uhDHqtqewS5
	 zooxdD4vLOthX2duTDCFfQwxjp9s5CYsELVPPhoYVtCL/dSWBtKYKQS1LB0Xfuyo+6
	 aD/rc8FQkFdn0nplolx4no4c/s4BrOiwIFJS/VNpIvoa0RZlYkjva9qDjZrFPYOcw7
	 1ufEmfTS+I+ePet8VMO1CBKNb8eQ+PznP67Gj+hASBRjfekz9htEoFB1k091tE/qfr
	 SPL1Q5QViXOMQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 1/4] goldfish: remove unused gf_write_dma_addr()
Date: Fri,  3 Jul 2026 10:47:14 +0200
Message-ID: <20260703084717.176442-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last user was removed in 2020 by commit c869eaa617e4 ("drivers:
staging: retire drivers/staging/goldfish").

Drop it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/goldfish.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/goldfish.h b/include/linux/goldfish.h
index bcc17f95b906..40a059e03d78 100644
--- a/include/linux/goldfish.h
+++ b/include/linux/goldfish.h
@@ -26,15 +26,4 @@ static inline void gf_write_ptr(const void *ptr, void __iomem *portl,
 #endif
 }
 
-static inline void gf_write_dma_addr(const dma_addr_t addr,
-				     void __iomem *portl,
-				     void __iomem *porth)
-{
-	gf_iowrite32(lower_32_bits(addr), portl);
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-	gf_iowrite32(upper_32_bits(addr), porth);
-#endif
-}
-
-
 #endif /* __LINUX_GOLDFISH_H */
-- 
2.54.0

