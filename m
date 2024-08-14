Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF41B5832;
	Wed, 14 Aug 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650816; cv=none; b=SH5cnAs3ZW89216W2fjuM4RUDSOGNjcix6Redg3OHibhnF/BSdSVfD/mTcpebSRsonXkqr0cO8FRim/beErigmIDPaidmloWyFAqMFnutQkZhys60jSBsIUO9Suc9JaQ5n893k6UrTApYyD2NtpeIe0P4/Xi4w/iuYURrpojTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650816; c=relaxed/simple;
	bh=Or1+h5BCUkQk9PcJ2qsUhycm7+RhGUIIDkuJFnz0sew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+M/IJCmiU1ClhyM+eqWBK7hMz7d1WEV1oBqmai8aj9Hpc4j5J5x5H/4k9XTFo5CvKPffLfSEmHd8UcJEAh1DOFN8NRCeI9M4Ghbu66QgCKd8cH8/kRh3ynM42ekESaKL3tJYN8eoKt1elS36nW1xIO9XXyH5vWczMAS7nDigrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=QrXplldw; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="QrXplldw"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5CC0B44D82;
	Wed, 14 Aug 2024 17:53:33 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WSyibF93yuzA; Wed, 14 Aug 2024 17:53:32 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1723650812; bh=Or1+h5BCUkQk9PcJ2qsUhycm7+RhGUIIDkuJFnz0sew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QrXplldwr/Tnra1yKDDP5TlOVRqGYIjbazSiBVczA1OhGaZY7rmy9Mtqwvy85nKY4
	 jRayh1NAiUZc0VmHi9Oa8GeRDtS/edZ+RPK1SZAYY3UpMCcO3gQo2601foI9SRPofS
	 kUkESsnH0K+mn1Ad0WEYT0887+YRfbC90HDU0/81z6v9KBQCVycRtCJR1r0nM4P033
	 opQUdB+VLc0fbH2Gv368ts0vaBXw85o1nt/RuuJKMEYLMGniD1IWoMCpS2W7rXdovN
	 kg4uU9pLouT3LdExp+syJ4ryA8L0sNleM83dJemyk20Yd203cfHemUgMq0OPzrtt+w
	 R5e2TUnfpOo6Q==
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
Subject: [PATCH v3 2/4] dt-bindings: arm: rockchip: Add Radxa E20C board
Date: Wed, 14 Aug 2024 15:50:12 +0000
Message-ID: <20240814155014.18097-3-ziyao@disroot.org>
In-Reply-To: <20240814155014.18097-1-ziyao@disroot.org>
References: <20240814155014.18097-1-ziyao@disroot.org>
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
2.46.0

