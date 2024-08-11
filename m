Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF414A4E5;
	Sun, 11 Aug 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723385337; cv=none; b=TJOx13H1rStHaVemBmX3H3FHZSU2wqxMPMxHdZHJS8AcOLQIsJIJkPlsVhQ/gHvKLX4Pue+UHAP9cBAJsiObm6Bz45eaJWZgx7QgGsHjc1t6PCfauS8+gDiueeKcpNJNTvyPENnPaoPwDgn86usXLtEqzwGq/2X6PlnG+aS9B1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723385337; c=relaxed/simple;
	bh=e2IHfBtzbhR4PRGxd2fO9kDj9k6eoW5eYQRrMIPOcoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANZ0oqoqeSMiKMmDti9MpegMKpjqWS/jkKXwUT0OYuZhnCHu6zJjx+iGxFs6qgP9i1OclYXK7YDEoQSQ8O5x43zDDAA0gRuu0nXJkIMnaRyiJVyiFUVqWp9TzfUcc1JOrRiyYL0t5IvyLCENiZtL5X9oQHsxYoW2xqPNUY6VR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iejZ8Elc; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iejZ8Elc"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4641C41185;
	Sun, 11 Aug 2024 16:08:54 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A3zMd-89ca-j; Sun, 11 Aug 2024 16:08:53 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1723385333; bh=e2IHfBtzbhR4PRGxd2fO9kDj9k6eoW5eYQRrMIPOcoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iejZ8ElcrQ0/+/5Le2PBXPAU+AEfbGnImW2YHwX0OqSy2MlEOsl8NdM0LLh+Tjj7A
	 8K73uLtchrNRmDjQ1KGjuCfaE/uOFIz0LwRnyNYaEve8/tlmCxPINpwD0zqbSsUVQh
	 ioAxX2QxEoeL2ZeDthox9rTp9jARnv6pyFGWuVXo/kx/sUkdu/fKVAxUN+Y7YAfTm4
	 7DtmWGhXqHAaQdXqXXIsIEAM3k+G6QBYpWhi/4CA2B+CY8wppSMMqoZ7YE+vtYCgIC
	 6sAcXm40oJLkBIULybSB0LOt7DbdDfgeG5O/Hbmb+faFRlfa2JJHINLsWVLkVKTMSx
	 HPrQlZziNGwJQ==
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
	Ondrej Jirman <megi@xff.cz>
Cc: Celeste Liu <CoelacanthusHex@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/4] dt-bindings: arm: rockchip: Add Radxa E20C board
Date: Sun, 11 Aug 2024 14:07:23 +0000
Message-ID: <20240811140725.64866-3-ziyao@disroot.org>
In-Reply-To: <20240811140725.64866-1-ziyao@disroot.org>
References: <20240811140725.64866-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree documentation for Radxa E20C board.

Link: https://docs.radxa.com/en/e/e20c
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..2b8bfc7892cb 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -753,6 +753,11 @@ properties:
           - const: radxa,cm3i
           - const: rockchip,rk3568
 
+      - description: Radxa E20C
+        items:
+          - const: radxa,e20c
+          - const: rockchip,rk3528
+
       - description: Radxa Rock
         items:
           - const: radxa,rock
-- 
2.45.2

