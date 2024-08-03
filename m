Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275C14F9DB;
	Sat,  3 Aug 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722689792; cv=none; b=bESyeRJEr6T5n/T/ML5PpVOHzdzI24pIw3cl5sHslT5MojjZBRv7BcAPDicWwW2eY+hWOM4vqb6WvVbmJqgFXhm9E2xR5l8fL6H2b/FJyVpLakwEUP4NeCyQQTaSYCmmlUX+z6n7TNmmvZo7hapRWt5qNvqDVB44TPJbCxMPXVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722689792; c=relaxed/simple;
	bh=GGZ4YI6RLLHoGKa4s40NjWmL8ucXD8DGFawgO4lCUkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gk8JaI1rkXxUFC1+gIBa4FiX7J/DwzkWRC4G+ERUFHj9Tv7MK80k4X4Jo+VJtMkCkivqywQw5rU/Wb3vzIZHtCCLdY+kku8Tv+H5h1RbVmmXtVTUt+vVaemo/COwyVOru43OEgEjrVpAl51hu8P2ZJj0KU+0KHD+72+yaV1DfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=gpbJ6hBH; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="gpbJ6hBH"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5FED641A06;
	Sat,  3 Aug 2024 14:56:28 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vDqRDkXKTiKr; Sat,  3 Aug 2024 14:56:27 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722689787; bh=GGZ4YI6RLLHoGKa4s40NjWmL8ucXD8DGFawgO4lCUkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gpbJ6hBHJjCadUT0/SMskCBTbgaxNpOBiwnKaLNxC6IZeFuKTOiWo7+iQ6svTegYY
	 WYo16Pd2tU+rSHNPnQDjV2vJYdl2e9Mtn7uiLcvAO/0vl+evnq07tiLzcDvyv5ORhT
	 t0/sgIpo5G2ewM32S6qtHaTGb1uA8eomuFtL4vAesmUFs1n/Hq2rDt5H6b6c4TtCk8
	 FGwkhYoDHAFFkf5Jy7G1EHnxA7BF1Om4xUaweH22An+u9rn+iljDLqWCJRuaxHttAE
	 F51IajaaH28K6tIoNZw3Ju8rEBT5Ig3Cb88HgRuJyo040Uxao7nDPDeI3x9/ILzJgG
	 0U0MClD/Ske/A==
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
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 1/4] dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528
Date: Sat,  3 Aug 2024 12:55:08 +0000
Message-ID: <20240803125510.4699-3-ziyao@disroot.org>
In-Reply-To: <20240803125510.4699-2-ziyao@disroot.org>
References: <20240803125510.4699-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 comes with a snps-dw-apb-uart compatible UART. Document
it in dt-bindings.

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
2.45.2

