Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC26409281
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525116; cv=none; b=FYgIExzCAFwwcCZOhom6bgcM4HS0AW9oE+BjLcb1lSnRI4sOfvwp4SrYVWGvwx7YvHK8kHUBZRsnGqbWZVxj7FWfm3ipNuQUeirEX9vnr3/FmZQcLuYukBeLwsg+tB4vPARn9doPmgcqnQQJhZnG1zntGVUaORHyoDvdFluBFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525116; c=relaxed/simple;
	bh=ZnhkDKdmhPBrpcYhAlSCSGgrlpqxEa3PkV+ULDwJizo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vE7hg66MQ8Cur/NzDeWAALpdUpkalm2rlCye/9mO4OnWisXzYR62XqlsjogYCwoMWh1c3J836RO93BQkCesH9PbdZ1dIxHv2+W6LpUelSzvYrapJbCziytB0hm44+6RgpDTELxv+bLjE5mOMf6Ymj/eFhzFZjwaix2MczzaJUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=D4HOHQFY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="D4HOHQFY"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c00f74baso5867195e9.0
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1783525114; x=1784129914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IsD4MhplgL6wFfLDJdfUVLAz4oGDfnauFOzTWjsK6XA=;
        b=D4HOHQFYQs2mCjYqr5QbHdBbuklmKbUgOoIGU2oq0IJ2ZUpmZNJZUJKgz83oNyPGf8
         BR7Q3UM9Vie9rDs29vVWDhsgx/M35c54g9lk3bVpYP6Zswf/9uZEc7Ar5voIACNJtYkD
         RZV1W/OzFA1RC/xajubhTJ8bPt/iRD9l1kTpk9CPCMynOUd6nokxspSgD0MezARVwopY
         8fAlryyxfCA1/n/pzUNdmwUPCmFKD/772ncO4KAK3fO6FlKryrDS9vJaOtFEYXYJbEwF
         AXkLbgBQrHz07kx/fwqqnoMncix5eSmK0GeX6DcWGk5fxaO7eEdg+zGIk1j99GYaY0um
         Mgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525114; x=1784129914;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IsD4MhplgL6wFfLDJdfUVLAz4oGDfnauFOzTWjsK6XA=;
        b=M6fIJMryzJmbFygQ2k/aVcqQ1k12ev7DxMn4YgwPmMF2ky+6HXDOKYmXFcPeYgqbWK
         KnOJJnQqNzXnFgf0U9ecVG52mLCfYI6g7JnzeVDAaLtt5GMmemIXdb69C4rNTXVwQIOS
         uIcM1XRda5e7ZoOXgB6EdmG+iwKYMujUKBg0lDu5203Mm7SoChD4raGZGpdEQzXiIBng
         YuqzEFYVJvVmMDuk1RYV+X4edwlNWwNThKgvt7wXzWjNjOZAsK5y3bMLFU9q1fGJKhFt
         cWZJJGX7i33GY3h3gFV7nlNGmLWjUv7nQNgZ0JBvAtAAX19EKusIanHNPLcScrQRASxm
         Zrbg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3fns7VHOX+rN45JxT+EaAC/sWoB672DV80+vRpPJS1wGUkyo4AvD6lYUzAuWXuIj8W1JHQAeVUaebYK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbV9ef4/V53un7k4jDhbfRUpxalkwCDpJTiScRpjsmWJlHsiSz
	EK6dftuzdM/tncbopw9q+alPOqGWR3KnUbp55EFXRdz20gewH2/mGCsEokuGeuOgii0=
X-Gm-Gg: AfdE7cmc5H4e2cwrB64gjbR1m4h3H1yWuQS6FCl5kT8eCvxKtD07YjZsXY1MZEP/FvJ
	H7FkUEg+V/Lf4/dPlqVSomNWZGJErX7FJGQJ7hGTMIe7v5ONO+VRmyAHlSh07CB0WlKWccCPE5u
	NuWRwSdI32aldg5vusvH/e7fx+Y5SQxwD0makRHl0H9klLq05qG8v1eMAleH6m8vjCruxhC34dY
	0Kxn/6pOrxDIn47Afjfkm3eP0ArYSXlBNpT9SKVqING441+2zJVTTMAks+FtjjeoMlwl438j0aT
	ba9t8EzOd1d4ZDX3B/78qITqEYgXg377UxxD1Sx5xnwqiTg13g737Keijw57DuiUbjUVf/UWihf
	EELTWqcKLDmm4QZ8elvKhp1EqVCxoraUb70tsFfd7UmIgDX6/eC8Gyf+AkChA/kclH9esLzcQv5
	EcDLji+OCqsB6XEVOu31wFdQL8sPdKy0QFS+rzJpKNE2Li09RdijvGWiLf/lE1nwEvhToFp6kJk
	w7yV/yVvhFAfJXWq+y+9KTD1DLq
X-Received: by 2002:a05:600c:1395:b0:493:a435:d870 with SMTP id 5b1f17b1804b1-493e68ce31cmr32926785e9.27.1783525113666;
        Wed, 08 Jul 2026 08:38:33 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm44254136f8f.15.2026.07.08.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:38:33 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v4 2/7] dt-bindings: serial: 8250: aspeed: add aspeed,vuart-over-pci bool prop
Date: Wed,  8 Jul 2026 15:35:54 +0000
Message-ID: <501428d6a6cb1548bf357c25313dbc319724ead2.1783524645.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ASPEED AST2600 has 2 Virtual UARTs accessible over PCI.
The ASPEED AST2600 can be used as a PCI device.
2 Virtual UART can be exposed to the host via this PCI device.
These are 8250-compatible register sets and can be used to have UART
communication between the PCI BMC and the host.

This boolean can be set to specify if a VUART is used over PCI. A VUART
over PCI needs a syscon phandle. The syscon gives a regmap to the SCU,
which is used to set the enable bits of the PCI device.
On the aspeed's chips, the clocks phandle already points at the SCU node.
But deriving the regmap from the clock provider would misuse the clocks
binding. An explicit syscon phandle states the dependency directly.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 8f22121381fc..2ea8981bba80 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -27,6 +27,16 @@ allOf:
             enum:
               - aspeed,ast2500-vuart
               - aspeed,ast2600-vuart
+  - if:
+      required:
+        - aspeed,vuart-over-pci
+    then:
+      required:
+        - syscon
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-vuart
   - if:
       properties:
         compatible:
@@ -223,6 +233,12 @@ properties:
           - const: uartclk
           - const: reg
 
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SCU syscon, used to enable the VUART over the BMC PCI
+      device. Only applicable to aspeed,ast2600-vuart.
+
   dmas:
     minItems: 1
     maxItems: 4
@@ -316,6 +332,12 @@ properties:
       polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH). Only
       applicable to aspeed,ast2500-vuart and aspeed,ast2600-vuart.
 
+  aspeed,vuart-over-pci:
+    type: boolean
+    description:
+      Enable the VUART over the BMC PCI device. Only applicable to
+      aspeed,ast2600-vuart.
+
 required:
   - reg
   - interrupts
-- 
2.54.0

