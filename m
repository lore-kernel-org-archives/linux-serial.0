Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E8146587;
	Tue,  4 Jun 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507682; cv=none; b=hUHJP3TnV7+G/cRIfEA53w1/i7GqRIfIwUiy6EaoLnC+IdQ5OCEm7Orqo6M7sKtBcXo/dPoBbc4/9yMmpHDlmPcUdAQbQHs45rq5Z4Fu/M3SuoOJCewviMoxi2Yu1OPwCLm9m+w3QW5J7db4BJvdjPK7XOxG2+YopaaGXT4IREU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507682; c=relaxed/simple;
	bh=XD7sGTd2Gsxw6auJAyBns8W6FqefWrT3nEzqQT0Lca8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L1+dao4J5tn8ufnBGuccPGgqa4dj8MPMtYrvt6f6dli7F4KDJwsOi6Jx0K5yqsTo4oyo9hbhj56wRQCCSj6p2iubR7IE4ZDMQKYjrRueKbJUv0JnPAvetQPWUI75CKLa7TMMyIIXyF0Y9ZASQCAoqTsKLSv+sOOro9zuDyV2o3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mHb7GBUL; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mHb7GBUL"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 09942407AA;
	Tue,  4 Jun 2024 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717507676;
	bh=+rTEg07k9uO3gI73BYv1gqqZWfRUljeZMZ+vQPgJl7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=mHb7GBULCdVEnDIXP+HRZfNv5bbYo6ONwzJgzXQp1pKbG0QGKtIaTKSsd3ua8yYWz
	 tLXRCN4fCNqcM26unkZTS99EZslV2+4VWFSszMHSCny+abZqR3A8JerH1V1ynQiMVP
	 yaK22fMEO1Fn66EvdEE0cG/Y/q+JKtLryeGq9Mxo0YA3dIOky9NPpkDmPBN4U0vyPw
	 /n8d3Wd6y/z7Mf2cwIyKwnru2C8iCrK9t7Zb6WkXGpMEjbsX5xlqrTMi6Ey+o1UYS8
	 /R3SF6qbpFIsVLi02OJtGvB0bDPyqKQH4TIYSHluLiWxe++mobGGycyUtxYF36ycS7
	 0ZMQQKKdiLMPQ==
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
	hui.wang@canonical.com
Subject: [PATCH v2 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
Date: Tue,  4 Jun 2024 21:27:25 +0800
Message-Id: <20240604132726.1272475-1-hui.wang@canonical.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
In the v2:
 - include the gpio.h
 - run the 'make dt_binding_check' and 'make dtbs_check'

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

