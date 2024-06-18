Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867E139D11;
	Tue, 18 Jun 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710080; cv=none; b=hVo/64bwWMwyy7tCLoVMGmyjoKmgUvkYBHjvE3F47FFAOQaUwsjy+l6/+HJER1OzH/LVhb1qp+RFQ3L/t9wNQCLcWQmqd0i6Dj/QaHfgSW9V8ul7qFhTVyxFfvzcYbS+lVdZPPiLsY+GffC2M+dEFk7DixxH86DCvhHjEJ+kGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710080; c=relaxed/simple;
	bh=9cakxw16MG1Is2XYxq435WdMffeoOQdzvmvP9zz7Jv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k47ZzN4o2N2I87jRgZWj8WqC3KQ13B/uAxXofH+vUfyWrsFxtFls8BBy5R6tgmxBxu3v8Y4sbRSqq4hfzOlaGcJiGmc06v/f/PwFNHfKARh/srQdRZHaA+WT1j8ly1C0KQRk/b2kcmB5mCsxLZspIrVVfDz8z52E/TGOhHyeHfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kuPNntk1; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kuPNntk1"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 15ED33F1E5;
	Tue, 18 Jun 2024 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718710075;
	bh=MevBdRTfcD5TvScobUERArql+8UMb7ptftVJJxjWRKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=kuPNntk1ecl6ISDOmdh3CSO4M/FJWNrb52Y2tCJUFXHtrgR9QMrpkk8EIvqQugz21
	 9Y8uvEdNbxTfuGcjuhvrBSD5WW9GeJLnhVsd3mEdvBu2CX6ae7wLfYpWGdGrO+dbxT
	 8Jm8A4n70xuEvPR0k74uadgtErr7STUSGbCwEX25PjYUXPHAwmIUqxL3ZRxHIde+aR
	 C39itLrAqF0TELAE3628LdJW1Xjf5IrxlwwXJ0zxXFERJNVcXyBMoSB/1fvZ9DR6XQ
	 vPqBDuSJF5MFMMvrkwcDvBMphzxdizJ7I5PwsVPUue3iC5Ixs3TnFPcfNyBLy+6Nop
	 cmXn9oXdUo8MA==
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
Subject: [PATCH v6 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
Date: Tue, 18 Jun 2024 19:26:19 +0800
Message-Id: <20240618112620.152848-1-hui.wang@canonical.com>
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
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
No change in the v6

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

