Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED52BE047;
	Thu,  4 Sep 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021109; cv=none; b=H8sZ4cPNPWJU92LcYdLRcGGJDAbk14IeJvaZeQXhOiJ/oQBdlEx/mQD570V9D6es7vLNk5IvfPBxZaPaPI3Wz44F89dJtDosanUgR81e1gmV4gTbtwWAtFUo8dr6PKlH5F9LYiPhTHVWhFjMGUByv6HJXbwXcV6VPkpkZOyJvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021109; c=relaxed/simple;
	bh=pKAQLsshWECw1X3z2y70UhSzMLQ4h+Oc9fVb+lbsv84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abyjKjtz90hA+qxNTy8L06h0vePTNCuB0cR4A+UqaXyrw0aSM9NuZA9/MXVj5lXj/8k2fZYwaki5YmjWIac+Z5RVngqX+1cfTMfBMDGKi40f2xtd49rWh8RPRSKmGfu2acadatE3vEv/Ye2RmUmKToT3vlIw/Y8ziFJ78KYCib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EQHMPls6; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EQHMPls6"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584LOxtJ3561776;
	Thu, 4 Sep 2025 16:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757021099;
	bh=jBgeeqpoNro25yUCNp3rX608oj6F8xXhDRGf+2Go+LI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EQHMPls6CxLKe/nikFjARk/yJcLz/U8zVDRQ9EQqCWk4lIcGIJxEQ1DEZsRullvX/
	 c4kiUBCDl9aelLWhAhQJeDpn6qn2g8HfylOx+bf6Gtah+324tjv94B0kLvz+zubN7m
	 oScDa4qA+xpHPDDoriNvphVHNfFkksg7Amx0uNng=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584LOxFi405712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 16:24:59 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 16:24:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 16:24:58 -0500
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584LOvle3611150;
	Thu, 4 Sep 2025 16:24:58 -0500
From: Kendall Willis <k-willis@ti.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
        <msp@baylibre.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
        <k-willis@ti.com>, <john.ogness@linutronix.de>,
        <andriy.shevchenko@linux.intel.com>, <yujiaoliang@vivo.com>,
        <b-liu@ti.com>, <u.kleine-koenig@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: serial: 8250_omap: Update wakeup-source type property
Date: Thu, 4 Sep 2025 16:24:53 -0500
Message-ID: <20250904212455.3729029-2-k-willis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904212455.3729029-1-k-willis@ti.com>
References: <20250904212455.3729029-1-k-willis@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Allow the wakeup-source property to be either of type boolean or of a
phandle array. The phandle array points to the system idle states that the
UART can wakeup the system from.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 Documentation/devicetree/bindings/serial/8250_omap.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index 1859f71297ff2..851a5291b4be4 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -69,7 +69,13 @@ properties:
   clock-frequency: true
   current-speed: true
   overrun-throttle-ms: true
-  wakeup-source: true
+
+  wakeup-source:
+    oneOf:
+      - type: boolean
+      - $ref: /schemas/types.yaml#/definitions/phandle-array
+        description:
+          List of phandles to system idle states in which UARTs can wakeup the system.
 
 required:
   - compatible
-- 
2.34.1

