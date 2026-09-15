Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22B48F848;
	Tue, 15 Sep 2026 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470941; cv=none; b=HKjAm4qzmAO3aX+kDiMVsDLi7DhFSluGkHdur13LLnl8hK+YXDgOPT0EBI/Ddb9P6bs0hRcGlVu7FdnFvO+2kq3LzpJxSj/bBEZiiphpyHbpa69+lesSJJV3U9scQsjfSWkT8QSS4tzWVMLGTeJgZq/2BESq0FGixT6gTh+cu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470941; c=relaxed/simple;
	bh=xlgdz85g5ZuvQDNFwEowu0Z8RwHg0Djr8a/zm5VCL+Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ekMLskFoI680K3RzallbG4mgvuogzzVS46cuWd/wMW0xsR/PDDJ0YBEaqWxwXkji2Vy+j9/YHpvGIOsOSyqGOgaJ60s6XB3szHqMeWovga4KCvMQo+FcenLGS/4wrdRu4TQ90X+bx0hBQEKLiLAwVkR6J7hyxvYwcBjjX15IJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiY5TgJP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiY5TgJP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD9D8C2BCB9;
	Tue, 15 Sep 2026 11:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789470940;
	bh=xlgdz85g5ZuvQDNFwEowu0Z8RwHg0Djr8a/zm5VCL+Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YiY5TgJPmXGG8LueEm0cgPWY5sEzZzk6QMXudpQo3hV83i3rtGYYuMsFKiuo0mr1O
	 sqUPjOXClXbo1Iq02g9vdSZ2fd1Mn/iDU7jmqMZgqYPDzvY0q3KHd9j+7/R7qivBhX
	 N9KEBeV5iZSF43yytB5ixHpsI5WcbhTVmsWcnpoyN3H7xk3sWmHoa1PCDU+S7RXJdX
	 pIomCEO3tQOvpyaQnIyblEEA+ZJqwSgZK6XJAQAXWcIDU4nDfnfJACm9ADYd8819QY
	 lxk6mBTdBF3y87KkOCg8gEjH8BACIb3sJah9i8SUGiBYpwAn+poEgUPx7Yi+KVqxlt
	 8/IeJnobJk77A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A74C88E7B;
	Tue, 15 Sep 2026 11:15:40 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Subject: [PATCH v7 00/15] Ambarella CV75 SoC minimal bring-up
Date: Tue, 15 Sep 2026 19:15:30 +0800
Message-Id: <20260915-cv75-v5-v7-0-3297d3fbc9c0@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANIoqWoC/0WOSwrCMBQAr1Le2idJ+ku68h7iIomvNtI0ktQgl
 N7dVkGXA8MwCySKjhJ0xQKRsksuTBu0hwLsoKcbobtuDIKJhkku0ea2xlyjIsFKZcpKGQub3cf
 gcR4i6b+vWPXzc4MMSXFZ88qa0vCT9kZHGkd9tMHviUek3r0+M+fLl9PT3MnOexHW9Q25YUTtr
 gAAAA==
X-Change-ID: 20260818-cv75-v5-9e2039b349bc
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789470938; l=7469;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=xlgdz85g5ZuvQDNFwEowu0Z8RwHg0Djr8a/zm5VCL+Q=;
 b=BA72ZKeOmT3/gbCnaGOMODUBLhSs+m+oA9GAo9GOoPgN85sCwaMR6fbroAMr/B2JCKdkHMXUb
 fEcloGtLYziDy+Xw9FQ0GH8BCpi/Azx27P/12UasEYcENM2t3qX0i18
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

This series adds minimal Ambarella CV75 support for early bring-up with
a serial console: DT bindings, RCT clocks, pinctrl, PL061 GPIO via
gpio-regmap, 8250_dw UART quirks, ARCH_AMBARELLA, CV75 EVK DT, and
MAINTAINERS.

This is a single unified series. Please apply via the SoC
tree; subsystem maintainers are Cc'd for their pieces.

GPIO data path uses gpio-regmap with two layouts (ARM PrimeCell and
Ambarella). IRQ stays a custom PL061 irqchip: a linear domain is
created after gpio_regmap_register(), attached with
gpiochip_irqchip_add_domain() via gpio_regmap_get_chip(), and the
chained handler uses gpio_chip as chip data. gpio-regmap girq and
regmap-irq are not used.

Verified with:
- scripts/checkpatch.pl --strict (0 errors)
- make dt_binding_check DT_SCHEMA_FILES=ambarella:pl061-gpio.yaml:syscon.yaml:snps-dw-apb-uart.yaml
- make CHECK_DTBS=y ambarella/cv75-evk.dtb
- arm64 build of new drivers/DTS
- CV75 EVK: console via 8250_dw (dw-apb-uart); GPIO edge IRQ
  (gpio-hammer / gpio-event-mon)

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
Changes in v7:
- gpio: 10/15 convert ARM PL061 to gpio-regmap; 11/15 add Ambarella
  layout with a second gpio_regmap config (Andy)
- gpio: 10/15 drop gpio-regmap girq; custom irqchip with a linear
  domain, gpio_chip chip data, and a chained handler (Andy)
- gpio-regmap: 08/15 write_data_after_dir; 09/15 gpio_regmap_get_chip()
  and quirk kerneldoc (Andy)
- dt-bindings: gpio: 05/15 $ref arm/primecell.yaml and
  unevaluatedProperties (Rob)
- clk: fold the RCT driver into a single clk-cv75.c (Jerome)
- serial: 8250_dw startup only updates the up->ier shadow (Ilpo)
- collect lore tags on unchanged patches (Linus Reviewed-by; Krzysztof
  Acked-by on the UART binding)

Link to v6:
https://lore.kernel.org/r/20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com

Changes in v6:
- gpio: convert gpio-pl061 data path to gpio-regmap; keep PL061 irqchip
  (Andy, Linus). Add write_data_after_dir + girq helpers to gpio-regmap.
  Ambarella layout uses JEP106 periphid 0x000e8061; no AFSEL clearing in
  the GPIO driver; Ambarella skips unverified GPIO PM save/restore
- serial: restore 8250_dw Ambarella quirks from v3; drop standalone
  8250_ambarella (Andy). Commit message clarifies Ambarella IP with a
  DW-like register map needing only a thin quirk. Binding under
  snps-dw-apb-uart; DT uses ambarella,cv75-uart + snps,dw-apb-uart with
  reg-shift/reg-io-width
- clock/RCT: document #reset-cells (Krzysztof); soft-reset ID header and
  reset provider deferred (no resets= consumers in this series)
- arm64/Kconfig: do not select ARM_PSCI / HAVE_ARM_ARCH_TIMER (Sashiko)
- pinctrl: no Ambarella suspend/resume claim without validated PM

Link to v5:
https://lore.kernel.org/r/20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com
Link to v2:
https://lore.kernel.org/r/20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com
Link to v3-A:
https://lore.kernel.org/r/20260813-cv75-v3-a-v3-0-cfdd20b1b4dd@ambarella.com
Link to v3-B:
https://lore.kernel.org/r/20260813-cv75-v3-b-v3-0-1d82e18da09b@ambarella.com
Link to v3-C:
https://lore.kernel.org/r/20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com
Link to v4-B:
https://lore.kernel.org/r/20260814-cv75-v4-b-v4-0-622e63153d97@ambarella.com

To: Arnd Bergmann <arnd@arndb.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: soc@lists.linux.dev
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Long Zhao <zl020895@163.com>
Cc: Lee Jones <lee@kernel.org>
Cc: mfd@lists.linux.dev
Cc: devicetree@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Long Zhao (15):
      dt-bindings: arm: add Ambarella CV75 platforms
      dt-bindings: mfd: syscon: add Ambarella CV75 secure scratchpad
      dt-bindings: clock: add Ambarella CV75 RCT
      dt-bindings: pinctrl: add Ambarella CV75 pinctrl
      dt-bindings: gpio: pl061: add Ambarella CV75 variant
      dt-bindings: serial: snps-dw-apb-uart: add ambarella,cv75-uart
      clk: ambarella: add CV75 RCT clock controller
      gpiolib: regmap: add write_data_after_dir quirk
      gpiolib: regmap: add gpio_regmap_get_chip()
      gpio: pl061: convert to gpio-regmap and a custom irqchip
      gpio: pl061: add Ambarella register-layout variant
      pinctrl: ambarella: add CV75 pin controller
      serial: 8250_dw: add Ambarella CV75 quirks
      arm64: ambarella: add ARCH_AMBARELLA and CV75 EVK DT
      MAINTAINERS: add ARM/AMBARELLA SoC support

 .../devicetree/bindings/arm/ambarella.yaml         |  24 +
 .../bindings/clock/ambarella,cv75-rct.yaml         |  64 +++
 .../devicetree/bindings/gpio/pl061-gpio.yaml       |  25 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   1 +
 .../bindings/pinctrl/ambarella,cv75-pinctrl.yaml   | 237 +++++++++
 .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  14 +
 arch/arm64/Kconfig.platforms                       |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/ambarella/Makefile             |   3 +
 arch/arm64/boot/dts/ambarella/cv75-evk.dts         |  30 ++
 arch/arm64/boot/dts/ambarella/cv75.dtsi            | 177 +++++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/ambarella/Kconfig                      |   9 +
 drivers/clk/ambarella/Makefile                     |   3 +
 drivers/clk/ambarella/clk-cv75.c                   | 366 +++++++++++++
 drivers/gpio/Kconfig                               |   2 +
 drivers/gpio/gpio-pl061.c                          | 589 ++++++++++++++-------
 drivers/gpio/gpio-regmap.c                         |  40 +-
 drivers/pinctrl/Kconfig                            |  17 +
 drivers/pinctrl/Makefile                           |   2 +
 drivers/pinctrl/pinctrl-ambarella-cv75.c           | 554 +++++++++++++++++++
 drivers/pinctrl/pinctrl-ambarella.c                | 554 +++++++++++++++++++
 drivers/pinctrl/pinctrl-ambarella.h                |  44 ++
 drivers/tty/serial/8250/8250_dw.c                  |  32 ++
 include/dt-bindings/clock/ambarella,cv75-rct.h     |  14 +
 include/linux/amba/bus.h                           |   1 +
 include/linux/gpio/regmap.h                        |   9 +
 31 files changed, 2625 insertions(+), 199 deletions(-)
---
base-commit: 34cf6dafc47441dfb6b356a095b89c3585a93714
change-id: 20260818-cv75-v5-9e2039b349bc

Best regards,
--  
Long Zhao <longzhao@ambarella.com>


