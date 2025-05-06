Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A27215F72;
	Tue,  6 May 2025 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568807; cv=none; b=MIHyaycmHs8KRWAlhYhGvtIWC0PG5VkcglKa9huBk7hC085t1b9N4xUzYCvlSMpd2K0ODlpaB/XFIuBR5AAQwm6N1TCq/KuHs/IilLP7hhIVaQM7Ehfa2qJTgR4ESQ5ECZAZPq2tni4AfpeHZ+tcEeo4NZpPK+3/ShR6R1t/sLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568807; c=relaxed/simple;
	bh=Mj+eMxLf9m+noFmwrjbv76s5DbrMoR8J1aSBT9qiduk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuNUxakHX+sYUt8fOfpDsL6cwYYuO1n04oECUfF2rzHZi1h/T/jHkJQdHZZ1IiTifFDzQ9loGOECfP9ALhwwczxrLblClQAR5Su11i97DnaZZDvaLXysDyqFJo0/wp2fNR68NQn8IHqZR9za3Mv642p8AOFfVsPBv2ohNoCohbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u99cYz9y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u99cYz9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12256C4CEE4;
	Tue,  6 May 2025 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568807;
	bh=Mj+eMxLf9m+noFmwrjbv76s5DbrMoR8J1aSBT9qiduk=;
	h=From:To:Cc:Subject:Date:From;
	b=u99cYz9yrJs/GpQq6mhihsjsYTBBAxW/dyWfxxum76gVNe327RRqW90+nWieM4tN8
	 W1PKrEuJXc0E85MgqQ+KJu+CLeMKKb9HjTjumaSBlPRLq7+RMpLyu9Wcpn1fgQ0GQ7
	 rWfFIzxlzmYmQbLaj6iqM+JBYCNKPi5lXCtEjvMmHSx5Iv+eDKj68/zSFGaXvVSHAK
	 vbP6vZfBHjqyMUeuYir+ahovXho4zhJZ/M+OKj4Xo8eAVKxKFkJ5JJYGvLq69sq5aK
	 hRO+gteSBUp4YucYJrHhuElPq8bNVejz+aojqMm8PC/AL0rI6l16Y2xFyOTFty8RU9
	 MOYqcvqWk/szA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Convert altr,uart-1.0 to DT schema
Date: Tue,  6 May 2025 17:00:03 -0500
Message-ID: <20250506220004.2545130-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Altera JTAG UART binding to DT schema. The "ALTR,uart-1.0"
compatible has long been deprecated, so drop it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/serial/altera_uart.txt           |  8 ------
 .../bindings/serial/altr,uart-1.0.yaml        | 25 +++++++++++++++++++
 2 files changed, 25 insertions(+), 8 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/altera_uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/altr,uart-1.0.yaml

diff --git a/Documentation/devicetree/bindings/serial/altera_uart.txt b/Documentation/devicetree/bindings/serial/altera_uart.txt
deleted file mode 100644
index 81bf7ffb1a81..000000000000
--- a/Documentation/devicetree/bindings/serial/altera_uart.txt
+++ /dev/null
@@ -1,8 +0,0 @@
-Altera UART
-
-Required properties:
-- compatible : should be "ALTR,uart-1.0" <DEPRECATED>
-- compatible : should be "altr,uart-1.0"
-
-Optional properties:
-- clock-frequency : frequency of the clock input to the UART
diff --git a/Documentation/devicetree/bindings/serial/altr,uart-1.0.yaml b/Documentation/devicetree/bindings/serial/altr,uart-1.0.yaml
new file mode 100644
index 000000000000..72d4972e1e22
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/altr,uart-1.0.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/altr,uart-1.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera UART
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    const: altr,uart-1.0
+
+  clock-frequency:
+    description: Frequency of the clock input to the UART.
+
+required:
+  - compatible
+
+unevaluatedProperties: false
-- 
2.47.2

