Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BEF149C47;
	Sun, 11 Aug 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723385331; cv=none; b=LrYf2SYm6EmIYtWpausbykl2N3uDEsSU30hMGFtOltcEiOJ7FpoouCggeii2m1/wC5+j2tqJrKIjOscRXLIIzwEEB9wQjBcbNhShs6A7KVR9Ho6OamGSVdxmMj2iI/5ZhdsMuEvXfktDapw7WDhUlKgc3CIk1LSdxJhNwRs5b9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723385331; c=relaxed/simple;
	bh=8LxrzrFhWFpCUVmO9uUCUHCbQe2VRU08Ja69nX3UYjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OA/ucoA0LpYbu647V7n5nVAxTdQQiSikX9SiPm48KOMGUjN4uu4iZVFK+jwXOMgksanQ+JfXh6C9AvSA+wzS6l3phm5JoKSzZFcb2S8PNqG5YhmA8T1y4yc6s/iqgxLzGzoY/Cm/D0Q4N5nGgaqfqfD6lGeEpR/AgGNpKggIyCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FB/+KNGG; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FB/+KNGG"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1068840CF8;
	Sun, 11 Aug 2024 16:08:47 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cijQeAMapwPm; Sun, 11 Aug 2024 16:08:46 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1723385326; bh=8LxrzrFhWFpCUVmO9uUCUHCbQe2VRU08Ja69nX3UYjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FB/+KNGGyXKfYYd7xCyqTeV9lhIvF67RYtHr8UcBEfIoA45cReMeIjZJ4kvCTG6IF
	 qykbiNE51+Bt/fm+JyfuOnnD482jeT4c0u2ToIjLhH6jHOLyiqMyL7eXg1tRPf3TWI
	 dV+nC1Hfej6eCsZhTBHixksmStj+NHwfHcDL5TF+bvdFwm7tuP2WnNOW/mmzZecQ4w
	 2Y8KlX5xyPvJ6FTAt13Qa/pCiQ/sv8asCATTb24ElyrAF7D7+ecMmBhANOrsoWc0tu
	 Z8HxH0bYpc8fW3+PJCXxOmOw1pF4J/iF/1T938wVyDfZpnmUWyWWptNyPj8yeQk5Z4
	 oPcthvVpUnALw==
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
Subject: [PATCH v2 1/4] dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528
Date: Sun, 11 Aug 2024 14:07:22 +0000
Message-ID: <20240811140725.64866-2-ziyao@disroot.org>
In-Reply-To: <20240811140725.64866-1-ziyao@disroot.org>
References: <20240811140725.64866-1-ziyao@disroot.org>
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
2.45.2

