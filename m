Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5968D41166E
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435810; cv=none; b=CMfX3R45AhW/BPEMFj6EVKu74k9O1IdBwxPGHgaq5o50WCbhLC3t1BT1kXuzV429emj6j8j0yesP3LG97VOrgvwlDZ749N6N3so9YrXWJWl3PPe+5iDc33ss4TGbnZcRvbMTuu2X5LtrXNGNVK3RojoEeTiv/xNl1NzxDigYJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435810; c=relaxed/simple;
	bh=jbgbQxiggxyOWFNcof9c06sLtRb8Ukd/sZvwJ1H9sBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDMMhnVDdfzfmLuL1UfgWE+CrLfem25qLkaoYldgB2x1qbuPywXZWjullUujL6iqRSGh2nHvHmM0MDRLYtdiWM5JC2+VMxcn9YaJ8csX9/B3zvya1YiZmi8cYlQq1nUNCnQhHzzzz++tKIzUW/MVjWdsFrxLiyqHyN6Z1JUEHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bas4mpym; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bas4mpym"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so24611865e9.2
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786435806; x=1787040606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72tHxGeDmqo/wIaZhKN/J6u0CHloZDvItpIiDg7V9Wg=;
        b=Bas4mpym4X4Eo1xCQrWMiWheFeWRHbit4rDqWv1mBOK+kMd2fmqDBrKO/5okDRqaap
         NV0THx9zsNcLU04hDeFlASJ/6YJD4stRhfoGVa0lhe9J3Yg8u7C68v2KYOTLBhBXezV+
         TyNXz9jXHG37C0Gdlb5oMZlfqgbFLM3JnQxQ8UscBhhZ9CPkd9/GaoC55hYyTr9BFF/o
         DmqGvIUO1ddeoicGCNIRIqoQOPDNYXryns3SU2ux4SzwY50+UyXJldYmd17NGY7YPGvy
         7R1b5vvQ0X8/AF/0MIVWes5lw5xN7upCrLgTD6MU8EiRGCCee8Xn79QR6UH8Jk88mi2Y
         wpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786435806; x=1787040606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=72tHxGeDmqo/wIaZhKN/J6u0CHloZDvItpIiDg7V9Wg=;
        b=BTD7YlqRZuI0vNTrf7+FSB44ypJ7HaFiYMVvTVkxPUAgJUhTwdYeBtm1mjpoECX1I3
         n5u7rWrtGmAzbb72ML/eAtyd26iPFVt6yEsLzh+YnNLnWnYSAPZbtZv//K8/MCG71vRy
         jWEjOLYBwmSK+kXh6b62wWHxGa17FjkN81LyE3fcyXl4AtPFqlHSN0ph2E1H64YeT2Dj
         QlUzvONAeAiJuWdzZItOBAHX8HyQUJrBUBLhDcvyRz+YFKsuu1xQJbH4BTHtOJv70ZHq
         kiHCZ+YLjejEyxQcDSBUIB6nAx5IHO8dE4MpTlGxKzBnatPUTdSpcaab0W4qqkBV04+/
         Xrpg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4lDa5uOoIr3U7GUlP+j5G6C4x8cCPZOXi5JC6LKDiA2KQAULeMsp1XC6swGHA5cCooQ8labLhk4KgGN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGbFqaFU2dqjmYoX3WR+vdz0Wey6ken3oDKzlKe3EaSEgAW/IW
	It2VtARlmxTpE4vSxRx/a4HGx7ct/xj8KsS5bnaMs3ixwsy+wncJoOVP
X-Gm-Gg: AR+sD10o+3D+qDxdKknh4OZRWgnl17AUmwl5boB66DK0MX2LOx1Keu+8VmqdDdBAIob
	fDPeh45XMM9EB+V8NMl3m7jb+Z6R7p4wVnYf54kem58MSjsQaT3w6XZX4GO3Owdz0uwMtz5SASq
	HuBuMU6QKks2NzBpHsIPS4uTIZYqOj+CJ1a89q/WbWcVWf0swXcIguq3tWH6uTMIh+16eSB8hyv
	hNG+sDOMLc2bsIneHl1RYtWAsE86pknBDg+NpowI2UpjuAXNdhoJPw+bmKvAwHaSTdR5NzfgXfJ
	1mxbT5WhNBqsGgMizfN8tI4bAhA/rWOsCgXaJXlYVaz9nOzBk5WTR/NrZ8zoTjRAB1jn1XIBNvP
	EuMrPpnpQlEI/Ic6R2u7AFcurtOqpFpH11tGkDxjwkA8ceIvjqjApggt7H1L4ZkxORYTDMi/Nfz
	w1oawmP/l92UZPmUq6E2S3X1VmX4OlcjbyM3Q69We1kMi+E1CnFit6nvFcwEV1nHD+Axur8MJK8
	3JGqJlWWkJWcJyYXjhjI2rtTOWfThp4P+7GsDIMkO4rjz2P
X-Received: by 2002:a05:600c:c162:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-4997845f3e7mr23581055e9.9.1786435805464;
        Tue, 11 Aug 2026 01:10:05 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49977df9489sm45336675e9.1.2026.08.11.01.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:10:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Christian Marangi <ansuelsmth@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gerhard Engleder <eg@keba.com>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 2/3] dt-bindings: serial: 8250: Add Airoha compatibles
Date: Tue, 11 Aug 2026 10:09:47 +0200
Message-ID: <20260811080950.664379-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811080950.664379-1-ansuelsmth@gmail.com>
References: <20260811080950.664379-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Larsson <benjamin.larsson@genexis.eu>

The Airoha SoC family have a mostly 16550-compatible UART and High-Speed
UART hardware with the exception of custom baud rate settings register.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 039bd392f876..9a3f596f8a0e 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -105,6 +105,8 @@ properties:
           - ns16550
           - ns16550a
           - ns16850
+          - airoha,an7581-hsuart
+          - airoha,en7523-uart
           - aspeed,ast2400-vuart
           - aspeed,ast2500-vuart
           - intel,xscale-uart
@@ -113,6 +115,9 @@ properties:
           - nuvoton,wpcm450-uart
           - nvidia,tegra20-uart
           - nxp,lpc3220-uart
+      - items:
+          - const: airoha,an7581-uart
+          - const: airoha,en7523-uart
       - items:
           - enum:
               - exar,xr16l2552
-- 
2.53.0

