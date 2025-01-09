Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57482153EB;
	Thu,  9 Jan 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415528; cv=none; b=AIUDvvmxpswT8DGawWzJrS3egK6VW89/PYJhP8FkSFxqHz4v9zDrZHmQBKPMfLk/4P94Ni1xLkQEwzo7DU450oY2/keiTMZfDA1GCH1M7r5W2z4M5gRl79XDrcB7tGxrXOOuSQzd7+k60NUPh1oqqvfpIn3cI52JbKR5c2XV/Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415528; c=relaxed/simple;
	bh=8V25lAluMmQu4srTgfo4NyJuGys1jRMKVlUTRSm6aWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQ24dZzoQfBdrY4kyotSaazNsRsZ1Aq7bLCDnccMYmueSs94eWdesar/xbwoIMN3s4csifDZauHXjsK8/j2He7bj85DxqUEM2vVBRC0R9mc37yvn8Ll/EX9+nqtfGyhfTUXVhqSO0ig6E5wW2e/XfbPM/8LSR1Ryc/ntIj/fOws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=Ej05nBQ3; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="Ej05nBQ3"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id E71319400109;
	Thu,  9 Jan 2025 10:38:36 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id BtaowGXAJLjQ; Thu,  9 Jan 2025 10:38:36 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id BDD349400101;
	Thu,  9 Jan 2025 10:38:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com BDD349400101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736415516; bh=M1/YGR3ARc3PqIwKwPuXE4vun17KYkga4+2ZArcij0k=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=Ej05nBQ3oAdL4esZPVbPjHvq+n1Tgbcof9etRJHA/Ni5sXi/HOia6qmzQyJEyVnK4
	 CblJ451wTr+UUVgJRbjVovXPK5zOd+paBxHiVQV1BLgajQ3MBpr1icLY9DdnhZepK+
	 /pjjShiIbA4gIhnGpGVoo5/LYW1BkGkRcl3is50CXjqJb2tXw5/rVuMS4/now/eom1
	 tYjsru7/GGj98F7R5VlXlHqm9Tz7E0QgYjC16dUkfKTVVwcl7l1w/fBoGMxSdNzyGs
	 SYz3Fy5soPYE5983zMgF83XYhJAJ6WvTA4+LsvZNEdtAjQJT6l2fw5okGdPMzMnqBi
	 kS0qF5a7nJz7Q==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id A7dx2YyjDkIT; Thu,  9 Jan 2025 10:38:36 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 562469400109;
	Thu,  9 Jan 2025 10:38:36 +0100 (CET)
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
Subject: [PATCH v4 1/2] dt-bindings: serial: sc16is7xx: Add description for polling mode
Date: Thu,  9 Jan 2025 10:38:33 +0100
Message-ID: <20250109093834.1013025-1-andre.werner@systec-electronic.com>
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
V4:
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
2.47.1

