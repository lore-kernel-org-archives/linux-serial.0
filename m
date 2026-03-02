Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA73624BB
	for <linux-serial@vger.kernel.org>; Mon,  2 Mar 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450539; cv=none; b=T6VYpalfedt/mAZRYrrXA8laKPYvEbHMwTHLL4ZP418KNNvTIJ9o1RP5m0xZkkvtnU2c59OVSlfttv1/Hd2lwtSFG6t6ejeJJ78G9ZjkxDQrVlxB2iN0AaRtRXbiAJz6lr3oAlzC4fduEPg0B8dDAJlBnRKL9Mcm2QX1nPn2Xf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450539; c=relaxed/simple;
	bh=5YXoza1npYaJ9tc4xJEPvhZRjZCxh9QfUM1VALrscjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZ2lcUCR0qtNPb7xVMJpUHnRtD9t2LC+Gzm6NT3BVEsCUYRdjBsAyz64NfbMC9VETvS5XZ1h3qikbhpEi78qqki590DeyGgJ4+PhDTHGuGV1uEBVopQkBwyiveaxiojMAwZVIwLEvadqB9UMGGeqO32tYChqrfJqTG2SFwywwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=lTTzIgpT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="lTTzIgpT"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso36407905e9.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Mar 2026 03:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1772450531; x=1773055331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ESgBMDji8rov6yYhnHGaS+/+l3/SjDdxdOhefVJEU4=;
        b=lTTzIgpTiNx0t+9SMh3MlGQYkXFZy15WCA27C9rEH091hqDRqfkh8C0o/9AE5HcYe/
         dDpN4OL6ea6MDTatMK5gxWagxQNrHP1qKpvK2Q/0EWHM8aYDLPheH6h8lnZfWL3q0Q6v
         LPlUAlkFznXbOzlro0zXoOl3xcBIVDgAkdk18UU/gMmwXDzAlAUsTXSWDTHDEY/5RuCD
         x9pOz/iUN59iKNG9DV54hfNS6AKu1IDBMrtgSIaA785Y7m95k2CVQMeXm37evukqRP3E
         Lm/djHE9I+YubkAcxBkHKSBhMbIvQai3cm1gyxHtbnLcpnNfmtkCwaiBrvQar4vFV2rF
         AwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450531; x=1773055331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ESgBMDji8rov6yYhnHGaS+/+l3/SjDdxdOhefVJEU4=;
        b=V3x5uPXTz3h6ZVeziTUkIZFCvNz320B6sVavVxuoY0c0Tt1nbCSFLsd2bN8c6C/R7f
         hhOXIu4j4gmdTEsfILxYvBPIcF6UVijYsLkc9gcB8O75T+MMCXcExAFQ3s17VJsgde37
         MicUncPlpbNvJeP+cu9yT937q7xAPIF8LGquTBliLTeEVq1O/NYVT6D16igznEiL63L3
         JuRWt3ExDJhU0+eECKXScn4NL639Moq2WeLdKoOdjfMPVOegfyQ6Hz9pyaFQci7O3XDu
         2Evf0X2Cr8um7gC1VpxY3ff3+ob7nDfOSiJ8vJwAT4SEaT90+LJz1SFt6o5tm7Vai6Lo
         S2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJHalP3X2pMTdIpUlkb3thVPMY6ZnKtfLYvwLHTmRUyIu3SAaneuISeIgW1KfmKLnAwwkUDlw4I5vno6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrXUg5fNbNoOCKaUGlkWOGof93mmIQ41PaajcWTeBlY0nRM9x
	JNjgrXvW10XKNornSKQhPSxEBHOAIaHU+ZN+owQe6XBtjMBnRtD44dqNZJoFuj2ImS4=
X-Gm-Gg: ATEYQzwUXfk7IiqymwJ/JsKO5OXV87QCOZgXPMluQ6dnYIAdsOLja6JQ5wZPnGTerbz
	FW/kZyI3IudHvfu7e5o59Y/qWXucCrG/nkjcIT3vOvFmC9BU14lLAAiU+30ipGj1NW1PXkFM1wN
	yDLkfSwmSjmh8F9O0oa1mneAr8UaH7iw1Rk7Ajw5+qb2xaE1rlmmCXZCIYbKpAT/eid+HL//rSw
	N4mepVWTVYVBB/rBCzU+zsqSXDjNyC2iu25eoVoE0fcqHiot2JEND+BNB9JCB7A6rOWNzoLM+S4
	3D0oFkaxJdKVbIxlxYH0MZNnamgWSLMufwBeVilt1XiC14V5Uk0Ih50MKWc7ZCsv4/FpLnfN0VA
	AMEB4/3S0ANbwQt/TWlR3xst+MrzdjaSLDCJQ3kSj0QAND9FJ9O2+8Nc4HslCS/nyYg7ZzaB2fW
	CRovcMSsPSFvybwla2yJqmuSaoDUEdmSwe1TPVByjvkHJlmb83sdSqANzV2BY43OiudbM2bjto5
	T1fLhsOpFMn6gx2tn73f7ZISHqtpkvMnD2XnFB01so=
X-Received: by 2002:a05:600c:4fc8:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-483c9beaca0mr247748075e9.19.1772450530729;
        Mon, 02 Mar 2026 03:22:10 -0800 (PST)
Received: from fedora (cpe-109-60-83-135.zg3.cable.xnet.hr. [109.60.83.135])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm292493035e9.3.2026.03.02.03.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:22:10 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 5/6] dt-bindings: arm: AT91: document EV23X71A board
Date: Mon,  2 Mar 2026 12:20:13 +0100
Message-ID: <20260302112153.464422-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302112153.464422-1-robert.marko@sartura.hr>
References: <20260302112153.464422-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip EV23X71A board is an LAN9696 based evaluation board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Acked-by from Conor
* Pick Reviewed-by from Claudiu

 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 68d306d17c2a..bf161e0950ea 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -243,6 +243,12 @@ properties:
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
2.53.0

