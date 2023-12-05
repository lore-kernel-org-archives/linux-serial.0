Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZpt49+l"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC19185
	for <linux-serial@vger.kernel.org>; Tue,  5 Dec 2023 01:22:40 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c09f5a7cfso24051005e9.0
        for <linux-serial@vger.kernel.org>; Tue, 05 Dec 2023 01:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701768158; x=1702372958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObxMeQH5boMcLQ/g7RCJYr6nmE+CvqsmjJ2hJZYAzS4=;
        b=eZpt49+lJK7WIr/ZxSoLC+67hGDAvqT88ih2KPCBSsOtKU14vy+1LlW/d2j/YHStkw
         HYjXjb/X/iEMIH2IZP9JJl8xgkDFJBa8Rm+g0gLSo4C4PWxh5nXyFEJpI8N7fi1j3Dl+
         /jJ9d9dg6GY8sTVAEuzIhGI2/tHPhl6PDqX6q/pxab0m/jI5WwCxypt3gBabn79ZMdY9
         5aMuzEBvbzgQKwniMFdHxAcfR5hVoJ/OCFMV+LJM6GpFXwMPuy5bfe5m6XVEMrGTOb9+
         YeKb8p1ArqX5pMl7ClvMDFolsR+7rxz9aE4VctzomLgX0WLMuPXcC2zhP6v2Qn61xnX2
         IGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768158; x=1702372958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObxMeQH5boMcLQ/g7RCJYr6nmE+CvqsmjJ2hJZYAzS4=;
        b=Y8MrYcgG85AGZD86oMUGaA0FpjICgTyFKP8VSF/yoK3ITcMkh5TYNlqp2fi+fw4+Xc
         uMhhZRRyApjhdZ3unF/FjoCjFojs0JCvmT06aaSTmlSle0Hdjy+KMjtVHn/swydFIGOm
         vjwIq2zJi5O/xTU1zkUapEK5eXXjV7LvM3p7bI6H5hk1QrE+IQP64seBIoHeV12IN+IZ
         nSFNd19P2Q+JyNP+8HSpOEv/005MM6DNC0PkQ5E7Zq1Nr3s5tDsm+Ahf3DMm7+CfCc+S
         H6Wxub3ovvV2b/CG8xidPjquk0+nbpIHxyEK8YQxpdhqMPFfv0OT7flxi4MOdR+xtZIW
         mUXw==
X-Gm-Message-State: AOJu0Yx8Mus5dWZZyq+zkxF1EMWIKCeN7shV0vnT012fgja48A7pLeic
	GPOaT7gXrBCOy5YnoCiQf3G2HA==
X-Google-Smtp-Source: AGHT+IGx3W7fpSGh/VpzrYet5YuHsyAZROhAv05v+RTHYlVan5pyIZgU5eQBamgdMnQZcOBhzibgkA==
X-Received: by 2002:a05:600c:3093:b0:40b:5e59:ea06 with SMTP id g19-20020a05600c309300b0040b5e59ea06mr230527wmn.165.1701768158557;
        Tue, 05 Dec 2023 01:22:38 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b0040596352951sm21692287wmq.5.2023.12.05.01.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:22:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-fsd@tesla.com,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/6] dt-bindings: i2c: exynos5: add specific compatible for Tesla FSD
Date: Tue,  5 Dec 2023 10:22:24 +0100
Message-Id: <20231205092229.19135-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tesla FSD is a derivative of Samsung Exynos SoC, thus just like the
others it reuses several devices from older designs.  Historically we
kept the old (block's) compatible only.  This works fine and there is no
bug here, however guidelines expressed in
Documentation/devicetree/bindings/writing-bindings.rst state that:
1. Compatibles should be specific.
2. We should add new compatibles in case of bugs or features.

Add Tesla FSD compatible specific to be used with an existing fallback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I propose to take the patch through Samsung SoC (me). See cover letter
for explanation.
---
 Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
index c1f5d2cb7709..df9c57bca2a8 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
@@ -29,6 +29,7 @@ properties:
       - items:
           - enum:
               - samsung,exynos5433-hsi2c
+              - tesla,fsd-hsi2c
           - const: samsung,exynos7-hsi2c
       - items:
           - enum:
-- 
2.34.1

