Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81802495026;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470941; cv=none; b=ufdFCghxLKXB0jR8VqCCi4DVy8oydRoacZCbX7klsUlyesGwJuiHXGc6xO1q5X4qqnuROuBUFHoqA6DrOTZBKfkMBwgRdWDV9Adnhsfnq7ZgbblRCv9dO7TAJJ/R/vrsdoHGy/g0FqSqoxPwv1/3wYpTBDAnbA2xEg6xzklwTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470941; c=relaxed/simple;
	bh=Y99LIShZBZhPmmdMk5Ppx+DA9Tlbp2khrm8XeVm1tJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PDvu74isEnC74M5pRVMKeZ2bxLhYliLvBbD/AeIwdsLd6cJLA0/WqCIxzx04C06Z9lvh9K96DhHMih3GAsoANl6vUOTCVKkiVRaCZ8/bb7Xqj5uHSyC7KWiZ42vk+PZtB42xJ8BNCUOFDTCKFilN3Zwcv3dVjIA0RREXCYcBxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtEn4NBq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtEn4NBq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25DC6C2BCFF;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789470941;
	bh=Y99LIShZBZhPmmdMk5Ppx+DA9Tlbp2khrm8XeVm1tJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JtEn4NBqbLOQ+UbYHK1/qZZ9rwtvsKPl0XeRqysXoAKnFyIN2Pi09x3vfao0/xQtX
	 k/ejbqOfqqMAtguIbk+yUXfBFV0pC9NuT4bkbuLfY33lKbSnl7Cau8GWhwtaL4CBck
	 yw1717F4R5GJNIfZTBx1aZU3eTRED8lTo49qVxe51qM0k5THrvGMjSVgjgp+J8nhZM
	 J60CbdJqMeZ/CeNQ3/xVq8E3uxodo0tVLuGzz1JFkIEQMefMB95qwRGs+PXfvGrx06
	 GKGokCb2SB9DFZhwmicfWY/nqxKzJebEH+HDaEl0H7pXUiV29HH6kCeFS2zglTSNid
	 qCw1/c0tw1STg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF6CC982C1;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 15 Sep 2026 19:15:35 +0800
Subject: [PATCH v7 05/15] dt-bindings: gpio: pl061: add Ambarella CV75
 variant
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-cv75-v5-v7-5-3297d3fbc9c0@ambarella.com>
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
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789470938; l=1618;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=aAqprMpaSLw5qFZ97734U35wOILQfn5VOtCzk0qgTJQ=;
 b=wjwZC5nSO0mnA+lQUBhAJnLHm7BRubRNaWWlThrxybkhqfwzBEiTuU0zmV2NXrMINNlxJ9tqC
 U7oJQTHLJSGDJ5MgZuPXeCrG0kq/AYF0BK3+VcEs4UW+PQIYcW4OvZn
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add ambarella,cv75-gpio as a PrimeCell-compatible PL061 variant, with
arm,primecell-periphid and gpio-ranges required. Reference
primecell.yaml and use unevaluatedProperties.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../devicetree/bindings/gpio/pl061-gpio.yaml       | 25 +++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
index 4d970e55104b..00d0d8ddd2c9 100644
--- a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
@@ -15,17 +15,36 @@ select:
   properties:
     compatible:
       contains:
-        const: arm,pl061
+        enum:
+          - arm,pl061
+          - ambarella,cv75-gpio
   required:
     - compatible
 
+allOf:
+  - $ref: /schemas/arm/primecell.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ambarella,cv75-gpio
+    then:
+      properties:
+        arm,primecell-periphid:
+          const: 0x000e8061
+      required:
+        - arm,primecell-periphid
+        - gpio-ranges
+
 properties:
   $nodename:
     pattern: "^gpio@[0-9a-f]+$"
 
   compatible:
     items:
-      - const: arm,pl061
+      - enum:
+          - ambarella,cv75-gpio
+          - arm,pl061
       - const: arm,primecell
 
   reg:
@@ -64,6 +83,6 @@ required:
   - "#gpio-cells"
   - gpio-controller
 
-additionalProperties: false
+unevaluatedProperties: false
 
 ...

-- 
2.34.1


