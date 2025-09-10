Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2030FF26;
	Wed, 10 Sep 2025 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539440; cv=none; b=XJDYRN1l7gw5iheBzI3k3Mccx0ThlzyTeDHL6t9VgBVrhenRYtNn5ujoYCSi5UI9gC9b5GtO0LV2sqrV4BjFIjkZZv9gCbqPegi3mAJBP0HgzJ1NErEa0tskO4QJ4NUCM+mKYctNsFpyZCjPH7j8J0M8igyeH4tx27944J7CgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539440; c=relaxed/simple;
	bh=PbQeF3y+qwgBCbyFKvOZXgZH5WFcFU8Cgb1ja0zs8uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tLoOpMknHlUylvyz8eaHH+d+Q3u14zEALbtAKY0OjjmTOsIfJBhM86939Lzo/aJFfXQTWHGlY5oHMs5/NQ6/X+x5FyBw4xcphOUUkOFr1DLbuy2NpjASAG3h3xidcrqt5LhIgVug1qicqSCJZfFQlSm+ZbVMGJYL3jq8C2zm+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FdyknXB3; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FdyknXB3"
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58ALNoH4146663;
	Wed, 10 Sep 2025 16:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757539430;
	bh=fkjPzOus4exPAHnEz6RTPXE//hfUlcCGzFIQiKl5DiE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=FdyknXB3VPlFUy9nK5nSE36PDZYZo8a7pTSuDLfpmnGUXI6vpZr9uSUk+8x5o5kb+
	 m7GtK7NL73n+2aQ6OYZ7V/WBqn7KOyb0Y4rr8qEPpal221daZx4SIXq30Z0AFlqkUl
	 0rq2q5GA7HxHcMITXxK9WPg4M75I4F7KHXztYtA4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58ALNnGV014784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 10 Sep 2025 16:23:49 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 16:23:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 16:23:49 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58ALNnZ41097742;
	Wed, 10 Sep 2025 16:23:49 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Wed, 10 Sep 2025 16:23:31 -0500
Subject: [PATCH v2 1/2] dt-bindings: serial: 8250_omap: Add wakeup pinctrl
 state
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250910-uart-daisy-chain-8250-omap-v2-1-e90d44c1a9ac@ti.com>
References: <20250910-uart-daisy-chain-8250-omap-v2-0-e90d44c1a9ac@ti.com>
In-Reply-To: <20250910-uart-daisy-chain-8250-omap-v2-0-e90d44c1a9ac@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <d-gole@ti.com>, <vishalm@ti.com>,
        <sebin.francis@ti.com>, <msp@baylibre.com>, <khilman@baylibre.com>,
        <a-kaur@ti.com>, <andriy.shevchenko@linux.intel.com>,
        <yujiaoliang@vivo.com>, <b-liu@ti.com>, <u.kleine-koenig@baylibre.com>,
        Kendall Willis
	<k-willis@ti.com>
X-Mailer: b4 0.14.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Markus Schneider-Pargmann <msp@baylibre.com>

Pins associated with the 8250 omap unit can be the source of a wakeup in
deep sleep states. To be able to wakeup, these pins have to be
configured in a special way. To support this configuration add the
default and wakeup pinctrl states.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 Documentation/devicetree/bindings/serial/8250_omap.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index 1859f71297ff297141e5cd455574fa9ccd9dd11c..aabacca2b2fa6a7740173e6c415656360b5df4e4 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -71,6 +71,22 @@ properties:
   overrun-throttle-ms: true
   wakeup-source: true
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. The second state called "wakeup" describes the pins in their
+      wakeup configuration required to exit sleep states.
+    minItems: 1
+    items:
+      - const: default
+      - const: wakeup
+
 required:
   - compatible
   - reg

-- 
2.34.1

