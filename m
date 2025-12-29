Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4333B6C4
	for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033636; cv=none; b=XKP2PSnrU1YtcS4POFGa1LRJKpBKReT+zBRYo73dtZXqzsik2tHmt7ZijUl/5IfjoJpeMJvQuIemRZ4I7V7r+IrvQjk+ajakkuf2V6Zs9GevHuKWWVH41GUyMIA2szBzhQg0ZedmRh3PhNFuMaRIwDXOgT0vAN28RNN+/xB+GgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033636; c=relaxed/simple;
	bh=omWUVkHfDgWK8/wVYsqR1gmKx3uRcWW/S7wsFlqvQZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSm5aG1M65CIF2TglJviYynsxC74UwOzPEl6bMuJTtAWvBUVskx8/ty87HlVj/SQfogj1P4dmAUyZ8vmEq7sJhCnNo5oe/b5XlRU1u36/IE/WaCcYuiDnEEa/fJGV5RTYM+DpCKAvizMncApiyRNgOamQTqYSsk74eYjIQ1g9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=js20qBKl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="js20qBKl"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so22431275e9.3
        for <linux-serial@vger.kernel.org>; Mon, 29 Dec 2025 10:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033632; x=1767638432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe7/bfwW61qpTH+JIS3AKR1VkqKbIoFXot2V67cYu6g=;
        b=js20qBKlOIc8p7LAg3ojQzBrDVa9hnJ3iwdqCsfn32yFz3aInQM6QoNK5N/ROzBK2F
         7GGCtwcKHJrg81RR8yBIoLsUREQkvIHNvhSZ1Uyooa1SkWmuCNLxf1fM7yTIF/tSA5xd
         VFlGqY3EMA41aCFoQleCr+F/kX/Bxmhq53oqbmeTatA6OX82TeqOt3nsr2uNqBEqrl0k
         nBsY0OfjmzG0AqlPzNx6ENwwoGPvY0sYVSF5LPWB3Vob0xzKohW7DvCBZ7tTFFYgAJ6C
         HU5bjhYy+qoTsm16Nc5dGsdDMwZMnkSPDCi/zwej+DFJ6pcf+YNfvG9ROfUQuUhCz1pP
         LuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033632; x=1767638432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pe7/bfwW61qpTH+JIS3AKR1VkqKbIoFXot2V67cYu6g=;
        b=jyFd/YhAxKT9+IRwD6A/6fQmnoppZo4M2gjv+UqLg+g1LwXWSFGbXb3ojpbwE7BQNb
         Q4wtqXQ9fkDmM07Qw55fzCEgEitm7Plm/5UGl4Ib2JYDTHOsb0QBmoBAcgxlc+dUV7uV
         DSb2ctER90padud0+uPobtBOr2RwVTX0lbP9IzRbJWZaEHvvlLeCtHWWq5Z2oHAFWuYu
         YrOtgC8aZIZDGUfLHl0LS1ES6ZJ/HUum1VnCDA7vQCd743UhJHLkvn3XXtU5fwo1MWAd
         Bmk+pdqfvtulf+28iJIVm3gZ9dlVo1mOgGSsf1FjnjdJZKbBeB914wdV3GakDYEvQuZZ
         8T/g==
X-Forwarded-Encrypted: i=1; AJvYcCUONdv8L6K+ILHibqaCxrfal13HXGMwYJ1hhojqqgVSnXeA/7eYh7V8mYL/3oplInJMtv0iRdQyknqSp98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkixJ5Xj8nTikSAANFU7wND0TrNXbalKZ9Gm5d7hNAgS5efg0+
	KtXNXEWMS+ZNlzfNraf6cgYWvcyhSPXO5b49OdK5qJz2XKLxMa697kgr3MxtHFYnCzE=
X-Gm-Gg: AY/fxX4GfqfWrtC1vmvcw9NGD/KDsSJWDhcRlLJapCo5vCMiuJXyxdHACsJzGQ7Q+eQ
	Gph5TQUX7RvCYFuCsThvejutDl++7Ru9VVlaLiT981lu9vzl7l+PvKO0KDUh+SONF2O8GrwoQjM
	NvSdo702pR3cJIBHbw/Gpithhvq52PGEbaUmKvbyxxokfUEzSKVpF6picyOMd6p76iRPIFOlWAH
	skh2HpaOtiC24Pbs8WGIlQ7RRO6BUd2CXIYoXsATwkKrQoQKfvjSXP9h90GIBnaNe78vpgOAV7M
	BwtFSxNxSvygQP9ZEWiAuDE7QxSPXu7BgFMC2fX+Qs+3Doo1vhPXz2TphgWF/MoHAJcQSBduNMx
	Zw47XAJyZ1H3X5tWFRg0HhFY8EVmaWYTaKXvRM5y6OFRSqaLcsFvd9tBbJJnEbyiO/eJwUQQyxO
	HRnbfcv3QfzUM3wiB4wxCPl3DPZ0XPpMCea0hrDViZp4SMN03iOr5AwrF6LhU3wqBdsLnefJRHo
	ZnnVScL1LRIwMPErB7q0EDoBSpF
X-Google-Smtp-Source: AGHT+IHMeEPdVuxCEsr3HbzwXW9O9zK0z+wZ0vfJLANR2lbSoc703JFfFuycpKgytpooUs272ghcDw==
X-Received: by 2002:a05:600d:108:20b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-47d1c038664mr255232695e9.28.1767033632356;
        Mon, 29 Dec 2025 10:40:32 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:32 -0800 (PST)
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
Subject: [PATCH v4 10/15] dt-bindings: net: mscc-miim: add microchip,lan9691-miim
Date: Mon, 29 Dec 2025 19:37:51 +0100
Message-ID: <20251229184004.571837-11-robert.marko@sartura.hr>
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

Document Microchip LAN969x MIIM compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/net/mscc,miim.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mscc,miim.yaml b/Documentation/devicetree/bindings/net/mscc,miim.yaml
index 792f26b06b06..2207b33aee76 100644
--- a/Documentation/devicetree/bindings/net/mscc,miim.yaml
+++ b/Documentation/devicetree/bindings/net/mscc,miim.yaml
@@ -14,9 +14,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - mscc,ocelot-miim
-      - microchip,lan966x-miim
+    oneOf:
+      - enum:
+          - mscc,ocelot-miim
+          - microchip,lan966x-miim
+      - items:
+          - enum:
+              - microchip,lan9691-miim
+          - const: mscc,ocelot-miim
 
   "#address-cells":
     const: 1
-- 
2.52.0

