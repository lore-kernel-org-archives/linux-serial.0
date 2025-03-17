Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA615573A;
	Mon, 17 Mar 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742239378; cv=none; b=FbN25rAefd49eMltOVyjCAef8dZCsur2QXj82/Jy+A/pUJ0lr5cKPRnjCOoZGqU9HXiaHQh7xWjeQPLPg0e/9W094GM+V0AeecTn74prxSLIbhSccpqj28t+fB01ZNO0qdkmNW9+3EijpCEB0d0Pij3Em6tFGh2BGLmOGmhLq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742239378; c=relaxed/simple;
	bh=fZNVQMp38R+fm09V4IiqclMsqo4Do1Cn9eVz2bE9FPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iDYURD3cU2vAcXeSxiJkZnpIDyiAiKF/GtAAezjBYT4S8OxqrX5ZznoUsF3tZ8/nSfDIPdQCQ8kl82S20fNBueFwwK4X1bY5caYekvtiNj1LJWMfEXAehE5/VSwOPEF8uPZljzUe9sHtYFZ4KsMhLscXcz3lPwHSu7VqFgE+6d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Hp7LGUmI; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Hp7LGUmI"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B684520221;
	Mon, 17 Mar 2025 20:22:54 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ExWSxhWLF5ZT; Mon, 17 Mar 2025 20:22:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1742239370; bh=fZNVQMp38R+fm09V4IiqclMsqo4Do1Cn9eVz2bE9FPY=;
	h=From:Date:Subject:To:Cc;
	b=Hp7LGUmIsRZ+VC8B4cwU+FNiPEcOEpsmfvyOe16dpxp0eucMs81kHoxKA2Ob7VQy2
	 /rnIzh6nGp5fiXYcSJXjdzJq/EOW5V7mM26q5et1anqCbo+qG87azjkgXc9OmLWBSB
	 KlTRw61vVvACDD7uHZyN9/i2Je+2x5WFqQ0qsbmpi7i5dg6ilFPhS2uLpxKizhRuTk
	 w23A6gb3jz9kiSjhFS6DfK8GhD+kcXprEv2Q1/fy4p2K+58ta6zGsaE1/g4DbkWya8
	 7fmJ9x5v9S+9DH8Kl2xF2UTcvUg+iNAf2itX+J4I7+3xK0MQpeyzuhyf6kGKIgBQ23
	 eFFHTTMyM/AIQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 18 Mar 2025 00:51:53 +0530
Subject: [PATCH RESEND v2] dt-bindings: serial: samsung: add
 exynos7870-uart compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-exynos7870-uart-v2-1-b9dcf145ae87@disroot.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742239363; l=1559;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=fZNVQMp38R+fm09V4IiqclMsqo4Do1Cn9eVz2bE9FPY=;
 b=2rVCzd5/CHqGb1ChG52Moc7SN+UJOR7KnsnSJzMf3usgccSgb8ohIzSBjAZz0Z+Adgb82phoG
 LZ1aRVpd9SLBMnzz1HXOixpCirufJGURtbTF6F2zhaoFH05IVi2dex6
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

