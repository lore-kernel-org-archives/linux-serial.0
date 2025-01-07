Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836F1F190E;
	Tue,  7 Jan 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260202; cv=none; b=h75TfzncP1lgWy/wxkgD9Cng6+NFD6mmwfKbRgLSnsyJRKqELOggA8tVMaMSlWzQxGIM2Ayyy2YhtDoRH937nXblbtCHrzUAYPE39BRgfOPzrFl0Gy7xWSHLZpv6Xw8WEj0VKCNGF/58GZawnfzJ1B+HWIJsbdaglflZcY8oW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260202; c=relaxed/simple;
	bh=5udNTovtIvW91CoRKPj1IxA2mdonFGul1jaLiQ3G0TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvWKq9DFuiWGeXyYQ3RMcMmdDkJbFrQd2fpwuDWAdq7U4VcJHvQ6RH0vGskJXlPESb5K3/chbEXNOynDNPiHo58TkcnkY+3JJ+3VI7jsPAuBwLLuW/+A/oDASv8UxZciwY81ZHQ45fKqZU/X9KvWqkna0L9hlT3bdkdBSsQwIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=KlI2RocT; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="KlI2RocT"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 3DB1A94016AD;
	Tue,  7 Jan 2025 15:29:50 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id W5gBt2nXpk13; Tue,  7 Jan 2025 15:29:50 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 154B594016B2;
	Tue,  7 Jan 2025 15:29:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 154B594016B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736260190; bh=5nCIec/4jtVJJuHb7SlQlQs/JYbppZp7PbbHAW4D93Y=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=KlI2RocTmU08fT3gFYTgOKx7BBc+ZjOBe2Kfnvm+EAxoYm/7F+OZgZIRgHfq39XdR
	 j92csZ0OB2MQW63HWnmiOGCGJPtjJP9jU5OpR/l2ew+EshdMHWqOn45Ncx06rRxBl1
	 lfNmsdlsDjigsTahMre222Gqwn5bkSA4XoFXWuObAw6LZT6ZAEEdCpNZ0bnheLD/OV
	 jBj6lh/YcbwZ50U8VtkqS8f/KXh6DrqjY9oKvLPkx2RxE65c/DXcClc+rZxGsplBVI
	 4unOZvoZKUWAC59XXP3Ybbit8d+B5nABK9/5f5VDpheiFdCo0SNdAa8y65wQOauHal
	 4tkQO+Wi2XRlA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id zQbqP4NFaxcr; Tue,  7 Jan 2025 15:29:50 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id A6F6494016AD;
	Tue,  7 Jan 2025 15:29:49 +0100 (CET)
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
Subject: [PATCH v3 1/2] dt-bindings: serial: sc16is7xx: Add description for polling mode
Date: Tue,  7 Jan 2025 15:29:46 +0100
Message-ID: <20250107142947.327508-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.47.1
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
2.47.1

