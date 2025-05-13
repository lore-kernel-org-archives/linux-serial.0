Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409621FAC30;
	Tue, 13 May 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173588; cv=none; b=NKYYLWOZ985zR6zgjDlyCF6qGjdH4kTnOZd9OhYrNlt9O1j2mqhFSOnQtfeZv1fcY9gRKwralwHaPF1aXvHU8uYeN6xXOXmrhaIAJvXDo+pAzQjKdihJSrviZk/n1MflC1bEea/XnFfb1HCFpNrMYDlQrTyl/HmYXKz6QOjyY00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173588; c=relaxed/simple;
	bh=KZEn/QtXsHYg73UlRGGnMR1jgTy07zQFPZnzyBRyfUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDDHNvBSAiM13R1JoyaRI0aeUPXVE/ME1sB0n1t8YWoJw/4cLaQNlGRyDrsbrzlYsuXTutby6kkBF5//fmXCHGThSk9ezEEoLq7C8Kdo6jJV0+UDd3cIQPkzMMAQOfn3UlV6do82yhLa0kTGRB6qGi8sDUIbvy/RVsTepXvC59w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KaWNy2Iw; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KaWNy2Iw"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxa493216120;
	Tue, 13 May 2025 16:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747173576;
	bh=lllgZxj9IlpQkvyLsX6w5NEjjZcmEQTTD7hvtYVHWic=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KaWNy2Iw86bB8Yo6oY4YpNNspjHbr5MxBhVNqsQRHQBMLhYmPX/oeFWimHBtc5wdc
	 W/7R96Bb/0QzZp+dPUsxsCCUINq+EL7W+DuUhWKoqFtb7mfetfFD/xPIecHy2xXu/O
	 qyU+hbYv2OfiFJXIFw261U1Rkpi7d8vdhBbHDn38=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54DLxZ8Z1005888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 13 May 2025 16:59:35 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 May 2025 16:59:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 May 2025 16:59:34 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxYdD111031;
	Tue, 13 May 2025 16:59:34 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Bin Liu <b-liu@ti.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Andrew Davis <afd@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/7] dt-bindings: soc: ti: pruss: Add documentation for PRU UART support
Date: Tue, 13 May 2025 16:59:29 -0500
Message-ID: <20250513215934.933807-3-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513215934.933807-1-jm@ti.com>
References: <20250513215934.933807-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add documentation for PRU UART node which is for PRU serial UART
based-off the industry standard TL16C550 asynchronous communications
element.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 927b3200e29e..54397297cbf5 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -324,6 +324,13 @@ patternProperties:
     $ref: /schemas/net/ti,davinci-mdio.yaml#
     type: object
 
+  serial@[a-f0-9]+$:
+    description: |
+      Serial UART sub-module. A PRUSS can have a serial UART sub-module based
+      on the industry standard TL16C550 asynchronous communications element.
+    $ref: /schemas/serial/ti,pruss-uart.yaml#
+    type: object
+
   "^(pru|rtu|txpru)@[0-9a-f]+$":
     description: |
       PRU Node. Each PRUSS has dual PRU cores, each represented as a RemoteProc
-- 
2.49.0

