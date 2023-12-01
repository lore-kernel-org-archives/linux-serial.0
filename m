Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUOMjZnl"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E0F10DF
	for <linux-serial@vger.kernel.org>; Fri,  1 Dec 2023 08:10:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332c0c32d19so1765509f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 01 Dec 2023 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701447057; x=1702051857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V1UUtwAmpCe4BOx2n9je9qb/QMltwNIij4rqLKsGDM=;
        b=XUOMjZnlJqJuQwDM9lnM3QFa6Uen2BdJHP2eUWh9BOkdPtpbuN+iDiTlxD4xykaJiW
         EoAJsx0BJd+KtE/5ko+ydEFaQBnduSW2dKQuOeYe3Dc2FXSsoSLkR3pX9k4XtE0uHHLI
         GXJFEjzot0ShhOdwAldmNv+PXAs831z1g7ZF+FqEr7ixrS/RIaOnk3PtWYfX+NOcmhdh
         3dyP76k7vYa9UnxSKKlbU6L0ZLNDhdtrk6w5MUz1/c9R2CEBNscRfxWa3McxUF7GxQhQ
         Z9Ejji9ta/IcBtsa+ynD47e0z7iH1mecqtJ7a8P9+9tOzxediCxu7A4Y3e0ZP9mROF2K
         7baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447057; x=1702051857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V1UUtwAmpCe4BOx2n9je9qb/QMltwNIij4rqLKsGDM=;
        b=P/k3DSUcshXEF0vyS9uqUQMMcZ7z3v0syLQwj73Jykar0KXRz8LUA9aRuVpYRlAmRZ
         uHo2Bpdc98UTFDU8ADXqwxPmHsNig4tBBwqUn8ci+8gv8aJIR5mdVfhWxoqR7vvIIFul
         PaxpCE6qOefeaswTrHHTN9eyfhKj/fMkj2IBPKd/SyOrHSbUqd4W83n9KTb/rVYZmcHT
         KVVYK/l+ZFNRvM4Nv+zb/3tvOkoFGGmYoRKYRGPVtME0j+I89k6adMn1nDxTUmzNWWOQ
         5Rv0MSu8J5qMYhkLDl4ugg1Ny3beSPv3B3np0P8qZ+H5PNMJ1XCrex1OioCUJ/qRGGng
         Rylw==
X-Gm-Message-State: AOJu0YxvJW5o6bP+HZejypfmGw5QDMHntvJtB98qri8j5qk1gdTqkDRi
	EDPurmvTX8yISf6v6qVBiPBFNQ==
X-Google-Smtp-Source: AGHT+IHcniH93ls2L4js8Defcoe1/o0gUisiuD4Xta5PPEUQLQ4rpfJ0BqVOXkpofKNdpYD9Sa4B/A==
X-Received: by 2002:a5d:4051:0:b0:333:eb7:cc15 with SMTP id w17-20020a5d4051000000b003330eb7cc15mr940801wrp.45.1701447057474;
        Fri, 01 Dec 2023 08:10:57 -0800 (PST)
Received: from gpeter-l.lan (host-92-29-24-243.as13285.net. [92.29.24.243])
        by smtp.gmail.com with ESMTPSA id cg16-20020a5d5cd0000000b003332656cd73sm3907386wrb.105.2023.12.01.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:10:56 -0800 (PST)
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
	linux-serial@vger.kernel.org
Subject: [PATCH v5 06/20] dt-bindings: pinctrl: samsung: add google,gs101-pinctrl compatible
Date: Fri,  1 Dec 2023 16:09:11 +0000
Message-ID: <20231201160925.3136868-7-peter.griffin@linaro.org>
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

Add the "google,gs101-pinctrl" compatible to the dt-schema bindings
documentation.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index 9f04a0c76403..118549c25976 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
@@ -35,6 +35,7 @@ properties:
 
   compatible:
     enum:
+      - google,gs101-pinctrl
       - samsung,s3c2412-pinctrl
       - samsung,s3c2416-pinctrl
       - samsung,s3c2440-pinctrl
-- 
2.43.0.rc2.451.g8631bc7472-goog

