Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F943590B2
	for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521306; cv=none; b=ncCd3ZCuwwfq1O0wbwhALUZ9Tq0gn3wTMoI2j0RMIAqY6ferdRC4D7Ueh1viiYZ3bil2/5rkEhuzWSSltdlD5y3y5tnfR2hEOIhNE0EcIuYPJEibWmDN5B2ajmf9gTPrDD5MCEWkRePQbu17eA2r3us7q5LlbqKwZ9lYyKzsjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521306; c=relaxed/simple;
	bh=XoF0Eovrxm1txLTrLfP7MB7ayo4/Y25gdep/95xkk5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU2IzPNR7ZbDuTKXj6cy1fZtBDxHHe2JJySBYfBndPzdyp646QjELWbhL2nTCuvV62ixUW3Oj1Q7myRqAQlIdqDZPkLHzdYQhdw7aYd61H207ZlPxPskonenMryRDY0+pXemudZ4VDdMghafuQ6YQKBEk/xKnSetgkbtEKqpdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=tqNu0iNX; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="tqNu0iNX"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so6113104b3a.1
        for <linux-serial@vger.kernel.org>; Tue, 23 Dec 2025 12:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521304; x=1767126104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfMU7MT4/V4GUajmsYnn75DFErJTnupop06HbanZvHw=;
        b=tqNu0iNX/T8f4ZQ0j/Yobjqpzb43xMAQ24m5BfCOWvdzq3IHmLjeqTBOAgIiE7d5S2
         N5fBPe5y3gl9uLYGhAi4647HW/5fN5LATqcvMhv8qLSObvDo519o4bPtPTd0HcrOtJNL
         +yrIM8SMF0AMAun4zHRZJCoFTQvESD1JZ71NTG7XBB+JBmw6GT/ko8ZiqfMcvI7AT3/T
         fYOEil8UzahtCc/HfhugBjuEHq4Pcujmr1Visr30t0FPiD0JQG5z8cnjJpuD0T4CGuh4
         AzOo/BgdB+0KcAyjo3REQrPASQFRboUdXtpZEUsvwTEelTK2a6yQ1+FXxnZACDRLKtDD
         LFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521304; x=1767126104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfMU7MT4/V4GUajmsYnn75DFErJTnupop06HbanZvHw=;
        b=eeK/wx8Q452nJv/wAWpDfiv5EW+YkJXtPWuBAAXAkM8sSANI1wnD0xAAZdXJIN8XAp
         DLj6zlXMc6Ot3i26cBXoMsGKRCgDKfB4RD2zRAQqWftKc2/KNesVE2jrIPEOzSeQRoUT
         to9VgZEAwofw7w2sedcrs0kvB88axtcz0vcFQtt9vDDRocDhQIKtGbpnm9uT2Qk8O1Zf
         qQeTOGtl3/Kvp4l6AFU+0KN/Aljmc60fHQExS033UiSZiuw59Y+GKbY9gGP/d32EThUo
         TAx+M14aG5xCyQv+jsoKyQ8XS3cDzxRWMTHZSIAIiwbG1eAXzVJx5hs+rA3EE8IOGsYN
         rfxw==
X-Forwarded-Encrypted: i=1; AJvYcCV7GbnA2w5bRkoT88b7cjFo3bWGpVTsBRyHp8yiBUy386mUuuzKFqkKeYsyaCOG7g/SRkLMLhIpMnzD0y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2TBuAmnE0l2br/dANR2DV6pitp+PRWzvg08Pu0j618fXwheV
	4JdGDBiE9/V56A6TU4LONnTJ9DU81ZrUAodXDKC+2PZgzXosz/u5t6Ow5a1xbyN3HBQ=
X-Gm-Gg: AY/fxX5+3FW4iChqIbLT8tEf2KZLSH628sJqSaNRC7B34lXTSgAMtKC1giybKl0wiEZ
	iJOv8lMZahpUf/wdiExyyD+ODJkm6S+tw5ax0qAlDPjkzVjZHE9Wk9PJIZTnThDDZtbKaw4uf3c
	+q1gRmeDOm+k2NzfvIR4c4cpPCHgJ75Pe6kMgcyUHRohlRC5bX0Gaht9W2E50iwJ8ybA64mEwR0
	rRFHivS9FoORGFOciW2jt2aZLil7iGiXdmHpnS/355oFxbD8e8YJUCmbhvZvm9mNdlC+rtThIES
	/8/vYx9YLz1SxruRZocEf5nm1pmhBiKsB08S8/QHRV3aU4KOsOUtJhY0Kx0rZOWGkXehB2UhiFb
	+r6WNXVvIVJY7dxeaMAnQlHEF9wual2mScfg45ZTRU8Wkv9/MhCnBEpmvGHnJfO9UbG66HJzVxo
	mt1LdPH86wyk3yBPK9oiTohNh+JrHkBTKgSdqg8aQwxN1OgOQQHxHMJZPpjnwpJxE5rdyM05WZm
	Qsbc/Rd
X-Google-Smtp-Source: AGHT+IFrLV1OA+vGIt1Qeh3SInjG9m4lWsVJ7UMsa9ff7itN29HXneV9Wlv0pR5HcnrOBgJnEjlG2A==
X-Received: by 2002:a05:6a20:9392:b0:364:14f3:22a7 with SMTP id adf61e73a8af0-376a9de5935mr12020799637.42.1766521304022;
        Tue, 23 Dec 2025 12:21:44 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:21:43 -0800 (PST)
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
	mturquette@baylibre.com,
	sboyd@kernel.org,
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
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 14/15] dt-bindings: arm: AT91: document EV23X71A board
Date: Tue, 23 Dec 2025 21:16:25 +0100
Message-ID: <20251223201921.1332786-15-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223201921.1332786-1-robert.marko@sartura.hr>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip EV23X71A board is an LAN9696 based evaluation board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 3a34b7a2e8d4..b0065e2f3713 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -241,6 +241,12 @@ properties:
           - const: microchip,lan9668
           - const: microchip,lan966
 
+      - description: Microchip LAN9696 EV23X71A Evaluation Board
+        items:
+          - const: microchip,ev23x71a
+          - const: microchip,lan9696
+          - const: microchip,lan9691
+
       - description: Kontron KSwitch D10 MMT series
         items:
           - enum:
-- 
2.52.0

