Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21A12C522;
	Mon,  3 Jun 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418267; cv=none; b=cjiAdDYrWgH+hHU6QP5H5LkADqIC1jTkJZFOVFCMNLwfc359uWZMvf7ed6IzuDZrEPSN1abEZuuTf2ezsnwLEHTVc8ZV7qjLP3tFh6OODczlKQiT/BwLwy530piwTOhJoe6oMVM16B9gNlfyjr//8tTRMlA942YZy+7RVliB+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418267; c=relaxed/simple;
	bh=iNqoXL3l6pGrCO8tF1wXllFct7L4FEYTzyPho9173rY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LeKzglNU3DWop6g+oHdf5gFWZ9dQT5Or0JkgiaGfA9V3J9WRXcJkA/5Kjtp4IpOT1Dkje4C7x6Fa9pURmL9eelU1lWAjoHrcLm5eBDaWHWQlq0iFCcZOQ+JIY/g8gBxRxXMh0Nl6eTgEvAjMRxSkzjOYuxUcwRkWm5exZnLJlo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=gJIX7C0w; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gJIX7C0w"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id ECF243F5DC;
	Mon,  3 Jun 2024 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717418256;
	bh=F5M+W+x3E5jyNkr7sCMlyiuydTbGqQoGu0AaMJzisok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=gJIX7C0wCbNvEPyuplbpqn1Rx1l36yx+fxa6xV9X1OwyynZFvjLallTKBnek4sykJ
	 wmeRWToP5fYinagzivKKlxh1ibDDD5aVNG2wHTVqFxEEUOBJx1ZOnHcAbP3ut0Quwd
	 R0Oaggnjovy2k+JEEJj0qzjWI9iogJkHEllmZRtlhaR7DeELD3sk2W4f7/SJsZ0luy
	 SkXwWzo5xsNpIncHY4TEHqoSc3kmi0iERvCWZN8AHKtj/p3utdBhVVn7aLeq0GKW4c
	 ihnZ/Ldt1q0KOVDa3HOXpaelM0Y7NEg5pUeYkZiVY/YMeaoiesJ/w91pA0enGqutTu
	 RIE0ELS9FvE1g==
From: Hui Wang <hui.wang@canonical.com>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	hui.wang@canonical.com
Subject: [PATCH 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
Date: Mon,  3 Jun 2024 20:37:09 +0800
Message-Id: <20240603123710.649549-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some designs, the chip reset pin is connected to a gpio, this
gpio needs to be set correctly before probing the driver, so adding
a reset-gpios in the device tree.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index 5dec15b7e7c3..62aff6e034cb 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
@@ -28,6 +28,9 @@ properties:
   clocks:
     maxItems: 1
 
+  reset-gpios:
+    maxItems: 1
+
   clock-frequency:
     description:
       When there is no clock provider visible to the platform, this
@@ -120,6 +123,7 @@ examples:
             compatible = "nxp,sc16is752";
             reg = <0x54>;
             clocks = <&clk20m>;
+            reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
             interrupt-parent = <&gpio3>;
             interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
             nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
-- 
2.34.1

