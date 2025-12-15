Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8EC332EC1
	for <linux-serial@vger.kernel.org>; Mon, 15 Dec 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816723; cv=none; b=NrfrYBVC7jCfso6U8fOtPRj/ypeqlOoDo+EZrgCRCwuud22fHJRdCVpsbjuhYI87jrtMKKwUNHvxpT4q0HnN70sCD9QyTkR4UFhcYVbvNCaPtL8EiTRnaTySLGUUtAjhx9/qXsb8cwTujebIsntu21O7t4GRk6h9nng9TiFeCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816723; c=relaxed/simple;
	bh=KckEDwOpPTvVDuV6vEp85iQKEd6lVbIzeIrpO820OvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHI9Z7uh2chPuKzrsY6DsboJDLSsdiLzyJAv5D0x/ciF8PoBnNas+eUOp5BTqf/eHWM0nOW3omY4cjD97frcIP7sYsr9amPiMh8JApVS+NJGIHKV2VUBCSGh6V7gbEkYo/mn3rbMbBbJ6ERNqQ+EhhS9ycnTmvQvaZQz7i6o7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=v+T8RzjO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="v+T8RzjO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a1c28778so41698875e9.3
        for <linux-serial@vger.kernel.org>; Mon, 15 Dec 2025 08:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816717; x=1766421517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Glxh1+4wMOAEOdPMYe7TVA1/ll/sUwlQUZ1Z0+HONCM=;
        b=v+T8RzjODpQ2o7XMuoOGoo26SSMjx6obFhRx1WllniiTrhMuXJbcM//TfBZBcR/Ka/
         g+hDI8INtxekK1pvWAzhJ8ObK2Ja2zlYBIAtc11s2rFb9C2fvjzrSJQGl1ECLR1/c+ju
         ETmZ6hzDDCNv5aOrlTLwjlSTw5hurjSZRkI8/NxGcEo3hJPzHVk6amLwpNldSF9xjiu1
         zgahaIHce3vgT3My/TcIxJDCjVgozsuUB0rRsyTh9ocDsVFWmEgc2S/eT4pKaNeFpNos
         vFJjsEduyB0oLFdK4zLfbFY2OSLX7gBayxbx9cJs9PYlEin87d24+LCvdrMg0q6a+eZw
         Rdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816717; x=1766421517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Glxh1+4wMOAEOdPMYe7TVA1/ll/sUwlQUZ1Z0+HONCM=;
        b=N9GvasL8PYXOXNCIj3Xe3sNSm4TS78Fv/uToyRwwo5EFaUPWsVIlmSnizxGIO0zDNJ
         5a1gLclhidOjhiT0HgA8foxCnEvbsBER6gOU/v0f6XiXKEJEakk720htHKWyYfPg9KD/
         QF9MvRP/fZKLjtijSU1U3E3d0VNtb850bcCOTbshmPclorK17loXC30TH//Bo+S/bOvc
         UiETW/UiM4FxGeINVwXvn/9f6bdghkttmmzXUV91tVQ2sqTAGHGZSlfUapAC8EyuISCp
         u5T/gGevlRB+DcNjliWgxOK19dqwBk9qo6xsQQSrjcSVmIKfusw7NQ2lU1qjVPYk9fZI
         37sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+44pMq7PJGqnnKdtJFGIL8XIRcmjI9YzN1YxXVufebVF1Njdc6OXFHaL2Cg89xtxevXViCVcnj6F4jHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrEhUZUv0OvPMT9CdcF04hkvSurwW8/fA/5CaY23zub2KaShBO
	V1Dwg9MT05dUW/w4y1hjVC8BXKLd7JiA/HhMezgR7QUX0vHLSG+wRIgCGrx13ZmRLm0=
X-Gm-Gg: AY/fxX5jcMcHMMGjnRVaqjbuY9FfVlxWuB/S6TbOvlzzKosuRx4gc/g1HkJMQezWwRE
	JJqEmXjmZ3uJgjafuV4/coOF5Uh/PnFqqIWunA7pLrvpySgftbUGd8lyuj3W49iJ4A1K0Q1D8Xj
	GGbOCSXFWcon+u4r8oD3zAvkxx07pmU+/qALHiOcm5LVWpgvT7A0zNG2OFZxvrb3Fc/Ckr2/W1f
	8rwwD4PqNsKjASUr8Ar6L8ntbtfARyEXlaYcATZ0K9VFhkIu9E3N9rKmiAaKhfm+M7RfjN62raA
	1ubTrJzpHnwpwBZ9lGuw4gUJjs47+z39XwPtS2+Yr6e6Yoa4ycYFUViYJ7cRHqncbakHLQfaDxU
	910EhetbXk6cA3uJUSFSGpPt62R165FaICXGBYydoOsN59bYb0Me6aB+I/pRyPBdRvY6ReBxGYb
	WkI464Ds8zcesFMv/DDzvd+Z5ezhfEtfiL0uyuPrxdpTAa
X-Google-Smtp-Source: AGHT+IET494SX2l9gCFBDAsNgva9GdCaocHF5w6Fqopjo065ROPc9sjb2/YbJQBUdoy8LPQteXLhmg==
X-Received: by 2002:a05:600c:a31a:b0:47a:9165:efc4 with SMTP id 5b1f17b1804b1-47a9165f157mr97992715e9.33.1765816716425;
        Mon, 15 Dec 2025 08:38:36 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:36 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com,
	Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com,
	tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com,
	kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org,
	mwalle@kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 04/19] dt-bindings: arm: move AT91 to generic Microchip binding
Date: Mon, 15 Dec 2025 17:35:21 +0100
Message-ID: <20251215163820.1584926-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215163820.1584926-1-robert.marko@sartura.hr>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new binding file named microchip.yaml, to which all Microchip
based devices will be moved to.

Start by moving AT91, next will be SparX-5.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../bindings/arm/{atmel-at91.yaml => microchip.yaml}       | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/arm/{atmel-at91.yaml => microchip.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/microchip.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/arm/atmel-at91.yaml
rename to Documentation/devicetree/bindings/arm/microchip.yaml
index 88edca9b84d2..3c76f5b585fc 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/microchip.yaml
@@ -1,19 +1,16 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/atmel-at91.yaml#
+$id: http://devicetree.org/schemas/arm/microchip.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Atmel AT91.
+title: Microchip platforms
 
 maintainers:
   - Alexandre Belloni <alexandre.belloni@bootlin.com>
   - Claudiu Beznea <claudiu.beznea@microchip.com>
   - Nicolas Ferre <nicolas.ferre@microchip.com>
 
-description: |
-  Boards with a SoC of the Atmel AT91 or SMART family shall have the following
-
 properties:
   $nodename:
     const: '/'
-- 
2.52.0

