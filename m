Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892021A424;
	Tue,  6 May 2025 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568820; cv=none; b=Qz7LxzP2fSqkISgxRStpNQA4gIQiRHrhswb9O3M4rbNCv6mTPMimsjluZTf2r17KCu0EynC2/ySV0tdJx1g7IHVJjRhRs8pBFT3ZoTwkbeLGa6w2U1P0vQVIMsJTh4puGiBeRl5Hqbx6m6Xm9OJNU3hqwyNQ6KeFYmDMm1x/PyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568820; c=relaxed/simple;
	bh=MoPCYV5IicT+SXbX1HoGZb/eOt3di2mnndgHJo8hidY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4xjQGn/6V+AgifUKqIlu5B+QsKk13qT9oI0zKQEkm4xkdsoOzKkPwpyVP9doqzfSG5VLxvPDKDLbCWrsYUGRHsdJmnk/1dd9x21qCFXufZ4bWsgqiobS5XnIhi4dJhW4ves9utpa7N712rdAyw3W0eEDlghrxfBjI2ZTTeibMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgFU+3GZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgFU+3GZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA0EC4CEEE;
	Tue,  6 May 2025 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568819;
	bh=MoPCYV5IicT+SXbX1HoGZb/eOt3di2mnndgHJo8hidY=;
	h=From:To:Cc:Subject:Date:From;
	b=UgFU+3GZqjNAenOWdLoF2SWu5AOIssHVv9NruKs2kfRE3ihc51G+7MvtEw2GPrx25
	 iH6yaKSCROecyRlrE2Ck2gc3LqHOyWyrY4iPqZ2YlyRwHEGBnsN3k30DyAZ3/Ih/3Q
	 mmFsmy4aB7XqXvbeEtWwAxjT/9UXEbo3kGGsFyIE4gJF8+1isiIGeR/g5uv5FImIdF
	 t07wPuDZhZxj+dTQ1hTKNenL4FsKl/5y0ODNzZ5CO5/ae4yJXJz+AaFyls4i82IhnM
	 Ko1xbbaVh0VV7s0c5H+NuNUKOMfqig2x0ZEtQlJMF56pv3G4MJACLp26GPKF2Y6S6y
	 2a+cy+RuoJMCg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Convert arm,sbsa-uart to DT schema
Date: Tue,  6 May 2025 17:00:15 -0500
Message-ID: <20250506220016.2545637-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Arm SBSA UART binding to DT schema. It is a straight-forward
conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/serial/arm,sbsa-uart.yaml        | 38 +++++++++++++++++++
 .../bindings/serial/arm_sbsa_uart.txt         | 10 -----
 2 files changed, 38 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt

diff --git a/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
new file mode 100644
index 000000000000..68e3fd64b1d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+---
+$id: http://devicetree.org/schemas/serial/arm,sbsa-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM SBSA UART
+
+maintainers:
+  - Andre Przywara <andre.przywara@arm.com>
+
+description:
+  This UART uses a subset of the PL011 registers and consequently lives in the
+  PL011 driver. It's baudrate and other communication parameters cannot be
+  adjusted at runtime, so it lacks a clock specifier here.
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    const: arm,sbsa-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  current-speed:
+    description: fixed baud rate set by the firmware
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - current-speed
+
+unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
deleted file mode 100644
index 4163e7eb7763..000000000000
--- a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-* ARM SBSA defined generic UART
-This UART uses a subset of the PL011 registers and consequently lives
-in the PL011 driver. It's baudrate and other communication parameters
-cannot be adjusted at runtime, so it lacks a clock specifier here.
-
-Required properties:
-- compatible: must be "arm,sbsa-uart"
-- reg: exactly one register range
-- interrupts: exactly one interrupt specifier
-- current-speed: the (fixed) baud rate set by the firmware
-- 
2.47.2

