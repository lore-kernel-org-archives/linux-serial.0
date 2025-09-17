Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5219A2DA769
	for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093237; cv=none; b=IEhJhv53przXCYGd6jkATtsufLcFRX9cYs+OC34IE5A4yPS6E6XNf7DUcZxQYXuGkIbELtuSZ1KRvHpPZMtZiruIk5sjVYOIEy9yqLZf2dStqy5cip1YB8YMtfKVXdS64czuzYmVYAbgHkrie8GY63Jdua8Fu+zKxnelpGeDkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093237; c=relaxed/simple;
	bh=Pw6SwIvC5HR9FxU8AOn+X7vEoKNviSLnMBUiSV7KSE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=RhBe6u852wPCnJaHa3NIq6vN8gN1AqLLOpkxSPFp0jNPGcC7I5vE1Uh12X8eUNVNJFDgS4mAA7QvWdEZf9WlBHOy8/seDBFpS2dWtoG4Ao0+IFD8RPCjYQ6XxyLTIQVKOPO+wQRA7TZWqTYkKtOGF7XIqQb/k5L3BBLAGdXxrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IkhBcOsO; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IkhBcOsO"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250917071353epoutp037f2ce32bfcbeb2e5b437a26572529fa6~mAHsl6WF80464104641epoutp03H
	for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 07:13:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250917071353epoutp037f2ce32bfcbeb2e5b437a26572529fa6~mAHsl6WF80464104641epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758093233;
	bh=fRXYlmwUu6J4W4Dm8/+PyXnDw1pO78eFLKDecT7iP3Q=;
	h=From:To:Cc:Subject:Date:References:From;
	b=IkhBcOsO1SthYRbXoWHJz+2L9H/I4JO0BLwsHti1vnokQ98mdeefJSKq5BNsaqMRP
	 1Z5ros+Sq4hwj/GzIREwGGDFQEJPo5R/UzLlout+Ag5yhshDFoBy7HJquWG9T9jjmC
	 xL/HCImsuYxb2uxIqo6AKs+BMa5tXZ+p07oZZbTQ=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250917071352epcas5p1c5e369c59b060161eb5975ca16bb60cd~mAHrjoBOM3047430474epcas5p1R;
	Wed, 17 Sep 2025 07:13:52 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.86]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cRVPC1nfxz6B9mF; Wed, 17 Sep
	2025 07:13:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250917071350epcas5p339e015f976f63e2df03544679ad6e6cb~mAHqCzFfd1682016820epcas5p3x;
	Wed, 17 Sep 2025 07:13:50 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250917071347epsmtip206f2559e389a17ba327d8aef0e18009d~mAHnOrkgR3178131781epsmtip2e;
	Wed, 17 Sep 2025 07:13:47 +0000 (GMT)
From: Ravi Patel <ravi.patel@samsung.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, ksk4725@coasia.com, pjsin865@coasia.com,
	gwk1013@coasia.com, bread@coasia.com, jspark@coasia.com,
	limjh0823@coasia.com, lightwise@coasia.com, hgkim05@coasia.com,
	mingyoungbo@coasia.com, smn1196@coasia.com, shradha.t@samsung.com,
	swathi.ks@samsung.com, kenkim@coasia.com, Ravi Patel
	<ravi.patel@samsung.com>
Subject: [PATCH] dt-bindings: serial: samsung: Add compatible for ARTPEC-9
 SoC
Date: Wed, 17 Sep 2025 12:43:42 +0530
Message-ID: <20250917071342.5637-1-ravi.patel@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917071350epcas5p339e015f976f63e2df03544679ad6e6cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917071350epcas5p339e015f976f63e2df03544679ad6e6cb
References: <CGME20250917071350epcas5p339e015f976f63e2df03544679ad6e6cb@epcas5p3.samsung.com>

Add Axis ARTPEC-9 uart compatible to the bindings documentation.
It is similar to the older samsung,exynos8895-uart design.

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 1a1f991d5364..3895049c954c 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -48,6 +48,7 @@ properties:
           - const: samsung,exynos850-uart
       - items:
           - enum:
+              - axis,artpec9-uart
               - samsung,exynos7870-uart
           - const: samsung,exynos8895-uart

@@ -168,6 +169,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - axis,artpec9-uart
               - google,gs101-uart
               - samsung,exynos8895-uart
     then:
--
2.17.1

