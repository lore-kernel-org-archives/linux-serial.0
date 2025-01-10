Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D614A08E;
	Fri, 10 Jan 2025 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494280; cv=none; b=iJwcbjHKyMe/FDMFiOkOEME3nEoN9gztrJy4X7kaSUMjzDvNSwXs0N2Nm0H/25w31DTO0q4j7IkihDdUIhBabcUAr1m8rb5DBtcSBpkozjcaNySb/m2bvfjcmY6f3ratN4IyRxvaoMB1wnk25SseTqy6H0dQyBhQ8s+WfNkyhMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494280; c=relaxed/simple;
	bh=GsWrk8VUb7xb8OCGs+0lJMhAJb9Cc+HpiQgwngrP7/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IT3WAoylN5tXtXfPuAkXh2RYp6SzS+S11MQaFLDTnTik1uc0n9tDuM9MdUonlAZHwYvM380THT39oB9obIt/V8Q7DnesO62k9wzspZxgPgFcJ+RYUZbTgxJAUhv8i0YllwTPJf8bSDdHaNeYiUoNV3Ma9gMRgRDS0KJxy/Ul9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=DQ4HKGuw; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="DQ4HKGuw"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 319FA9400101;
	Fri, 10 Jan 2025 08:31:14 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id YSxNbskgZ0PF; Fri, 10 Jan 2025 08:31:14 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 074F69400109;
	Fri, 10 Jan 2025 08:31:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 074F69400109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736494274; bh=ornAsy/udXoisEAbv8buqv69PlNcgPEEYnmrCIK0TzM=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=DQ4HKGuwRwFPdpV4/EK4eM8YoUWyJlhz8b45Sccid4ny5PujHmMfRm454fpP2sPhx
	 fx0QNHec73p7ZeCv1DuHe6QmpAgbTzngtnmPfGhuWt+GBc4+wunRcd5LCARExQmSYK
	 UZ82f+ophhWWUiBLC9prZeZtcLPRa8WbnjoBWl/H5Og2Ihw3D3/bS+9s2vq0v4DWBe
	 7hILRgL5lNCWZwp022o4BjsE3LlhmGEWJXfMGb2wpmNuCU9vBsG14NVMF5qE3KxKvH
	 wVRoih8Tp523x6E4GLh6YC7uA0l0bIL3HWbgZCz1ZRLLZZTe5Xs3ruA7MhS21Xww8g
	 U1+mPZzB8JL9Q==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id gSapMPUMXxyo; Fri, 10 Jan 2025 08:31:13 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id 685E99400101;
	Fri, 10 Jan 2025 08:31:13 +0100 (CET)
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
Subject: [PATCH v5 1/2] dt-bindings: serial: sc16is7xx: Add description for polling mode
Date: Fri, 10 Jan 2025 08:31:03 +0100
Message-ID: <20250110073104.1029633-1-andre.werner@systec-electronic.com>
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
V5:
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

