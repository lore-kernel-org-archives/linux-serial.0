Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD78496D2B;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470941; cv=none; b=jncPAq+xsH8EznswoQoC0nr+tx3k9f4u3VCp38BDghVcsyF2j4qmdr//HC/O9O79aGYc1hA/5ZO63krjyXm7W/jO4XC68kA6rcHhgnnIQEUPxbej25v1gfIPZzYL2bvy3PXKcKOCQcwYQq8W3caJI235xreynH79MMvjlJ6pIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470941; c=relaxed/simple;
	bh=vqJg9MCrHhTQ3dSYeAuOSHwl+5KNi8MVa3c/QFLqYsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJf/b/4MmYjupmr3AK1TmjjRaGU96vhIm3NIzYGY5syNP+G+4btpealMG99kpfM7CgeWqboedsFDTmJKaJVKBtoO6FPa7z5i0cAVBSK5mUAQsjOiLzicQclS66e0oAN7fpq/GElR1hompPdKcbCHc9ZylM3S1WvGohC2/YNudFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ0+Mw53; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ0+Mw53"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F44DC4AF19;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789470941;
	bh=vqJg9MCrHhTQ3dSYeAuOSHwl+5KNi8MVa3c/QFLqYsE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QQ0+Mw53flsx3x+3g5e0cV1XTfIPhHJvZVAkC4O0CwM+fbljr4k8jFa8EPaWzsweF
	 rYET0qeq2Qst9xPPL8JpJevsMrytnfnJXJTFrSgguXHqyzHyEJ7J/PKQ0g2oUNs/Uz
	 j1s6t7V7FQkRYaQRDvAbZgXgex4YhwYrXk2lemnpcOwFE2Sf57zvMafuhnpCTeW6nx
	 StVyl6CyHeoU7qxUrK0Ug1pjRYWtncc9plQUXQDvqQVhCll3hYKyR+Yt1XRmexn62+
	 pLxWKCtI7vaVk6OJpSxprgZqxlFtWfPWEGJ3a7VLFdg8cG0KjZKojoMZEn5kMcTvp9
	 /maMgw3LnQM4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E37AC982C4;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 15 Sep 2026 19:15:36 +0800
Subject: [PATCH v7 06/15] dt-bindings: serial: snps-dw-apb-uart: add
 ambarella,cv75-uart
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-cv75-v5-v7-6-3297d3fbc9c0@ambarella.com>
References: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
In-Reply-To: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789470938; l=1072;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=aI42/QWFrT0q/wEmjSA5wdZvhIPXU9faQz3G+ySJ344=;
 b=w61i85kPUWtRPCLdL5wd37zWTqD5HNu/dPSEKTo91hSaguKMPeWDi30NhvwCDuk44pGCs0KgH
 /4Xp7kmpHDWA0ekKbM18jJ5j0T/WeMEVmf7PxZzf24HluqHBY06J3nC
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add the Ambarella CV75 compatible string to the Synopsys DW APB UART
binding. The block is Ambarella IP with a DW-like register map, so it
is described as a DW APB UART variant.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 49f51b002879..cec5c679f1a9 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -51,6 +51,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - ambarella,cv75-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.34.1


