Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247646D083
	for <linux-serial@vger.kernel.org>; Wed,  5 Aug 2026 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932454; cv=none; b=A7ERaLcy+W4ewu1c9UGswj9nT93sFnkUCxs6FBqepYpxGltfyF6B/d8lpl7IQgNM6D9R4MpStQDKLToyz3OJ7R8VWqBIzVmBSLMTiXwUHtqsTp8s2uHyFsraDWtJqo3pUnc8uK0PbaYBguTE8Ed0K4OrssGoMxhQwCRwA7Ylk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932454; c=relaxed/simple;
	bh=f7yF4xfFFHIj3dQvLZwaPrGUwIwSiMCTUNahiYRsF5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LS5s+mo3VWVW0jiDQ/6yNhw4iB4pHQLujXR82PYK4+uKMhMfo140p5yNOAQ6l/DcYj6FLyVkdWqf4z8A8Fi6WLGp7iB3YQZnSrY7DQ6QLjkaHGJKFIwa8oQyXt04SnyjHY1705rTlwYJ6VndO4vL8JFzP1yjZi2Q+T8SR7ZAYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=C4eYpnMU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="C4eYpnMU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so7365365e9.0
        for <linux-serial@vger.kernel.org>; Wed, 05 Aug 2026 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932449; x=1786537249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/7dhBSgukk8ss4p9GXKM7Hns3H6z46vF+Aj0GzKdlA=;
        b=C4eYpnMUwvO0Cqql+suM6pyz0UNqQpSmIeCbhbUOOruKmULqzPJzspPt78rtTLq2Dx
         ZICyQhUJTAzX1460ySAoUr7/XidbL63SiecUAoLL21kFXpZsEtIvk5xcoyoMoqOWoXYz
         MDm69FDmKcKt+G5BgFQtIcDuCg1KSMDAS+sFj9EJH41PhLwvJfykk0bFgGVVbRKngvN3
         7T/8cADcS3qoPsYGoQU1JlphokyNX21P9iGg62zueRRCWq9DqSnyfSTKgEZ5JVRShx51
         U/qJKh8xRwXcOMm/kuiqY0Vi/WJHisRXyrFGTYxjNkBJplDJU3LSqDzTdweFZqAcxC1u
         Pl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932449; x=1786537249;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/7dhBSgukk8ss4p9GXKM7Hns3H6z46vF+Aj0GzKdlA=;
        b=BjaNdkjvHYJxEpw7ZKt0wxCMpTypF98I1+39nrn2SK8KE3R4fw+CSM2odoUYT8q56E
         QfVOLnsAX+sii4ZX7RKxF0Bv+sL2perYKnvQMU0mA9RuedbXVDLLbp7gfcCc38NYvYLw
         hjeAtFlTaJZjc1IOq7Pj7cr+TwTeDxgSk3IcBTkvQ9Xt4bPNQfRD0fRAy/q809i2hg/4
         c5IEpQeBnYwRSwqFallDtKrHmnE2a6i99A9F5m+0xCbHXlL5JJQPnzktwmqN0cEQXCy2
         gNmMT5Er7G2FdA3iVzDp+regukesDjXoRLywDLe39foZVCI3ROUzGll0DpwnzcZuYqbu
         KoQA==
X-Forwarded-Encrypted: i=1; AHgh+RqSfnR2wf71K7okM78HEpxnbt9L0ld4seAcH4Y4BMuc5X2oWKm9PnrXOCz7NPXbdoEcir8wwiXzxbw1uj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNbEyHLtMIqVF3JfR7rDwwtsZq+IDVm56ZPsm7IMyVvsNLoOk
	5kWAPmkHxPiCGbjEZl2AYQO83s10JB16ca6ozW/l6t7yBz7V9i9p0SkAqk5+Jl2do3c=
X-Gm-Gg: AR+sD12dBsmlKidaA/iNbumzDyBsIlHfpnL5LtvMxJZCd1XB3U+fPYljHi67AyPS/zd
	uqkSmOlVEnHXAd0TxetsLjrTifxbhBzyKihkI0UkcZursrIREl0jJCHOEzcPEBJKQIAWc5tFRoe
	YYCM18QCaW+M0u6a/DBERRl/A0mqBtycZbb75tQTofLwbMpr9nivt/h85FUSmCuUT5uZhvkj2cn
	eNTcFpjJTmgnPnPo6o7l6JbzXUh3SUc/egVsEfCwjMwCuels6LUoa4HSQTVziGzNV5VcWZT+c8V
	4uWLQ8IgwU+6At6X/gNr5mBsanB3wS8fglv7894jU5jb7vjGBZwRHx19iAy0WTMjkNsv+Q/yb6j
	BOcvk/jE7qkqqmjdR6geNpxRpekyS0v2niVEsvlhac0UYIkovAoaLgop4KhoUN1l4XUQhYdtEBD
	2hHyc29WKewuta7D85dgHkFzbhsRrjTT2I5EHx6+DpkHPCOcqqpCHADuha2TktsPk9sL31Hlgzw
	vl3RriDVD8SLykYF1CkhYVjN0P8A6gYOIoexII/CulNY/fgXupnbeVstyqtvfkaJ4DlpfQURnR6
X-Received: by 2002:a7b:c7d6:0:b0:495:4b42:8677 with SMTP id 5b1f17b1804b1-4994e7d17c3mr61632935e9.18.1785932449558;
        Wed, 05 Aug 2026 05:20:49 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:49 -0700 (PDT)
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
Subject: [PATCH v5 6/6] ARM: dts: aspeed: g6: add aspeed,vuart-over-pci prop to vuart3 and 4
Date: Wed,  5 Aug 2026 14:19:53 +0200
Message-ID: <8d24d424b3504105394055de268e0a11515635a9.1785932211.git.gregoire.layet@9elements.com>
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

The VUART 3 and 4 are VUART over PCI.
Set this flag to indicate this information.
Also set the syscon phandle.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 7c02633f2bd6..fbd7ab6332a1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -722,7 +722,9 @@ vuart3: serial@1e787800 {
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
+				aspeed,scu-syscon = <&syscon>;
 				no-loopback-test;
+				aspeed,vuart-over-pci;
 				status = "disabled";
 			};
 
@@ -742,7 +744,9 @@ vuart4: serial@1e788800 {
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB2>;
+				aspeed,scu-syscon = <&syscon>;
 				no-loopback-test;
+				aspeed,vuart-over-pci;
 				status = "disabled";
 			};
 
-- 
2.54.0

