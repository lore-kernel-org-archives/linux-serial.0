Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="og4STcHf"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FA8D60
	for <linux-serial@vger.kernel.org>; Sat,  9 Dec 2023 15:31:22 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c3f68b649so8226215e9.0
        for <linux-serial@vger.kernel.org>; Sat, 09 Dec 2023 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702164681; x=1702769481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufy0nGRtp/1JIZ9psxq6/E5zOi0BD5o7YxdicbrUE94=;
        b=og4STcHfpcsjRVK8s4n0RirNEr81gpeabeqyyx0kbuBUuUolAkqMGsZej92CY7cEHH
         Fdm90Tc8W4/cqWGM7wOH2DOzwySVXVTnXYkbuXnE8ZeoS3dyQdrwB65jyQNU3rAi5QPS
         x5jUaCnVjpikHgdRg9ukxA6yaMSu8V0rZCGDHEbHlZDzi/tWyLvQoL29yAaID5+vqK9m
         rRnsnYBaAeLvUjsUrkc2b0Q6In263MVY2AWM2NTqd1Ve94sJsiJP169KvLLIFLiWnZ33
         PphYKDZMoyPMk3jgWQ74PFSf5rRVUD+5FeOJSx/y4TNkpycOcJgpItDmiqa5A4Uo2hhp
         gIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702164681; x=1702769481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufy0nGRtp/1JIZ9psxq6/E5zOi0BD5o7YxdicbrUE94=;
        b=C9fbdJiU9fosmCmUT23SMxkTn72X/kPHN3jcwgizNAYgQBDq6CTX/MeO+na/AbL+Z2
         MOJFaNeueR8/1pIaie4ozfdoGFLcZKW/2LUssOPWz8gbhePPH3ksrJB8PSQGrnPbPI5H
         c42d4pAvy8KAbpOMJ9a2DypEN2E08WOQYQwJQvi4qhu//nWVAqR4GTuovfpLopz1amrZ
         aG8RWvNxHRg3uYYsdo8E8+UIuBwpmzELE178IP67RC5m8ORBLCmdkq7PWKDQS4gjvYdP
         1V909WF0ATgUuJF1kXU1ut++zxMrxMYOObkDlrEgQxRcYNvkpvANCgBvZ+uvdtnP7Kp/
         SHEQ==
X-Gm-Message-State: AOJu0Yy4OLbbpiWz+astmr5we+0gIuMV5T5Q0VxzG+AvfmeB/cD6Ld2o
	E6qBLcE9gjhIFia/u2HRbUgeUw==
X-Google-Smtp-Source: AGHT+IGjfXfdEi+FC95F5SnCn1zV/uuKcGFsWqZfxOQ5CQVz10lrVJ/v+al0iR+cDIdCSxfU0CP1Rg==
X-Received: by 2002:a7b:cd89:0:b0:40b:5e1e:fb94 with SMTP id y9-20020a7bcd89000000b0040b5e1efb94mr741927wmj.73.1702164681233;
        Sat, 09 Dec 2023 15:31:21 -0800 (PST)
Received: from gpeter-l.lan (host-92-23-61-173.as13285.net. [92.23.61.173])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm1875277wmq.26.2023.12.09.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 15:31:20 -0800 (PST)
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
Subject: [PATCH v6 05/20] dt-bindings: arm: google: Add bindings for Google ARM platforms
Date: Sat,  9 Dec 2023 23:30:51 +0000
Message-ID: <20231209233106.147416-6-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231209233106.147416-1-peter.griffin@linaro.org>
References: <20231209233106.147416-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces bindings and dt-schema for the Google tensor SoCs.
Currently just gs101 and pixel 6 are supported.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../devicetree/bindings/arm/google.yaml       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/google.yaml

diff --git a/Documentation/devicetree/bindings/arm/google.yaml b/Documentation/devicetree/bindings/arm/google.yaml
new file mode 100644
index 000000000000..e20b5c9b16bc
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
+  Google have a few different names for the SoC:
+  - Marketing name ("Tensor")
+  - Codename ("Whitechapel")
+  - SoC ID ("gs101")
+  - Die ID ("S5P9845")
+
+  Likewise there are a couple of names for the actual device
+  - Marketing name ("Pixel 6")
+  - Codename ("Oriole")
+
+  Devicetrees should use the lowercased SoC ID and lowercased board codename,
+  e.g. gs101 and gs101-oriole.
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
2.43.0.472.g3155946c3a-goog

