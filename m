Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6C48F03F;
	Thu,  1 Oct 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858460; cv=none; b=uYekDc0HkyuR0Hxt2HySqXDe7sulzRF80VSuLpo5k5LLMZrVG/6yN0QZv1AfN8FW7TbD4cATY2CdHofNAa7HCmXyDfI2yOohJLm8MFIGn6PIYOfUQ6NwODTPiyXu7Lq9glon5tFRQUnZbuiV91vGgGjhsPqw4fJMvdJzNMc0Q/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858460; c=relaxed/simple;
	bh=n2PC5Ygmm3kKQRsnARaZvzzaiZN9N9d+mwOfSpacRzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDer88XPWAJ9YItu+RyGnYk5radMeqU0rtxDcK0w8VUM68J3XQdb3/uORtMsgmMfAW1i4v3Qav+CN7mkUnxkd86HGKO9pkReQmT90PUDlsWZt4DRtKiFiXq70fAWHET3eGFNsNG5J/qrULhoxTeMM+pxqHLt0bjkbJJgKwHF22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axY04V11; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axY04V11"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BD0BC4AF0B;
	Thu,  1 Oct 2026 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790858460;
	bh=n2PC5Ygmm3kKQRsnARaZvzzaiZN9N9d+mwOfSpacRzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=axY04V11caQs/FYp1d84t6qg1LHcYssPcunhfV9pReaT2QaxnrMtZlSneObNRLWrU
	 Ww3xnhphs5gaskfmqSLgttlpYmjtJIIi0XQj4fYkNvJKad4DQH86ZKq0ZjXusI2yUu
	 QmuemBWEqEtNZtyCLDCx6gE0sqFfPYekpb9PI8tEXpZovQ46nyM4C1X6ovoTkxhvLs
	 KOzuFTmI9G1L1p/P1B7Godbdp6tPwdQ0lhA+9TB3ku7wUVk8TyqNIle/tnjZ22KKtG
	 jyayhQI8f6MBR7i+wXzZCFSt+aPOIRdg3MOjo/Dx88djWSsTklDvMJAcZVCJeFTs7N
	 5cDE2KP9ejifA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36595CA5FD2;
	Thu,  1 Oct 2026 12:41:00 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Thu, 01 Oct 2026 20:40:51 +0800
Subject: [PATCH v9 02/15] dt-bindings: mfd: syscon: add Ambarella CV75
 secure scratchpad
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-cv75-v5-v9-2-486cc289a4b8@ambarella.com>
References: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
In-Reply-To: <20261001-cv75-v5-v9-0-486cc289a4b8@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790858457; l=934;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=sWEDtsH7Lmq1R/x+RLJKvlPiYjtNzkc/ykiOxa9OBkU=;
 b=Ur7au6+duy42kHSViIdX8c/1puUmSrN25+m7krt+Is2WpDy85zhJCbuesB+VUyB23ny0NBpmF
 ACpeHUNY0jkAIMSwtxcqEphsZd4KJRYy/tDOgpIdZflOFXsRPKy2F9T
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


