Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD12D5C9B;
	Mon, 21 Jul 2025 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113067; cv=pass; b=lACYvs+IYrLbQq0UyNwU0ZcZMHMnoBttz3KKSc0lsGRfLpNY0EW95RYsUUO+l8mvAKehhp53N/+jOnMgbpnuw0/yfegLxaZmj4BH4vJvy/r75byI2OHTdpo2FaTCKyhmwbvQhUzReeTFin4oEVdDV6qOTQNyv5Ekyb9aY46VGcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113067; c=relaxed/simple;
	bh=HreXRyE3WooyT3OBlj6lQxbBuWgeoeeliEaJp8Tpnew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VIo6eVY7ZuMZ857PGUvirc0gOrM8zYenmXLkcy2VqESewYIfpIqth7hpvyNEhX0IedjGgCutQq4Am1xfDd4jNhRlF/G01Rlwfq01BEjucGhArKypkz84ZSIAWcRFiIwJJ6nUFtMPZjboGmUEzurFzIEZ1P1ZwQVB8n613Is/Rwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=HydIqtAd; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="HydIqtAd"
ARC-Seal: i=1; a=rsa-sha256; t=1753113049; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dA5eqdqf7Q/qAr9IrapxXD1nXz14pkQsnqxOwv1IbSLcUz3eLdtEolsogx5vCSEl8d7CYJUoec063aqikO1TwrtCfiOgfgozt5YwncmvPmfzGFXhVy9yORvnh9dj2IgJo+gn7BkMZy7Ja5qMrYI5PdVTA8ijaWzfAB3FeZF5fVc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753113049; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XYcNJKtpMAOxlltRwDFwqWTLmYmscb2nfhhNfGq1EW0=; 
	b=bSh8yAtc7RbQU4gdBoNLYXkwzAKN9HGNDd1zl5aMHUN++qXQc27zhsQlOcn48uGNCUQWgDmHeXp/sKC1VKTQEFDWH3y8LpFc2cne9eHHmeQgThg+IQ2dqLq40tkP7Vnavu9NkkEPGbo0qnhBfRMRwtszVUWmEApv/OpCoHJDNn0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753113049;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=XYcNJKtpMAOxlltRwDFwqWTLmYmscb2nfhhNfGq1EW0=;
	b=HydIqtAdfJcN6f+3BUQPmzxZCcS8ae8D+k1xB4tpyGg5r9hoW9VgGOEZ/s0yZI/b
	VY1JHMGf7kqLBNL5Tf93KvIyxcS7bhblhGl9OT/YKatji/v8PSDHf5UB0ZxAm5GeJL0
	neq2ysayZn569x52YUxjV0MsRS56UfUgjqfe4FD0=
Received: by mx.zohomail.com with SMTPS id 1753113045317130.23548011092828;
	Mon, 21 Jul 2025 08:50:45 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Jul 2025 23:46:09 +0800
Subject: [PATCH RFC 03/10] dt-bindings: riscv: Add Anlogic DR1V90
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-dr1v90-basic-dt-v1-3-5740c5199c47@pigmoral.tech>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
In-Reply-To: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753112991; l=1167;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=HreXRyE3WooyT3OBlj6lQxbBuWgeoeeliEaJp8Tpnew=;
 b=pOpDPuzVCGLpujyU9CePqxQrwiGOshvfUEmJB1WFpsJQSm6Ir1/1MCt6VsCL6Kj44kpp8+JA5
 3BUYRTtRV5aC26FRjmT4Ks9yHbIn/h0CPisf6PWqecz+4k5e8N18tpv
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

Add Anlogic DR1V90 FPSoC, which is used by the Milianke MLKPAI-FS01
board.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 .../devicetree/bindings/riscv/anlogic.yaml         | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/anlogic.yaml b/Documentation/devicetree/bindings/riscv/anlogic.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..91b1526c99aa3ca9cc7b0e7978861408bd017049
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/anlogic.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/anlogic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Anlogic SoC-based boards
+
+maintainers:
+  - Junhui Liu <junhui.liu@pigmoral.tech>
+
+description:
+  Anlogic SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - milianke,mlkpai-fs01
+          - const: anlogic,dr1v90
+
+additionalProperties: true
+
+...

-- 
2.50.1

