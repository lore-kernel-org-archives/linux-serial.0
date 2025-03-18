Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7062D9460;
	Tue, 18 Mar 2025 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319267; cv=none; b=XiDbk0tfhByquzGQtmnj135S4fpt8aXrk7uvDYmldP2NOubH0a0d0PIE5H+yy3O/6G13CDPctdEr1ZIWd5/YWO8UTmIBkmBUO6mOjs1PvOt7Oe8Akb3Atl2k1jL0RBInqQy/RCHnoycJ7h5yYqQHYgaXmrcwd9q2/f6SwaSZ/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319267; c=relaxed/simple;
	bh=ilUgQnak1v063AZqkH6Wyx1Uy0H7R4gCn8BjLppOiZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fF7n5aFfHizv0zhC6Wme2Sym0c2AFqNH1H2pUxxBkraYE96xP2Ycmf4ixp2BuuImmG0+MYcZRcSADBNML0mgonzNvLY82Y87wjT1hiy6nV0rlOfmQ+bCwyGWeWIrbjhQh7gxToDcldPB2ZD38ZYVK7IRMpmmwgByAoTFMKgur+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DtZPSZAW; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DtZPSZAW"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C526C203B0;
	Tue, 18 Mar 2025 18:34:23 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQp2UJ9KnmWP; Tue, 18 Mar 2025 18:34:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1742319262; bh=ilUgQnak1v063AZqkH6Wyx1Uy0H7R4gCn8BjLppOiZQ=;
	h=From:Date:Subject:To:Cc;
	b=DtZPSZAWS8vDWTUblWtBsF1OAzaV7TskI1Kdd5WSMcGhNk9Wcz5dXpEi1EMqNBQdK
	 u8TnlHq+cFvj7bNQYjIZFlfcFBAjny6bYQpDuMzTahtWuXLRSQrxd/a+FIVpsD0K6z
	 I6qkf7H11vI3sfJm4eHaAPAOhLlGJ86ZIjIbIpIX30PUn+M6QjaQzosj4NzRvtVdoK
	 90IxbnushPx9osoEkBBW5oqy9Aq8YNq18abU5jPN/uc+g2H43s0mK9wdG/bX79Nb+n
	 /ZbucleRq66NzyvsyO0S+da9tY6SZIcvSnjmETJOXEww5qhpvaMoKyjibkb7CkkvDy
	 5z7i9c4Fpq/jw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 18 Mar 2025 23:04:05 +0530
Subject: [PATCH v3] dt-bindings: serial: samsung: add exynos7870-uart
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-exynos7870-uart-v3-1-f691b6679bb7@disroot.org>
X-B4-Tracking: v=1; b=H4sIAIyu2WcC/2XNQQ6DIBCF4asY1qWBgSJ01Xs0XVAclY00YInGe
 PeiSZM2Lv+XzDcLSRg9JnKtFhIx++TDUEKcKuJ6O3RIfVOaAIMLAyYoTvMQUq1rRt82jlRBq6R
 DC1IbUq5eEVs/7eL9Ubr3aQxx3h9kvq1fSx6szCmjTD1RWWsUaHlrfIohjOcQO7JpGX4Ebo4CU
 E6ddqpuhTVCuX9hXdcPityem/IAAAA=
X-Change-ID: 20250203-exynos7870-uart-62f64cea2489
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742319258; l=1761;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=ilUgQnak1v063AZqkH6Wyx1Uy0H7R4gCn8BjLppOiZQ=;
 b=vxmcQIh5pCDpHnNld7iiZ1iLzkQy+/BntZdv23XpsOO8+Lz7vbOAAWKDZz3skOp8t9lEIjnuB
 17MSBGq2FKBCKFtTysX8rwUONbcuntqIuskgxVZ42LqGffjQiYFKue+
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Document the compatible string for Exynos7870's UART driver. The
devicetree property samsung,uart-fifosize must be mandatory, as the
driver enquires about the FIFO sizes. This feature makes it compatible
with Exynos8895's UART.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
This patch series is a part of Exynos7870 upstreaming.
---
Changes in v3:
- Reviewed-by krzk.
- Link to v2: https://lore.kernel.org/r/20250219-exynos7870-uart-v2-1-c8c67f3a936c@disroot.org

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
base-commit: e94bd4ec45ac156616da285a0bf03056cd7430fc
change-id: 20250203-exynos7870-uart-62f64cea2489

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

