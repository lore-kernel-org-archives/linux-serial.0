Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F03DE429
	for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803064; cv=none; b=VyaxM8IUaMlLsySB/yk3GDFLulpn9ay4YkjlmS4J8SX3ywfZKQ+yAvfy5qMm7wTdTaV2UMA4QllJp5quoguKyZGwuJbvucyWS7dmfmpnOLXl09Cc/0wsvPdp+P930P1XVTb7tuDq7AlA/6LNZKgf9v+EpzUITI2Z4R/F/bMO9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803064; c=relaxed/simple;
	bh=CEUKetRzVzn2Xnwq6XKvSjU6QTqMzQIFYZ7UZd5Gyq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CDk9w5cBSVoFj7xrYp57G4+dHHfNnLIWz4jH9Tba3irLp9d+KyA5kxqFPTpzDyDDFVcm6qhxw0am2ue0HGJxhHzNWVmvWbzyMgBAmLbqXSKugZhtc1xaBDhkO1tYijEYtkVzCT7rfXegFIvzzJByjsG5V2UP6MhkACaGRl0L290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDW+8n8p; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDW+8n8p"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488d2079582so54612335e9.2
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776803060; x=1777407860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBJ+hPnmdJzo3k/g70RHgYIGur+PsmZcEVdmZLkZuHg=;
        b=UDW+8n8pZKTy5M5Mw+TRx1ngXKrAGqxdOSYQn1ZwnieZ2rvZbKWcAdbJPTCQfxB020
         a+4vBlN4fEjR5B2DgDAA1iE2iH/9VnBD1+WXvgBwNGYCk7O194R8a5Iiw2Aoxnw8yMaP
         Ut13+07HlQk0JrDv2C5pB0Iwahq+NSQkpL1kFXrPvC7ceg/0ixpYzbSWPHqVPraZdKuH
         JLLqLVMNjCJZ/Q5re94H134pb8MBLanOLMT873G0lTpebfxjttSI4yljyFEEP/wpDr1J
         I+tunIrVPdl4PoFxCascWS0R+B8PDValGagLQWOyAiijEhJqWgQIYLcCITryAquLfwp3
         Eqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803060; x=1777407860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EBJ+hPnmdJzo3k/g70RHgYIGur+PsmZcEVdmZLkZuHg=;
        b=f/nlMORCx56zawFH8zq171HdDi5mLV4MozTZQM/TwQ64hb2+t3oG2OvNhW0SoiFniY
         3GhQF9MaL9DoYM5J6xgkS37bnQMN4dzaKSACD8MSdJYI7mDZb0dinM6n3ECjEsJtiu4Y
         2n3ZLVLdWabYfTjFwmaBMsyYLx+7UtuRpR9KOlEvcJcgE9ZCpm1xBr+ZBPJ/7nQlS14b
         vyAbbdP2fpHZJYtVoOfLvWV2WyGnwy4IrHjQc+G3lZy8GXoFVGfRWPuZ9ilacZWpQbIk
         lC+kLSc7Ll6cx0mnvliGOHxy0yI/h7D/zMCH3AHi9BxfR+mXSEwWsXKujBP3dzSZOiI9
         bk6g==
X-Forwarded-Encrypted: i=1; AFNElJ+AneuQKBGxm8tDi59IieT5wWSY1kLTDXZzsDTBqgolng1WEFagRCFDSRCvimftof/jh+r1dqg260I3uDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOFjtHAWo1l6WyN0aalqCIaSX26UW+eHfhUxJvcC06ONHasroa
	+nlXt34TM/0I50Y6a7xfQFvMIHlZDkg68B85thmE75kADW2IBEv+9SYe
X-Gm-Gg: AeBDievamTtJCeRVX+gdglC7uqAwZ1PF6EHuOlUy4EOREl4SWyr272MxcQNU4t1wlzK
	e+KatWM6x8j6K0dPlkXJdM3JlgYMgERGlgRauCP6NJ8QVLbkAvIkVcGQ12j2hxjbYR7AGVBAUW+
	Dft+qiMRXeEDl1/rr202muASHI1ZkqrE1FtlXplIMqaQr9onjyAdS7OeGQ2Ql+fzdWSUrkJoypc
	XI2JA6LRyiUzXvImQWUJFjZ+hsCvwEL26t2MdyK4nXcnzKv1EEl2TYiAA3llM5ezHu+37l6hTKA
	oP0QBIBaeRY1rHH6Wl5wfAJO9lQeb5yjoiQKdXRaQc8FpRmBPyy+OZLlYxDf83sUNFto9KYcRNC
	2z/sIeUIC97nG2J+UhCyX++V9aK/iq3iKbtBDuOJ/5cUE//K9IB3xzsajZ0SQQfEMJM1j1juyf8
	NtWfUNLzWArFMRNUHwAsC90CGXlhFBLgxghE9veTiMmQST
X-Received: by 2002:a05:600c:308a:b0:489:6c22:e081 with SMTP id 5b1f17b1804b1-4896c22e217mr83386305e9.0.1776803060488;
        Tue, 21 Apr 2026 13:24:20 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm655989805e9.3.2026.04.21.13.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:24:20 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Tue, 21 Apr 2026 23:23:13 +0300
Subject: [PATCH v5 5/8] ARM: dts: Add an armv7 timer for zx297520v3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-send-v5-5-ace038e63515@gmail.com>
References: <20260421-send-v5-0-ace038e63515@gmail.com>
In-Reply-To: <20260421-send-v5-0-ace038e63515@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 soc@lists.linux.dev, linux-serial@vger.kernel.org, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2135;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=CEUKetRzVzn2Xnwq6XKvSjU6QTqMzQIFYZ7UZd5Gyq8=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp59zXF6GMMLpNkq4WwPjAfftYcRTaZJtkuzLOe
 KXRFnrgIfeJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaefc1xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiK8xhAAldsqjYe8+3h/X86yla+u17rfI//QK+v
 +A4g3kwBFOtoQ4YkoXtFlmKNU60WhO3ldAyJruXz0oONJCiUGJVhQdevJ6gJgTGtbFxWrFd62OG
 TpeCV0pwDt69klMWhqnis/g8QTr1XydLXrExyn59UcGmkzMiT+namcriwxgM7xXxZKeDxQ9w6S/
 A9+oVVuDBIfCc7ZwisT03KEmHMnhWy/mTY/9Ggzwgu23EHu63ztG+sePZ/nAI5Vqml31qmTpgox
 18zynyLmwOSAvGMPGpnfI3bq2ldQwf+JsbyS1qRvI/lNXPTEG1AgIIlXgX0qF2r4ZRtV5GqByR0
 QZzbBYy7jO4f6n3dEE/T+hrPGJpdv8edlkFOYbEv3Pu3+2tmCIa6dup5VjLjkLMS89ERRnvvW62
 c7eWCocyYyWgow/ptUwWJ5NLIhY4XsYe67F35wFukL0irgRrfDYLaKVYNS90fEPjULHLhpYpgSn
 wwnlChwvKoS9BJLqY8a3cJszrQdI03ujbootk6HZVjuE15Jx7a/P470qo6sviolSF+rmWsA0iuG
 7qWOhsm2ToVSrk5f47Fm0rI56oD9QDQLiJFXq2IIDYNSIol8ez7QWvqlvfiPZKeCHNVVGMQYcCt
 fEy9cxesmM3Pq2mT5aNKIPDB79epR6RVMymRSpe3VxKmldcfrKLU=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

The stock kernel does not use this timer, but it seems to work fine. The
board has other board-specific timers that would need a driver and I see
no reason to bother with them since the arm standard timer works.

The caveat is the non-standard GIC setup needed to handle the timer's
level-low PPI. This is the responsibility of the boot loader and
documented in Documentation/arch/arm/zte/zx297520v3.rst.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---
 arch/arm/boot/dts/zte/zx297520v3.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/zte/zx297520v3.dtsi b/arch/arm/boot/dts/zte/zx297520v3.dtsi
index 0fff00f910d6..903050c684cb 100644
--- a/arch/arm/boot/dts/zte/zx297520v3.dtsi
+++ b/arch/arm/boot/dts/zte/zx297520v3.dtsi
@@ -20,6 +20,21 @@ cpu@0 {
 		};
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		clock-frequency = <26000000>;
+		interrupt-parent = <&gic>;
+		/* I don't think uboot sets CNTVOFF and the stock kernel doesn't use the
+		 * arm timer at all. Since this is a single CPU system I don't think it
+		 * really matters that the offset is random though.
+		 */
+		arm,cpu-registers-not-fw-configured;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -27,6 +42,15 @@ soc {
 		interrupt-parent = <&gic>;
 		ranges;
 
+		/* The GIC has a non-standard way of configuring ints between level-low/level
+		 * high or rising edge/falling edge at 0xf2202070 and onwards. See AP_INT_MODE_BASE
+		 * and AP_PPI_MODE_REG in the ZTE kernel, although the offsets in the kernel source
+		 * seem wrong.
+		 *
+		 * Everything defaults to active-high/rising edge, but the timer is active-low. We
+		 * currently rely on the boot loader to change timer IRQs to active-low for us for
+		 * now.
+		 */
 		gic: interrupt-controller@f2000000 {
 			compatible = "arm,gic-v3";
 			interrupt-controller;

-- 
2.53.0

