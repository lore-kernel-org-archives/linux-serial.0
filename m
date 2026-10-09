Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEE4C33DB;
	Fri,  9 Oct 2026 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543604; cv=none; b=jJuKgbkzP4z1wrjCSxsbNc/3UbMa+klgXJSYSdcvr96OFIQJMkVT8ocNBNcNseEETWVjDH03TvqKRAlPy1F/Ya5Nuxtyirtr+88HdhKAciQcPsB+pEqyHma0ovnlS0uKobOWgySuYSy1gi2PTTsSROFcVKbjxiQCYR1JEf8Pn1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543604; c=relaxed/simple;
	bh=vqJg9MCrHhTQ3dSYeAuOSHwl+5KNi8MVa3c/QFLqYsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCkvjQiOyFtUZrl/718UaAIeRdRS5qs4BgzyELsuPLGxszAAXCdgHONymAg/j4ZtEWSV9j5Lgq5XsCWUrpDeRKJ62Iw9FfisZ0Uyixn/G3W49ZhX9ABxndZXdRo0gTFCeC8pEar8ML2yuoZk2CR0y/JGyZij0fZeyj+fi4M4sqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYEeUV2X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYEeUV2X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50141C2BCFA;
	Fri,  9 Oct 2026 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791543603;
	bh=vqJg9MCrHhTQ3dSYeAuOSHwl+5KNi8MVa3c/QFLqYsE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WYEeUV2XHPCuKXQjPShldG2ZNmHvBbVd/Ge/wtuRs7eDVxh887KHhLAzvskxFA6Hd
	 DdEuNcdOExRzQzDLEIQWXFAsTjYvcvg5vdhQ2VttAr6cfCbkhl0r9R7unTc/4ZqhMC
	 efj8yeqsuMcR5qT3xYLmuFioONPr9B/BDzFTjYotB1U05JFEd9mH6zorT94INdoHsw
	 uEi30K/F5UWnEgtOqEEXP7W5oLUp5/RgeSd5Tkc0+Awz0LgtB12CLvTWtMaqU5zXiZ
	 WkeJfywF8pl0uOVR7vEfooH7j/gs6mlXyab0uhkW8GAZZzZKjC/G1w9zGijngulWeq
	 ZB70sxpoodiuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B929CA6012;
	Fri,  9 Oct 2026 11:00:03 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Fri, 09 Oct 2026 18:59:58 +0800
Subject: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: add
 ambarella,cv75-uart
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-cv75-uart-v1-1-38c098efaa99@ambarella.com>
References: <20261009-cv75-uart-v1-0-38c098efaa99@ambarella.com>
In-Reply-To: <20261009-cv75-uart-v1-0-38c098efaa99@ambarella.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Long Zhao <longzhao@ambarella.com>, Long Zhao <zl020895@163.com>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791543601; l=1072;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=aI42/QWFrT0q/wEmjSA5wdZvhIPXU9faQz3G+ySJ344=;
 b=lIp0ILBvri3QNGxMHy1XKJUiWUYvElO3MP7ucJnJbw9m/h3rwUbLEJKvYPKkVXFSZwiMpETos
 GooebNqnK6vAXjzFxk3apl48mIUIWRLuRk4A/XJaaZ4bJJBMpDhFEPh
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


