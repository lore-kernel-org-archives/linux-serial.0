Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844018F2CE;
	Wed,  5 Jun 2024 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577697; cv=none; b=K+uYwbMvv9gL1g/I0slhpsYkvnuvZy/t0zYw6/nVQ/D0DyUpq1MYaJipCw/sjyW4YmLDJz41maGHZo18giQjrE1Iv1c2c2mPg4JM7gRNbbvAbskA9wxJHIbs2g2Q9TowEpNYA52CcrodjL2/eFrXEXn5VGX1nd56k5pk3SJWAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577697; c=relaxed/simple;
	bh=LDI7twUhWCuEtevEi83CX6iDT7t8XD3IERCZjhKbzgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oF0JzIXiAGkLrKpuHRiFasRJNsW82AAuJA8w5W2FAW9QWHOMJQNLSbyU23bioM8KAoEh9vbk9qPMWIZfryXPQIHnsqquDzcUHzn7G083/drE/3tdzzupBVHgfttxdLEm1UyEYFJ1cs6w+LMJxVieQlVo+WoxJDqh7fDaNdJPXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHi/HoZS; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHi/HoZS"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a2ed9af7dso7340816a12.1;
        Wed, 05 Jun 2024 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717577694; x=1718182494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzCw56uBajgoPcSKxbxBOTmVAmxJFjZGHkEQgNNQnIk=;
        b=PHi/HoZSw/WjSBUBYy0EJE5x28JcuVmdw01kB4gP0gxJ1cjZ/7zm+JDT0e0egGY+sq
         H3U/vepUlJkhSM5ruWuscx3kbA+giqoqmr09u9FWX1zIVmUJDC9oKRYqY6daf6Juu9eI
         TlPuvwXMtzonaWW5iU1KOoaklDLl+KPI+2L9NnKoKADd2uxuOUH9jXqmed0K3OWiZ8sS
         GFMS8t2P/snFfnT2uugcik8+ogSeiur5NA77bLiSJ4MnLtKjm4kpNKHH1wb0CV21td1V
         vBxz2eaRa2Sq129DL3PIvmLg5SfYXbt11RSlbtUYLXwKThCxgk5HXtWKje31bVPF5beS
         t5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717577694; x=1718182494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzCw56uBajgoPcSKxbxBOTmVAmxJFjZGHkEQgNNQnIk=;
        b=kOX5Rz5BWpuvbnX9VCUrQBFcTC6beqPoJtqY0w9t5k+GDjT1KriE+uoxMGlpTKKk8P
         GMkvTy0eikzgcwglChKgh6q9rqsjyvuj6HiTKZ1tplbp1RHMY2PXyXB8w05sj7bDoRt/
         pe9StyjJxoa5cCcundhJGu5wYOXxrk1RQVkHT9leKkAU804FKAEI/0PKj49GLuF4ZijE
         g6h14eTW5D//eF6YLzLZfd35Kf9lsyC4p5Hf6jnjDcdCTAixwtsJkaJmhpvyRQ7p9+BX
         XDSLPz+o5qf1jNbnBPg4QmhPTBk6mcGIYyC209YSfv/0fsJMyOoxZQmCOb2H2A9KA9rM
         iD0A==
X-Forwarded-Encrypted: i=1; AJvYcCWME6PCMSzd4JAR19aPGawdV5+Q5C7hNzfT1dGcbH9y6yBgp47PONBEhqJYQgQeVtkwEFGjrw3EoQxb6KdSxWty+MCg06PF5Va1QA==
X-Gm-Message-State: AOJu0Yxjw26hEeClNBjw3JctG/u44DsPcqjBm2adveh0BJVAWHNPbn/L
	KvT1BQA1SaKJxaGfYvsRncgDrknWLKBP0V+y2pmf+/0XwkDEdumN
X-Google-Smtp-Source: AGHT+IH6OtCR7PLNaxYCvlpziDK8I1V+86+Us/G+mB0/DfR0zTAG5P+/fb+cGawEEBhtJmDl0TX/5A==
X-Received: by 2002:a17:906:b209:b0:a66:7b79:3573 with SMTP id a640c23a62f3a-a699f6664demr134166666b.25.1717577693663;
        Wed, 05 Jun 2024 01:54:53 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68bfe84c67sm586249866b.62.2024.06.05.01.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:54:53 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt7988: add UART controllers
Date: Wed,  5 Jun 2024 10:54:33 +0200
Message-Id: <20240605085433.26513-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240605085433.26513-1-zajec5@gmail.com>
References: <20240605085433.26513-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7988 has three on-SoC UART controllers that support M16C450 and
M16550A modes.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 35 ++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index aa728331e876..7690a83911af 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -86,7 +86,7 @@ infracfg: clock-controller@10001000 {
 			#clock-cells = <1>;
 		};
 
-		clock-controller@1001b000 {
+		topckgen: clock-controller@1001b000 {
 			compatible = "mediatek,mt7988-topckgen", "syscon";
 			reg = <0 0x1001b000 0 0x1000>;
 			#clock-cells = <1>;
@@ -124,6 +124,39 @@ pwm@10048000 {
 			status = "disabled";
 		};
 
+		serial@11000000 {
+			compatible = "mediatek,mt7988-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11000000 0 0x100>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uart", "wakeup";
+			clocks = <&topckgen CLK_TOP_UART_SEL>,
+				 <&infracfg CLK_INFRA_52M_UART0_CK>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		serial@11000100 {
+			compatible = "mediatek,mt7988-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11000100 0 0x100>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uart", "wakeup";
+			clocks = <&topckgen CLK_TOP_UART_SEL>,
+				 <&infracfg CLK_INFRA_52M_UART1_CK>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		serial@11000200 {
+			compatible = "mediatek,mt7988-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11000200 0 0x100>;
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uart", "wakeup";
+			clocks = <&topckgen CLK_TOP_UART_SEL>,
+				 <&infracfg CLK_INFRA_52M_UART2_CK>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
 		i2c@11003000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11003000 0 0x1000>,
-- 
2.35.3

