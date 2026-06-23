Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57C399011
	for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225001; cv=none; b=QdVEEr31Bc9o/qr4d61mf/+cgrYydzL6V2ZcbOogKLBaR2vKI5bwhSkmS1X+XX6DQbzx+TEXIA5ImbPu9U3lqFkYjSMWI7iCG7UQXPcAH8REPScCna38Hvoun7nEk3F3aLB3tmBVk7egTx0GdHyKXFNCtEpfCPvWOwYUuYvf4qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225001; c=relaxed/simple;
	bh=v1FBGkXnHfQv5BSJ1xkMgDQFKe1pyB8IwLLqyphSqLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLX37kDpJvwQLT0rB8CJ7ir04WQ/n28e3sSAXSKVSnbBVSuFzsjB+D7z1/+h/Hbj4ZVsF/OxoH+SSJKuYVW1+bQlqTf9Thk/JBGwT9oo+bDkVDeOa7ULX6rKC3NIvzWbwv5wQeheEXBuP0otMt2Pyz6FeL/+tfF9f3wfBHOx2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=HyifI0+5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="HyifI0+5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49241a577d8so29745055e9.3
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782224999; x=1782829799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0YQhBtC/ubH1Q0Mrdh/TGxhsAQ0oS6iny3Z+QMvfNE=;
        b=HyifI0+5YDrk5TbehOn5L3QaO+Z0Fq9tyJJiRGYOJ9Y+VTwTtxEJt8TYDPIj34M6qZ
         UzAUq3c3t8M9/UFbhTcXi/VF0jUnImkW0cc1yramX7cAfd4EduBQM8U0LbkAcKJP8+iH
         MQDePovMVdk2tmHVSs5GlL3b4AXTyeu/RLcLGH0BAPMG/I1oNNwnCbFfSqhWQTcjrnXx
         iLIeIfv5XWNyEhej1wT7JSmDV00gOPV5OjDHweYQObDvuFMXW5nj93lAl4E2z6UXQCCf
         IP24L2U4XehpF0rDs9OYUx73OvgRfs6SLJivecnF1CkorBKjZK2REFtlS3098H7xh2NQ
         Qrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224999; x=1782829799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w0YQhBtC/ubH1Q0Mrdh/TGxhsAQ0oS6iny3Z+QMvfNE=;
        b=lPoxFns8tB6vNK57PxatjNO4kWWo9eRvUalbBoOzk1W0lHs2o7Dh2xKAJRtpUCEBlr
         fAI9qoLJc9x1vOVoKGyhxFOysqHuzrtvMiVPh8LoMTz1+PzhS4BoHG4RMWFyuzUEXmnq
         FUrYU2JV0mmNNEvFVP/rNieVXVa70N03DF2ctttr9bu4P2Q7ogkU4XO+jDzqyVn4plRZ
         unHJ3K8SjJcR5P9BNero0KrB2cKDUxUKcsA6WIF+LSCqKNBI1KcN7GDq0/PEw9bcBT6J
         Irl0hWfnxAvKCBdf+1HbwxzK4Ly+gBVtkGj2TVrgE87BEkpZ0mmnwr8oacvqO9OaGmCK
         faNA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ir/QYhyhv6rzHfYT2X8bzSUh5uoka9dckvIvY1Z2ChPENoBKp4mPbx+yDAm5Hw0XAf48yAjREQkY/5PI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8HGResK8Fsvl+NtD8hHe+57JN4us3M5pAxHkgsQVTF/PYvH3+
	eVPLp03J6qOQ3TA8pXyg4ubtS2VT6Y8rVVaakuHZdo1dxSz9vzOuM2YLGCp6qyj4Iao=
X-Gm-Gg: AfdE7ckBqkCio9X6goCwOQT/AXkfSg5ayGTK1lnMH7sO8PNq0QwZBTCuJM3sT15BVn0
	n/lr2DQh43zQOWpyqdZ8fwgT2zimS5BepDOCqDmsbgyLacN7sTnFVDQesksFsCniQsskckf6mDo
	8FbpNDxD/DBdKJZRqmQo5cybN5Xbgy7dAdZW0xvo+5wQQwt542REUK4vmQSl1h3efFq2pDk/x2F
	rTr0U6yDY8S+M4/p+8RLBjMVpHdEYvG4FZG9sT3XxuXJU5Gxw5LzPqE27m6ushF9z+Thvr3nHY9
	VCbMqyHn2gkrsOdu9/rVixALuPcLJglXMbMPQ6ZfRhIGIo4a8o2O+le3fQ6jxNZDnJ+udCyBBHt
	4c7V6MG4W5KZzKYs9soimwJgFmCi/OetSlISpXs+Ix5U43/3fVVtob7mt7wD4YY/O1X8O18JvsN
	eKiI+xw9ddB2tmWl8twbgfWWxNtyg9oGwRk7TJvay/Oi9mhup7VawUuyDWVgVf4BykM9fE9OOV7
	I9otLeXzQxt1ZA/0PU0cnJ4uua8
X-Received: by 2002:a05:600c:4886:b0:490:d354:d15b with SMTP id 5b1f17b1804b1-49240e9545amr189390855e9.29.1782224998752;
        Tue, 23 Jun 2026 07:29:58 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:29:58 -0700 (PDT)
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
Subject: [PATCH v3 6/7] ARM: dts: aspeed: g6: Change vuart compatible string for ast2600
Date: Tue, 23 Jun 2026 14:25:44 +0000
Message-ID: <30aedaa9ffd5ba2d763d8802a07b77ef2d5bfcf0.1782224060.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782224059.git.gregoire.layet@9elements.com>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the ast2600 compatible string.
This makes it more precise and enables specific ast2600 properties.
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

