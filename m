Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE323D286;
	Mon, 23 Jun 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671317; cv=none; b=mcoAc6NOofEkjE5mbTt6mT193fy6SMrCjhtfmLfz+UO2ePtP0cSEJudbycittZJrs79RNBW0MaIrjjYaA8O9XpP+3+zu82Z1860Op/eDOCzfYdbov3iBhE/xIxnuFrnnVZPn4D6ouy4B6fOx68j1quAKuapY9KRdf7YXfe+7SR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671317; c=relaxed/simple;
	bh=da79pZNN2aEY0mj+gSG8wWPoFOyi+E/yZ//aZFT96Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmvWcqHsbXPRmtntk97UdUhZMQLfDkJQgiz5/2MsG0+vXtRrx29ZRYXkbvae7WxRFcKCCPX+9hsd1YE/UiB8jkuZ3EbcNDGlzYjnY23lxuUBgpgS8+NVdNQw4A9kw6ThuIo19gBz3q/8zL/xi4mv+dGOUmvsYSqmY54MDog4c0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Zj6zhUHv; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Zj6zhUHv"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 769C520468;
	Mon, 23 Jun 2025 11:35:07 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R4l370J94e8X; Mon, 23 Jun 2025 11:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750671306; bh=da79pZNN2aEY0mj+gSG8wWPoFOyi+E/yZ//aZFT96Bw=;
	h=From:To:Cc:Subject:Date;
	b=Zj6zhUHvIdxIIr+/UqghypFZfQacduvJ/Rjcm0iWnx/JyYBrzDX40IangFB188PvQ
	 D8c4MsPYaBfW0tTtR+ZHU/Mx9aW0mO/4CNJIyTQnmhqC85/SlRrsS4VkIFN9A64uI8
	 NvoFghhfegoY66BhAELo/0HEXo+NcklHZ5CiggTDOfW45z+/99B8nxlp9ZqNclret5
	 I8oNiV5O22ntmWdj1cwez4e3phUstSoTgbLPcmFaBPxIU4WP+4Zdkgvuui/vb9L8v6
	 mhXmDyQ0FwO72Yd9orMImzfDRw1CTWjM5tYY0My08GeEKtR4ZTpPTqI8GsCqiFafQp
	 HcrxM4yruIqqw==
From: Yao Zi <ziyao@disroot.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2] dt-bindings: serial: 8250: Make clocks and clock-frequency exclusive
Date: Mon, 23 Jun 2025 09:34:45 +0000
Message-ID: <20250623093445.62327-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 8250 binding before converting to json-schema states,

  - clock-frequency : the input clock frequency for the UART
  	or
  - clocks phandle to refer to the clk used as per Documentation/devicetree

for clock-related properties, where "or" indicates these properties
shouldn't exist at the same time.

Additionally, the behavior of Linux's driver is strange when both clocks
and clock-frequency are specified: it ignores clocks and obtains the
frequency from clock-frequency, left the specified clocks unclaimed. It
may even be disabled, which is undesired most of the time.

But "anyOf" doesn't prevent these two properties from coexisting, as it
considers the object valid as long as there's at LEAST one match.

Let's switch to "oneOf" and disallows the other property if one exists,
precisely matching the original binding and avoiding future confusion on
the driver's behavior.

Fixes: e69f5dc623f9 ("dt-bindings: serial: Convert 8250 to json-schema")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---

Changed from v1:
- Remove unnecessary allOf blocks
- Fix grammar issues in the commit message
- Link to v1: https://lore.kernel.org/all/20250524105602.53949-1-ziyao@disroot.org/

 Documentation/devicetree/bindings/serial/8250.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 33d2016b6509..c6bc27709bf7 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -45,7 +45,7 @@ allOf:
                   - ns16550
                   - ns16550a
     then:
-      anyOf:
+      oneOf:
         - required: [ clock-frequency ]
         - required: [ clocks ]
 
-- 
2.49.0

