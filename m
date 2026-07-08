Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD77435AAC
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509487; cv=none; b=QqXJkaxxFuIvrlTsYd99M5FAQzAxeQITvK2vgMM+4eiaIZPRRfXonV4gt/MKX26KQXYq1MUnsK+cJsq00Gq2WTVhx977BjeEhUEW6jtXw30tjeEr4YCZ/b+QDr3F5OSgD60gu43+nKbi4bYTSLJvzjx2VBSjnuYOsQkvUjtgFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509487; c=relaxed/simple;
	bh=OHh53Z+dDBZ93A60zd+H0Xey0RUcchyzj1Bze3fWvW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKlSg2foJedobgD0B1gbpbk21pTWYFvDSqLx/2kVXNM4sMbRLun7gfTLXyeHub3owBevJgaU6T1fE2PMTjN0gLa8d1W9VoNXXLRCnFqwvo5spA3kVQXbokFpfmSWy8x72SLXILehKj/1JA3i8d1CkUCHlj4xx6c+ccZ+rznEc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=n1/LvCF4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="n1/LvCF4"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47de0093c42so556645f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783509480; x=1784114280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=egpcAQdW/SLTTZ7EKezQRyQCSwkm0Zu7f8FvgmBPrNw=;
        b=n1/LvCF4CflI9e+UmMNlcQSqwlFPSaJ2neypRr7cVdHQlD3477uAZ+pKQrDYiZtHQo
         XzDdaF7pb/4Zb7j/COu9BW5cIofbl/2ryb9zXDzyxQpoM62ZiVYxxy6PdzeOXlVpHKV3
         8AM//E8yfaYr4qkVwOT74PxNv0/nS1hwT+j1PP87JUE8SMC3Q80LI7x1GJG7xLk2ND6d
         mAuO3b9yk4q8KIevQv7F29r8K60nN/BulvWgR7lcPraaHsVxQvqxYTlIlWYOEmsXos1O
         610rEgAvs7K7q8TSGmc9DcAUYaMhnSrUHLwe7kEW9t/m3jN9oybL/1MRkrffKkzizpiE
         C/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509480; x=1784114280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=egpcAQdW/SLTTZ7EKezQRyQCSwkm0Zu7f8FvgmBPrNw=;
        b=sn0H2K52R8exNYIKyGtsUjadv11C8FLPMbaA1tcb9GrlUQtSqd8a+4Hw6PCvq8eZJl
         c2F8/JZ6U03mOFuHeh4lRB41ijfIPUv6mowzYNljZk4entzIKSmi6bQ5QTAe5WMVCOmG
         EvqYmXgJfMvuM4PV6Fqa2vKqAr3E9Shklbjaxfp68clVVFnibwEsvcTdLp/ghujY8HiJ
         WYTJoNJtMoplwPSC1PVOsmgtlDbCgs+YGYUXAZPySHUcxXYplgWl/ZOyETH+jVqBmE7N
         rZjWZW5IJLBuDS9mOiOZ8V0nNB0VVQC66wnix8+kPMMLsI0hHcBxzhmrjiAmjEMQszsw
         R/xw==
X-Forwarded-Encrypted: i=1; AHgh+RrBn14f2p1K4+AOapWi+sL8mU2tn7nA4vhVYcZqxOOLmLgNh1+iPhTFnoE/WBNrUCOf6D3z+uv78/XW3Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLOCbRgyjps7HRQcw5bVO29PVuKzEHUF8o+QOi3rXjkfS4bgq
	G+SbIeMtKtdtH9dHnuarJ4Z7b/0yeF0XmwcFDnzL3A0NphUUY1iw9jlX8bxPLX2rtY0=
X-Gm-Gg: AfdE7clF8WUN4Iai/s1NVxBCTMUb/GFZh+oSB57mYJlVbyv1XyIHY0LF7rfEuO27ECh
	981Ic477A9DhsVx2v4+oKX5/vDmwbHtpRkTo36ci2H8Dfx/3Pm8fPVHesST81F86L33z5EvMoUH
	1p20Og0rA9ojxf9WxfindwNRCBVDTpJnDZ0LxDhH2Ot9mumHq97MIvSW+5x5gViR/+NAGVYcRJg
	SYeQPPZ2kP05rYadpPaaH7dK2O1CztqeVy+yijAlLtgubTRWhU6RkQaLFg0BYDRT3/E6aHAJLb3
	Ot9wssfPzqvEnS6jakIh+O6MG43uvXCzh68fayDpDqTZB/ko+dxzZ5OaAWqhhYjkTahkwxBl1iC
	mjCbGmmnmyt/n3r9GOvr6cFDtZoEaR7medCsf7YaZ08ZHHTC/nimwZ3IstH4UTTmJALx12+GJKH
	usFi5D6eHNiOfhmWFpAo4lhVTnWqwoKJaf7fPODRIOIsA3guumaEREdLGb9FzTnyTF3RvOcDIKx
	duKQ4tyUqAbbEIXEQ==
X-Received: by 2002:a05:6000:290f:b0:473:c18:f2cb with SMTP id ffacd0b85a97d-47df075637dmr2204598f8f.18.1783509480468;
        Wed, 08 Jul 2026 04:18:00 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm37867694f8f.31.2026.07.08.04.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:17:59 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 08 Jul 2026 13:17:40 +0200
Subject: [PATCH 1/2] arm64: dts: mediatek: alias all enabled serial ports
 on Genio boards
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ccaione-genio-serial-aliases-v1-1-bf22229e9383@baylibre.com>
References: <20260708-ccaione-genio-serial-aliases-v1-0-bf22229e9383@baylibre.com>
In-Reply-To: <20260708-ccaione-genio-serial-aliases-v1-0-bf22229e9383@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2

Only serial0 is aliased, so the remaining enabled uarts get first-free
line numbers. When the console uart defers on its clocks, another uart
can win line 0: console=ttyS0 then ends up on the wrong connector and
the boot looks like a hang on the serial console, depending on probe
order. Alias every enabled uart so line numbers are stable.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts              | 2 ++
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi    | 2 ++
 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi | 2 ++
 arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi    | 1 +
 4 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index a30ee523b0b5..c535de34dfac 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -24,6 +24,8 @@ aliases {
 		mmc0 = &mmc0;
 		mmc1 = &mmc1;
 		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index b0c97930a0e6..26e24431d467 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -33,6 +33,8 @@ aliases {
 		mmc0 = &mmc0;
 		mmc1 = &mmc1;
 		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
 	};
 
 	backlight_lcm1: backlight-lcm1 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
index 888248a75e93..51f12328a1d6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
@@ -17,6 +17,8 @@ aliases {
 		i2c5 = &i2c5;
 		i2c6 = &i2c6;
 		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi
index edc5539bebde..86e487fb1832 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-common.dtsi
@@ -22,6 +22,7 @@ aliases {
 		mmc0 = &mmc0;
 		mmc1 = &mmc1;
 		serial0 = &uart0;
+		serial1 = &uart1;
 	};
 
 	chosen {

-- 
2.55.0

