Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD57194C8F;
	Fri, 14 Jun 2024 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718362147; cv=none; b=OmZq1YDhkKi0nrdTBpHzn0LcvjzlxMVzGneP4KMq8M2sr57I4yI+DbJ9Jf5dm7KTU7FYNfMAZq94tvc3ZPBuKcGZykMJgZJVLFlZADMUti/yZB29CRh/55G7dAd1PZ/gaIRn2d/QF6j4z7XiUNDSMlT6zpvmL2ULFYFS/ajIs20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718362147; c=relaxed/simple;
	bh=0OQ7fAQz268gKpsmJc8+bAZ72791gLCH1pCX1SeyqQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LL2g8ecEv5TN4CHQGrcN33xqaxJEQYFi8ZglzQ4zJeyIjVDqb1kevyMebeZtQHslkEktfRWliFhH3jvsxoWv1N74i+2Ee00/o110jNA2dJ8BUWr6e6WCB1GN4rUGgRlIm32+WunWtJ1+nxZYbs9VlYwaPTxE+Aa6sVwMTMkKqBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OeFerS/+; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OeFerS/+"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 381B440EED;
	Fri, 14 Jun 2024 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718361127;
	bh=bnS7kqTuI1oofRO47Dt2B1kbXI+rXgnlYIL3KGjU60o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=OeFerS/+6vvsJPCYDQ1QLKW9IBoj5olWVVzfZs8thBePbdpHGc5eCZRHM1ntwxLBG
	 SGhbYfSV8s8Vl4MQ33vmf9Z1BTA9wiLpx6JWqhrKW0Pb85kuESlYVJvAJwqSGUdMYx
	 9iQlkbd5111W2D0G2SyWPf3zYBfaiWeoNrNw5du38kjD36IWZEPPTbTqGw++CagIpc
	 l5H1bzrkcROlos9k11XarB2LJbLvTnOvACcgQyhdOExOb7HiYnz3dAKOHr0eLoX3gc
	 26NgGM3YfYMrCQDWK6O6AuQHp9AviSXUA99PqmVPxi1YKd/bv0I8LJyikM3+S97Od7
	 QEI+8VhIjYdQw==
From: Hui Wang <hui.wang@canonical.com>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	lech.perczak@camlingroup.com,
	Maarten.Brock@sttls.nl,
	hui.wang@canonical.com
Subject: [PATCH v5 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
Date: Fri, 14 Jun 2024 18:29:51 +0800
Message-Id: <20240614102952.679806-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some designs, the chip reset pin is connected to a GPIO, and this
GPIO needs to be set correctly before probing the driver, so add a
reset-gpios in the device tree.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
No change in the v5

 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
index 5dec15b7e7c3..88871480018e 100644
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
@@ -91,6 +94,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -120,6 +124,7 @@ examples:
             compatible = "nxp,sc16is752";
             reg = <0x54>;
             clocks = <&clk20m>;
+            reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
             interrupt-parent = <&gpio3>;
             interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
             nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
-- 
2.34.1

