Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34710152E0C;
	Mon,  6 Jan 2025 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736153821; cv=none; b=d0GSpqs7LDvpEZzg6SMEKVgaoaoRb0kLPYnJABcIXN6FxppfsoYMbAn+1p2R3UPA0FtWvIBZevMGRmKNt5wiXauZhSmpKX74ObnVBBuOmSoTZ5d0TCIsxUz/iFL0NfFXVM6Vcpa3UUEkIdi8PxWTt7vtZXl/omM3DOZN/mu/880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736153821; c=relaxed/simple;
	bh=hx2+nbJRzM19kfojTzn1IuSLLeDyUAnDr3cLJ9vp5nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fR+5+F4hfgmkwXAAEIQ21OCZaJiy4CFrf9AT+IlaD4oKmlTHgf6BBIh5bxaSQtFXk3wXc5UXPPwHTz3vP3uFEn5nyZ3ibfpu9uwMIXLzAvI9nbpoRrdGHAGky1oLV9Jdpx5Xb3990IOAYyRtF1r1JXrMCRw4jVPnGsBVWqmQsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=MXlfztgE; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="MXlfztgE"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 363FE9400109;
	Mon,  6 Jan 2025 09:50:56 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ei5MdnGbRtFx; Mon,  6 Jan 2025 09:50:56 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 0F0C694016B0;
	Mon,  6 Jan 2025 09:50:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 0F0C694016B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736153456; bh=25KwakSebYSmtbmZYv7/gDHXkMpWo098Y7aWGhDHAL8=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=MXlfztgEwunXK3gAbXusZS9mQk1flSZocIOJ6KPeb8RfERMxeZMhi4o89p+/4ig+f
	 z5FKR4u/ip7NcocUeVhQicOd9Y0oqTxYouieoHwd0P+gFk4YsjvbTkv7llkUYbsN0Q
	 USV9Vk97WWvdbvEdUByB4WIxypDNIoTd4osOPnDZfOJS2efiErZ7LEXwaSkJjD7Jw4
	 BSsUWRq1AMSll7hDJiuslalCeCS6C9fjXmopwfO0FrMmA2JC2qAImy5s7HPblotyvr
	 QaI8p8qCrHz5y19NZb7OMPgKNB0gi7deXckU82ic+u3sEi4K+Uz146gP48cHgIXmEy
	 R/fO48DcrtoiA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id BV0GZiXX_lkt; Mon,  6 Jan 2025 09:50:55 +0100 (CET)
Received: from ws565760.. (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id A800B9400109;
	Mon,  6 Jan 2025 09:50:55 +0100 (CET)
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
	Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH v2 1/2] dt-bindings: serial: sc16is7xx: Add description for polling mode
Date: Mon,  6 Jan 2025 09:50:50 +0100
Message-ID: <20250106085051.50861-1-andre.werner@systec-electronic.com>
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

