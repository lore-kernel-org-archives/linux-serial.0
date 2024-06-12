Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76221DFE3;
	Wed, 12 Jun 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198216; cv=none; b=eAS1QA6jbwW1Jrp0tPJOZWQCnIDsu9n6x2dHM1XvzzgILtGAQdaHNK2nhb514L1s/i1ItWQho35c13Dbu4w3ZKwwCjMbPOFfqoz4kOOGIf3MZ1UNSkEhJ3zZMVv877TbXFqxLlDnPQ8TblxXcP1GG3yVsbkzPN1Kwgyb9UlwbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198216; c=relaxed/simple;
	bh=nJOFmrm8l5bSrDjpUHq3qu5OKW0wmxDGuPKVXh7BBQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQBzr/aSN5rUKCqrfWp4HVAanLFh1e46TyoEmjdZR4eeE0sNf9yA2esNI8ojzclHpouAqVr3CxhcJiddNO48+n8FCCvpynBNVU4QuyQuMcIv53pIfIs78Efcuwp+OGHzWGrNh1paa89rTxT4+lpYo5PjpSAQBlDhSqzcnOt7tyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Z3vU9kJe; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Z3vU9kJe"
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 88F323F2D5;
	Wed, 12 Jun 2024 13:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718198211;
	bh=lWaknml1ZsYphGfYvvQzVm/qiCqaAFI4Q6XTyj2MPGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Z3vU9kJe3m76ID1TVWkukE6rrKwhnqA8Nr2HO23Xv+3Uxgo2fRS0AjnKCKezN8A4J
	 Cpg4znc3hYqLdHBdeVcN6F9PYcY6dJcTAApAw5LAGkVaGHV5VGtw/X/LqDTHF1Z3im
	 pKoFPc46VagUWRpgMtpTABT7OsqN1bDzY0/nzxnLNQCvYoJMLfqg5bFvFlUnuloKFK
	 NySeDmK9GX7YySLuparESwAV9MI8bI/rd5FkabhMYawqdSotVUOQo1fOhpXQ9jB9RE
	 LbhYg79QYPUwMEAilkCnHujY+W84+Sxd4dCPgFQbcnVfejwQPmGsSzxeSht/yRyY5m
	 Ru0tf3bnnYRCg==
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
Subject: [PATCH v3 1/2] dt-bindings: serial: sc16is7xx: add reset-gpios
Date: Wed, 12 Jun 2024 21:14:53 +0800
Message-Id: <20240612131454.49671-1-hui.wang@canonical.com>
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
In the v3:
 - drop the Reviewed-by
 - change gpio to GPIO
 - change "this GPIO" to "and this GPIO"
 - change "so adding" to "so add"

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

