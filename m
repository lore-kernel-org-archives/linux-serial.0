Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A144AF9FA;
	Mon,  5 Oct 2026 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214759; cv=none; b=KhmRKFV+zRv0GPDna7DpmJFTw/cf+Rf/ds7kqz0Oen6QlN/UyyT4pXCfDNYTdjtQwxgKhYdrTu52V2mdcUda9b5DJU4lieD4vRh/iLbnM+XpVBQ0EW6tEATpOO2mfaiufxkHONPnu3O8F3ku8cBLJyi67DE832qGefZa6Q4rhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214759; c=relaxed/simple;
	bh=NdDAmGKSfysWHMXCSJbk65A4t0KhXlWdzk3AMSzy/yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRLRDHEnNlfWLl7lvpjhZcquIl2gft+ANR7FxNObJuMhC2bmHotOBobwvd11JpE7B/qU2jEIfeHsTzzsbGnv7xa4GrSPhr7WmFvugnm4l6ogijU4MD0BSD5YDHpFKl2xUS4rqnHgTW4mazdggWwyVwoKoTlh4CnRQl39ptbzIow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnmYAUhw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnmYAUhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5DF1F00893;
	Mon,  5 Oct 2026 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214758;
	bh=ST8JvTfWiVBzR+UC4P+DeoNgfhkeK7Pj4K0yMpN+dnA=;
	h=From:To:Cc:Subject:Date;
	b=cnmYAUhwCCAkM+s6t6LelFAr8lCfZM5Rex7/SvUi3ujGbPZQHyeAu6c9lViL+KMMo
	 eqVWhnd5KOcaPEtpSypEXT7+QBL4D8QD+9UEHGEbWGu5Yk4t/Inu7x4GgF55D45iwp
	 gCVMtrQ5a53/F1hrCuke/TZXfm6nXkXP5hUXyW0Wo6eSpR+si+NPrlPDu9l5hXiC2J
	 hRP80gBeI73gJJhmG9tLaAFxK2WLC9ug8F2H9kEmX4aabJ1RoAicIjNcs30AFR888L
	 cjNKLeeQJ/6XUeMNBneVycVJvVFYhrP9aaXQ1KDhMP4Ov0YOJ3tyGp5htTFdQV5Aqh
	 z89CZdS6P13NA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: snps-dw-apb-uart: Add Synaptics sl2610 uart
Date: Mon,  5 Oct 2026 23:19:18 +0800
Message-ID: <20261005151918.25259-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the UARTs of the Synaptics SL2610, which are
compatible with the Synopsys DesignWare APB UART.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---

since v1:
 - use sl2610 instead of sl261x
 - send as a separate patch

 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 664305de4986..a40f2737e71b 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -34,7 +34,16 @@ allOf:
       properties:
         resets:
           minItems: 2
-    else:
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - starfive,jh7110-uart
+                - syna,sl2610-uart
+    then:
       properties:
         resets:
           maxItems: 1
@@ -80,6 +89,7 @@ properties:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
               - starfive,jh7110-uart
+              - syna,sl2610-uart
               - ultrarisc,dp1000-uart
           - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
-- 
2.53.0

