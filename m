Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6C224D6;
	Tue, 14 Jan 2025 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736838300; cv=none; b=M4iYMo9lGWaCQMe6bIWm1OS9PZDnQ4zkJGKSdq6nKt/wnujHY6UhUn0zpacstP3Y6KoRRg3I7SDzEMdPZJ6Fl203+Rte32FIb7Lz1ftJnqxETkAJG+qWtsnpTj6A6ajbgfa+GSIeO5wVbDOi2wKuGQxdHZfbVKRSGd+GBJ+ani8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736838300; c=relaxed/simple;
	bh=NKWhz5D/K6CBky9eXGOgzYr6l1+kvz/9G5cyFeoDFPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0UNZAlQmPKXtZSxR+c2CAhCLerXVniFQ+BIkr0uNqC1/D7Z3LdKXfMyK8C6cCjpKRc3jeRL+CNeZ2CwZZ5H2iXEAyzdwiubhixgI9REr3/5azSb3hwt6/HkpW4EWZd4LOduRNVz9+KSChpoToMepg6DA+N4LKrsNmFY5r0hCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=cB3+u0XM; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="cB3+u0XM"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id C030594016AB;
	Tue, 14 Jan 2025 08:04:54 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id JjnCRFdXO9FF; Tue, 14 Jan 2025 08:04:54 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 9604D94016AD;
	Tue, 14 Jan 2025 08:04:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 9604D94016AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736838294; bh=yvW8KVsdaB/+eGDWgYKngO3+pEWC3TldsXxDOnr6vtA=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=cB3+u0XMCBPVyC/EKzSh2QkqDOVE42WM+6KQTSswUHHENUHSUSeqE8YwRL0hKZtQ7
	 C/AEEJ7+tzXlV/kgafW19Vv9T2tGEyGPAemcRtfD2MKd1uOA9iWNoWIskulA996Y7F
	 GWbwEUJfira4dpbFEYJ3KX9eGlgFoy8kirvZYYn17gOOoU+Bwir47nks2JSfSlI6Pn
	 pejNsoZjHWZn2R87Rt70B2+pJvpxdDqWrYYVMplD2A2GiJlsG7R3WEjSAV7aI//nz8
	 4gFJXzrtRKB9QSYjyNZyyUfaTej0nwg6Qm/aFzzbAsY1hfBCsWhbdg5S4LaOWsKDtS
	 hRjhy2Wx2N5xA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Hh1F6A3LuLc1; Tue, 14 Jan 2025 08:04:54 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 345E694016AB;
	Tue, 14 Jan 2025 08:04:54 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	andy@kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	Andre Werner <andre.werner@systec-electronic.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/2] dt-bindings: serial: sc16is7xx: Add description for polling mode
Date: Tue, 14 Jan 2025 08:04:48 +0100
Message-ID: <20250114070449.34226-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Polling mode is enabled if the "interrupts" property is missing.
Thus, this commit deletes "interrupts" entry from "required" section
and adds a description for the fallback to polling mode at the
"interrupts" entry.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V3:
- No changes on source.
- Add Acked-By to commit message.
V4:
- No changes
V5:
- No changes
V6:
- No changes
V7:
- No changes
---
 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml =
b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index 88871480018e..ab39b95dae40 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -23,6 +23,8 @@ properties:
     maxItems: 1
=20
   interrupts:
+    description:
+      When missing, device driver uses polling instead.
     maxItems: 1
=20
   clocks:
@@ -76,7 +78,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
=20
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
--=20
2.48.0

