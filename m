Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21A17A314;
	Tue, 18 Feb 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904802; cv=none; b=SONJJ7h3oilC2wZANSvda7akYyTtymwzJfIkRS1GVfx2kSoKpfeQI5tHvDkflhFqwEtWkvoNHThA4E9fG0oPw92QgsX/T7DYIopQuVvaxBeT2eO9jEQ5NgQ/3rGQ1YuTomq78IKImGAQiwd5dNgYE5QxT2n8XQOlcuDz9PamH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904802; c=relaxed/simple;
	bh=fZNVQMp38R+fm09V4IiqclMsqo4Do1Cn9eVz2bE9FPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E4H0rkezcYwlDLG1PqBZu4PY/gFjFtdY6GySpm0hktPYwYmGqrmdssD4Cp1HjnzvdriC0jUrsXHLVyyhsAW4cqPwqzahsxqBsjwByu2Jzq1PqrG111LOqPgYmzzOFx3j/g+WRKdQyC9TZSUGBSGAR7ZC/hr7aqLl+9jeJqUNh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=c0zyonA+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="c0zyonA+"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A130B25C33;
	Tue, 18 Feb 2025 19:53:19 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AlPi4aWyX7CS; Tue, 18 Feb 2025 19:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1739904798; bh=fZNVQMp38R+fm09V4IiqclMsqo4Do1Cn9eVz2bE9FPY=;
	h=From:Date:Subject:To:Cc;
	b=c0zyonA+yB3OCYTdcvOCuv5UAdnbcBqTxorJD0epQf3S3sYfcq9ecydN7v071YImL
	 P7tgGs1RLdCXyX04I81rQo3quDoSTBjPG5s9Rc27GGpBu1mLNL15jdb+LK7c760ZSg
	 iZRiYgIQUIEAIaFsClINCwQPWBAlvPJND6mmB+Ij7ug1pVaSbe2YYPnDLNaAzRXVQk
	 hOJYEJCwr3AVxC1uvZ01/eKQIgz4SNlZKD4Plvmzc3JcghiRGSmDz4Usp/1YZqvHNk
	 8hWOp2CYAsa+SXHc8W87wgtkCWbv7m62Wn9gopFkGVYebHtWFufSA1nkjH63d5NMUw
	 pMft337jdnk8Q==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 19 Feb 2025 00:22:43 +0530
Subject: [PATCH v2] dt-bindings: serial: samsung: add exynos7870-uart
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-exynos7870-uart-v2-1-c8c67f3a936c@disroot.org>
X-B4-Tracking: v=1; b=H4sIAPrWtGcC/2WNQQ6CMBBFr0JmbU0ZawFX3sOwqDDAbKiZ1gZCu
 LuVxJXL95L//gaBhCnArdhAKHFgP2fAUwHd5OaRFPeZATVeNeqLomWdfajqSqu3k6gsDtZ05ND
 UDeTVS2jg5Sg+2swTh+hlPQ5S+bW/lvlrpVJppe2TrHONxdrcew7ifTx7GaHd9/0Do9U+ELAAA
 AA=
X-Change-ID: 20250203-exynos7870-uart-62f64cea2489
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739904795; l=1559;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=fZNVQMp38R+fm09V4IiqclMsqo4Do1Cn9eVz2bE9FPY=;
 b=ld7qtC2ic/6MUzTZdmmMUcAIzbav2BOZB0VXv5XN2Rw8PwOmkihbHgCPWQLq+r26RvM4+GnSg
 uhmAQQNXvijCkVlZsKY6ptW0mIDCsy8nMbX6MenIPfHET8AJna17XGh
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Document the compatible string for Exynos7870's UART driver. The
devicetree property samsung,uart-fifosize must be mandatory, as the
driver enquires about the FIFO sizes. This feature makes it compatible
with Exynos8895's UART.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
This patch series is a part of Exynos7870 upstreaming.
---
Changes in v2:
- Modify UART compatible to now fallback Exynos8895 UART.
- Remove the UART driver patch, no longer needed.
- Link to v1: https://lore.kernel.org/r/20250204-exynos7870-uart-v1-0-06be6aa96284@disroot.org
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 070eba9f19d3e039090c58a82f93d02eed58ab84..83d9986d8e98a2a55615d15383c9c7fc89f5b52f 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -42,6 +42,10 @@ properties:
               - samsung,exynosautov9-uart
               - samsung,exynosautov920-uart
           - const: samsung,exynos850-uart
+      - items:
+          - enum:
+              - samsung,exynos7870-uart
+          - const: samsung,exynos8895-uart
 
   reg:
     maxItems: 1

---
base-commit: e5d3fd687aac5eceb1721fa92b9f49afcf4c3717
change-id: 20250203-exynos7870-uart-62f64cea2489

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

