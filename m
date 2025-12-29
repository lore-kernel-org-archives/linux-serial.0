Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5A33B97F
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033637; cv=none; b=i+GOn1ZwGr5Syrpbed9UEbOx4lunBQKgiCscQDbt3XDaaK0xi1ogeuRBmRe8Mh1FSwGiNhquZeFyqSeya/PQpxZdxdhFk/J7XTuU1KAE5A5k17QjE3nwMYK4cambzgO/2pqPJ/56KOSLDZPTKDciDSJwCvQyrUY4Im6nrDYP0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033637; c=relaxed/simple;
	bh=Q1obzpbb74AZt0ukfBT7/Xcte4bERP/uv0lOi/h0us8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbkVVp+zYToRHXZehUGAhKMnLXKzzLqCWYNzmL9VmTHfMbiWCErK7QsVaWeHJitBb/FqCA8gnoTtyGJxowjEJZB2k5/WylHopCEh3QQw/PKHIzonaCQTvaduq+62EwV62RidV+AE/b65YFxbdmoGLWaT85tf6qDMABbrvrU5syY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=LyRSbbrq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="LyRSbbrq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so71141235e9.1
        for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 10:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033634; x=1767638434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD3TOo20gfVbUTTrRVEjhVDMuAvx6I5y/UndE2JGgIM=;
        b=LyRSbbrqhsYCVMar6TnbNq5OwUK6vM5vLOubw24DS+DHtGNV+bJd9Ws4YLFLcIaAk7
         HWPCtBIRseMv3/cnK5UmboWJt/jYxd0RuJWmcbt2Yc58+DpXPQwFcYmx5ERXgyz/VGnj
         V9qPrIkX8CwYabWmv/ku38VSqUqR3RGC4o789At+xV4gIlr9J+R+B5MA6mEnjByrB5D9
         6AGB6F9TcKy1iuVMGebdlKSCHbuE+vyg+Q01p4WIc/CbgEApewqay4CiCCRYEI2Eypo0
         a4p8Uo/of/KtQ63rWWRF9/G+a3GHxhBtDB30wW9cC//iynv4tt2gWEPfDR5IAzePQaxD
         wR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033634; x=1767638434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fD3TOo20gfVbUTTrRVEjhVDMuAvx6I5y/UndE2JGgIM=;
        b=jc94DJFZW3YB2iid4bXtzuPBu6ggGSrhLZXCJMSqTb9bqLk9njIDF95grt4p2gLu7/
         q/44KV4lS27Zb6Yhat1JhjGmYw2bLXkvyX9rOoMRFumuTY6SdCI+0P7NgQDVHDqgr7f5
         yZiuqDQZEtCFkW7x9JYaRFQmQbYNIlclOVhrF71AIGJtTrG7B2dfZKDelYonDmg3hDwm
         qYKk/D8J234wb9XDPnHEKhG81qK/zY+skpeKGS6STp6seDJRIa9hoR/Wv34/2NZ51ZxY
         r5Z6Ijyh6BFN9FOSDTUL5qanrGYFvicBaudL5W1jTF3Xa5+GdAzy8xYhXdJQExgfaZ5D
         Kkag==
X-Forwarded-Encrypted: i=1; AJvYcCUxJ8pKRNMfowQYPIj1fIbnDzuXXYEYarumCkB0BlfOszUF0I6/mBKlKVJ6NjfVra20o/Hfmk9DRYTcWw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGrY3rJKnCy6ESmQf80Wl6f3sWg4r1ify6REBofLxKuoTaN1jX
	pafD10lVXdHQe2CQoAqj7EdGApNTmbBvIYn9f8OVfnI8csV9JFEwvKzqCn/gNhGZ7+I=
X-Gm-Gg: AY/fxX4+b4yfUc/MqxwxW4f2u3HYhvMAnsFGHu6zmJ38N10zf3SEwdq/J0zSFpmwPbR
	8nj3+FyIdTEXf+K3Q9Uxx5U9q5FPBv8j2kHyoLfVQ2MlDkhiXtmfgGpxRp4jPmedueeVUfKinu+
	QbKbYR7Mx1dIq+FJrBKatKwGEnRnogFieZQDcdymOIRiZdQAEgrauc2dyVuhMw/iyQLIeT6VHYF
	+Cs7UqM7KOVntsJnLj1LmkODamqghAbHYD6kRLAvHuNE9xBlpo64LsBy59dbIvWqSj925+jhFa3
	C4CyC9mciFXNtUTrgQpBPoxo+sv4NFa+vNQIp+ul2wz+SJvvg76eklwm3YaZuyp0NRV3Dvdg0Lh
	G5O7+z+BYTayuxUjP9ppaReK5s7be3YH48lxDeeo9kWEcTkFMnBSwFuMd/bE/jwPpimaIG/WT5+
	E/5B4Yw+onupa+E/Qxue1nbLvOLwN2mGntyU05a6b62TDbe2dFHtr9+1/8L4hSqUIJGX4ig2QhB
	nm7skhyrn+5rVoPHIUEfet3iXzH
X-Google-Smtp-Source: AGHT+IEOW1WMqA9XyyxJdu/NN+RbiiVAdkX9+5SQ+X2Sm6Ndg4Ati/iuxawV+Wvcj48RXpcfvKGVGw==
X-Received: by 2002:a05:600c:c115:b0:47d:3ead:7439 with SMTP id 5b1f17b1804b1-47d3ead7574mr139091495e9.37.1767033634253;
        Mon, 29 Dec 2025 10:40:34 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:33 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 11/15] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
Date: Mon, 29 Dec 2025 19:37:52 +0100
Message-ID: <20251229184004.571837-12-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229184004.571837-1-robert.marko@sartura.hr>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
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
---
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

