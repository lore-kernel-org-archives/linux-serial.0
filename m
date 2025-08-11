Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33D18EB0
	for <linux-serial@vger.kernel.org>; Mon, 11 Aug 2025 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925489; cv=none; b=gzU3/EIHOvlw1iaxXZPefayBts9h/LXMcftoVQeM8H1NYsF/Fm5xFoBGVl1j0BbopFNXlN3XOY+oyfrmm/K2LVTqCKVks8pHRxgxHpEIPwsQ3gBKBlHqZitsG7VvgGrqE0yVJkc4TmNoxeSbTmscOqp3d8jyTOuKNUSMxy8nTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925489; c=relaxed/simple;
	bh=YvWvllehKsY0eU8l/4yDh9aRcQewZPW2zyG86okcjvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/Qeejf4TTriSiVSy+tRHvPqB3EYCunstVOXVk/eNcCBjwxESEHFkvfStTy5MVlRDziOIa9B/IQRpwWOvUI3bAvzIByBCvd25ZitJ3vWnSJkj+faDsL3+wion8Bintdwv2lZkEoUL8/xJLz6MDH7SzFw0Butnw2NMAU3tG+PKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DMqv0+yo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DMqv0+yo"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso6598484a12.0
        for <linux-serial@vger.kernel.org>; Mon, 11 Aug 2025 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754925486; x=1755530286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zhh5zaRs2oIpYFCywf4aV1Gc4V+uvx/WgvPXoTIlm1k=;
        b=DMqv0+yobTAyM91z4NzN/4oh2hr/MAe7td/gR0I4zmjGfVpdx15GBl7cbemZexMUjU
         3wgobkmvDin6LXVZrIO7BYdbkh5G0QpioJJ+RThHorYkjCZirZ9phowRd8UkLV038sdG
         EM9SE82p1Hv+PwnNbTZw9xInsSR5Gz1aibVjzriem6zLdax4wm6akVZhBmSftmd1xLLL
         XsF2d0P+3CjuEWf2cuogzfT3XZ57FpC/kMwTFUzdcMckqafggJ7hLo80rssrn9QPyejN
         DzkRUL0r3Bu0BBTxTDG0u5Mk/N4CdubSXWzXSe8GVDeYNNlm2j4JDpIneNLVd27PU/4a
         MkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925486; x=1755530286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zhh5zaRs2oIpYFCywf4aV1Gc4V+uvx/WgvPXoTIlm1k=;
        b=eMJf5aujtEaMkCnRLchXCdiNZA0nPQVi/4kqiMvLPwy6ky9d4gT+cVG/VYQGTaVTFW
         Aib6LAZPezyf1uJ++6lJn6d4XM8lq2TpXCpGzqnBjUNfDDgiwH9Qizi1xb8eSnDsI2C/
         Kht+tlYPtZEH39YXiDh5F553nDlwKfqwUhybct1uvwTxpgnSBPI/JUgPD7wek8RwhOAM
         kQTmywEVmLoY8VTA0lSYJFEkJg8re3khLd8D4IIfmxSROoBA0oNqALiJUnwdizoNFb+9
         yfkMdn2AtJ/ecmq7Lqu83tehenwkS5ZhC8vqKlIbDDz3hrvuoa41QreAUu5gjHsiDq9n
         A3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWAS/Lq/3BcGHCJBb4ol9dAd7gD3M7tmPxhX7Xzdj9omeZjxKv9ikYYFIXoAOEcH6sTLQJrR+BkUzMtZEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZD5TmHqy7LezucC8UPj+SCsWXERrP7zqwo9AuSp3+VHgD2ip
	cHzr8Lr6d1MhGP+WHlFQB17Jy1flEObYhdbkoKra0+Z9NS/59yhRwF/TfWkA8wgBCkQ=
X-Gm-Gg: ASbGnctBbbPh7Wt21fkoIgoZhz86ia+I/cakXaYInAwQ9yMxwAeGfv9naRHKg40OJge
	8iaizEsNPUoePYDoBvdRwoEH93c7FbHoQbAxuil/0IAyNEtRd7xi+M6SwA9qAHPLHB+NX5BVWs2
	IPLVxqxW2X1+mpJvqWBZIKfG9IpjNSByMZt4Qllr8+JQNnb78/F5La6z+gh0Y8ytMfjcYv+fcdy
	UyNHlWJNRvaXZZncrXviRqOQJduLyfU3sQPv9S5JQ1gNTG7i+USxFjZhNVCA6BY2jRU8UqtUtIC
	30M5fl+T6j4H42JWj7y4jkXjLP0Dl9W7wujhCKw6664NK//bfAgeFZAfV5bppfmZoKR6yPYl2aJ
	18F6OImzFlnPVvzZggmH5C4rZiVlJ0DsSwlQ3oj/XcP6t1NfnAksJQ3uf0Rikl7qUuA==
X-Google-Smtp-Source: AGHT+IGNa3UAEq/Ce3/sswcy3A+j3yXj3Hu9QHzagv2xAwHzDuZRAXkuzsWUlKzyxvuIXzuGjI7OUQ==
X-Received: by 2002:a17:906:9f85:b0:ade:43e8:8fa4 with SMTP id a640c23a62f3a-af9c6373614mr1374008766b.18.1754925486344;
        Mon, 11 Aug 2025 08:18:06 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a07659dsm2020105866b.21.2025.08.11.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:18:06 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 2/6] dt-bindings: serial: Add clock-frequency property as an alternative to clocks
Date: Mon, 11 Aug 2025 17:19:46 +0200
Message-ID: <419658ce1a1009c6f8b7af22a02b278cd695dab0.1754924348.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1754924348.git.andrea.porta@suse.com>
References: <cover.1754924348.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UARTA controller on BCM2712 connected to Bluetooth chip does not
mandiatorily ask for a clock connected to the high speed baud generator.
This is, in fact, an optional clock in the driver.

As an alternative, the call to uart_read_port_properties() ensures that
just a simple 'clock-frequency' property can be specified for the clock
value.

Amend the bindings to allow to either specify clocks or clock-frequency.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../bindings/serial/brcm,bcm7271-uart.yaml    | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
index 89c462653e2d..96697b1428bd 100644
--- a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
@@ -40,7 +40,15 @@ properties:
           - const: dma_tx
           - const: dma_intr2
 
+  clock-frequency:
+    description:
+      The input clock frequency for the UART, Either this or clocks must be
+      specified.
+
   clocks:
+    description:
+      High speed baud rate clock. Either this or clock-frequency must be
+      specified.
     minItems: 1
 
   clock-names:
@@ -61,11 +69,18 @@ required:
   - compatible
   - reg
   - reg-names
-  - clocks
-  - clock-names
   - interrupts
   - interrupt-names
 
+oneOf:
+  - allOf:
+      - required:
+          - clocks
+      - required:
+          - clock-names
+  - required:
+      - clock-frequency
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.3

