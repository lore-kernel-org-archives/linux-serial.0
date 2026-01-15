Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04DB37C0E7
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477290; cv=none; b=f3lUbFz21SONvqOe84MFlHzpmANR4zU0JZMeYcFOX90FzMr6Tv8FsUIJBWLuOZAKzMJaY4LrnErkL55imEoWP7KiM0DmPJGZobflIRHsf574b+IU210VjVvqYMGihVTZfvJTQPEHbA/fktSgzdy1ftSTbta1QsZREjS7Z/+qtm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477290; c=relaxed/simple;
	bh=93VOl//T1710gnGzUbrxwFAJf93hjOVK3YA9kMeokWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xv7FZGaJ+3seGGpbF6OOXcil7RMh8xT7FEE1Asx4kWZ6tgFav1KyI4TwjTauu41NU10BtZFtZrnMRZi1AAHW85mNAmdFXJJnr0WWBLwUJCL66lHoRY+8uaHXwNUIPrwnu6v73F5nQ2y5FBUADqtDGgaft9EYeLHTxELPg+Y/WGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=HH1xjzbj; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="HH1xjzbj"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1233c155a42so926010c88.1
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 03:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477286; x=1769082086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HFCj5ztGvyCwGgMLXoFCMYjN9FIM/YL2Od2IwlkeWA=;
        b=HH1xjzbjFzEvFTuYaEQ5nW7+KnA4ufCUvTIGdO29F+2BByw6owFoSV5LFqgnJqmNP+
         PzIW/fii97DhSeFAVfcwYuCOKxpaYUsHwiQxuv+UoIrs9wLZiWaLsyIRlMwIarYpuXae
         c/whJBTFucAhJaV2k4amzhKN0SdMGQR3+1hRKwV96f5MKZPVhJGTk7oQu+n3IXxG74+x
         fP/OpGTKm5VSFF8Z0q3KjOfyokSoN65OXNkmggxmxdvt6HdVfaaiV0rPoB7Z+fuuUPNo
         S/eBQHnZ3qh9P/HhTViiSs9a3tqqOd1iDTGx7bUjTM6hGqdbtwlg95BySgWqt9GcdjNN
         kbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477286; x=1769082086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9HFCj5ztGvyCwGgMLXoFCMYjN9FIM/YL2Od2IwlkeWA=;
        b=MBW9zeQLPwRgQMyLG91PltN+5w4zKnfydFCOb/XdYniGyY+3dsXCAlD7ksGhJqHNMf
         e/F8ZZ0hbHBKehbs4lX5ScepWkWsEKNHxCVnkKtbHTIL5rUyh5+kB22tRwEmteCV/cDH
         Qq5uQCB4Hc9mHUq7/Oxu5yJIT2PR+/IiAmogq4Vzu7qLP4vylNz5nEr22nV2hrzUE0h3
         IuRp8rQSVjZP5jz/tCPldv0uNvmHc2WVcmxa+qtpO3dKBwVbLX3XTjE8hiAJEajQepgF
         BNTG9U+5Sfk/2YiWmfkR0czwlEEsF57omq3kciUL7lJIUowtGj+GYg0Cq4DKTCvk6si8
         uL5A==
X-Forwarded-Encrypted: i=1; AJvYcCXokzoTO3M6Desh7WEWx2lr98wfcDLaTJtFS7Hiss0gXWboT3zhEC/MgygoFoitC6Q3PXEjHwxNoivINyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqok298mCFj7cGM+XVkzK/xOqgTYXYfTqC4WIfeZ6uteqZcGcm
	ftpDbH4E+srAFCbuFrKSV1Z2tptonPW6OzZamNEvlAsbdpSXkP1MFQYJZM0gx+BtjOc=
X-Gm-Gg: AY/fxX5zc9yrOpcGrXQqA3jOTmsQhwI3wC5IVLEUXkJ9rHmwq9EE94k011G4o3MA8Gz
	w5VjOlrFazhvIVCPK5jg4jBb1cupO/cSDQmHCKgz7hQ1WBO9sZt3ykJFah4RjzsznGPPafro/sR
	Nx+LWpxdjQq0vEfZlwyapVeOfNBSuYLnSg/ZETkbzNZs4LNO8Aq7Ub6ACa7XRxwt/0kjh4JREvw
	XkzUKaZkHXlLrV95fFSgA2hpRhuICELr4PEzUao3/SIXkiQTmc6PgXvZxvlwOYO5nhMd3gjTadu
	vTKW7F4QX/x8qGzN/yQ8jN2gmBnZVnPXF22WaCWAHrESM1brVdGadFi1c/7A8U2bcTPLihkyKDN
	EO5kAZyivQ8E2q9lYQxoZycdW8mbagh7T8/nCLLTPZGCReNgdmApI9uLAKaxXBk+0qcP2tjfrgn
	cBVyzixpMtsDhz8XnN9C0pQnqwVfZ3qJKks703CrDNrfOo+mRyv3McBgktcinPevQVXUr6E+DZY
	Mvwn8vR
X-Received: by 2002:a05:7022:1719:b0:123:35c4:f39c with SMTP id a92af1059eb24-12336a67900mr5434114c88.26.1768477286121;
        Thu, 15 Jan 2026 03:41:26 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:25 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 06/11] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
Date: Thu, 15 Jan 2026 12:37:31 +0100
Message-ID: <20260115114021.111324-7-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document LAN969x compatibles for SGPIO.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 .../pinctrl/microchip,sparx5-sgpio.yaml       | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
index fa47732d7cef..9fbbafcdc063 100644
--- a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
@@ -21,10 +21,15 @@ properties:
     pattern: '^gpio@[0-9a-f]+$'
 
   compatible:
-    enum:
-      - microchip,sparx5-sgpio
-      - mscc,ocelot-sgpio
-      - mscc,luton-sgpio
+    oneOf:
+      - enum:
+          - microchip,sparx5-sgpio
+          - mscc,ocelot-sgpio
+          - mscc,luton-sgpio
+      - items:
+          - enum:
+              - microchip,lan9691-sgpio
+          - const: microchip,sparx5-sgpio
 
   '#address-cells':
     const: 1
@@ -80,7 +85,12 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: microchip,sparx5-sgpio-bank
+        oneOf:
+          - items:
+              - enum:
+                  - microchip,lan9691-sgpio-bank
+              - const: microchip,sparx5-sgpio-bank
+          - const: microchip,sparx5-sgpio-bank
 
       reg:
         description: |
-- 
2.52.0

