Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqzI+8Va"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F81726
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 08:10:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3332ad5b3e3so1088706f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 01 Dec 2023 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701447056; x=1702051856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqUq8HgRrGxmt9Sh9WkyxYYOgIWePrhLH04C32o9WIM=;
        b=aqzI+8Vaa+EIQqQ9IDQ5mLO+OuGQ74HOjDTaGFLIG62yh7lkQRCNCCX9/hZ+XrN6QC
         n0yXnlskULgxoF+bDqiFUtw4GHRsDDhxg9X430rqoEV3oRr0jFxsKYEChPPiJZsU13fj
         GwPoSCT8VoHyRwARhTxY5/2L6w4zJdVHEo7JruSxXG0J11/wuudPYxukoTJk/e9lBlOi
         Z3kckVrCCVEI92F2AIiFyuGmS/m6xlizKQoS6kWZsa7/oXrFIkGVFoY4JrVlRJOsOvlu
         YnlNtka/KkJkq9mv9A8tTwkQ2LcA2tgK4fTq+JLnFOcY/xsD9UA1qG9zgUGnA59niuBa
         Ju1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447056; x=1702051856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqUq8HgRrGxmt9Sh9WkyxYYOgIWePrhLH04C32o9WIM=;
        b=om28UJE3qagIUaos08Lt+ngAAnBzNkK2YBL5+udwfAcKbHewgoYdAPBJNGZiAR4y7S
         /tSdvDEBf4yy2q1NgW7dbSufLsyh9YTCgIq5bBLaZDzOlN4q6cNvrLitu+78opK1ml3c
         VowQTZbtUBC1+VNcGwft8wQJPwTfvqZU7cAkBHYGa3AzQBX7wrWMJTV0Vsf5tr+MWx5F
         +0SG2bkbE0Q51d8jjVvPAJeINBocNxV4EIiP108NrpUgFd7AzVeJVvr9LkdWzhLkZM/Z
         xJRh4qrUYkVm+3Ky6pYl9dSfoexktEj/NwPe60zD/yrKm2mo2NFG09Mbk2oiimwbDN58
         AJRg==
X-Gm-Message-State: AOJu0YzrLsw+hbGP/ZyYiTfUbnGjGFZyyUAhZTlQ0tPPEReKIL99uii8
	euN5mqKSQOD+TuKR//imrEeJoQ==
X-Google-Smtp-Source: AGHT+IGxH3HZRD9B1F0nvSoZso66FA8TLrJx4cs/LpqBZQYZyLd3azB4kfjBGCl5Q90eurcfEWOWWg==
X-Received: by 2002:adf:ef83:0:b0:333:2fd2:51fa with SMTP id d3-20020adfef83000000b003332fd251famr1015597wro.115.1701447055983;
        Fri, 01 Dec 2023 08:10:55 -0800 (PST)
Received: from gpeter-l.lan (host-92-29-24-243.as13285.net. [92.29.24.243])
        by smtp.gmail.com with ESMTPSA id cg16-20020a5d5cd0000000b003332656cd73sm3907386wrb.105.2023.12.01.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:10:55 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	conor+dt@kernel.org,
	sboyd@kernel.org,
	tomasz.figa@gmail.com,
	s.nawrocki@samsung.com,
	linus.walleij@linaro.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	olof@lixom.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cw00.choi@samsung.com,
	alim.akhtar@samsung.com
Cc: peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	semen.protsenko@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	soc@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	kernel-team@android.com,
	linux-serial@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v5 05/20] dt-bindings: arm: google: Add bindings for Google ARM platforms
Date: Fri,  1 Dec 2023 16:09:10 +0000
Message-ID: <20231201160925.3136868-6-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231201160925.3136868-1-peter.griffin@linaro.org>
References: <20231201160925.3136868-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces bindings and dt-schema for the Google tensor SoCs.
Currently just gs101 and pixel 6 are supported.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/google.yaml       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/google.yaml

diff --git a/Documentation/devicetree/bindings/arm/google.yaml b/Documentation/devicetree/bindings/arm/google.yaml
new file mode 100644
index 000000000000..be191e70192d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/google.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/google.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Tensor platforms
+
+maintainers:
+  - Peter Griffin <peter.griffin@linaro.org>
+
+description: |
+  ARM platforms using SoCs designed by Google branded "Tensor" used in Pixel
+  devices.
+
+  Currently upstream this is devices using "gs101" SoC which is found in Pixel
+  6, Pixel 6 Pro and Pixel 6a.
+
+  Google have a few different names for the SoC.
+  - Marketing name ("Tensor")
+  - Codename ("Whitechapel")
+  - SoC ID ("gs101")
+  - Die ID ("S5P9845");
+
+  Likewise there are a couple of names for the actual device
+  - Marketing name ("Pixel 6")
+  - Codename ("Oriole")
+
+  Devicetrees should use the lowercased SoC ID and lowercased board codename.
+  e.g. gs101 and gs101-oriole
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Google Pixel 6 / Oriole
+        items:
+          - enum:
+              - google,gs101-oriole
+          - const: google,gs101
+
+  # Bootloader requires empty ect node to be present
+  ect:
+    type: object
+    additionalProperties: false
+
+required:
+  - ect
+
+additionalProperties: true
+
+...
-- 
2.43.0.rc2.451.g8631bc7472-goog

