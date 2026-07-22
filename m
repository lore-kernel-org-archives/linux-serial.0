Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981E47010E
	for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714174; cv=none; b=nsiW06cGRmfMj+l8A4pmZtN+kt5BFL/PgXE4vnJboveY7Z7/xbJZhlt/HczKzMQ2nh+jsAmO2ridpRliqPI2l7yQ19BV1yTMOtVb+1PTOXqyXyp7fwvcl84bamefqwcQ4WlBOmu33BQMPnKQqqdN93ujkuGAzVkGdUOG0D9O04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714174; c=relaxed/simple;
	bh=9LvGxvNSc04gEvH05YcEvZdgJ9Kd3n1dE0XAfkXYM4E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e8ysiapo5HjWBHafOgOGIjiEeCK/HBVUTdJ9U9iWhT2bMcAmA4hyJYI+QRl7i+Q1LqveIWS+BM8edwFqmMENLmwR6PPfle8+N0FMPvZK65KLWV5gYRXbzcr5kWVJQsl2tMRbEwl+SSvGv5yvBMuDhgVpUkYf/KJzRCA8Cw3hU/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IquQQvT7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IquQQvT7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f878135e0so235374f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784714169; x=1785318969; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=czz2pXk/RoUWqIRbuJa5XveWzwRZGqxPRQFLkTx/vUM=;
        b=IquQQvT7xUmx+0M0D+Gx5iuN4hyM8ht0sLXp7rGNzKCRkPNyFctO4tnG5/IqSN8MQz
         JAwTqUwNNzCAQavEBXqPBlFWKuOLv9FozbBOZE7xN+Z4gzk8XHBrqICZr4cm7kVNa6Zu
         /lJAGkwqwfKe5CdqPlDuC0/b08LRB0SenOq/hyqqkOBwsS6UfFbfLTilP2DdVSWFSGXT
         4bjz8peTEyb5WJfQenIZ/qoiMJ9huy4b4+ltvi/dIImP/SdYscBq46IZ//3BtPYElfXF
         w88YfL2QFPJ8c0DcPnJ7C0YbzvsW4A8HLBdUfS5De+JF1q/RhtZe8xv8CUsNdknSTxG3
         mYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784714169; x=1785318969;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=czz2pXk/RoUWqIRbuJa5XveWzwRZGqxPRQFLkTx/vUM=;
        b=cTKp7b8siJbh2GQZkHP/QTY8MiirePkgGwwC2hABt9PiSGvBbJJKPBozM1cWcDzfnc
         W5sCvvq7hMo/HtJLE6EHo4yZORcu4d/yPzdI4i6+oYtIyWfriCAgHWd7e7f6XBnBqtwm
         1ZFxYSUcaDJGyWBsX7yOtEJ0LmhYikKeqdYKzEPd730B14KyFbtep3I6Ji7DC8oaBN2J
         OYTHmFUMfsTyRgf2TmzwpNw7FIgwlxUHTXYLPor1ej3ESdm0zYNnPvppvoMKuxFtVOYD
         mlL5J5zkjTUzL87bFp09v4/tY1oGa53zFa20HAUFBENP/2wJT7JDOjOLlxjgNj9k260O
         sB+A==
X-Forwarded-Encrypted: i=1; AHgh+RoQJPCly59dpxn8JEl90kQ6CWN6i6Su5Bho/26sfIw1+BaEoszn1Up0zsTKBTmsmiL7urBtWSpbKrftJCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm75oo+rLcS1KW5MNKDAQUQkqnmdd6yUr+/W0jFbyX3wcx3ohz
	DqTLoOrr98qodexrlWf04GrNO0LG+lBvx1UssIrEW+/l0eQhzoGrCgph6RZ4OPWyBpk=
X-Gm-Gg: AR+sD10jKsnX/vBG1L42jM47ZBpBXQiEq7+H0Ycz1nzM1EjZYyA2GR/hLZdd9Mb/c7O
	myC83wQ6jI2BATbijlbWrCSbSrHon3vuXpTHHqyKk1rWTbMpWzB4f47P0ao1dX31UnA4UwUo4U6
	U45thjLcq66mwZ5LcsEIvCfXzvR8KxTSuC4jqB1Hm7HKxWbUyjcqTNhEvcEjxxSNmSQogWJCot/
	UT3jj8wxNTAi7+cPtk+a4kqjHRTT1gBzpPSjyXKJMseyppliy3PWOlt8YdagapGq5DZKu3iku78
	5MoVusCQ1zK7gq/mOSGtN6nDF5GjGZonSFYU5FMJR/hwc2zbwRGPLH84qrfQ/KusE61v95xnzr8
	mrDhVAKVPcfGV0fnSlKZdbYnxUS1umJeOEdCUA8GRwOTkJz/1mHUWfNeTtp9WNMErQsVD65I4vK
	NBVADg/FozAxXGhP2JRG96am9zJYH7JOBxAQ==
X-Received: by 2002:a05:6000:4211:b0:47f:778a:6587 with SMTP id ffacd0b85a97d-47f778a6775mr15011918f8f.40.1784714168736;
        Wed, 22 Jul 2026 02:56:08 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([2a00:23c7:314c:4601:ea7:d5d4:79db:6d52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c532d4sm4414533f8f.22.2026.07.22.02.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:56:08 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 0/5] Add Laguna/Tensor G5 SoC and Frankel, Blazer &
 Mustang boards
Date: Wed, 22 Jul 2026 10:55:51 +0100
Message-Id: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKeTYGoC/xWNQQqEMBAEvyJzdiCGNbL7FfGgcdQGiSEJIoh/3
 /FYTdF1U5YEyfSrbkpyIuMICrauyG9jWIUxK5M11pmuMeyPUBImjitHXLLrhICCcee5ZP58l1a
 8a7vJOdKTmGRR7Q30w/P8AeIvXNlwAAAA
X-Change-ID: 20260710-contrib-pg-pixel10-initial-dts-49f5ec657b66
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-serial@vger.kernel.org, soc@lists.linux.dev, 
 Douglas Anderson <dianders@chromium.org>, Juan Yescas <jyescas@google.com>, 
 RD Babiera <rdbabiera@google.com>, Brian Norris <briannorris@google.com>, 
 William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5682;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=9LvGxvNSc04gEvH05YcEvZdgJ9Kd3n1dE0XAfkXYM4E=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqYJO1FTOQh2Xnhd1R6kiN2IChC7cxVMZrCc8kU
 SjI5BBvxR6JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCamCTtQAKCRDO6LjWAjRy
 utZ/D/4wrBAifd5y+luQ/441+vTlMrCYREjybtztCUiD/tsCMVGvmJX6JsWuKzD3N1w8sWe0eJ2
 lwslJS3RMayKq1WFUSKEdEz1Bq0HJyUNCElAfCPMOol9NbTj7L8J7ub+/Mo3yDSUEEZVvNBnqC3
 G19HjiPTb4oap+VioP5/pMyera50ImWZHgxqcQs52Y/6oxtkgrLVqpZlIdabE4ps7pWsw/oFP3L
 ANjgO3r3qtoQ6vY7FBqbvOLWC6c24ev8UUcrMpVFwqG67+sgJOLe7D2TAHJB+2ypN+/eTvbZfhe
 BfXceBHhitrTXlxeD1oSokjOgM9J02u8u59fGmCVGkoxj+abuQ2PLBfh+lnQjbQXpC31Ssc8WFi
 1E+FckfGMU1squp+92je+rF1O3bnhIuuOqZu1xvtlKRSMBDKCL3Q1QlDHnfPuO4Jmp6IwbbAoUJ
 dEijNChKVMegNUqTJYmkmAyDLhcZxFhe4Ix+CkIdYzTa28X8BSsFihdeaA41uAtRLDpjwRtAM3n
 DCB3cDtkEANg/D9Wu0/e9hzHN02sh/JE4cysKEYDE1W1CMzbgGUUCf+2hEnsG1OVLdXpL3FrUsx
 AaUDrBu6C9OeCou7ENSW5Dq8wwNvSWo8/cyPZgFE9PlWLZ3h8PR3DodkVNHBWQ364yw8U1pI08D
 u6yPrY8rMaW1phw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Hi folks,

This series adds initial basic support for Laguna (Tensor G5 SoC)
found in Frankel (Pixel 10), Blazer (Pixel 10 Pro) and Mustang (Pixel
10 Pro XL) phones.

Whilst Tensor G1 to G4 SoCs (found in Pixel 6 to Pixel 9 and Pixel
10a) were offshoots from the Samsung Exynos family. Laguna is an
entirely in-house Google designed SoC.

Currently this series adds very basic DT capable of booting to a
initramfs busybox shell and is a v2 of Dougs original submission with
the contentious DT overlay parts removed.

Whilst there is still interest in resolving the DT overlay topic (as
I believe many vendors use this approach). I would like to decouple
merging initial Laguna / Pixel 10  support from resolving that
particular issue. I believe Doug intends to revisit the topic again at
Linux Plumbers in Prague later this year.

In v2 I've updated to use the usual upstream approach of having
individual board files e.g. lga-frankel.dtb, lga-blazer.dtb,
lga-mustang.dtb  the same as gs101-oriole.dtb and gs101-raven.dtb.

It is worth noting, that with what is currently supported upstream there
aren't any known differences versus pre mass production boards yet. So
lga-blazer.dtb boots fine on my EVT 1.1 board with A0 silicon.

At the point where differences do arise, we may need to either add A0
silicon cut and other board variants upstream, or keep upstream as
purely MP/B0 silicon and maintain a separate out of tree DT that uses
overlays for Googlers needing to use pre MP devices. So far at least
with Pixel 6 that wasn't necessary.

Folks interested in trying this out and booting a pure upstream kernel
on their own Pixel 10 device may wish to use the build system and docs
found here:

https://gitlab.com/LinaroLtd/googlelt/pixelscripts

Example commands:

make RUNTARGET=frankel flash
make RUNTARGET=blazer flash

Also in v2 I've added support for ramoops reserved-memory carveout and
tested with `console=pstore` kernel argument. Additionally carveouts
for the ABL bootloader are added (which is used when doing a debug
boot (e.g. after a watchdog timeout). This allows for the extraction
of various logs via fastboot oem commands (bootloader / kernel
logs). The bootloader log can also be quite useful as it contains some
amount of on device debug parsing which can provide some hints after a
crash.

regards,

Peter

Changes in v2:
 * Enable CONFIG_ARCH_GOOGLE in arm64 defconfig
 * Remove all the pre-production dt binding support (EVT, DVT, a0)
 * Remove dtbo overlays and add individual board dts
 * Update to lga-pixel-common naming like gs101-pixel-common
 * Reorder nodes alpha-numerically by the node name
 * Add ramoops reserved-memory (tested with console=pstore)
 * Add reserved-memory for bootloader & gsa logs
 * Add reserved-memory for Android BootLoader ABL (used on Watchdog
   reset to extract boolotader logs / parse breadcrumbs / ramdump etc).
 * Add osc 38.4Mhz fixed-clock

v1: https://lore.kernel.org/lkml/20251111192422.4180216-1-dianders@chromium.org/

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: André Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Walleij <linusw@kernel.org>
To: Drew Fustini <fustini@kernel.org>
To: Kees Cook <kees@kernel.org>
To: Tony Luck <tony.luck@intel.com>
To: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Juan Yescas <jyescas@google.com>
Cc: RD Babiera <rdbabiera@google.com>
Cc: Brian Norris <briannorris@google.com>
Cc: William McVicker <willmcvicker@google.com>
Cc: devicetree@vger.kernel.org
Cc: kernel-team@android.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: soc@lists.linux.dev

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Douglas Anderson (3):
      dt-bindings: serial: snps-dw-apb-uart: Add "google,lga-uart"
      arm64: dts: google: Add dts directory for Google-designed silicon
      arm64: dts: google: Add initial dts for frankel/blazer/mustang

Peter Griffin (2):
      dt-bindings: arm: google: Add dt bindings for frankel/blazer/mustang
      arm64: defconfig: enable Tensor G5 SoC family

 Documentation/devicetree/bindings/arm/google.yaml  |  48 ++-
 .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
 MAINTAINERS                                        |   1 +
 arch/arm64/Kconfig.platforms                       |   8 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/google/Makefile                |   6 +
 arch/arm64/boot/dts/google/lga-blazer.dts          |  15 +
 arch/arm64/boot/dts/google/lga-frankel.dts         |  16 +
 arch/arm64/boot/dts/google/lga-mustang.dts         |  15 +
 arch/arm64/boot/dts/google/lga-pixel-common.dtsi   |  23 ++
 arch/arm64/boot/dts/google/lga.dtsi                | 423 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 12 files changed, 539 insertions(+), 19 deletions(-)
---
base-commit: 17c7841d09ee7d33557fd075562d9289b6018c90
change-id: 20260710-contrib-pg-pixel10-initial-dts-49f5ec657b66

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>

