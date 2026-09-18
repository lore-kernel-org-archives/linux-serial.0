Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2C48F02E
	for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789758322; cv=none; b=eFX2ZNw0jLBks4tY/Aji3ONLMdn3lqaK1FOEeEz6ygYI8mTNrlXT0Ezw2KAkziSbpxEkMRzxHMRFEPvJnNp8UftMJhD7wf3fd6lJamt1BB63jCfFHUs2d5mA3+cSu6QRFMSwVrxkxQpDgUy88qirn1mxGe2cVm/bg3kQ99V0TKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789758322; c=relaxed/simple;
	bh=idSz/4f1QVQHoHKJ9HY7cLr1ePY0I9DKUIMLr0x6hpE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mezhcaf95anVe7Sl958WR+v2L8QFj/lrRuhq09Sf5RXOv1r9C0ECC5F4tBK4H+plPKXn5VJtHhuNH088t2HvOdOY1fXJlUhfEe+bqbAFRO9vedEaEde9Km9Vm+vKeklccqMn2S/KcxiHGnmq/iHdNWjPqjgaDV57Q9zKylkPMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YuEGEkJp; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuEGEkJp"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605844571so1452036a12.3
        for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789758317; x=1790363117; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xA9TqT56uzHoio3Dn/bRlfu7pF+Mn+DEDcT+jkOCFzY=;
        b=YuEGEkJpVgQMsvygfEWvZzJU7UknGFUoBh5fH2kkT9gJKtknV5+rAMez4omdBBR9k8
         Y6sKriVwaZuOXxjoqCWtAhc0YbU5Nq6dKd+A5lWvogcWt93S9h0/mpqTVIdDRngswMqi
         sNsTtr9vNu/OTPdLRgIYMQ9kPLn4nS3HUoIAg0WHCoDfjc3i3eZ5IFH5XPgPnY76Og9m
         B94hTmrC3oECH2fvavu3xxXZ7safoOGG6x0vbR0WmIpGw1X6lYa8SpuJddH1xb6ccHKt
         SfMKmtwWR1oUIG9v3y+hUz9Dh3uQ6K2m2ppJnlkxlKGR3nhs0Gk3/6SPrthnsF2kB9VI
         C0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789758317; x=1790363117;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xA9TqT56uzHoio3Dn/bRlfu7pF+Mn+DEDcT+jkOCFzY=;
        b=PZ/dcg5cS2lqCcRr4wPFF3CchnTsxu1c0/YvW6Dben5ORmBXQHqO0UmLp37wwid7T6
         kbglnk8Uf1ntsNcNPItcJll4hiFMlW9pj0UBx1Bc4cMy6097H7CHZRR+gNEIe6KS+klf
         MF9mMU6h6Liv0MIGqCnH1ytJTDvUb5K368Dhvnq+p9xzN3dTYRDSJdIW/kwvmujoPFKz
         tBaI/XDqdORDgkoZKzyZJjl0h7vnraMuvpTx28dE4nv5ADmVrdBqyis4dGQB+lJ6Zmvl
         P13xkP4ypA1P0aHAwFhFel1YNaHIsskolaznnFajYTOQJvYEd3rM0TGRhbYDG9689b7i
         tQPQ==
X-Forwarded-Encrypted: i=1; AKwUvBz707Uwn0t3+OLl8xvvszrySVwoQNuwgRzkTESXXifztK6/iLP45kWFXmzGvRPzRTbNM+K3tx4TBfsFBJU=@vger.kernel.org
X-Gm-Message-State: AFuF++mtfOlbNU+yAktHp0iKVn4Q0Dh9mZK6sjtHmEOcmRFzbLYitIEg
	9RCw+lJVYbYZkSW2H2gmHfkTRHv8BS1Jb2cUgp1+tF/HAr5DII40yBcZAbd32YipFD4=
X-Gm-Gg: AYBFou2fP9TSKWghM7zA43PTrAGus4h4RPqdmUHd3fqO1LEdT3pObzidWqbFloRaMR1
	6KJ1ru9w48jJbEn7U2pu1f4FbpgVRAR3zvKaI5IKvBZtG8afNNYoMHuSsMzpNyr0RXoTzIVWxm/
	epgYGOr++RlwEoNAaaze8ngBiNZ4GK84koZkOSvw0uUYQ3cm4ATvD46s4n/ajlZ9Ax8rkPDQn8i
	E0E4zQyk8ypepfpdsZWuUiBLJbc5B+vXu3C8Uey+keB/alu2oeVj0JA3fDaqC/B2kaTCXNxPApz
	yUwr90w+xxjkewRPk44A2cNN268U9aLc1Y70GxOjaTRK32mjmWJ/QyaETZlEeSBM4hSisylw7H3
	/TTz8puBDS2ist/NAxdrGe7udM1wSX0QMGd2guqyOiVI6d3lBOU+dQhG+f5QKrtiaeRpjPDB9LT
	vUkSpQDU6OBfb7LXFO7ceZLukrid173D6PW9h3sCQWv+XHwWZ6oqauCH4YBHo8V3owuMkt+OvTM
	O1kIZ2rL5/uqigOxES72rz9wkjXB2heUKz4Lh7rVtbFG5Liex6UZ2tytdJXKbiWzQ==
X-Received: by 2002:a05:6402:4145:b0:6a9:9766:59ad with SMTP id 4fb4d7f45d1cf-6aa548d810emr2704620a12.43.1789758316858;
        Fri, 18 Sep 2026 12:05:16 -0700 (PDT)
Received: from petegriffin.c.googlers.com (116.118.90.34.bc.googleusercontent.com. [34.90.118.116])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67d816b5sm276250a12.7.2026.09.18.12.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 12:05:16 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v4 0/4] Add Laguna/Tensor G5 SoC and Frankel, Blazer &
 Mustang boards
Date: Fri, 18 Sep 2026 19:05:01 +0000
Message-Id: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF2LrWoC/4XNzQrCMBAE4FcpObuSpH/Gk+8hHtJ02y6UpCQhK
 KXvbiqCeOpxhuGblQX0hIFdi5V5TBTI2RyqU8HMpO2IQH3OTHLZ8FZwMM5GTx0sIyz0xDlXZCm
 SnqGPASo11Giauu2ahmVk8Tjk2X5wf+Q8UYjOvz5/Se7tl5byiE4SOJS606ha0Q7Y3Way2ruz8
 yPb7VT+PCUuh16ZPaMqrIWoeM3Vn7dt2xvRUDUyHQEAAA==
X-Change-ID: 20260710-contrib-pg-pixel10-initial-dts-49f5ec657b66
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>, 
 Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
 Brian Norris <briannorris@google.com>, 
 William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-serial@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6963;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=idSz/4f1QVQHoHKJ9HY7cLr1ePY0I9DKUIMLr0x6hpE=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqrYtqcAeTl4ZeFIg7dO9m7NUqCkkLgycw9oehj
 jgCwjJLiYGJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaq2LagAKCRDO6LjWAjRy
 usewD/9JNAfxX1k3uSFD2XVvKZUgoCdpQzRMB/OOun7KDcIGoM/oz0Qkzkhoh152OjHRCZIlvwo
 pKBMsc1tsYxhgrz1QQ5sAr3GdIU9Dt9ZVvrwRGUw4fYpkmWVue7tbK7ajJw+OHmmzDR+FrkhUcA
 tFk/zKD7kdeee0UPBoCjEiq15S97/HaP2zGXYCsDsKM3Q2w+jRgkpZLQuTJlsaCq5dFv2XIr0vc
 jAowh+gjOp9mGjpNnjZTTzh+JzIPXmxsl1BwLZRwKmRloEQ6Q7KZyqDtOtyaTsrQmNqIObUjm/I
 sSEVtmDk0B3p2EyE15N8XswTr4uoBJYzwlfdLWWrMmg6/bh6/sX+dnoi4elqDK3esLwoTTArhri
 4LtjtoNnW7TtuaEM9ua3ukbGRjVwDt5xfeOoyjt2Xq5cFVwqozROK9VKP/6ZD5pf46Zwvml6egS
 Eo+9E6kbJwG9HiGh4oF5chFWrtu1DpArOIYuoQC+5Nvsf+xGJSTz4kUFeVwQGRfylTg3pCxt0Xk
 QFVm84K+hVyXMzk5p7/eOR6rMeD9qRjIZbZsv6DhryZGHnP6yDFkToprioAXs5iMnFNiiuc31Gu
 s/WeebW7DotX0PG0XjcETPbB1qOInjEMZbOm5DpHY17pdMtx6n7aFm8A+K/bEX2a495pj44wg30
 blqClLuoEWjYRNw==
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
initramfs busybox shell and is a v3 of Dougs original v1 submission
with the contentious DT overlay parts removed.

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

Note: In v3 the ufs0 alias has been removed but the bootloader will
consider a missing ufs0 alias a fatal error. Whilst we wait for a new
bootloader release that changes that behaviour (kudos to Doug) the
pixelscripts Makefile [1] will apply the node so that upstream DTBs
are kept clean but things still boot on the device (see [1]).

regards,

Peter

[1] https://gitlab.com/LinaroLtd/googlelt/pixelscripts/-/commit/156bd361b39c55303cb4de33cd66ace9b1f610f2

Changes in v4:
- Fix one remaining dt-check-style in lga-frankel (Peter)
- Fix one remaining dt-check-style in lga-pixel-common (Peter)
- Link to v3: https://lore.kernel.org/r/20260918-contrib-pg-pixel10-initial-dts-v3-0-c94e51140509@linaro.org

Changes in v3:
- Rebase on next-20260918
- Collect up Reviewed-by / Tested-by tags
- Use 0x0 instead of 0 consistently for new code (Krysztof)
- Remove 'ranges' from gic-v3 as no msi child node with unit address (Krysztof)
- Remove ufs0 alias and ufs placeholder node (Krysztof)
- Remove memory node from lga.dtsi (Krysztof)
  It turns out bootloader adds the memory node anyway
- Use standard '/ {' not overlay style (Krysztof)
- Update alias to point at label (Brian)
- Remove GIC_CPU_MASK_SIMPLE for gicv3 interrupt controller (Shashiko)
- Fix dt-check-style --mode=strict warnings (Peter)
- Link to v2: https://lore.kernel.org/r/20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org/

Changes in v2:
- Enable CONFIG_ARCH_GOOGLE in arm64 defconfig
- Remove all the pre-production dt binding support (EVT, DVT, a0)
- Remove dtbo overlays and add individual board dts
- Update to lga-pixel-common naming like gs101-pixel-common
- Reorder nodes alpha-numerically by the node name
- Add ramoops reserved-memory (tested with console=pstore)
- Add reserved-memory for bootloader & gsa logs
- Add reserved-memory for Android BootLoader ABL (used on Watchdog
  reset to extract boolotader logs / parse breadcrumbs / ramdump etc).
- Add osc 38.4Mhz fixed-clock
- Link to v1: https://lore.kernel.org/lkml/20251111192422.4180216-1-dianders@chromium.org/

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
Douglas Anderson (2):
      arm64: dts: google: Add dts directory for Google-designed silicon
      arm64: dts: google: Add initial dts for frankel/blazer/mustang

Peter Griffin (2):
      dt-bindings: arm: google: Add dt bindings for frankel/blazer/mustang
      arm64: defconfig: enable Tensor G5 SoC family

 Documentation/devicetree/bindings/arm/google.yaml |  48 ++-
 MAINTAINERS                                       |   1 +
 arch/arm64/Kconfig.platforms                      |   8 +
 arch/arm64/boot/dts/Makefile                      |   1 +
 arch/arm64/boot/dts/google/Makefile               |   6 +
 arch/arm64/boot/dts/google/lga-blazer.dts         |  15 +
 arch/arm64/boot/dts/google/lga-frankel.dts        |  15 +
 arch/arm64/boot/dts/google/lga-mustang.dts        |  15 +
 arch/arm64/boot/dts/google/lga-pixel-common.dtsi  |  22 ++
 arch/arm64/boot/dts/google/lga.dtsi               | 413 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                      |   1 +
 11 files changed, 526 insertions(+), 19 deletions(-)
---
base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
change-id: 20260710-contrib-pg-pixel10-initial-dts-49f5ec657b66

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>

