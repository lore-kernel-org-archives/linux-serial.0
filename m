Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDC34CFC2;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964612; cv=none; b=qjSGywb/CNt6fypjJIbkNZVvcce3zDdDgbwUX84srJDSnOVxXY/K7Ichu+W8eT2RD+Olk2qUlrOAdDR+ZQ5BP0sVlJr208/Ch88Z7dW0PFgTWk4SVIA59YcWNXhx7vM9RbLtfAaNIIIrKY/Pf7uup1cDZfVypmPJFE0icwltezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964612; c=relaxed/simple;
	bh=n2PC5Ygmm3kKQRsnARaZvzzaiZN9N9d+mwOfSpacRzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahU6iDRax0SRWGlScf0fUyxfskhZifTdfo+EyFSCghLGPMTYRo3w7uTx7Y/Be9lNLwAumZeFvh7jemf+gFaw7Wnb+22Kzk7SEQ20oG+051JNRaiek5lBJWJgWWSXKwesrzDno0wuMj49DLR3QR4EG9p9nLa8DcIsiola0eWskQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlX4nmUs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlX4nmUs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D107EC2BD01;
	Mon, 21 Sep 2026 04:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789964611;
	bh=n2PC5Ygmm3kKQRsnARaZvzzaiZN9N9d+mwOfSpacRzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qlX4nmUsNet0rZajFt+qle/x2v+IDWwzAOGmwx+R+eY95PnoXF6uBEqBoZLA0w6xL
	 t5G++ihPJH/zFG919Kml6khI+69UY/QaRgepDfKDHbRgjaOkyEfUL32TtEaTlJvPBV
	 d1ochGAodBJZBh5sipGdI5MF9M5Ww/CBjv5fQ5ieFUwF+faXa4j0YENHq/WZi3eDDt
	 9KT7kqba1RXW5J/9HW89/co0HT/sVLCXAzb4eKqPT8tYgB1sc1kMDbL/K1J9G6qaUw
	 gDk2yqqwDoC5aHfbFzCdcpXtVhjkxpUVGlQHnCXxDZEVx54GQnIz4zlGI1d0qmKo+b
	 e9auK8mv4gFTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7583C982F3;
	Mon, 21 Sep 2026 04:23:31 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 21 Sep 2026 12:23:21 +0800
Subject: [PATCH v8 02/18] dt-bindings: mfd: syscon: add Ambarella CV75
 secure scratchpad
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-cv75-v5-v8-2-282ff5d98dda@ambarella.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
In-Reply-To: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789964608; l=934;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=sWEDtsH7Lmq1R/x+RLJKvlPiYjtNzkc/ykiOxa9OBkU=;
 b=wljdeKkGrqNWfzTvFFVGbZAT8zmIebsIhjl5o8Gig48qo97VDNSel1vmcxttmUsF5GL6UVc2V
 ROhchdi/E/2AeNjF9VSr9sQKj3GjCJwsdWTXFeNd/kteyYJT2DJOIgq
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Allow ambarella,cv75-sec-scratchpad as a syscon for the shared secure
scratchpad registers on CV75.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index fe882d3f828b..9ebf702c06f1 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -32,6 +32,7 @@ properties:
               - allwinner,sun50i-a64-system-controller
               - altr,l3regs
               - altr,sdr-ctl
+              - ambarella,cv75-sec-scratchpad
               - amd,pensando-elba-syscon
               - amlogic,meson-mx-assist
               - amlogic,meson-mx-bootrom

-- 
2.34.1


