Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1669B1B86C8;
	Wed, 14 Aug 2024 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650809; cv=none; b=kEZ5JL8PfYSx4op5nKSLcT7ney3vaOl6Mde6a5tKe1B5ftAEJTWjrYU0VkKt2pUIqXL7xukaFJ8Ge7lodzjYShn3xBKgJNhDHmuXM8broSgO8o5CVdfm0auNpBX8540xBL7UJPyb82E9ozsPHPFNL1mReAAZ5JxbiUX7RC6ZHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650809; c=relaxed/simple;
	bh=trcBH8zzl6PsP1oY6MIhqNhFu0NHretoyOUcqxJsYhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPVtWYeevKsJ9gnMSIxADfC1bOLtuwVInetDwV7zyS4+hCLYbOXlJr99vWfwRsL71H6VsVsvTg/wYNamcCbHuPWUL0jrFRT5rw13iEGoDhwS6/uqU57ykJBvzSuo5ohWwFJfxcTil2K4Vke1SHNlDlfym+Fzh+GntFc8rWHz4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CbLaou3E; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CbLaou3E"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CD7C94127B;
	Wed, 14 Aug 2024 17:53:25 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fsXfYEHWHriT; Wed, 14 Aug 2024 17:53:25 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1723650805; bh=trcBH8zzl6PsP1oY6MIhqNhFu0NHretoyOUcqxJsYhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CbLaou3EUpE5DJ/wf004E+FHLGypHIYYBkYxPbjja8KpbXco5TR6eqdOQDq4qJ++t
	 BZOBgw8+rNUqhQ4v/95lxh7DWQpTNLeABqlL/VpG/3TKKtUsQG2SW1nubxadx8K5Wg
	 fhNvMOF/Y9SD2A2Ac6xtqv79ZBHZUBHcIE5VLQCaYnFyl2+Rk7NWKpJQf59cPEpnwu
	 EKzPVdEgCRc+zkYhg20ETTDW+3FacdU+AZQvKIkeFstpyNoH/gfd6zdB5LkAH0F7uk
	 YZ6aHNQ2vuE2VFQ809aKGlKOoa1oviJwmJNSqEREmbbhEwZ8jxY+xxm/EdWB0AGymE
	 ouLQSlseTaZZw==
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
Subject: [PATCH v3 1/4] dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528
Date: Wed, 14 Aug 2024 15:50:11 +0000
Message-ID: <20240814155014.18097-2-ziyao@disroot.org>
In-Reply-To: <20240814155014.18097-1-ziyao@disroot.org>
References: <20240814155014.18097-1-ziyao@disroot.org>
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

