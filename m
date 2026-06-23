Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726333C8C46
	for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225005; cv=none; b=s7hWpymM/A+JXPj4yFb16dp52DWLJw7Vl4BvXh3K4eHiqqwRdjAwsMZrrmtTckiPH6xk3NsGNLSInCESlh4RfnAsWPphfdjawpzTWbn7ClBeAyNyjL8PClbKtnEgX42n1DGSZc0EmzIyHZJZaI3LgIr/UYs31LRhcoddMuTmijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225005; c=relaxed/simple;
	bh=dLaS5Sy8gUpm0N42qZ54uayTqxL7b5QT+UE7kAdTI00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIPNAVFF48L2Wf/ZexytuC0cn5bwb9f5YAJOH6esbLS8qVUmx0poyfoWC090YkAjQgQISR2LHfbGJgNtzIy4unfEKy1FeJ0VTzifG6RNWudNLwf8tVY70SUHnNirSIxdXYZdSb6MNyz6XKwnlsXfbdOzEuQHfjotQZ/xAoY0zRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=K/ZRKo7f; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="K/ZRKo7f"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49249707788so25083855e9.2
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782225002; x=1782829802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7ygF1/JVCediAjvQA9d7z/Koai/OFw+MbowQK5OiLM=;
        b=K/ZRKo7f6xH+PPagk8fJkPStDnqCTY8ypQKNuIEx7CotZbIZxq0YV4BxNX25PPDngM
         pQb1xocTO3G23aoR9cAJJHJ6ZzoYR3lfhjkGb21ZFuKXXjcdKT4ztBgRggWxAr365cim
         QwRU6H0h7pgJG57PmAdXPZ6KsYxTcNhtvNBphO8p0W6KlVARMIYocfrv2lss2xcqvx8C
         48NRtPZfaBHkqvlMOPFHlpLfmy/Pjxv84tiJQKZDNDtYPKvK2hryD8aoYoQayzubgvKx
         4qKT/9JbfrJ5tOcjliIRlG7xaM15+DhTQMmGyaOyvwjW+tFcCgDJE6Zp1HyCpMJ72JJH
         0wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225002; x=1782829802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E7ygF1/JVCediAjvQA9d7z/Koai/OFw+MbowQK5OiLM=;
        b=JOFNqOZ3pl3+ZQCrHn0b0qLj79wVbhv1FYdFUD71bClAtwtDyigaMe1SnzDApK3clS
         7FUbYU6FF6MXJa9oX35K+HA31q7kJ/8IJ/RltbgIIX55z12KxWzdIHIZ9iWzZD0P346S
         J1bZVpPUURU1rh9JDA5o1UuwQnKNKvTnzBb2iWRZbYNIW+pm2oparfpu1VDtL3gx4GN+
         boSZarAA8BF4WZ7FhJfCHcWJ6zrZ7HZpL+fLPPkHu4HmdR5G2igzesuVP8agrstMxohQ
         9vlQg9+8KToIG00G3h5cr9/aF8YqFGHAbcO78XbX+ABWExlVE1eNhnUhDv2g6HueY21r
         +WTA==
X-Forwarded-Encrypted: i=1; AFNElJ9RjShWpZAaafTvZxwB2eBqMWvakQQfOl4PKfOu0aIm+yTj/df3ALeLbOeNqBDc0BcDkAPGXAjFjHILOMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBkyIHY+tuIKhjH7g/AR4Q2xdGUPGV32NndBOgdLTJQioE2SHL
	/iLCwDJyqmCHdFlAC2bOscJxy1o9Ksw1u0j5ZhZg5jeh77dEIc7oBog4uVBVttOrVy8=
X-Gm-Gg: AfdE7ckrMFOkz/Vr4MOS2OElNS/Z0BdfQnGqPPvv3fVxNmnPl4oL4k34N7U/PBFrpKT
	wgPYQ7h3L7+K7z14QHy72gPbW5QbLadQya+fFwexVMYM00bdEOoPiXxwqn2yCsSvmk6n8R8yMMa
	CAXNuiIeDeVbQNWjma6QfjtT+vvqW6GPWspqntHvr/H6QsC3gqA7Ub/6MM0egIkuMYZRSvIY21C
	5tNnoTtdLPSuO1iWxgvg5yqukdx0sdhPC2GbbD8CYwjrZ0Q8akSHVwYyQpcbn+rtA652S0heN+K
	kuylk08F8sPqRsYqwfxGwTl56cdPRKUWuzad4ZyL9b6/HpE4EQvIGz7k3rX1FodLctGX5sM6YU4
	LvLhY6rm6OPxZe/zMmwCw5ydDXOn/y0hdSxqma2svVRgdtWN/Ca0zCMz7rvk2iHBBo6gSwgMLQ7
	hbQ53BDSqky8bBYzaHZwV45nL2B2EJB5kN2Zej3RwZxhZvSEVZaXQDgrJxMdekyQdT4xgy+mwLv
	c30BEKzwXcGsQG29ni4ihpWbEwz
X-Received: by 2002:a05:600c:4691:b0:490:b9c3:6c48 with SMTP id 5b1f17b1804b1-492490af5cdmr215448425e9.29.1782225001894;
        Tue, 23 Jun 2026 07:30:01 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:30:01 -0700 (PDT)
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
Subject: [PATCH v3 7/7] ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4
Date: Tue, 23 Jun 2026 14:25:45 +0000
Message-ID: <86fc0b2a105a16ceb301ba53fadd096877455bb8.1782224060.git.gregoire.layet@9elements.com>
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

The VUART 3 and 4 are VUART over PCI.
This flag indicates this information.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 7c02633f2bd6..2a19463b4c21 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -723,6 +723,7 @@ vuart3: serial@1e787800 {
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
 				no-loopback-test;
+				aspeed,vuart-over-pci;
 				status = "disabled";
 			};
 
@@ -743,6 +744,7 @@ vuart4: serial@1e788800 {
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
 				no-loopback-test;
+				aspeed,vuart-over-pci;
 				status = "disabled";
 			};
 
-- 
2.54.0

