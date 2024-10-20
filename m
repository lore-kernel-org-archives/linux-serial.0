Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313B82866;
	Sun, 20 Oct 2024 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729447329; cv=none; b=EO1milLngJVRGNDQii3ekfrnjWtycVx8aS4rQWi2ioIwvKtNQRmg+s1YB/xHARpky71xQpDXV2nWhzpUGrRAMPA90YtlwevQfHK2TsWzL2xK/GCqP+4rPNXcDs5MUSMbOy4OWgJjvXsOkYOsahTZEOc8QlpI0pY1/+94GP8/cos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729447329; c=relaxed/simple;
	bh=UinalwRB3ARrKgdjgwMn0So5wH2T5c7BnVVlH3YYDA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmoxHj9rqgUj9qRBMvmhQ9kVbmYuwQU3HP0hCRko5Sqdq93DJPgA3GyCYIovTvuhikGFLo/t7fJWfAYk6MJUleawrW3E0SCXZuUdjA3KYC+DVjV6XMDrD3Fu36guTI2KPnhYdPrdaXEaXmQg5UfgX7BCYQPFwgoxsz6bG+u65r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT0E4Zpe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT0E4Zpe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431616c23b5so15125675e9.0;
        Sun, 20 Oct 2024 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729447325; x=1730052125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWLz0nOfxq6+oJG5q7DR2DISAyUCoTN+vEPpZde2Mgw=;
        b=fT0E4ZpeSv95zx7qO4vqzkKadcOgb9C0BewjLG/t8Wyb3pO5R9xBsQmgZCogSTIYQs
         d2vKftYSeZgXD290iJrD0ExLooxeUFm+LuHSqor5DMlrY7pZOMTmIScaA4Ksi2Cijyf8
         2u2HxWMw5jofm3taqY+MLsQd2bEtyctxaiD4B7qqgb9rd0rGilkCtyDv/JKBETMfs9R3
         hQSou8PJuz5cHRmyS6kT+NRW/4L/wUkJLkf46XXPNrJKHod4JpCwfJV2Qenxs+K2zBSV
         XptekXU8q/6CgFvJEuEp5GsgwFN8wU0pRHma2A/a8+Ik4DQxo7u9m93ZQLB5tHmtkLsm
         l0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729447325; x=1730052125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWLz0nOfxq6+oJG5q7DR2DISAyUCoTN+vEPpZde2Mgw=;
        b=GmrIH8M4ULKNRmaw0+U68XKMqCNoEv4rzpm51TFW6/+YC3n+cxN6gb9BeLZG5lMniB
         nYsB+zOSBho83WQ8x9QeUtN8iryyf6v33qBuxP05wsh/Y//Fb9fR/3h4QfyS4BHmmu0W
         5d6E6LNktk9RgPXMYAGIe3qhEvHx9fYxb1+tI+zsArmzVVN97jJh2SghaKzHGjM/39B5
         JhBUjdRzeuPCIlDAt1noqRkGfSx+c2p1iF1Yui/pfszD5mSQYpPJ7vMXsIdwtExYP/SS
         b8xFo0pM46ZW1KsVMfrRSLx+2nLm0PA5LOx4/PP2ArfH3RYriwyCE4pmJiA+3KEX2ZZi
         gsRw==
X-Forwarded-Encrypted: i=1; AJvYcCVhsQzSIgUmzV2yDzenqZv8JgngDwLg/7SD4Dtmn1+evL9JAY/Ecn5OtT8OQWM9BUHbCbJ+qTof/AhOt1gX@vger.kernel.org, AJvYcCWZ0kwRlfY+Q77dgrBhexHOa9RLUyN35WHzmLcpqdgJwmxe4xn6TbO0vXVycjbPo0/qaQFa0FU59TwK@vger.kernel.org, AJvYcCXKngknU8sjEO6DDkiSfpCo+u0GfT/X0vsBpBrA2WMFsksnna53MWVq29yOjzzBFp/PGJBDpV4qt4GxiFho@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Ar7t7nJImdp5H/mtWcxDMK74oBWQlV6Y/q20WSgNPn42KgU2
	ikykUpopDQlpfDEFk0FLWTd4YL2o830FOMUF9GzIMo56d/ZJNBw2RuEzIRv8
X-Google-Smtp-Source: AGHT+IGOvOY1iPYyM/tgrqHIiOAkqT3mUbSYqYCANESsmcuw+Gag7BIBmkBpxgKf4XTKCqAjRE5WWg==
X-Received: by 2002:a05:600c:5110:b0:431:52da:9d89 with SMTP id 5b1f17b1804b1-4316161df7bmr51737235e9.1.1729447325484;
        Sun, 20 Oct 2024 11:02:05 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc57esm29922105e9.48.2024.10.20.11.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 11:02:05 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: serial: samsung: Add samsung,exynos8895-uart compatible
Date: Sun, 20 Oct 2024 21:02:00 +0300
Message-ID: <20241020180201.376151-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241020180201.376151-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241020180201.376151-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated samsung,exynos8895-uart compatible to the dt-schema for
representing uart of the Exynos8895 SoC.

Like GS101, it has a required DT property samsung,uart-fifosize, but
it does not exhibit the 32 bit register access limit.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../bindings/serial/samsung_uart.yaml           | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 788c80e47..2491b6048 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -27,6 +27,7 @@ properties:
           - samsung,exynos4210-uart
           - samsung,exynos5433-uart
           - samsung,exynos850-uart
+          - samsung,exynos8895-uart
       - items:
           - enum:
               - samsung,exynos7-uart
@@ -172,6 +173,22 @@ allOf:
         clock-names:
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos8895-uart
+    then:
+      required:
+        - samsung,uart-fifosize
+      properties:
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          maxItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0

