Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAADA218838;
	Tue,  6 May 2025 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568803; cv=none; b=FcV1WOqxGccSXo4Q59FbA0EilAssNBTLMZgNkJhbmaJppzzgGipDGpxq4r1VdNtR1WkNl3WJXCRgQUimAXgI1gB/MdFTokGeimRFxbYhbufOZtoJT5/D4VMSuvJnh++XMmnMXo8lB+HKlMM8n0Hgy8RzM7wnUTYBJnhwov9A8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568803; c=relaxed/simple;
	bh=x0kj9Jv4aZPukUlCk34g8XBO/482wG4PTvrgKvgia2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0/iSKQcgvXiSWD2HwLiYcbVNZr2EsI7oSWEb8kGN20A8+PAyvWOzqhbskaUpRNS7gZkpz7ZY2JiD5wdoSwbopCNXwc7pRyJEBvQfsCGfiCo3B/yeon2zr4dSgTdKi7Ft5Tl0EQIDrPbYfHJ1FBx0Qn1ZBxiuLp6DbJhKSsJdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgrIkkK7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgrIkkK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F45C4CEE4;
	Tue,  6 May 2025 22:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746568803;
	bh=x0kj9Jv4aZPukUlCk34g8XBO/482wG4PTvrgKvgia2k=;
	h=From:To:Cc:Subject:Date:From;
	b=dgrIkkK7HAvlEDQcNymbKS0V2gBDv+iWjyjxsiXg+1/1JL095lGvZ5zGgCCUp6B9b
	 depbAmj4LCyB15mG+hOKoeHy9KOtsXDc7eYgZDqYRj/QWuzgMrSOMetb2m2ANa9CCa
	 ZIFJEgvzHf8NeX0J4Z8OHH0TX3bitKjcpGme551AWDCUtDRFKhRVTa37PXskICjHFH
	 2ckmrU1xZ5thzslYRzCTEl0ltStPlIN27QH/2lJ9c3oSkxublMvw4+NJHN0e6NTf6J
	 ZX5wiGApVLy0McVD09lDsne+bfX5tI/t9UWDoeG1kjF4ZWB510JDkUYld41R/yZ2jS
	 m8QxqzsUL+J8A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Convert altr,juart-1.0 to DT schema
Date: Tue,  6 May 2025 16:59:58 -0500
Message-ID: <20250506215959.2544931-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Altera JTAG UART binding to DT schema. The "ALTR,juart-1.0"
compatible has long been deprecated, so drop it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/serial/altera_jtaguart.txt       |  5 -----
 .../bindings/serial/altr,juart-1.0.yaml       | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/altera_jtaguart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/altr,juart-1.0.yaml

diff --git a/Documentation/devicetree/bindings/serial/altera_jtaguart.txt b/Documentation/devicetree/bindings/serial/altera_jtaguart.txt
deleted file mode 100644
index 55a901051e8f..000000000000
--- a/Documentation/devicetree/bindings/serial/altera_jtaguart.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-Altera JTAG UART
-
-Required properties:
-- compatible : should be "ALTR,juart-1.0" <DEPRECATED>
-- compatible : should be "altr,juart-1.0"
diff --git a/Documentation/devicetree/bindings/serial/altr,juart-1.0.yaml b/Documentation/devicetree/bindings/serial/altr,juart-1.0.yaml
new file mode 100644
index 000000000000..02e20fa591da
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/altr,juart-1.0.yaml
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/altr,juart-1.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera JTAG UART
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+properties:
+  compatible:
+    const: altr,juart-1.0
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.47.2

