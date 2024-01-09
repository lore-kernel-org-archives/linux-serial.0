Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2035381D5
	for <linux-serial@vger.kernel.org>; Tue,  9 Jan 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0IU/FAQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e490c2115so10458315e9.0
        for <linux-serial@vger.kernel.org>; Tue, 09 Jan 2024 04:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704805109; x=1705409909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9i0+GNnJ7PUDNqQJFZRpfiefslzNtbvECkFwhm7N13k=;
        b=k0IU/FAQGwAxZsrpNoGZzX3Efy3Omhm5TYGPSF4enkBzp6cwM1n0e0na7lj12qao3P
         1LssB4rBj2p/PtjqXlgeyX3L0paTauk8IVOHqelkNdIlrxuRQ75uoZ9780Yt2cjMW8VC
         PW4FsSlsZBvRn6VPVJ4xGWzZZ1mNzcbqflNvpVN7cEDLCcSa7VXoQZHT620K+xC62xWq
         6mTQLk/DMN5QiqTk2DXXppaF4GT8YnC0DI/VmQJDiDnNUuBPr0/ZEDYLq3tL5muu6IoP
         PrFt4h7GGdVPyS5O3eGbcm5+mWb2k1SuFMbaO/TwFFYiCWOgsMctt73F7zy4iBMuBWJd
         +lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704805109; x=1705409909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9i0+GNnJ7PUDNqQJFZRpfiefslzNtbvECkFwhm7N13k=;
        b=dJ19cQL0WNDDEhGFQGAdTNffbUaT532Id0ioBdr6wimzdztGZDJiUFD806e4iwScvC
         N7KNsvYIY0MgfoMaDuhcnJNwWFK8UqJYivJrUz2v4jdP0qKVy3HjSe5OwLXYjn7pplcV
         VbakgBnMzh3FHkimoMFQwyPkHuu6skS/qV1z4o0exvvbZs2ss8XJMgAGv4hVZ1xNqseV
         fImogl3beCpa+fG3/hpoeKitqwSFe2GQuMOANLcPTofCZjiXFZJ+U9/gZmyJx77yuxbJ
         7Zu1q1x0V7LZN2wuRIZlDKcZ9G8sxjDy/rZYwv1Di9fQLrTE8spLkrhXPQBMhAEvoTme
         jHGA==
X-Gm-Message-State: AOJu0YwOd26Ab2B7FK/t8aDvCSM7WtFh0oFUABToeIUufmG4V6XYv5Km
	MnkwxSQ6C4RmfxeHcbejiwHht06OvN4Cuw==
X-Google-Smtp-Source: AGHT+IHQPeZVpACVYWJHOPDubk8UtBjdRQGuYcTeBwwLCvBDewKeTmwELU2B1EfBf9Fp4u7vSaHDEg==
X-Received: by 2002:a7b:cc10:0:b0:40d:8cb5:1b9f with SMTP id f16-20020a7bcc10000000b0040d8cb51b9fmr374679wmh.81.1704805108903;
        Tue, 09 Jan 2024 04:58:28 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id cw16-20020a056000091000b0033753a61e96sm2351302wrb.108.2024.01.09.04.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:58:28 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	gregkh@linuxfoundation.org
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	andi.shyti@kernel.org,
	alim.akhtar@samsung.com,
	jirislaby@kernel.org,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-serial@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 00/12] GS101 Oriole: CMU_PERIC0 support and USI updates
Date: Tue,  9 Jan 2024 12:58:02 +0000
Message-ID: <20240109125814.3691033-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set shall be queued after the cmu_misc clock name fixes from:
https://lore.kernel.org/linux-arm-kernel/20240109114908.3623645-1-tudor.ambarus@linaro.org/

Add support for PERIC0 clocks. Use them for USI in serial and I2C
configurations. Tested the serial at different baudrates (115200,
1M, 3M) and the I2C with an at24 eeprom, all went fine.

Apart of the DT and defconfig changes, the patch set spans through the tty
and clk subsystems. The expectation is that Krzysztof will apply the whole
series through the Samsung SoC tree. If the tty and clk subsystem
maintainers can give an acked-by or reviewed-by on the relevant patches
that would be most appreciated!

Thanks!
ta

Changes in v3:
- rename cmu_peric0 clocks to just "bus" and "ip" and then comply with
  the change in device tree and clock driver
- reposition ``iotype`` of ``struct s3c24xx_uart_info`` to reduce the
  memory footprint of the struct. A patch set reworking the members of
  the struct will follow.
- fix the usi8 clocks order in the device tree
- collect Peter's R-b tags
- changes log in each patch set as well, in the comments section under
  ```---```

Changes in v2:
- gs101 serial - infer the reg-io-width from the compatible as the entire
  PERIC block allows just 32-bit register accesses.
- identify the critical clocks faaaaaaarom PERIC0 and mark them accordingly
  (if disabled theslocks hang the system even if their parents are
   still enabled).
- update dtsi and use USI's gate clocks instead of the dividers clocks
- move hsi2c_8 cells and pinctrls into dtsi
- address Sam's cosmetic changes in the device tree files
- drop defconfig patches (savedefconfig output & at24 eeprom enablement)
- collect Acked-by and Reviewed-by tags
- changes log in each patch as well, in the comments section under
  ```---```

Tudor Ambarus (12):
  dt-bindings: clock: google,gs101-clock: add PERIC0 clock management
    unit
  dt-bindings: i2c: exynos5: add google,gs101-hsi2c compatible
  dt-bindings: serial: samsung: do not allow reg-io-width for gs101
  tty: serial: samsung: prepare for different IO types
  tty: serial: samsung: set UPIO_MEM32 iotype for gs101
  tty: serial: samsung: add gs101 earlycon support
  clk: samsung: gs101: add support for cmu_peric0
  arm64: dts: exynos: gs101: remove reg-io-width from serial
  arm64: dts: exynos: gs101: enable cmu-peric0 clock controller
  arm64: dts: exynos: gs101: update USI UART to use peric0 clocks
  arm64: dts: exynos: gs101: define USI8 with I2C configuration
  arm64: dts: exynos: gs101: enable eeprom on gs101-oriole

 .../bindings/clock/google,gs101-clock.yaml    |  25 +-
 .../devicetree/bindings/i2c/i2c-exynos5.yaml  |   1 +
 .../bindings/serial/samsung_uart.yaml         |   2 +
 .../boot/dts/exynos/google/gs101-oriole.dts   |  14 +
 arch/arm64/boot/dts/exynos/google/gs101.dtsi  |  54 +-
 drivers/clk/samsung/clk-gs101.c               | 583 ++++++++++++++++++
 drivers/tty/serial/samsung_tty.c              |  58 +-
 include/dt-bindings/clock/google,gs101.h      |  81 +++
 8 files changed, 794 insertions(+), 24 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog

