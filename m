Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AC2BE04C;
	Thu,  4 Sep 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021110; cv=none; b=NErKlv0w0lpqtllpnHJXQRg2HGOpjtChugWud4UT4MMpm7I6Xzal7no/yDmg5rAST0EBPuq3I0Tn+S5OOTApqS+F93bdWKc3GFx3wPPy7JN4u6EIgSAEvLCjlrdJaMDMp8g7XocTlgH02v4U9sNRk7JY3pT9Chzn64ASctgSyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021110; c=relaxed/simple;
	bh=uNCFwB3C+5Rw/IK15HEcSHsXBjCM8xjH8MVpjkI9if0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im1Zv8WsVenR9kgK4Z5lKcBxpH0SdNY2d3BgtKH24SdpcPRFlgZNh2J59+UN9tFgcGUSvItnLSBiKRl+vbe1gv4nTZuOHXhfL5pmWAa3XtnALDl+6Jj+AqJZhvLlOQOY7D0YwC46JIRZecDKl7KBby7rHXrKDngHtRiIgjc8SEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cIf7k1mE; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cIf7k1mE"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584LP0FQ3603115;
	Thu, 4 Sep 2025 16:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757021100;
	bh=Yl4PQBUK+AuhwJxjt4s/jV51T5GLI2nXcvVAFKVs1mE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cIf7k1mESroSFDwbW0PeHmrO3hOZ2sGaTtIH89PxMvB8O8Qln+P30ELYNOYz9XHlU
	 rTGL8myv/3Bta6hB3aVETCCyPpaScTdEJnZoLYFq5YhEuZwSPWtBfxuEie5l/pWAcs
	 DFaUX6xwAXK3DdmbJMs7ZimwTNU1mCeRbjpS2pZE=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584LP0Df405716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 16:25:00 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 16:24:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 16:24:59 -0500
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584LOvlf3611150;
	Thu, 4 Sep 2025 16:24:59 -0500
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
Subject: [PATCH 2/3] dt-bindings: serial: 8250_omap: Add wakeup pinctrl state
Date: Thu, 4 Sep 2025 16:24:54 -0500
Message-ID: <20250904212455.3729029-3-k-willis@ti.com>
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

From: Markus Schneider-Pargmann <msp@baylibre.com>

Pins associated with the 8250 omap unit can be the source of a wakeup in
deep sleep states. To be able to wakeup, these pins have to be
configured in a special way. To support this configuration add the
default and wakeup pinctrl states. Add support for the sleep state as
well which is in use by some devicetrees.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 .../devicetree/bindings/serial/8250_omap.yaml   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index 851a5291b4be4..1c4040a9f9d0b 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -77,6 +77,23 @@ properties:
         description:
           List of phandles to system idle states in which UARTs can wakeup the system.
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Can be "sleep" or "wakeup" pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. Other states are "sleep" which describes the pinstate when
+      sleeping and "wakeup" describing the pins if wakeup is enabled.
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+      - const: wakeup
+
 required:
   - compatible
   - reg
-- 
2.34.1

