Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0hcZotC"
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F1183
	for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 02:52:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so7222212f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 02:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551174; x=1703155974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz2Xvyg4JP2yoDb158eSoW+wfoMNINh6+jbVwRbhMzg=;
        b=l0hcZotCiUZF3GUAyXnrHKpziDKODeoJ2rFz4MeIFdYQRnOcxag8BJIwPPMn/t5DoS
         G2G1f4MMOHaNPjvHDBmer/O/zCTM1jJ6s5SLMKSV5UceeYSS+N7P7RMLlnF3SEkDK0Oo
         gIKx2JBs+8wh75o5i5MJVrAaSNToyf9h1Q3HfCxfbcAJ5NWBkDTBhcRsTlAdpAWN9YvY
         y4UoMCvdeDXAcBCJR/vshB0QjOYhGnIzP6AViUowsiNpKn5/7Bl+UpfR01VeQHYj/h1R
         u7Avswn4RgkewHE6uIUfaPE1u56gxPNVtCzsUit/K29Vp8nizjaJF4553cI/Q5HV4N7A
         5wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551174; x=1703155974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tz2Xvyg4JP2yoDb158eSoW+wfoMNINh6+jbVwRbhMzg=;
        b=EM5p6sSWHntwv7FMf+qodwdtYHJJ3nKyQ3hLne62PoQLZyC44bjLQfeK050vs5MtLd
         6kkM3N+ynBM7khViAWkuKnbTFNxVjZcLwOG97O3aJeBmxd23sEsluDsyQDWf7T6flvqZ
         +0ryxZTkn/7OlnLGrhCToSlP7QVEFj9Wt6gkqrVWBa1JW4RV9Rk2VLt6btk1G8IrttnE
         WEKgS18w9UVJucrArUYmbASuiXMeHi9beG5jLnJrWZ4t1vWb7lDUOM7RQJqsDUieHDXa
         lSjYNIIOEEQH7pmW/DxyF3w7LQydmPBIUWsey76EbndpusxhetvkU3d0tnKKEPn3w0fz
         Kj6g==
X-Gm-Message-State: AOJu0YyO5d6MZiyyAfrvfpC9+h67bFqLUiZcxrTxho9l+svRDLhjUs3D
	/HtXATwr7aMLrv9WcgLEkOJliA==
X-Google-Smtp-Source: AGHT+IH4J/oPnKQvv4O5ZLerNCsWrBSRNQ4wX2oCYLqm28AWAUlwAelLEDUbwmWNrJTRLX2wmLtGdQ==
X-Received: by 2002:a1c:6a0e:0:b0:40c:2617:69c4 with SMTP id f14-20020a1c6a0e000000b0040c261769c4mr4879922wmc.78.1702551174764;
        Thu, 14 Dec 2023 02:52:54 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm17614854wmo.22.2023.12.14.02.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:52:54 -0800 (PST)
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
	catalin.marinas@arm.com,
	will@kernel.org,
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
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 03/13] dt-bindings: i2c: exynos5: add google,gs101-hsi2c compatible
Date: Thu, 14 Dec 2023 10:52:33 +0000
Message-ID: <20231214105243.3707730-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add google,gs101-hsi2c dedicated compatible for representing
I2C of Google GS101 SoC.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
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

