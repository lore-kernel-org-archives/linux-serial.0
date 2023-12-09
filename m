Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5PqaDdQ"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E9FD60
	for <linux-serial@vger.kernel.org>; Sat,  9 Dec 2023 15:31:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso35573825e9.2
        for <linux-serial@vger.kernel.org>; Sat, 09 Dec 2023 15:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702164674; x=1702769474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzAXGyYwtUGZG8Z/I8N69PtrVjZfS2QiS9Asm+uQgQ8=;
        b=E5PqaDdQ04y01MgiI7TTHUSJsJNO9txwS4mE7/2cG9qC3St+4pAf8Bx5LuCZwCvVBT
         4bUApSx5GVutBwhklxT5VKuqn5kDRJUClfgeqDBhemFwotaoCMX2k57D0OMCJa7uZJJP
         ZKWrbbM33++KBoapDwfZK0m/qw1+jG1Kra9OY4e9fpOUsGYLdhuR8cx3HN1lmuZTWoZq
         AcsEFmYPd4s7HrQqjyXqD/eK15TRwy1SYWajzxQ5bcjHaTXLCyDWFsad5mkOxMQCDkRC
         DiTItERLZzxKQcK4xRN1PKKlvhJdNnbNsXwfWEyXc6/ElG0lrc4gBpz7WvHDMqgA0YxE
         MPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702164674; x=1702769474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzAXGyYwtUGZG8Z/I8N69PtrVjZfS2QiS9Asm+uQgQ8=;
        b=AjcwYBAuGUTCXJSWLvEVt1WEXGL9eKVsDEApZ3y8/KBmvTf8soRdG9Wv+4CI+pjHgB
         XuWLS2TkG2RcBuwrh2AQW8kdT8w9gRrqBaawTUI/UlTo2SOMCVBxendjK8AOSbKVI9TG
         14ODIKAjzAf56OmgO521ZjhX/Q5re3b6HMOmIhGOKumZU6FGevgACtqKf68KEzkthfNc
         3+kfIo+rhwAJgs2ZJ5v/+Di2Q+OmZG+ytkcKlvxSS4c/UIrkJG/DfvcqSNzUeM4P3qMq
         vb2hVK1C6YlkAlP/6brevNTqk9VZtOrYccxHs81MlEX6OAR6QbxjTxStSeqaEV9bI7QX
         J31g==
X-Gm-Message-State: AOJu0Yzwc5g7ljGkXaY8ntMazfLIm4GD7msdYHw+/V4J2Q9tvPm6Ioxb
	NU3g17VyOYNAA9sJ5VNKOmxtVA==
X-Google-Smtp-Source: AGHT+IGRorrE5Yjip1vrYZYwEDEw3YsTpOJuLCktNZZ088af1VXvfAIPBKDzkYr2NgWzmgqLQBRcWA==
X-Received: by 2002:a05:600c:3b16:b0:408:3c10:ad47 with SMTP id m22-20020a05600c3b1600b004083c10ad47mr1106521wms.40.1702164674507;
        Sat, 09 Dec 2023 15:31:14 -0800 (PST)
Received: from gpeter-l.lan (host-92-23-61-173.as13285.net. [92.23.61.173])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm1875277wmq.26.2023.12.09.15.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 15:31:14 -0800 (PST)
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
Subject: [PATCH v6 01/20] dt-bindings: soc: samsung: exynos-pmu: Add gs101 compatible
Date: Sat,  9 Dec 2023 23:30:47 +0000
Message-ID: <20231209233106.147416-2-peter.griffin@linaro.org>
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

Add gs101-pmu compatible to the bindings documentation.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index 28e2cb50d85e..ce1bba980961 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -15,6 +15,7 @@ select:
     compatible:
       contains:
         enum:
+          - google,gs101-pmu
           - samsung,exynos3250-pmu
           - samsung,exynos4210-pmu
           - samsung,exynos4212-pmu
@@ -35,6 +36,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - google,gs101-pmu
               - samsung,exynos3250-pmu
               - samsung,exynos4210-pmu
               - samsung,exynos4212-pmu
-- 
2.43.0.472.g3155946c3a-goog

