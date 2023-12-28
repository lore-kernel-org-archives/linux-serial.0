Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB7179C8
	for <linux-serial@vger.kernel.org>; Thu, 28 Dec 2023 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgBq2nX2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d5ae89c72so21937395e9.2
        for <linux-serial@vger.kernel.org>; Thu, 28 Dec 2023 04:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703768292; x=1704373092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LzbWE9szdRtnTR5PECxBTSqD8svHOqTLDWpgcXftXE=;
        b=BgBq2nX2itV8MpKeHpPQ1JDKDaEZ+S1grWWmKNTc2jSlcU+eopUT+Rr1rcDxjXJ7gX
         F5FCNwdG5IZDAAWgV9q3VJshMydNXBlWyaB8TuybeT51VDHZP9Q3rHs1dI/Z2pqdZQOE
         fga8cWWtKUl9oUCtWAjKEVaqJoA4As5cFEgLHB9Vx6b6pNmOwIDhjGtKzAHpR26yXqYQ
         Ln4Z2x0tOpFzTgoenm8ZFlJxxKWaGJKL0aNpldGMZ2RBcqQA2WetZftWNSORf+4NJEfh
         uTIGUMmuQJZWiR/uBx24fO18xotJ9vwvb3rDxCSRpvZEG/TbtNrRhOvCjjyuGN+Y/PBY
         SOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703768292; x=1704373092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LzbWE9szdRtnTR5PECxBTSqD8svHOqTLDWpgcXftXE=;
        b=W5lVeE9h7r15epEm6Dtji3z/QVnGr+K7TB80EgonN5j7fz2zvRog31m90XPUQew9c9
         Uq8WEGmtmwiephzNR8bYd3nKhk4+AgfCP5VFfdAr5yRs9wzfJH0XqGUGDTsFRPXxVUKy
         MaRqKqMukBQwtiEM2IH2LuKCn7km9+0fUEtgCW1NY3D6vcOx1Pl4fUqxMLu0G/93wmaE
         tMqWLD4WqW+tiKGp/OppS86O8we+s41VjFikUaq27W2LjNAlyArKNp2+Io+KMB5GmgrF
         f8PCg/hxOdUJvT3MCz2RW2K7wJxu87+YfXuZd3bZoIXm608snnG2lW+KatDMdQqZ7j1l
         +CyQ==
X-Gm-Message-State: AOJu0YxLTYN8mOu4hK6+wV0xcP9hpxqJkYQtL3LSGWwkuXd2kaHpxHg8
	72Snp/JuuR6QXke1ySxj8KEiPUCa7NUQEw==
X-Google-Smtp-Source: AGHT+IE7E9kPf6I6zhnXOaF+uBAHwWTIoJTK7yrN1FHwVGdUVH+mfR5uoQTW8/LH67NmXpPT96hsmA==
X-Received: by 2002:a7b:c3c8:0:b0:40d:39d0:9916 with SMTP id t8-20020a7bc3c8000000b0040d39d09916mr3985455wmj.246.1703768292208;
        Thu, 28 Dec 2023 04:58:12 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0040d5aca25f1sm8615807wmq.17.2023.12.28.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 04:58:11 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	andi.shyti@kernel.org,
	alim.akhtar@samsung.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	arnd@arndb.de,
	semen.protsenko@linaro.org
Cc: andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-serial@vger.kernel.org,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Wolfram Sang <wsa@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 02/12] dt-bindings: i2c: exynos5: add google,gs101-hsi2c compatible
Date: Thu, 28 Dec 2023 12:57:55 +0000
Message-ID: <20231228125805.661725-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231228125805.661725-1-tudor.ambarus@linaro.org>
References: <20231228125805.661725-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add google,gs101-hsi2c dedicated compatible for representing
I2C of Google GS101 SoC.

Acked-by: Wolfram Sang <wsa@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2: collect tags

 Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
index df9c57bca2a8..cc8bba5537b9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
@@ -33,6 +33,7 @@ properties:
           - const: samsung,exynos7-hsi2c
       - items:
           - enum:
+              - google,gs101-hsi2c
               - samsung,exynos850-hsi2c
           - const: samsung,exynosautov9-hsi2c
       - const: samsung,exynos5-hsi2c    # Exynos5250 and Exynos5420
-- 
2.43.0.472.g3155946c3a-goog

