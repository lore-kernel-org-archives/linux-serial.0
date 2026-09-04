Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8BA41D121;
	Fri,  4 Sep 2026 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503954; cv=none; b=WUrF0zAy7hYywaxEtOlOl5GefNtXGdgAreJYUM1aA2t723C0jJ8GX98icerH6SOfPUd0cRIl13RUgTwfqvkGKdd2yFJ0gQMihTQpeWTtZ7Bt5+NNRMIQFo9GhRCbu1dDYY+Q9Ty2q1wBELJRG9m+ngQfjb33zOFLJMNjLqnKqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503954; c=relaxed/simple;
	bh=YRtuINaeeg+H3XFSuIJVNYHLS6Z7t0vhSOvvVH0L3HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q16U94rcz/kg8WAN6CAFvb2UiIHDanZNRKHapP+LNv1vnYt9fKtfErDsKGpG8r/+7w56KmBvYbAr7XUy2O2B9daSVBvVb9H83SCe1gVMdY+v7b/tt3Ypt5zsNywmTfA3Dk7CJHPS4vqSiCU4omXEIyPzc5rEaZ6H1pQS6Y8gNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVjHyt5g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVjHyt5g"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C7DEC4AF0F;
	Fri,  4 Sep 2026 06:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788503954;
	bh=YRtuINaeeg+H3XFSuIJVNYHLS6Z7t0vhSOvvVH0L3HQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MVjHyt5gDwOkBcnDzLO64lWK0+72jzhMlVHf+0UxjD9qwVRe99+eAi+8pZbVyY4xh
	 3+Se2nw5WEhlr0E14S2eSE8F3YWzSHqxqo951eHA9ysCZnHbi3yqe85NyiD70Qocpi
	 ogsztGaJ3WLEzF4zJnD+mloianH7rK2pvsrwP6W9KyFM4mXXBTnTm91qKs5w2Ch6DU
	 WhFCgY7AHQ/U0gxBe5vaRgAF6CeRsWrDyHQBmgCLNGDj7zShQt1zMvyx9S2Z980Dii
	 DYLwQ1iHB56iDe7BnTc74uY8fldtfvjZsB16mAnPpD/Plvpc2hNBFxb74kmXPDbaar
	 2AkbS7veKpUFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09237C61DD6;
	Fri,  4 Sep 2026 06:39:14 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Fri, 04 Sep 2026 14:38:13 +0800
Subject: [PATCH v6 06/13] dt-bindings: serial: snps-dw-apb-uart: add
 ambarella,cv75-uart
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-cv75-v5-v6-6-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
In-Reply-To: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788503951; l=954;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=9H5T2CAaecrbxe1XZGmzDHUwCx/pDCa6CR6TyCM/1dU=;
 b=XXOx+PGosTen142j//farUwoWwOnOTOPuVxEH1dTawpqdUI2vhhMrMwC7T6z3DEC8TOxtPWgD
 vQdhQXPJndzBsxLC9NrgB+T4uhiJzGTj3DrWDeTgTjlQ/9JjeWRUE0k
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


