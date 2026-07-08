Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89742DA29
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525128; cv=none; b=qBIHAsPimXHvtIZB7R5viUxiYezZUlSDTpH5A3KU0WNKCIEnU2wuoCjC+hsooBBAVdHwRU5mvm3ljG9vvGcW1xZs63z5wtpP5F7OtAOylXyPEWMAd5gUKlORE5U0HRR/8CIqkqXdi8YrYjyYlZpckMGjaPFQwrNsPPzVUCufo4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525128; c=relaxed/simple;
	bh=WhuQpxIJsHfJelMhpqFK9UR04PUwBIxESY/bbTEtu84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYDJMInvmvBhG7l+8nzdJDvsRLAxxzd7syD+8ulZ9xcYDNJSgos+fTaHesGQP/kGPNTYrS9lAZuAX9uSuQTinz+B7tNKCrq+SSZ4g4W3ehBKqXUaZ/LywzJKVcwPQX9RQddCWQfaniCgJZ1Ys4GrdQ7i85trNzQmxJvo/g6QBZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=X4rxrjy+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="X4rxrjy+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46ed4f66256so742389f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525125; x=1784129925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NnLAnFwCqMFlG/o/7EF1TFc96QCA+EgXe00U5MXSsXk=;
        b=X4rxrjy+0uNQYD8BxKSXRIjdWs9ySfXvMHsg+u6UHx69Wk+UJGoVtVKdjaFKoCpf9p
         r3u99/Y4OdLmN2PCxuXhJ898WvL2vHZF2zmcPyeWmXOYJ8R0hwAIwYgNVd+bOgsiNXyi
         sKXqggCL0ojmvFobYe+CPQrP4Mshw7XxeoKueebr/K6kr3LTVve0/hftqK2CK3J5ymXx
         o4s8PEMyHsCAki4C7di3xlGiFtwot9coVeXCUR2Gj3na1ETlQH72KC4Ff4oFTdWnU9Aq
         Fd/ShzElkunyVGa5jJOy19O9dX/zE+0yagrVw7rtZJEMdG81RBTraZun3D4MsqAnt4D/
         wz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525125; x=1784129925;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnLAnFwCqMFlG/o/7EF1TFc96QCA+EgXe00U5MXSsXk=;
        b=cl62vllnZnv+jOwdDOwB8foMH7cjDsaahzKUsJEnamwSdHlCQDWDjOYJOwBmzzCBrL
         Rvi7MH/YGgXyP0IcshcCj4E/C2eMyXneEQw+tpvWPMRK13TaYl8PoVXkCpfPavAxTKkP
         Z+IW77XtplsgOCP61SaRz3i0ajl96uoXbxjmtW3Fn8O48NNlJJ4rrOk88P+J5VPcuL1K
         On0B4GCvhjgmo0mgZu1BndXN1XXbBLzAsYXvUcWjlvs6gltOGKBCJ6xR0Bv/t9I0gOYF
         ph94wD7VBhu0JJ6N6DNRfcq10cHIqvaCgQ8ffR6rwsb9tUoAH11NzaAlp57VaUtDpy66
         HkHA==
X-Forwarded-Encrypted: i=1; AHgh+RqJGE+IpVHe6cKRyEeIBShpy4zl1s4oLat9w64PKLAaD9EUMFVwa7lPiCL3GNUX98SLOXy5lI/uDMIUuFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW94IWgHnOfKoOpMxRG/APNxBgg698az0y6+bOl4+YF01hKo2z
	GkXdOn/OO8b7r/yl6yme5uKCQa+/2YVB/8W8URq89KLMZ4WY8NWQKqwE2CLwYkvNwVvO/BZKd4n
	QUtA514I=
X-Gm-Gg: AfdE7cmEWBW+KkovpZ2l6Utr08C9EppNHM1Kc9LYQuEsxiRbiEptIJLFdUdaIaSvAeu
	NaK/Wf6JPHfjEIB2cU6cVruwyY8wSjRrXWf6cuuUkohpgQITR4H9Zxg3RsTW99s+HjMx0B/wpet
	SNRibXmxDoqI8aLWvHYOY92Xr2fIG+jNsSFeI1Rpik5DHFYQ1+agFPlXSD1vYf6Yt37FT6kz9EC
	DFh7iyPbEqOYxVxT+hH7+v5LVhQcHKvCTU8BOwzG5qVYOSUJeXH1yHPfQudwgud4sKhwMfHyyEr
	GXy/mQveAFdbLBfkTYSYlqFo7gB4eANAhpKDo5kONSE/4YxgtsMQRRjtVSnaciFc0r5l53+WhTy
	bveiyKxu/fg9PVVIHirXRzqcvv5qvNEbs6uCWl1NMtD8DCPakm4u/qM+Lfi+94gsKo98SV0tVFl
	QL3v57wUBy9oqyTZlwbI40IKc/ysbM4kHAiAP+2DF/zUdWmM/C4eVGcFrA2sBvVPKAGB/2g1+BT
	aDrzE2tUiXf40Ek5vXCcUzH3e98qZyQRv+h/rE=
X-Received: by 2002:a05:6000:220c:b0:470:3edf:e28e with SMTP id ffacd0b85a97d-47df074e230mr4140001f8f.10.1783525125665;
        Wed, 08 Jul 2026 08:38:45 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:45 -0700 (PDT)
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
Subject: [PATCH v4 7/7] ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4
Date: Wed,  8 Jul 2026 15:35:59 +0000
Message-ID: <39091b1d0c716da3502a691d0a0bdb7621693cf5.1783524645.git.gregoire.layet@9elements.com>
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

The VUART 3 and 4 are VUART over PCI.
Set this flag to indicate this information.
Also set the syscon phandle.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 7c02633f2bd6..2b51749300f8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -722,7 +722,9 @@ vuart3: serial@1e787800 {
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
+				syscon = <&syscon>;
 				no-loopback-test;
+				aspeed,vuart-over-pci;
 				status = "disabled";
 			};
 
@@ -742,7 +744,9 @@ vuart4: serial@1e788800 {
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
+				syscon = <&syscon>;
 				no-loopback-test;
+				aspeed,vuart-over-pci;
 				status = "disabled";
 			};
 
-- 
2.54.0

