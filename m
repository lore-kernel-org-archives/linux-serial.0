Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663618CC00;
	Thu, 29 Aug 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923694; cv=none; b=HW/g8VI378ygentrpeMDmTGWKwqR4vEzXUxZIoHgeQURSzkTLl0z0qNl92QqanEiKlXj76/pbXLL8Zs6wVEC86Ho3c410EXZfKb5e9nYf4wQMrkmucE4KZkyn+erwJqKGZPAG/cA4UUvWpzu9S1Qes/TNjv0NZQg9COoCSMLwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923694; c=relaxed/simple;
	bh=trcBH8zzl6PsP1oY6MIhqNhFu0NHretoyOUcqxJsYhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2hujbS+cdm6yNrvMU1hI4aHZZ93yukKcZL+TfHFGWyRyw5L67tYQcaGIMg7TW9rFsKUgNjRd0M6qb1Df/H7YohKo6lg9Vz0O3+Gsi5rEG6d7JIGghYAq6+8KDBZvx3pvfYe9AxZen72flak0xJ48vaAi5d5zzUakzJyvzODMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DjMjMcwz; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DjMjMcwz"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9F6EF41A6C;
	Thu, 29 Aug 2024 11:28:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6iUDRcUzv1u4; Thu, 29 Aug 2024 11:28:09 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1724923688; bh=trcBH8zzl6PsP1oY6MIhqNhFu0NHretoyOUcqxJsYhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DjMjMcwz3Ra0Kmbxa/w+MBM1cJfUwQHkdSmKxX+jBFbzIra1V4SXmV/l/hdI2yLRF
	 +E/ZwPyIDKAt9qj766VeoAqoxPAZ6+8pGizSx2lLL0ysIjKlAF+8SqGuXCQ63HSJ6S
	 IvVB2N1nKS51n7ZkUXNxwflQeB5/ZnHSUTGWjbSRrYGYppP67lf6KD96BrUEy08Ze1
	 xma2MUKJGU4H0OK+oJOPYV843Lfw0ITxV8jYC1dllpbrucNpHxHIKAc2d5k6uEsQHY
	 M/36B5XpAZQbBcRePxewtflumjUL24kei1LiLZfJ7DcWRg7x4T8Kr+StDFlkEazLUi
	 ONQ8WbYD4Rdow==
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528
Date: Thu, 29 Aug 2024 09:27:02 +0000
Message-ID: <20240829092705.6241-2-ziyao@disroot.org>
In-Reply-To: <20240829092705.6241-1-ziyao@disroot.org>
References: <20240829092705.6241-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 comes with a snps-dw-apb-uart compatible UART. Document
it in dt-bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 4cdb0dcaccf3..4573044be189 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -48,6 +48,7 @@ properties:
               - rockchip,rk3328-uart
               - rockchip,rk3368-uart
               - rockchip,rk3399-uart
+              - rockchip,rk3528-uart
               - rockchip,rk3568-uart
               - rockchip,rk3588-uart
               - rockchip,rv1108-uart
-- 
2.46.0

