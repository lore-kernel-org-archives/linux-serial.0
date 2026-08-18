Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D560456E12;
	Tue, 18 Aug 2026 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049134; cv=none; b=QwYbrfPe8iqPr8EAfLLB6/+8odiZkdNNCl4QxNTOD0UAo8fuwaR97t4rdSUSpym5CnEDTQBj+LSsKrv8O176PWfb4xgGHC0Dq4I6eYHXLya/6YtBNDyNXDW7hKRZIz9Xf+pHnYS6ena17jKzyS0/5lTQOm9DP/3gvX6Ys08jOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049134; c=relaxed/simple;
	bh=jEcPzTS2r9CRkRuHf/bP0CLeDxdimN8/GXo8Hz0PSGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d56ISHha7m9/m0xejhOhqP45wsRd6F5YWZI1ucpppVGw1oa0UWYzSqiB5ODbdLDoYEZlnbCXJkLlWhWTDBBhX6nk0mX2DmfxXbcYHdQEioqLzzDyaKGaeVS5Ty8ZndQPHnR9Uvi4l0r07JU+TJ5G1BCvP2h4kq72UCEgxHN72S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmMsA0G5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmMsA0G5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFF09C4AF0C;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787049133;
	bh=jEcPzTS2r9CRkRuHf/bP0CLeDxdimN8/GXo8Hz0PSGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lmMsA0G5Q8oZQVCxvjBSavux2XN9pcMMQ2yqJxzorr/srtzEr08xBhf2s1phw7p9N
	 1lSf6a+ws2OUAND5BAN/taHWwfCFNSwxTA+bg/qlZsIJ6vPy6GXbMSfmYxNLJBzEuK
	 2W5Yki/1O278pIdNJurvJwo8T2XmaZkRGnf5sFIu0d5WvPAi8A588Qw6TpMh5CiZLv
	 okFtuLZkENaKtOEEHNnMrpx6OOXxVkDIHHDulgXNI/CZCd7xnt6O9H4FnHT9XSFQEY
	 UYP/b/8Lcp+ePUGbwiU0YjFNo+JW0iEfW/c9MVIMkpba+dfUsxzHmaj5H64I++tjKK
	 w6hMzwavt2KQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B495CC5DF84;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 18 Aug 2026 18:31:19 +0800
Subject: [PATCH v5 05/12] dt-bindings: gpio: pl061: add Ambarella CV75
 variant
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-cv75-v5-v5-5-7bbb12f0360f@ambarella.com>
References: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
In-Reply-To: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>, 
 Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
 Long Zhao <zl020895@163.com>, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787049131; l=1941;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=Pngr7p+U3E/qWLbm7iUMOUjiAHv8IZUzMpz2/ZKNyVk=;
 b=ERm6YliqAyLiRYZMFDvJ/vS+LdTq7UeN8oTFIqiNI6KrdZKYs66DOsVTYT6sbgYEBuqfZgS2r
 3YpxPbqjO7WDEs0T54oSFzodxcJSxS/ZKO7XsH4b7e6RewM+4nGHJOa
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Document the Ambarella CV75 GPIO bank compatible and the synthetic
arm,primecell-periphid used with the PL061 binding.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../devicetree/bindings/gpio/pl061-gpio.yaml       | 35 +++++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
index 4d970e55104b..414f8d4a3976 100644
--- a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
@@ -15,7 +15,9 @@ select:
   properties:
     compatible:
       contains:
-        const: arm,pl061
+        enum:
+          - arm,pl061
+          - ambarella,cv75-gpio
   required:
     - compatible
 
@@ -24,9 +26,20 @@ properties:
     pattern: "^gpio@[0-9a-f]+$"
 
   compatible:
-    items:
-      - const: arm,pl061
-      - const: arm,primecell
+    oneOf:
+      - items:
+          - const: arm,pl061
+          - const: arm,primecell
+      - items:
+          - const: ambarella,cv75-gpio
+          - const: arm,primecell
+
+  arm,primecell-periphid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Value to override the hardware PrimeCell peripheral ID. Ambarella
+      variants use a synthetic ID retaining the PL061 part number because
+      the hardware has no discoverable ID or assigned designer ID.
 
   reg:
     maxItems: 1
@@ -57,6 +70,20 @@ properties:
     minItems: 1
     maxItems: 8
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ambarella,cv75-gpio
+    then:
+      properties:
+        arm,primecell-periphid:
+          const: 0x00000061
+      required:
+        - arm,primecell-periphid
+        - gpio-ranges
+
 required:
   - compatible
   - reg

-- 
2.34.1


