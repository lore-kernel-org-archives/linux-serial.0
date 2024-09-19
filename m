Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4219CD07;
	Thu, 19 Sep 2024 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744583; cv=none; b=ElgIjaCZ0cfS+FlPQ6mKATR4PQtQFyVfIppCV8mIqKSZQaLJaHeT/vok6ij7DL84H6cZrMR2fXmZdihIiNCDeZwrXnpAoKZqch/38dq5U30Jf4TQnzKu9SPrA4TDpzI4fy+9yKcvLmVcV5D18XoAv2QguWmvaoqFWNTvN2PhrBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744583; c=relaxed/simple;
	bh=trcBH8zzl6PsP1oY6MIhqNhFu0NHretoyOUcqxJsYhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KofDfz3FSsw4Spfy7J3jHOuWTixeO8JtacKNsVuh69FftZHOmsLLokS9Tpp3kgUkhTAjClgxhv7zDvIPT08giWCs2ZOeTV16u3QASgb2NBQx9HzdpKNCbbrU9t226o5r95WFYUjtz84Oh4QNbSN9mNTIAppFhO+sBXTSLca70zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=M1Hy8zEQ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="M1Hy8zEQ"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 25EF223D9E;
	Thu, 19 Sep 2024 13:16:19 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqxPeLJWN-RH; Thu, 19 Sep 2024 13:16:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1726744578; bh=trcBH8zzl6PsP1oY6MIhqNhFu0NHretoyOUcqxJsYhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M1Hy8zEQcZ1qgc1TNFfp+Rz1+hUyYlFxv1HxA6YE1C+os4GqVMqyEXv/XAqibpt1s
	 D+IggyDrXYR/DSlI+LD36Kv1guDD4985gOECFUNzTp/q++8V/UKaZBBi771XgXLAt0
	 QY0bOZ1mRK+3dciCUFTeto1BC+JUSWF2cZ9BSAHLaXkcR/nhb2wcooYAQyisF/+dSO
	 l48sTNfRaLFAjjnSRm4bNNYQqzw6N3srY3jrGns0BvY7eCjQD9KmodSw39b70ujem2
	 dxarZuYmxtvv7x06ZHYCrYw2Y0eD0UzfLATaRkiXGwcNAGVUJsfM5kAhiR7cEx+GAW
	 FXt55BA81hHlw==
From: Yao Zi <ziyao@disroot.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [RESEND PATCH v4 1/1] dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528
Date: Thu, 19 Sep 2024 11:14:15 +0000
Message-ID: <20240919111413.45413-4-ziyao@disroot.org>
In-Reply-To: <20240919111413.45413-3-ziyao@disroot.org>
References: <20240919111413.45413-3-ziyao@disroot.org>
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

