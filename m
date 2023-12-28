Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F51410A21
	for <linux-serial@vger.kernel.org>; Thu, 28 Dec 2023 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkk3Pw39"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e7e1ddaddso3122108e87.3
        for <linux-serial@vger.kernel.org>; Thu, 28 Dec 2023 04:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703768301; x=1704373101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nshL/2BWW/EmympyN/DOS/o4W55HuW8fqdS5mFUVUCI=;
        b=mkk3Pw39fpmwTjMyLFLDajaq7IFSKoh6S8NF5IWmxPF0e5N6KLtL8xDyJUzfAecCrp
         FTpQbHEKN5xytknfDzurqYBORK8KoydCFJhkNc4hjLSOY+38T7pXN8rT6TvY4WlvDB/2
         WG/a9PvTTeoMUl11PtTUV6nsArmOVZ3Beghc/2BQXiA5IS77eqjanHeci+dezSM+XAX2
         XHGCAGkR/fmc6TTZE9147e7S4czbFX2ry/lXYqoItWDb6+6zW3QGxD78Hwoml/8O16OS
         NieEe8ks2/gcnG1uKiVJ04dBWXpsxpF5w7Y2GS2fkFIh69YDnEEDO179WGhk/rClHTYW
         9uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703768301; x=1704373101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nshL/2BWW/EmympyN/DOS/o4W55HuW8fqdS5mFUVUCI=;
        b=mdWJaQFjkGzxesbKEPd8+VH1oOFE1Y10yH69Q0xfj0tr31uXb2QonRSF40xeR7Fjc6
         JG7x2fPfpFZ7PojXpBopq+n6eQrxZQojgf33hEow0fdsW+rWZGW1v1BuIeobn/7UoLaB
         XdJjJcgMVdvfe18S4iVtzXHxHPUQ/75iIw3k+MI89NV29/wFjeqOiVzaNeplfiQAFm/h
         Cq7k4lrWvaajWdKiKFP3Ig7k4x1wf+uJatLmXesdP+9tnlf32/sEbNK6xeQleQXvmpCX
         6VB3b6MQYKEcjmhTA3H1l0IVJhq0NkZYmDfiXEJvhGHTcP+iwnH30wAj9tP14I/whH7Z
         S36w==
X-Gm-Message-State: AOJu0YwE7cRGrjVmPn9g1IXs46dgenXmHC5JR+mcEw87ioKMHk7IczDr
	PnLadM6BaYvbAwfQXPWCLE5jruJb03a1Zw==
X-Google-Smtp-Source: AGHT+IH1ngv6ejaU7/1CPrITKymTsj3xR3AtePeUh+QgKGYoFnMU100TN5ELJ0cgjYZTMENP3QXhKg==
X-Received: by 2002:a05:6512:348c:b0:50e:7c73:f4f3 with SMTP id v12-20020a056512348c00b0050e7c73f4f3mr2253161lfr.9.1703768301689;
        Thu, 28 Dec 2023 04:58:21 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0040d5aca25f1sm8615807wmq.17.2023.12.28.04.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 04:58:21 -0800 (PST)
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
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 11/12] arm64: dts: exynos: gs101: define USI8 with I2C configuration
Date: Thu, 28 Dec 2023 12:58:04 +0000
Message-ID: <20231228125805.661725-12-tudor.ambarus@linaro.org>
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

USI8 I2C is used to communicate with an eeprom found on the battery
connector. Define USI8 in I2C configuration.

USI8 CONFIG register comes with a 0x0 reset value, meaning that USI8
doesn't have a default protocol (I2C, SPI, UART) at reset. Thus the
selection of the protocol is intentionally left for the board dts file.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2:
- identify and use gate clocks instead of dividers
- move cells and pinctrl properties from dts to dtsi
- move IRQ type constant on the previous line

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 29 ++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 0e5b1b490b0b..c6ae33016992 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -354,6 +354,35 @@ pinctrl_peric0: pinctrl@10840000 {
 			interrupts = <GIC_SPI 625 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		usi8: usi@109700c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x109700c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_CLK_PERIC0_USI8_USI_CLK>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x101c>;
+			status = "disabled";
+
+			hsi2c_8: i2c@10970000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10970000 0xc0>;
+				interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&hsi2c8_bus>;
+				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7>,
+					 <&cmu_peric0 CLK_GOUT_PERIC0_CLK_PERIC0_USI8_USI_CLK>;
+				clock-names = "hsi2c", "hsi2c_pclk";
+				status = "disabled";
+			};
+		};
+
 		usi_uart: usi@10a000c0 {
 			compatible = "google,gs101-usi",
 				     "samsung,exynos850-usi";
-- 
2.43.0.472.g3155946c3a-goog

