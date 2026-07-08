Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CB41CB50
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525126; cv=none; b=WY7TcJGl+SkuChB+DEQswyqk6pOpLlKIRUsFBSE1bYIFy4n6COB3PnhmUE0aj2hnQS81T5FoaF6I4/IA7i54/cqxKSVEKGQo3Tloh2S/uaHAKVbU2qhiT+Z9mRjbj/mjgIJlBXnUNkefn+mpEhaIBBZP78QvY5lU+BHQ5SZYl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525126; c=relaxed/simple;
	bh=dkorfggf36ztPK+fgZCnE3kh62ef0QtYuBdCi01480Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlQ42HoAfHpKyGzcRwIK4NcqHogf66/IzP4bkruBHgVEci7OTMuSJJD03vQde+lxLGDTLQczEzlvaOv1LLQPQq/XgUhvsxT3PGtAG2AfgS5+F8HGtpLCb7O44zA9nKShTyuXFmLfP5f8w4G+16DSH8QFFPDogBSkPEB041zOa0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=G1R94AZ6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="G1R94AZ6"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46ed4f66256so742340f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 08:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525123; x=1784129923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R478x+VsQssRpU/U+H9eTTLOJEK424oXp8O1P95M0Gk=;
        b=G1R94AZ6NlS77X3o0TEod+xcO708X15cjl2xswiZ+/9BGiaNXwT6Nm/aZ1rhzNOZwg
         81OTukHSeXJ90UFvD1/gbLB50wVGN7R1jhj013kqU/nQ23N3KB58tBTIem09US+bOmn5
         3E2snAFyzJ/mn8RAz5coFG9d5jEctUbKihN0vXLqQWZZsdUpZzxDX20tkNdwVQPCCZkY
         XXbiU6zdPswmqDS/yDYDFAN9RE7zVLpSZT1wztwXw9vPRWMAJq2hC7lmvGzG4FlWCm9P
         EGTJabVjLJJ6Y+gRsNUvBgaRX61GdyXEy45URLoavJXNyrQbBu5Tn2d6yGzpz2Y1r1en
         fWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525123; x=1784129923;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R478x+VsQssRpU/U+H9eTTLOJEK424oXp8O1P95M0Gk=;
        b=sZc11uc8Ih12m+AWkX/zlPN06Q5zTty9P4QUK6zzjlKG0TxWHKdBoTkY9G/UgQMnsA
         w2I7xvi026NX0ahoc2Qq4swdJF71Pp3RikA45tWI/YjAEIWV66uEc8kEaHqGZRDMO1nn
         kvaQsRWlayiRKrXOw1pNEmZ40RUZxYF1oU/cEtPpc/fwnlaF/YYaFPEOxm2dhHCYHJsf
         +684ruc/SWdp1/nL6clyqlk7YrV3SwJAO3E/+rR1T8td/qpkrcPKxDE+0+5mhzY/ZEhy
         PP66R5Y9lqfNlXpARRX1MVTy5sUhHloRk9JMdMRe9opy6OZKnmW2LZnSYphDf4Qhtfxq
         TtLA==
X-Forwarded-Encrypted: i=1; AHgh+RpKr3Qz7kUp/kuzGzHMgaAPutsR/Izwx+qpoKMJfIQkwladGsd15+3naXgIEyDBnnA5IdogfvfDBZC/r6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWzNOHfKxkzidsYyin3gBUm7dLRMNjBjSSsyjckJl4Kac5Qm5
	z0nyk3WeBEVgb1vhPVqTLnjiE/LuQFMYS+w2ZyFx0vp7Vk3yg+wImTJubU7gnmSLLUY=
X-Gm-Gg: AfdE7ckIPvkQew2bQjNtBMO87vORNMoBH+zc6g9ga2w7UIvUMVgRFbyyIEjpC9wNt4n
	6BRHa0og+rgYaRY3lThnUTO8oZqomQYILN5Rb3XdRLlWUsVRquhhvA78upEgIoyK8h/8H1IbLAK
	2VRPCnaL7SaexLNAL0w/HDPIFm1UmuHR4ORCE7/h/kSsn4nE6MEJWLF9zJgoKxfpyxbb0/W4Gu5
	UQg7TFz80+RezgkDFS8JxLyPwCgKQy7kScKS+UlhKeFhfcHXmF0oINzNdfeKzQMTp2ZePYqpijA
	/GEmK10BVDDt9HvBIpsaKdIO4YJNU6c06gyhhYrvE5HZoVo6roRivhkDJeS0gIhDa3Q5AjXx9mn
	udtpvtaPEnCUxWFvq40ubJ74MU0ZnF7ShdC6Jl/NbzoZcTw/4/WAGWMBuzXz72ladiiwzt+uuBQ
	/YEblpKLsQw7j32amrPxLDiu3EZXHjEUFToIyT5s9hRUGBgMKo8slu2JZwNOKf2D+mpxk+zzEPb
	bMofOVw7MYGBV1dl24eqyDn9k1tLeZRDCpYyik=
X-Received: by 2002:a05:6000:4709:b0:475:f0d1:eb69 with SMTP id ffacd0b85a97d-47df07c5accmr3512417f8f.54.1783525123283;
        Wed, 08 Jul 2026 08:38:43 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:43 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v4 6/7] ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
Date: Wed,  8 Jul 2026 15:35:58 +0000
Message-ID: <5875623c1b20cf5a1abc980eab4c31a47cc58468.1783524645.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
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

