Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680ED107A7
	for <linux-serial@vger.kernel.org>; Thu, 28 Dec 2023 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPYZRAo7"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336788cb261so5399534f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 28 Dec 2023 04:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703768298; x=1704373098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfvY3WSeE4VIMFkeLJMaH8OzmsoSjNCK+Nz4eKgeCoc=;
        b=wPYZRAo7QXUGA/kTIdTnIIR/+lhZF4k7xFRxU97cFJy0DbF59Ajk4knIPTZPZDW+SH
         R8hVBzclA31K0t0nO6yWsUW5yBdn4g85JqkMwQWcfrEqu0GeCP0+xx98s12iEgJLNCgM
         bRCa8MPRq8P5GtsGHqwbpPKxalvgBvMxLimtIzRQxMaXjFYo35PQ6hjpTwpVt97bpGgf
         hIoaJWw1N6ZJW6ElXOfDHKfQpyxCnLcl4T9suyZxApsf59EFQk/BjRGVoSLt4NmXsKvM
         4TMJCNbPDDjFiiFTlXo7gWy2BP9q8p2ia5moLVHqTZn5R+DCycl8l1erYcYHMmbRtD2o
         cOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703768298; x=1704373098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfvY3WSeE4VIMFkeLJMaH8OzmsoSjNCK+Nz4eKgeCoc=;
        b=MYirJjXwVUx5lB2jAdmDEbvOTIF+YMnOcsZ9WQJOi0mltF5wAXRHUtkS2CGklh0FmU
         5OOkSUUgapWTQHNoIR0/APX7JV+g4k9Xv1aznFLMQowqXs+rAxIXMPifnvvq9B0Gm181
         vlfH78Kke1gSeG+rNZfBnEajiYuuhWV9WhwzMUjSdrM6QmeLm2JcFS6kihxhBqzP8te1
         dz2/VPld7YbqItkZgRxnuJsv7WWAH7oiUuoIMrVwvTmdRruUnSBjRe5WkMbVYycPPPTP
         X3Y7+Ev3KS5gDoLy98hDefePRqBPwDEGF//MXUJFQxlNanrGhi9uj/xl/ugHlhHnCW+F
         wMnw==
X-Gm-Message-State: AOJu0YwC+qVAT0pdRhWRy4M/UXZLuEehYhY4ZCx/Syg6RmofEr/hwqth
	+rNRbhAa8Zu15vWzAezvlLawqpQBzXrZIA==
X-Google-Smtp-Source: AGHT+IF55NKth7/eb18QsUtA1f9ddrzeSWtvCX/hHhNS9AwuDyV2qkCzAn6X1VS5tp90l5w01R7hBQ==
X-Received: by 2002:a05:600c:748:b0:40c:53ba:1720 with SMTP id j8-20020a05600c074800b0040c53ba1720mr5454225wmn.76.1703768298710;
        Thu, 28 Dec 2023 04:58:18 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0040d5aca25f1sm8615807wmq.17.2023.12.28.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 04:58:17 -0800 (PST)
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
Subject: [PATCH v2 08/12] arm64: dts: exynos: gs101: remove reg-io-width from serial
Date: Thu, 28 Dec 2023 12:58:01 +0000
Message-ID: <20231228125805.661725-9-tudor.ambarus@linaro.org>
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

Remove the reg-io-width property in order to comply with the bindings.

The entire bus (PERIC) on which the GS101 serial resides only allows
32-bit register accesses. The reg-io-width dt property is disallowed
for the "google,gs101-uart" compatible and instead the iotype is
inferred from the compatible.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2: new patch

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 9747cb3fa03a..2c27c3cb9237 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -366,7 +366,6 @@ usi_uart: usi@10a000c0 {
 			serial_0: serial@10a00000 {
 				compatible = "google,gs101-uart";
 				reg = <0x10a00000 0xc0>;
-				reg-io-width = <4>;
 				interrupts = <GIC_SPI 634
 					      IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&dummy_clk 0>, <&dummy_clk 0>;
-- 
2.43.0.472.g3155946c3a-goog

