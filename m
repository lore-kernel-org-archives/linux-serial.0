Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849718E028;
	Thu, 29 Aug 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923726; cv=none; b=ut+hgI5alRjsmZADWYLUNC0C6juQx11p3t2VmT3CLZXlaRkrrwqzX1gE3POtEkxlyJmfGVQXFyIbgTqCCokPmHt2sARBt0FoPjzVaUKfNbzPCOFeEvC5yV9HNL1oBY59MQxyfp5RFne/SLOQDrWKZUeToFBr7nEGx1cC3GPp/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923726; c=relaxed/simple;
	bh=Or1+h5BCUkQk9PcJ2qsUhycm7+RhGUIIDkuJFnz0sew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBGzA9IgEq6BUWJNp+tf1AkfKR1c6OVRMTG/fWtktosA41r7oKzGEvgnPgQGd5BrwB8RjKPt6yuGyieqqgZe5JfWY8LqvtcCLUE1TxjiN648D/a9DkhQSjwQq++IOC6KSthp2u0RR01ypWvx82Ddho5diQNBFdphA+iQzr9hMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aJEFel5a; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aJEFel5a"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2A8F344DB8;
	Thu, 29 Aug 2024 11:28:43 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iwbCpwi9uICB; Thu, 29 Aug 2024 11:28:42 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1724923722; bh=Or1+h5BCUkQk9PcJ2qsUhycm7+RhGUIIDkuJFnz0sew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aJEFel5aGcHT01qBVolZm/CLE0fT9M82zOinWLjU9f8GNlcAmB74U7ziMQpWTKIyD
	 yV05nF4SYqAR34r2wIoD92SDy8e0pzCfTZvN/cl+p4jUS+QnWOYzA9w4pM5/MYZTXe
	 keg/4W5NGzPj58R0XBwjVsBb/dt1hU8sHvx9nwBmnG4FJnr6FJbUcKuBusfQ382y++
	 I0MO5nOlcvfLcI/Wf5TVIDKw7mCJHFX3YwuiHbAfLAG8fsuS3CUE7YNskayLxvR3YH
	 jL3zyKsxCb2uVjvK3CP+Y4FssPB7xpXzwQP8puWd5mVYNsY8fPEODVwGhhHVzgEOjj
	 TCO3lRBGyyq8g==
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
Subject: [PATCH v4 2/4] dt-bindings: arm: rockchip: Add Radxa E20C board
Date: Thu, 29 Aug 2024 09:27:03 +0000
Message-ID: <20240829092705.6241-3-ziyao@disroot.org>
In-Reply-To: <20240829092705.6241-1-ziyao@disroot.org>
References: <20240829092705.6241-1-ziyao@disroot.org>
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

