Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142046AA75
	for <linux-serial@vger.kernel.org>; Wed,  5 Aug 2026 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932450; cv=none; b=VmLyg9UUiPk7qG1raYwmaFAvFb2A6SKrecbe8Fphk9IrR6hTIm9RCgYIdZXX1R68binmGXgqHoYirXyoH8FYTrUr63apL4HyPXINdmVAhINVhFMLZT1qGsZ4k2DRmuktm7NHbnmuldHrc7WuAnksO8UFiOZKV1t4MLHO0IGWG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932450; c=relaxed/simple;
	bh=dkorfggf36ztPK+fgZCnE3kh62ef0QtYuBdCi01480Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9VXCAQEcNE3z27ZuLg/lJL64NuLgFn0DwtvK4jgfG0E6Eg08sAgHOnAlIVyYhMvL7iP+VikvEPMuGJHpNhSC2zh5eF0Es9OjxMo/H296cnVFh26ZncHZeSh0mlkknx8kRw5ISoP3NfWYkXfl6EIfiXq25NuXJolLOfjJRPKpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=eie1iFJn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="eie1iFJn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49557167508so8332835e9.1
        for <linux-serial@vger.kernel.org>; Wed, 05 Aug 2026 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932446; x=1786537246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R478x+VsQssRpU/U+H9eTTLOJEK424oXp8O1P95M0Gk=;
        b=eie1iFJndar/FHwKUDqYFalUT919C4o4i/rIggbJ2s4iBCvjyCDmpTJu/8Z/iM6ATR
         wn5nlQtnIaWgkQeT49X5G0m0CH8V2Bzrt/5JMgXcCn/sIw/ib5/MuNf1vFmT4wH0Pwbv
         3S4nZYkLCPTai0i7tqUauIid7v0BkjPU4mtLBo3LCHy4gdvX76ODdtWa7WuZ9ZkaT0fV
         qRmdoD6LZ0crh2CKXTvmOZNmBjn0ikvAwMBmxzgrZR8SdJ0dd9MS6SJo4kvqHlj7pbik
         lVoIOAZ6GEjETlB0v31r9ALX7HGMWwGaE6hK18wMu2G5FdYDPTGO3LlqoNs65ZRpD2jJ
         Df0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932446; x=1786537246;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R478x+VsQssRpU/U+H9eTTLOJEK424oXp8O1P95M0Gk=;
        b=bQpy8LtZUwtOzZIPLXawNtG5VmhUmujX6Bgt3TcU5rlhaNUeZ2yHHN1z+ofCMCNEGn
         xBdK2E8gnnkhrntzXraWa1H3QP0bPpCN7Ythw/puhS4mwucuz4A7ekQaaOieD+Xe/Gm7
         oN+LoFSVJkWOLz+IpdG2pwbM5KIuUE1ZpHCNTeH0eWIPFXOMnmn8Ck0PiXRd8dPsY7DG
         +CnRsKAbDvN1EP4Dy0HrXeAmIsKGBb2YVQWYdv79vk2C2KUFw5TmXOg/jAfO5z2Qn7WE
         HFUcJyIPAGtsa2q5wDR9ahhRVxfRR33Vgijvkvg+4Oy9rQHr90a2txWylolggqX1ReqF
         SFWw==
X-Forwarded-Encrypted: i=1; AHgh+RpWsyTyif3dCTFX87w956mRCRPX9P/jKZ+9t8wVDBkpG4pYc2ZCKCx9mBvHM8Kf+jdYNgYGYTU5IC1Dbfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72JqdIlZD9r+fsRSo0y72nxLgyVk+kp3nFLuw14C44omQjM7V
	6FpJxqtyxZkYw8IBRVuL/FNO/8G3/HFaYMh165XThG667D5hrFnCXjw2qakpr4vh4bw=
X-Gm-Gg: AR+sD11cfOy5YbO3GtaXhlEn10zKfrvIgwvlexx1WvkshYDzunww2Kl2I2mHl5Lky5v
	L0KSCfely0Vl+yibN1nmn90T8j0yKVnadQQwl5PutwNfoDD97ghHni2TN3PniMxlnJIL9PlTAfk
	V8SpR0Sx4ObMKrhd75O8sOAx2Ogh2dNqzVyCILTpuCWMIeEcz5dGTG2Q7QjDVAyg2mdG3+HTQR1
	r7y7+oCdHQA63WJmi6jaexmdOiAWNr7Xt2+FJJirrOf6W/rSWJ/hUEn1Y1iSpzQxh9n7EVtIIhj
	RbQx3AERx2FxdJDys6O5H8MwVIG/Y7N4nhBtNK3di9MkG/FHPKuUhvlUwAHD8k1V3GUGsU+nb81
	jLZOsZGyohujoCnHqq7TITb9cBb/Nl6fmdg3Z/6FAZxRLMR6+kAEcukRf6R3AU7htT8wdlliHmz
	wOiwFakhgGeLFyJOH8ZBnlCTBLiJ3s8EaGM8jUrBfki5+Su2N8E/InJ2NFdHyWI0DIqCUdSGwo0
	dGGfpqxM5gH/OGWC+W9r+0CPx9UefWccID9+SjJQ3XiGWPCAzqpPL59P+nZHB53s+y0Dh05GCUG
X-Received: by 2002:a7b:cb95:0:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-4994e7c118fmr56108875e9.11.1785932446337;
        Wed, 05 Aug 2026 05:20:46 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:46 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	tan.siewert@9elements.com,
	linux-serial@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v5 5/6] ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
Date: Wed,  5 Aug 2026 14:19:52 +0200
Message-ID: <d54bfe689e6a0f318961588ab6b72fc2b09ebb47.1785932211.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the ast2600 compatible string.
Make it more precise and enable specific ast2600 properties.
Still use the ast2500 compatible string as a fallback.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 56bb3b0444f7..7c02633f2bd6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -707,7 +707,7 @@ emmc: sdhci@1e750100 {
 			};
 
 			vuart1: serial@1e787000 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
@@ -717,7 +717,7 @@ vuart1: serial@1e787000 {
 			};
 
 			vuart3: serial@1e787800 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e787800 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
@@ -727,7 +727,7 @@ vuart3: serial@1e787800 {
 			};
 
 			vuart2: serial@1e788000 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e788000 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
@@ -737,7 +737,7 @@ vuart2: serial@1e788000 {
 			};
 
 			vuart4: serial@1e788800 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e788800 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.54.0

