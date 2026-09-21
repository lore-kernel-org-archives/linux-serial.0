Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F9353A98;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964612; cv=none; b=Um8KoK/Z74nbw+vjMEVhrqNdLSOkcp0YbWJfVinI+XwWKz4iE/djpbcKri/NXXVwPT2Kc4mLNxyXjhvfWljPtfxkRTvaotzq1gjFSO/3LL2Hce7PTRr/obYxjuqGjuHXs4JocyBs57ByuaFSOaTB1wBOaKMxA3H3doIPWeMNXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964612; c=relaxed/simple;
	bh=iSN13jQzT5q3aGEtcq9pGlkB8alxyY2QXP+GvUaeNFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IThmD7qvixcKRbKZs30jHwg/kjlOkwPf/g51Q9pe4ASEYzfn0DC+1VV3jJCGiTkmuvS9HKCJC76zuo+4CtMjnEtJG/v8VUis/3coZA6iY5oO8gfY3JMTwhv4Dk/zBXhUKP/Z1wjK0ra570JyuigfvdNSrqc3JFRENxqT+goKGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7V3g70G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7V3g70G"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E471C32782;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789964612;
	bh=iSN13jQzT5q3aGEtcq9pGlkB8alxyY2QXP+GvUaeNFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N7V3g70G+bTOGPzDuOo6jB8D8KkRSRG1Dvt49X+paLpNP8zI1knerv/xcqiziifSf
	 yPx2bHWWdAlzI2usVtJTyOwIhTF2nsv8wCLQ3yFSIJeEh5fB3VHb7VkuonlTxfZ9sm
	 8UGCm3TpU1rtu2bjrvn8D3CyA55UCpKv66nc8xZ/aElujIMmwgW6eo1IqxUQyPyovh
	 scYgNAMqQXMSvC7hzXM2d/l/eioN+cXRI8SvR6EWNfMACYyeU0CX6mNjLGbnaZVYZR
	 +nTaBpYk+0b+OsYZWJPoGVtR6zMemL2730wiL8ZT0rU/p5n1sunE6zN3kh5Xan8xV6
	 x/zTXby8/WD4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C5EC982F2;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 21 Sep 2026 12:23:24 +0800
Subject: [PATCH v8 05/18] dt-bindings: gpio: pl061: add Ambarella CV75
 variant
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-cv75-v5-v8-5-282ff5d98dda@ambarella.com>
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
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789964608; l=2025;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=GVEIXtfx8rpLQa9TzFd09VjRop28rVpySsmXjUcyqZs=;
 b=Fo85IDH9CPKUggCRVyQ2gJURzjURGeK9VwzCX0zQQavK4eGy8LQzGOd51k3V62j04DGfXFOYr
 uA2NQBL+8O5CEp+xRahSZ2xOdeR3F1E7oyUkJgBszjw14265YYekQ84
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

The CV75 GPIO banks sit on the AMBA PrimeCell bus but are not
register-compatible with the ARM PL061. Each bank is 32-bit and 32
lines, with extra mask/enable registers, so arm,pl061 must not be used
as a fallback compatible.

The AMBA core matches the PL061 driver by PrimeCell ID, not by the DT
compatible string. These blocks do not implement the standard PL061 ID
(0x00041061) in the ID registers, so arm,primecell-periphid is required
and is fixed to 0x000e8061; the driver uses that ID to select the
Ambarella layout. gpio-ranges is required because each bank is a slice
of the SoC pinctrl pin space.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../devicetree/bindings/gpio/pl061-gpio.yaml       | 25 +++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml b/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
index 4d970e55104b..c22dd8a1d2c1 100644
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
 
@@ -25,7 +27,9 @@ properties:
 
   compatible:
     items:
-      - const: arm,pl061
+      - enum:
+          - ambarella,cv75-gpio
+          - arm,pl061
       - const: arm,primecell
 
   reg:
@@ -64,6 +68,21 @@ required:
   - "#gpio-cells"
   - gpio-controller
 
-additionalProperties: false
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
+unevaluatedProperties: false
 
 ...

-- 
2.34.1


