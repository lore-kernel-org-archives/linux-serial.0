Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF541DFE1;
	Mon, 13 Jan 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736753444; cv=none; b=FWnD36BB6eqODhr238yH0qBYEhZ53SugzL0XyHl0+1fPBnD9oYBTQk8TjAD9lM/TMBS6e3x2Zo/fzNAOFvLNL5PiAT9sDSt5WAS3MRN3DxAcKXxSw5mNx27xtv1u0sMNGEDtqmFKAFFltrp2yxTWUQ+jsIvyJMjtXJ/YCDwVRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736753444; c=relaxed/simple;
	bh=l5b6wy3duwqL3WY3LK0HKZFpwQdoy/YVYa+jIirql98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQcc++Mm0N8uAuT864hpHdMf3/6ZvVfzLFg8QPTMuAuCE77/SmfiwPyTYb9mahFjY4yMrKH0K8CJcukOdgdmME8cHMbUMjwIxT8T5XEVBUXuSBoN+oTk+QlPZ9TLwSXVh4K+0D8ZGJlk8F08iui16Qekv+pUYHYVBi1P1ZLe/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=dcbKDte4; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="dcbKDte4"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 699E09400101;
	Mon, 13 Jan 2025 08:30:32 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id pC6MxG5JuLwK; Mon, 13 Jan 2025 08:30:32 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 403EB94016AB;
	Mon, 13 Jan 2025 08:30:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 403EB94016AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736753432; bh=IMaFncpff1Uf5pfW/wTwQew07/JWnCIgy2xnF7SUMYc=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=dcbKDte4EgnO5R1yHJp8b1PnUGMtgpRZcJ30v2G5bySX8QrrVzPmaAPAxWS22fFVF
	 SBmy5oiMC+VaQtdtBOcA1/PS1OJzKuee7VTWc2pd2JMVKU+SbhgmOyGJjJM8PUyvfr
	 7bBpf9OJFzONa5cK4uKqrxp25ogVeLwEGs+69meWqbODj6t18DvmP1f/cURoPgVdXl
	 8AdKnZwC5j1+uFyyFHEJ10BxHL+WLJfaluo0pzeoIAz/vrjigBJ2Rd369viY/ZmFPt
	 pctngfVSSCQNJCEDeOcqA7rd8dB4E7vHVBMxQEfX30XdU73VcRpL/TeQeHMcZKy8AH
	 zpaqd/mfRpAKg==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id hRrvcNyO07We; Mon, 13 Jan 2025 08:30:32 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id D1F2F9400101;
	Mon, 13 Jan 2025 08:30:31 +0100 (CET)
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
Subject: [PATCH v6 1/2] dt-bindings: serial: sc16is7xx: Add description for polling mode
Date: Mon, 13 Jan 2025 08:30:29 +0100
Message-ID: <20250113073030.15970-1-andre.werner@systec-electronic.com>
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
V6:
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

