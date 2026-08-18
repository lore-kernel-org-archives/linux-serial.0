Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B796F45A2B2
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049116; cv=none; b=ADiIBd39QgYWiCjcJ6Y3AX/KddFOELP7ugXA3FMC6YZEuxKvxjUqjbrFmj91A12WH3THJ5Tpq6uXm2VnhT8u87FHzgXee2zrudUAEOYKmsszzB+Jz5sEREmN9kBgErvZtLQk0GXKBeGLRUSCJAFcFGdtX9D0B/pnlxxXMzoGaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049116; c=relaxed/simple;
	bh=JlXervBrap08oWjRy8YgJzXZgsiOFuEaToTks1m1ZUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6kth1SdxMcf3aotxVpfEfTWoc+0rHCUKKbT9TKtTGqNK42byAYe59HoDoCZIRi1Q1Q/h4i3J1dB/EDI2l9L/8vwYREIL5REY8lEr1UrW4Kvd56vZfNBzt3/beMuC72G2H6mu7K5lRGoP+HFe7BrC49aCiPP82xMWYR2Lv/qOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=NtGRzWCW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="NtGRzWCW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso44437425e9.3
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049113; x=1787653913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shnIdCEg5h/jv9ES3TNBugMx2+hKBHKqFcN0Zurfu98=;
        b=NtGRzWCW9O3KZ073Oi/lSaVXY8/kIQvPsWUTNgtb1Y8LEL+rLTjhSknZege1rNdX3X
         9RgWiNhPhLxUfosQlFuIH6D47kh7dNH9bDOm/ei1zN/8yrrGtAcmSXyXefFCrWwGdMWI
         5DdHc1phNt+ti0HI5czmdEnhc6WLV3cAyQeHw8Z+U6IN+x+t4qcBjNPCOvtYseFYvSsF
         hEdHeWKbEovBZiopMGGEPfoyNixXR1+vMlq7O6injQXQcoMkoooPOWvBhfVoVlgTwISw
         gHiJu4FLveJ4gnr0rtxPNIRIs3O7rXqHz4DSYO0veQ26sjvsQs3iZRAzY020pIvE/bAJ
         hJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049113; x=1787653913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shnIdCEg5h/jv9ES3TNBugMx2+hKBHKqFcN0Zurfu98=;
        b=WPEfiu4it96tb4c+QIi1h4RdxRkoLfQNKyPIPWS0phh3g6bkW+Rhf0/2jCW+XaI/pA
         UTqPubQ+m23+xfSLT65dbV7evajlzTlDKuSM4hsx1DotTg7zts5inVb/0Xq0EOBG4XzE
         2Cz3zLvihie5Ih5qnv/QbHtbwfkLPTeupwAwTEcg+NIqm4xAFWS2OXWOKTEb2ZTUt+KP
         ZhRsH3IhOlgJKLYvNI+8Gwl/yLDQO3aGCV0H6FalRs0ynJ9OICPhW+JoB6Awxtu2XZob
         /HbDGWnV9Q2aYAMaRixHDsbmbT9PPIFDXtPnRiRl6PjLDulKq3/r7g78kvZbM4uHmfmR
         sYzQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrm3HpAY2ebeyYN63BX9im+wBVzIigJxu8c4K7EkqRIj80Jv3ZUhC/42jeaTatMgwOfEof6MOh9cZPbjSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtDjk58oaV8K+SnwZRyQbISiVUp7xk8eh1OmB8VmrbMXkCw2G
	+t8id5TYQBk9cDO1CPV++BRBPa76o1LrGLl1EAAWoFWUvo3mIHdbUtu2mPaQfFNKolE=
X-Gm-Gg: AR+sD10vo+rUuowK4qJ90mPRgbjUPxe2h6oMaaRzFZq0oc7yIzNXzyev+woDdHvAk1h
	/PsAyzSGfZGPqQql3idGRi1u/ni8XlMMl3+tQLUOcwEyTe1sRDfZLDooW+a2em80PuG/GDCoAXT
	rgSGNAvHH5dE2pPQ41OY86ezZtrZsc4q9sDOFWnYTI1fW535Li+K2CWA0c8BAugjZ3UMoPPmv2A
	r/jfTaG+PTfb1OLA47e5w5nBeSSMFgJ7AniMofTT2dJIARXpVBBYJzblL9moPIWkABbEmv+LCYo
	BI9GYnSF5WSYkY8BTtTlNF11/Qxp04WiiQMTPYZHYwL8vm58OlcPgJ28QmE807lQ/z35a1iLhze
	lNmJCHk7jWMvC8upDkNntMd58yjQoYbpAIc3XnB757sNH5Dnk27hNO+gHaHP0pLrqZQh+ZtAmZH
	sChLsLPweu50qh44nFSac9APMSFVBkgOThdbsY1DQuMs/LBHstTeHcNj2EIWbmqARCiAgrPy2d8
	mbbZU9OWWbxV1eO6mgQeKputptX2nYkXVEZFywarYexOwfxFYWXzBjmAQsZ
X-Received: by 2002:a05:600c:12d3:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-49987980889mr317588565e9.10.1787049113006;
        Tue, 18 Aug 2026 03:31:53 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:52 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:19 +0000
Subject: [PATCH v6 6/6] ARM: dts: aspeed: g6: add aspeed,vuart-over-pci
 prop to vuart3 and 4
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-aspeed-driver-v6-v6-6-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
X-Mailer: b4 0.15.2

The VUART 3 and 4 are VUART over PCI.
Set this flag to indicate this information.
Also set the scu-syscon phandle.

Added lines are compliant with dt-style strict mode

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index c952e2075b4c..61cdca0b3ed7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -723,6 +723,9 @@ vuart3: serial@1e787800 {
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
 				no-loopback-test;
+				aspeed,scu-syscon = <&syscon>;
+				aspeed,vuart-over-pci;
+
 				status = "disabled";
 			};
 
@@ -743,6 +746,9 @@ vuart4: serial@1e788800 {
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
 				no-loopback-test;
+				aspeed,scu-syscon = <&syscon>;
+				aspeed,vuart-over-pci;
+
 				status = "disabled";
 			};
 

-- 
2.54.0

