Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136833254B2
	for <linux-serial@vger.kernel.org>; Tue, 11 Nov 2025 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889200; cv=none; b=cYtti2cSe95Xc9nn3ZqyyABb1WfkxiPAwYZ2hbDPJgHeBLcnm3uqUVT3EtB+GMr535GmQXBnEeEmh1qjWm0Of5SFE2lTVRwrfWADFkNDlVCcg4U+EQVEWR+Ol/zcqLLe9yv9MM1HQlhHtDsgttj5kzn2+VyDHOF2/Pq5FhCHkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889200; c=relaxed/simple;
	bh=f5tl5Jvq2Hy4zPlmf7aG3KhINJQaIW2CKTgzdHwDxdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=apjbwdEs3Tf2NpFs+dK1AMRRq4AjWfwj/qqzADx5QyX201fi8QtI+8AqBhCHj9BoWz1MuClqgQJg1MpWLH/gzZNljPzpyiV0T/46/IlWQma7SGJWZYnF3+q+G+lh7ceaZmPCIPYe/ngGQl4kXk0QXlRnik/YAqUsYHjwuCyX5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fworl9JJ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fworl9JJ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b996c8db896so57939a12.3
        for <linux-serial@vger.kernel.org>; Tue, 11 Nov 2025 11:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762889198; x=1763493998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3hXO0kohcojDK5N1gDQnbb7SNR3dS5AVJdqaUadyUo=;
        b=fworl9JJ+4vd3fn2WOlGb5AqkA6rYiZCmYBo3d8aQGQ/NqLkXAa0JVpDvJ9nuWPKRz
         d8RiWHeAVHBDeQ+L2pljavh42DtQMbly8l+/q9T5mt9H24Tn0ZevyKB0JjIYrztvMmC/
         +OAG35/iohrb9LkjxkXhwy2Uwdr1kC+w/fjMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889198; x=1763493998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3hXO0kohcojDK5N1gDQnbb7SNR3dS5AVJdqaUadyUo=;
        b=qTrpFhr7hBQ4/x2QpF6qyqH39b2u4yVCptcSg3Go8K8t5Pixq0e8nMe0ll5WZKL+ud
         lMsL46ttceHwow46yKc8CnFiGwzNON0Bfd8NZVLk9moeSlIjCr85V7ep+nBvo9QQd1OI
         +11iDUOEYeeiF2m5Cywc/rRuYP1MGK7bNCNsxu1UuuRtZjWc8a7Vu33oRGjLv+VF6ycu
         nUGKnSu2qsQehhE+3LRJp9dH36D10Hxx+LpIKoq82Aub3Ny4XvqS0+dFDgKOCloZUvP6
         V8dMV4dESW/jBGAgpaiN8SUea7B/unrL35fmb/UoX1DiI3lHQKJ42UsBzBwIKqEIeyyZ
         BCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl32z/wC/brelGfR3T+DYzsNLTp6xQqJHqb+IG0CCMo2PVTrJsH7b1J5T4rp6K3fxAYyfcbUYVwYYVorU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyErmY4RuUPr3J6JxKBShOkRnkwXgnenW2m5WSdOKZd3G2EH3QV
	glRj9BgKgSIfMWRgJXPVBAMkYX42WVoxLrBlTaN1gOJWHRTRq3OLPhra95hMgR1q9w==
X-Gm-Gg: ASbGncuvr1LBKwHpQBRh6gsGAV/2yi0AkSmOVSLNQEtH7Xpdszgag5rZWpxqllliRI4
	Acpcl1m+bWLC8+o7SLYhACZ1BWszyN2B8o7vY0OSch3UhAYobjFX2ddGl5NnXRnqBDc6QRJxlFp
	Y7ZcEaFkq+k9DaAOr0BCfgt+GsOEZDZOcOw9Jz0iz30oCTrTB0gRNG9LQyBP8EqW+cmeqWD+3JC
	NpLQwYdLfNV9PbOSKRhprwyAm6tYaRDQQ9ckDfyUoO6ZlTMZ0YuhVXne5bRFvI2ns1IOhowyNc/
	1VnbC27yxGwYqScDUATe3wBP4yDceFcXRW4uIhYnEynVnw28LWb+QruHm9cZPVWj2qnlcIh8X1K
	UIMU8vTS4drf1DzBTfnEfaCtS4G53R01mPKbWr+JeTzs7rRs5KvfHuJJREbPM+cYcshburUamCa
	CUbO6QLLrVM4s6m5vQ5S5prqUX8PlWcUge0MneqYfPd8sUj1RUExMgVPw90Vc=
X-Google-Smtp-Source: AGHT+IGzawljQPfuMSEdjKEu2O+TbUwNMNOGAm74gscUESQKCa416kMewGM3RhTWM1GA5ootFgKOLg==
X-Received: by 2002:a17:902:f684:b0:26a:8171:dafa with SMTP id d9443c01a7336-2984ed49524mr5944105ad.21.1762889198163;
        Tue, 11 Nov 2025 11:26:38 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:ba9f:d4c6:9323:4864])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd0974sm4861075ad.90.2025.11.11.11.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:26:36 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org,
	Roy Luo <royluo@google.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	William McVicker <willmcvicker@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Drew Fustini <fustini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	soc@lists.linux.dev
Subject: [PATCH 0/4] arm64: google: Introduce frankel, blazer, and mustang boards
Date: Tue, 11 Nov 2025 11:22:03 -0800
Message-ID: <20251111192422.4180216-1-dianders@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This series adds barebones device trees for Pixel 10 (frankel), Pixel
10 Pro (blazer), and Pixel 10 Pro XL (mustang). With a yet-unreleased
bootloader these can boot to a UART command prompt from an initramfs.

The end result of the device trees introduced in this series is really
pretty simple, so it's expected that most of the discussion in the
series will be about compatible strings, file organization, dts/dtso
organization, etc.


Douglas Anderson (4):
  dt-bindings: arm: google: Add bindings for frankel/blazer/mustang
  dt-bindings: serial: snps-dw-apb-uart: Add "google,lga-uart"
  arm64: dts: google: Add dts directory for Google-designed silicon
  arm64: dts: google: Add initial dts for frankel, blazer, and mustang

 .../devicetree/bindings/arm/google.yaml       |  87 +++-
 .../bindings/serial/snps-dw-apb-uart.yaml     |   1 +
 MAINTAINERS                                   |   1 +
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/google/Makefile           |  10 +
 arch/arm64/boot/dts/google/lga-b0.dts         | 391 ++++++++++++++++++
 .../arm64/boot/dts/google/lga-blazer-mp1.dtso |  22 +
 .../boot/dts/google/lga-frankel-mp1.dtso      |  22 +
 .../boot/dts/google/lga-mustang-mp1.dtso      |  22 +
 .../boot/dts/google/lga-muzel-common.dtsi     |  17 +
 11 files changed, 561 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/google/Makefile
 create mode 100644 arch/arm64/boot/dts/google/lga-b0.dts
 create mode 100644 arch/arm64/boot/dts/google/lga-blazer-mp1.dtso
 create mode 100644 arch/arm64/boot/dts/google/lga-frankel-mp1.dtso
 create mode 100644 arch/arm64/boot/dts/google/lga-mustang-mp1.dtso
 create mode 100644 arch/arm64/boot/dts/google/lga-muzel-common.dtsi

-- 
2.51.2.1041.gc1ab5b90ca-goog

