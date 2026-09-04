Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA3419FBB;
	Fri,  4 Sep 2026 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503954; cv=none; b=Nfm/c85i7/JtznBC7ToqLkERa1m6H6h3+sTZZ5CoOPPu7/fTEJYd0RQdujbkoxRTCA0PHIU1zdLWNyl3M/749l0N0RuUTRXWSqLxyQ0x5w98swSRcOpcmBLXZyT0zNkFt0FJUJfX2fkJ6SsxuEUARwG+rHPaFDCsZRDdMwj/fY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503954; c=relaxed/simple;
	bh=LxLxPJS2q6jYJIGAo6MwQAdyWp2ZE/7Rdic404uX3xA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tKnOi5bZ1iU8A9miqGXoSuAPjCeBVwba7+S+v4qncRjl84Fhajw8T7w9ntuKJvYSXa2R9T3l8jQ1qxqHEQ3vUNgYKEJMrGxfCW/ojPn5ABYj8IiTuzqW4OU5nd8WJy4PnCoCdcuE5n1ln9AyZ8tIQAygbz/YIJ8X6ijUBd9nFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od8rzj9F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od8rzj9F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6110C2BCF4;
	Fri,  4 Sep 2026 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788503953;
	bh=LxLxPJS2q6jYJIGAo6MwQAdyWp2ZE/7Rdic404uX3xA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=od8rzj9FEh7QOy16N2zqLedQaJO4yv6yxFO58yMOuBl1ldEX4/C2/pJ6e1ihEpNcD
	 8qSOzkhuMdUTxYkIy7KaFI07ZfcMT41DQYKulrgDGDod7t8jMEr/YUORlP45tVuqQl
	 SfFQ9GfZ2Saop7LOj6NEQdgi7v5yav0sFkqg9SA1POuQdAGpdShBkiTiWk+kTntqiM
	 Pb88LfOCdkAQKO9MysYNvsUc3P1et4gXt+dndUw0vkZSQYx+tv8LZJCYfkOO1l894L
	 Ihv2elGUCsr1at1w6V67IJf7wXdQKdXBh8BmMyKrmf6UAbIGvDcezJi3RbFg4niIop
	 TkDDleMsdGVIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D107C61DD6;
	Fri,  4 Sep 2026 06:39:13 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Subject: [PATCH v6 00/13] Ambarella CV75 SoC minimal bring-up
Date: Fri, 04 Sep 2026 14:38:07 +0800
Message-Id: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE9nmmoC/2WNyw7CIBREf6W5azEUhLau/A/TBRcvFtOHgUo0T
 f9dWpcmsznJmZkFIgVPEc7FAoGSj34aM+hDAbYz452Yv2UGwYXmdVkzmyrFkmINCS4blKcGLWT
 7Gcj59750bX8cX/ggO2/1zeh8nKfw2a+S2rz/1RzOKkQsheNSc3cxA5pAfW+OdhqgXdf1C+//V
 q60AAAA
X-Change-ID: 20260818-cv75-v5-9e2039b349bc
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788503951; l=6543;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=LxLxPJS2q6jYJIGAo6MwQAdyWp2ZE/7Rdic404uX3xA=;
 b=ENX8HEu3vC3vFKYcc+0iVKl38o5zcbzl/k14mVuhkoY0elUtXceU6NAL07rLJDdlZeYD5pqG6
 dV8jgL444PmC3m3nsJMVSQEunm2v7OFrtkNfZLI+mD8upIPF4BJmEdn
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

This series adds minimal Ambarella CV75 support for early bring-up with
a serial console: DT bindings, RCT/CCU clocks, pinctrl, PL061 GPIO via
gpio-regmap, 8250_dw UART quirks, ARCH_AMBARELLA, CV75 EVK DT, and
MAINTAINERS.

This is a single unified series. Please apply via the SoC tree;
subsystem maintainers are Cc'd for their pieces.

Verified with:
- scripts/checkpatch.pl --strict (0 errors)
- make dt_binding_check DT_SCHEMA_FILES=ambarella:pl061-gpio.yaml:syscon.yaml:snps-dw-apb-uart.yaml
- make CHECK_DTBS=y ambarella/cv75-evk.dtb
- arm64 build of new drivers/DTS
- CV75 EVK: console via 8250_dw (dw-apb-uart); GPIO edge IRQ
  (gpio-hammer / gpio-event-mon)

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
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
Long Zhao (13):
      dt-bindings: arm: add Ambarella CV75 platforms
      dt-bindings: mfd: syscon: add Ambarella CV75 secure scratchpad
      dt-bindings: clock: add Ambarella CV75 RCT
      dt-bindings: pinctrl: add Ambarella CV75 pinctrl
      dt-bindings: gpio: pl061: add Ambarella CV75 variant
      dt-bindings: serial: snps-dw-apb-uart: add ambarella,cv75-uart
      clk: ambarella: add CV75 CCU driver
      gpio: regmap: support write_data_after_dir and girq
      gpio: pl061: use gpio-regmap and add Ambarella layout
      pinctrl: ambarella: add CV75 pin controller
      serial: 8250_dw: add Ambarella CV75 quirks
      arm64: ambarella: add ARCH_AMBARELLA and CV75 EVK DT
      MAINTAINERS: add ARM/AMBARELLA SoC support

 .../devicetree/bindings/arm/ambarella.yaml         |  24 +
 .../bindings/clock/ambarella,cv75-rct.yaml         |  64 ++
 .../devicetree/bindings/gpio/pl061-gpio.yaml       |  32 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   1 +
 .../bindings/pinctrl/ambarella,cv75-pinctrl.yaml   | 239 +++++++
 .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  14 +
 arch/arm64/Kconfig.platforms                       |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/ambarella/Makefile             |   3 +
 arch/arm64/boot/dts/ambarella/cv75-evk.dts         |  30 +
 arch/arm64/boot/dts/ambarella/cv75.dtsi            | 177 +++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/ambarella/Kconfig                      |  13 +
 drivers/clk/ambarella/Makefile                     |   6 +
 drivers/clk/ambarella/ccu-cv75.c                   | 296 ++++++++
 drivers/clk/ambarella/ccu_common.c                 |  60 ++
 drivers/clk/ambarella/ccu_common.h                 |  25 +
 drivers/clk/ambarella/ccu_mux_div.c                | 234 +++++++
 drivers/clk/ambarella/ccu_mux_div.h                |  35 +
 drivers/clk/ambarella/ccu_pll.c                    | 421 ++++++++++++
 drivers/clk/ambarella/ccu_pll.h                    |  70 ++
 drivers/gpio/Kconfig                               |   2 +
 drivers/gpio/gpio-pl061.c                          | 342 +++++----
 drivers/gpio/gpio-regmap.c                         |  24 +-
 drivers/pinctrl/Kconfig                            |  15 +
 drivers/pinctrl/Makefile                           |   2 +
 drivers/pinctrl/pinctrl-ambarella-cv75.c           | 561 +++++++++++++++
 drivers/pinctrl/pinctrl-ambarella.c                | 761 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-ambarella.h                |  50 ++
 drivers/tty/serial/8250/8250_dw.c                  |  34 +
 include/dt-bindings/clock/ambarella,cv75-rct.h     |  15 +
 include/linux/amba/bus.h                           |   1 +
 include/linux/gpio/regmap.h                        |  13 +
 37 files changed, 3439 insertions(+), 138 deletions(-)
---
base-commit: 34cf6dafc47441dfb6b356a095b89c3585a93714
change-id: 20260818-cv75-v5-9e2039b349bc

Best regards,
--  
Long Zhao <longzhao@ambarella.com>


