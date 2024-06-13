Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDC13D605;
	Thu, 13 Jun 2024 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267161; cv=none; b=U5raO7Ljr67UlHV7Zq11wc+l+2KA6SlROsf1BAslBuUvVsgZ1kGY8NuwK/oonvVYMbiOnJ/TkAq+9Q5pbXVO0tjfKyTbg8hNEO8xJ9ul2nuLO3q90AUneZzZKbDk2crlMnydSF52TQPVAyFRw6i536M9H//BvQyKWkty9S1WL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267161; c=relaxed/simple;
	bh=EDYv1B7PGHb9bGboetU+iX/v1DXk0zLDEHhdH1Dn+lk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M94gNel3d1RTmI5FDle1sgOmCxijXlsxRcjy4+DikUMlZ9JcF/NIt/Ol77jiUSADK1yBOPgvZ60RKjUr4dzv70lrqkdNqpWHmuDnsRQeYwDv9b9bONhq5sjY5pYNT7ZyCBCrHXtrf4F6Sp12Qlx6bvZKkR0Qqsh62f6pd4W0qlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bLVKXO8n; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bLVKXO8n"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0CB6C3F1DD;
	Thu, 13 Jun 2024 08:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718267156;
	bh=yjnaeeD9WWuqmqNzoLXUqkLImKXM+ZgDbAX6D3QNxpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=bLVKXO8nC5IqV35WWZV5Fwq/00m1d8poNSQxrdVdpk/5Hp2YTgb6RHywRoCPdcM5V
	 V2Xt2zUbfGcYmnbsZIk2Pgq9GkVunzU9eJBMrFphO9jKYn4ijAXECL/e2drCLua8bg
	 VMcFYkSCXmVHe7hRuh+fJRcL7JhWUZ4s3cZmhyCfQT6P9F6+nzVMJCHG5xdUkgrWjv
	 w10BNeWR9iZ90bYci6L8TfBE17+Q9yOZEde/je3qrFsRagumNcjdGWDHNnFOlv3cMq
	 qSbrwVh6rMZOq3cZOJ4AWCK3PfLHMY9SeZuI6pt6w1OwmSOaXjI4g3E/BmdCNKaSC7
	 KGpc7b7UFvm1A==
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
Subject: [PATCH v4 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
Date: Thu, 13 Jun 2024 16:25:27 +0800
Message-Id: <20240613082528.22591-1-hui.wang@canonical.com>
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

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
No change between v3 and v4.

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

