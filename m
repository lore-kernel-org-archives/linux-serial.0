Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCC451993;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049133; cv=none; b=K51SA/2u/JrRIVIbS/cf/neqxY3di1AcJptRJRSNupN42U1+bgsTIXrBjtQSidhS05jGJPlyNC4GKOR8I5ST0porVyP4fJU6VH0JFZVdqBxWsDpnhDHkWZD5lcvCqj11m2HQk0ESbs56bRRceQB1GhPpXqA+LYuc8tX02Js1D8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049133; c=relaxed/simple;
	bh=SwW+bFSdjpPbLIIaN9qwdh9Xs8IFm4iqtAaKHOy5+wI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZA49aa1nXDCMTi/yuLLgNfyY7tJBO9T4N5XT03r2OVY+ZBCX/SP4tlffesg2UHB8EohHtdiq1bdvXETuXex9rq72j/QFAUZhuET/rIuqd+Rc43ZlnVPqk1kIaIgUe5di0Tss2QBlEzMfOTC0r03EsdRvvoQKltVQlLv2ukq/HGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQIQAFFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQIQAFFp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DA8FC19425;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787049133;
	bh=SwW+bFSdjpPbLIIaN9qwdh9Xs8IFm4iqtAaKHOy5+wI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DQIQAFFpVq47DoRgAODW8yHYWTRjoN6lHrCj16MH4D3ibS2c0t/JZSSircHnXLff+
	 LM6eIQxqWeZIPczAXER6gACQlTX/ij0FRO0yMgoNiT4uysFc2AOCJkBfI8rBEVg8x7
	 guxgP2n6dOXb09dA56VGg7CZg5tfi0+GH//UwCZ2nzf0P1b8IsxufnH5ClBSCCGlfQ
	 lIYmZD5GcsYYKX8QHyTpF13y1r7HHzgaYTET/o+YLD4GbTFJmq1xWqJTshv97PWiRd
	 ci0z2gmNleG3tvpfaEaBaVx3yFY6qK92ZY7rxfuboHGO36s9xPrdWpbeuvvrvvt1nj
	 zH3wRYJsMCN5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438D7C5DF70;
	Tue, 18 Aug 2026 10:32:13 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Subject: [PATCH v5 00/12] Ambarella CV75 SoC minimal bring-up
Date: Tue, 18 Aug 2026 18:31:14 +0800
Message-Id: <20260818-cv75-v5-v5-0-7bbb12f0360f@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHM0hGoC/yXMQQ5AMBCF4avIrDWpVlFXEQutwVggLY1E3F2x/
 JL/vQs8OkIPdXKBw0Ce1iVCpQnYqVtGZNRHg+Ci4FVWMRtKxYJiGgWX2shcGwux3hwOdH5PTfv
 bH2ZGu79zuO8H0MIQd2sAAAA=
X-Change-ID: 20260818-cv75-v5-9e2039b349bc
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>, 
 Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
 Long Zhao <zl020895@163.com>, Long Zhao <longzhao@ambarella.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787049130; l=5497;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=SwW+bFSdjpPbLIIaN9qwdh9Xs8IFm4iqtAaKHOy5+wI=;
 b=PXFTaJd97E5i+nXkFbLaY6nvDuOvYlrc+HQTkitftqGKpuENrGlnDHWRC8wpqq0reJ30wYyDj
 ZobHjFFnFB9BSNdcR/1HgzZ4lnA7OHc5MeDWMyu3r89Zsa+cUtk+w0j
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

This series adds minimal Ambarella CV75 support for early bring-up with
a serial console: DT bindings, RCT/CCU clocks, pinctrl, PL061 GPIO
variant, 8250-based UART, ARCH_AMBARELLA, CV75 EVK DT, and MAINTAINERS.

This is again a single unified series (as in v2). It supersedes the v3
A/B/C split and the later v4 B resend.

  v3-A: bindings + RCT/CCU + SoC/EVK DT + MAINTAINERS
  v3-B / v4-B: pinctrl + PL061 GPIO
  v3-C: 8250_dw UART quirks

Please apply via the SoC tree; subsystem maintainers are Cc'd for their
pieces.

Verified with checkpatch --strict, dt_binding_check (ambarella),
CHECK_DTBS for cv75-evk, and CV75 boot / UART / clk_summary.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
Changes in v5:
- Reunify into one series toward soc@ (v2-style topics); supersede
  v3 A/B/C and v4 B (Krzysztof)
- UART: drop 8250_dw quirks; add standalone 8250_ambarella + binding
  (Linus, Andy)
- Fold review/self-fix commits into the corresponding topic patches
- pinctrl binding: drop redundant groups $ref (Krzysztof)
- Sashiko: address applicable findings
  - clk: guard parent_rate == 0; include fsdiv/fsout in PLL approx;
    clamp VCO range; clear divider disable bit on non-zero set_rate;
    integer determine_rate uses achievable params; 32-bit
    COMPILE_TEST uses DIV64_U64_ROUND_CLOSEST
  - PINCTRL_AMB depends on HAS_IOMEM and defaults when ARCH_AMBARELLA
    (ARCH no longer selects PINCTRL_AMB)
  - IOMUX: one commit per group; use BIT() for altfunc (offset 31)
  - PL061: per-pin AFSEL claim instead of wiping the bank at probe
  - GIC: omit unused #size-cells, keep only #address-cells = <0>
  - RCT remains clock-only (no #reset-cells / reset provider)
- No change: ARM_PSCI / HAVE_ARM_ARCH_TIMER (same as ARCH_AIROHA);
  syscon.yaml has no select block; GPIO pinconf-only DT nodes (GPIO
  mux is via gpiochip request, IOMUX alt 0)

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

---
Long Zhao (12):
      dt-bindings: arm: add Ambarella CV75 platforms
      dt-bindings: mfd: syscon: add Ambarella CV75 secure scratchpad
      dt-bindings: clock: add Ambarella CV75 RCT
      dt-bindings: pinctrl: add Ambarella CV75 pinctrl
      dt-bindings: gpio: pl061: add Ambarella CV75 variant
      dt-bindings: serial: add Ambarella CV75 UART
      clk: ambarella: add CV75 CCU driver
      gpio: pl061: add Ambarella CV75 register layout variant
      pinctrl: ambarella: add CV75 pin controller
      serial: 8250: add Ambarella UART driver
      arm64: ambarella: add ARCH_AMBARELLA and CV75 EVK DT
      MAINTAINERS: add ARM/AMBARELLA SoC support

 .../devicetree/bindings/arm/ambarella.yaml         |  24 +
 .../bindings/clock/ambarella,cv75-rct.yaml         |  58 ++
 .../devicetree/bindings/gpio/pl061-gpio.yaml       |  35 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   1 +
 .../bindings/pinctrl/ambarella,cv75-pinctrl.yaml   | 239 ++++++
 .../bindings/serial/ambarella,cv75-uart.yaml       |  56 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  16 +
 arch/arm64/Kconfig.platforms                       |   8 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/ambarella/Makefile             |   3 +
 arch/arm64/boot/dts/ambarella/cv75-evk.dts         |  30 +
 arch/arm64/boot/dts/ambarella/cv75.dtsi            | 176 +++++
 arch/arm64/configs/defconfig                       |   2 +
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/ambarella/Kconfig                      |  13 +
 drivers/clk/ambarella/Makefile                     |   6 +
 drivers/clk/ambarella/ccu-cv75.c                   | 296 +++++++
 drivers/clk/ambarella/ccu_common.c                 |  60 ++
 drivers/clk/ambarella/ccu_common.h                 |  25 +
 drivers/clk/ambarella/ccu_mux_div.c                | 234 ++++++
 drivers/clk/ambarella/ccu_mux_div.h                |  35 +
 drivers/clk/ambarella/ccu_pll.c                    | 421 ++++++++++
 drivers/clk/ambarella/ccu_pll.h                    |  70 ++
 drivers/gpio/gpio-pl061.c                          | 314 ++++++--
 drivers/pinctrl/Kconfig                            |  15 +
 drivers/pinctrl/Makefile                           |   2 +
 drivers/pinctrl/pinctrl-ambarella-cv75.c           | 561 ++++++++++++++
 drivers/pinctrl/pinctrl-ambarella.c                | 863 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-ambarella.h                |  50 ++
 drivers/tty/serial/8250/8250_ambarella.c           | 312 ++++++++
 drivers/tty/serial/8250/Kconfig                    |   9 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 include/dt-bindings/clock/ambarella,cv75-rct.h     |  15 +
 35 files changed, 3883 insertions(+), 72 deletions(-)
---
base-commit: 34cf6dafc47441dfb6b356a095b89c3585a93714
change-id: 20260818-cv75-v5-9e2039b349bc

Best regards,
--  
Long Zhao <longzhao@ambarella.com>


