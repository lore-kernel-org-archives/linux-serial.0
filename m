Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3e8bQuW"
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413E31B6
	for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 02:53:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33642523623so1181975f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 02:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551180; x=1703155980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mo3Dx5itQzWuax7FZn6pfcTiRVwQ5I0itNwdOhqnqJQ=;
        b=e3e8bQuWvYbu5qOH8xAs9IihcWe61U6KaaczhFDR43vpstD0WhcrL2STk5EiKMlXj5
         plSqUo3vhHMrpnmfC5wQx6eJMUPGFsNjsIrgvk7AjR/SA+hTcVgvcRSVUthSfWZO8Rw4
         sjD/iq33F2lZTrSy0FGewtQDq0YZwb6SRlb8WEJnv3UA1pAkCmFyh4I4NTNxBxH596aC
         tC59oTi/xQs0OpWZG04F9euYFBUBxROOt/cNs9GnDNz9Al2NK3VTuTXDXe1hWUXS62R5
         SzXqhTrB1ODKgGYGVhuGnz48hE1kp3/Pd9QQPnSMTABTXhpYa7q+HQHLD/PXSNLBPyxu
         L01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551180; x=1703155980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mo3Dx5itQzWuax7FZn6pfcTiRVwQ5I0itNwdOhqnqJQ=;
        b=BUcFL/371iYilYwWzi/A61TzXfbMns+zxzzYFbADr+9fuSb6W6hTCoG3WF5fqJO3z/
         3cT/N+uq1KgZ0QwilJlyngBE5TPh+SQtzlSuEjf61caX9+wO8bl8nPfyvaSqq/AYf0DX
         LJUuh6Z5cffGd6ZN4BONXAcrPGLn4UgrRFz2zXAXHW8r9G5Ea+AIxVqwrR5bPpQQlsNu
         IvUNyPc5wAo59QYZTia1s6rbtExOHNmv87EdWwgPL8f3+JJOQauwpuBqe8O+D8K8Dkv8
         JSvYcgnxRKhCCeC3ZF+0KO5BCDNtcBf6xaWon7mYiTL9BGXjmm+ln5FcKgemCWvwRr/U
         6KgQ==
X-Gm-Message-State: AOJu0YzxrgKFDXfG8+IxyEFAwgC633RKt6mc+KgFQHApGTcKyPlk9rqC
	JPg/MB3tCfdK0zeKr90e2kQdXQ==
X-Google-Smtp-Source: AGHT+IHuGhsz9jG/F9bYT1xDJ7/aVGHW2+wpE9t6j+cdMeOfe0/DLNkaievhbt9JMdElWgNH9XkEFQ==
X-Received: by 2002:a05:600c:4f82:b0:40c:4dc5:b2ee with SMTP id n2-20020a05600c4f8200b0040c4dc5b2eemr2697156wmq.149.1702551180487;
        Thu, 14 Dec 2023 02:53:00 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm17614854wmo.22.2023.12.14.02.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:53:00 -0800 (PST)
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
Subject: [PATCH 10/13] arm64: dts: exynos: gs101: define USI8 with I2C configuration
Date: Thu, 14 Dec 2023 10:52:40 +0000
Message-ID: <20231214105243.3707730-11-tudor.ambarus@linaro.org>
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

USI8 I2C is used to communicate with an eeprom found on the battery
connector. Define USI8 in I2C configuration.

USI8 CONFIG register comes with a 0x0 reset value, meaning that USI8
doesn't have a default protocol (I2C, SPI, UART) at reset. Thus the
selection of the protocol is intentionally left for the board dtsi file.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index ffb7b4d89a8c..4ea1b180cd0a 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -354,6 +354,32 @@ pinctrl_peric0: pinctrl@10840000 {
 			interrupts = <GIC_SPI 625 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		usi8: usi@109700c0 {
+			compatible = "google,gs101-usi",
+				     "samsung,exynos850-usi";
+			reg = <0x109700c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_DOUT_PERIC0_USI8_USI>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_CLK_PERIC0_USI8_USI_CLK>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x101c>;
+			status = "disabled";
+
+			hsi2c_8: i2c@10970000 {
+				compatible = "google,gs101-hsi2c",
+					     "samsung,exynosautov9-hsi2c";
+				reg = <0x10970000 0xc0>;
+				interrupts = <GIC_SPI 642
+					      IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&cmu_peric0 CLK_DOUT_PERIC0_USI8_USI>,
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

