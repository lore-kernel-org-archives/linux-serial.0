Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="km5V7j/Q"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76322137
	for <linux-serial@vger.kernel.org>; Sat,  9 Dec 2023 15:31:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c2c5a8150so30476715e9.2
        for <linux-serial@vger.kernel.org>; Sat, 09 Dec 2023 15:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702164683; x=1702769483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLTmFy+aGpsyLwOEhYkWRbjPeTt0aEpPpmb55d4OE4E=;
        b=km5V7j/Q9oJ0v38UsJLrwcbkBRo1D8m7DlWjiuHoTPqpuQY5yYv1xBLgcratFJqpy6
         ZxtmRrjaDt/0IrwOaRAhoT+W4sTynMCwM0QsgC80Yi8lsfLarnNVzR/yRuNW9LteQGiS
         i+xwTYjSjL5ZTflGoBpvjiv8MfiCCaEmXK32hFV6hsLkHbwswI3kqJgy/fs63YAkQDzo
         7Vys7OGArvJsOW7EUIfbnVGxEvBeHbiWi8MJo2l7Ml98foi+Ni/bdWMjQ2oZBJOF/0L+
         e8+8ZtZYPL/snXHxtNBhWsF/kj9VGY55aXvaNLjslRcPjVeNFiWF7WrF8DK07JWUZ9K/
         F/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702164683; x=1702769483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLTmFy+aGpsyLwOEhYkWRbjPeTt0aEpPpmb55d4OE4E=;
        b=VEHzUFSVW9Pt2vCppZxYN/k6xpSmC6tMQk/0zZNgnHSvwULgY5MzCY8RKsd+agjqQj
         UUXZVob0UkKZAYKAVHCM1+SxiKZ0DOyZWzTq65mXzhIvAspkm+vBVmLRVZhIsse8tsHn
         TmrrdELmnXq6ypgLlTI0oJJvRppddVo+hoEmdSrFyfIpT6WtAdKv7yVIVy9EG92/O7Ka
         5JEN3xDUAPGbvyXockL888OS7WW2Rp+jVLpvoicEWrb8t9xxFiWKbofsNmfQnp+kicmc
         HG26Dgps5DUa5qE2IMKJuVIMzug04BbYsUfdDvIKiMfOgbgNRNv8MrqTZycZJVnABtCv
         urcQ==
X-Gm-Message-State: AOJu0YypdlSTiIPIC9/MscZ4C0jnHclynwVRW8GNyLwzksMsXMspZypb
	gFByngacsG0FH7hRvWIM4mkZ5Q==
X-Google-Smtp-Source: AGHT+IHZzuf9nj8AkteP8DCv0mhXpSmMS1+a+kuhBxEPUJQvoaaHh9qKEIYtsLnxuemYPnpFsZAh+Q==
X-Received: by 2002:a05:600c:1913:b0:40b:5e21:ec16 with SMTP id j19-20020a05600c191300b0040b5e21ec16mr1031961wmq.72.1702164682864;
        Sat, 09 Dec 2023 15:31:22 -0800 (PST)
Received: from gpeter-l.lan (host-92-23-61-173.as13285.net. [92.23.61.173])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm1875277wmq.26.2023.12.09.15.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 15:31:22 -0800 (PST)
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
Subject: [PATCH v6 06/20] dt-bindings: pinctrl: samsung: add google,gs101-pinctrl compatible
Date: Sat,  9 Dec 2023 23:30:52 +0000
Message-ID: <20231209233106.147416-7-peter.griffin@linaro.org>
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
2.43.0.472.g3155946c3a-goog

