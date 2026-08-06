Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D83F4118;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008866; cv=none; b=Y5EvP0rE6IV3Ayk9lFnKDwJs7I0qhqchzKAXXhdQPem8Is9bTPOp+tcI9+aGsYqIcXFz+LV/92kGDMhJbIEbEKj2fIPMIwIR1X6Rjv/YO/W9SlDGCmhRjF1JpWPtQX6uKqW2NI22Xdp7UphuVUiWXPCpilWW/0wI5D6BnsU72U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008866; c=relaxed/simple;
	bh=9o2ym9Q7UN5TolJfnYkWX8F/5ZrsOyVQK0D6QvuiADY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IyVUwDuldEkWddUXlY8np/d0sG1BbNnf5cpNssRBjgsoNOB3qZWH8Plaqep1n6EE2Qo4kQ44feeIOxQ1VHj2MQ0btWC7mDhQDlkhevsDn+0L3oqgM3d+jQPYtO0yui8gVUU4IWPSZpdFd2V02Vwu0GARTqcMB/GSV48ew4lm8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw7uhjC0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw7uhjC0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E85DC2BCF6;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786008866;
	bh=9o2ym9Q7UN5TolJfnYkWX8F/5ZrsOyVQK0D6QvuiADY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iw7uhjC0gxpZsDMbrtiAq4XMdOieKGzMWYx5grFRg97hExfHJQT8kMJpsk4Z0rV6r
	 tXllYRhEFCKtkIxpgFTgs25x86tiQQn9K8R1bmVoPMzBfXgVw+DKCnVXNcc+uoS1F7
	 YRNPHOeGYANSP+Bp2vOsDzgNLTHOzgLHYnDgMRogQ5a6Y32NFIbvzuanepv6G6vl/C
	 Lmea7v2NuL0Ub93K0QaAHvJ+kzmzWW748eI/IknJMYIcQXuBS7AysfXqm8+2SC0SWJ
	 LgG6xbOL1QaPi0lNvHbSd5i/SL8WVcrK5u17DJtNP/8jo6HBTj1HE+fKIGnKXJujhJ
	 yJXZZAQpgapqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19484C55ABF;
	Thu,  6 Aug 2026 09:34:26 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Thu, 06 Aug 2026 17:34:09 +0800
Subject: [PATCH v2 01/10] dt-bindings: arm: add Ambarella CV75 platforms
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-longzhao-upstream-cv75-v2-v2-1-6b09707c5fe9@ambarella.com>
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 soc@lists.linux.dev, Long Zhao <longzhao@ambarella.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786008863; l=1726;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=E64N0WzuN3RWFUU+WVOoB7iSv1RpxmiKsY2ydNVTzVA=;
 b=VPKdGB4d5Ldv0umrXjkMWEm6jdp/dVFupjAWrgqvugNER7Wy0ZmWZDGplb+H9c986jFj6wqcn
 EspvGexW2I6A00/TlCYPgvVtJYcODKR9hiXhS/h3BiFzQjSpdw/kEOy
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Add the Ambarella SoC board binding and vendor prefix covering
the CV75 EVK.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../devicetree/bindings/arm/ambarella.yaml         | 23 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ambarella.yaml b/Documentation/devicetree/bindings/arm/ambarella.yaml
new file mode 100644
index 000000000000..347148530f80
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ambarella.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ambarella.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ambarella SoC platforms
+
+maintainers:
+  - Long Zhao <longzhao@ambarella.com>
+
+properties:
+  $nodename:
+    const: "/"
+
+  compatible:
+    oneOf:
+      - description: Ambarella CV75 EVK board
+        items:
+          - const: ambarella,cv75-evk
+          - const: ambarella,cv75
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 85a27937832e..f48aa6dabbe9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -112,6 +112,8 @@ patternProperties:
     description: Amarula Solutions
   "^amazon,.*":
     description: Amazon.com, Inc.
+  "^ambarella,.*":
+    description: Ambarella, Inc.
   "^amcc,.*":
     description: Applied Micro Circuits Corporation (APM, formally AMCC)
   "^amd,.*":

-- 
2.34.1


