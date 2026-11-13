Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596863;
	b=NrTSg6knTs/0Mxoym8NOUqoFVsyjk3j5fWRTyj5bU5tl6Oxpq1w+VRE4f1MWsU2Fph66
	 n/pj6twHp5BIU1GB8L8eeY4eEqzAdeVU4Gh0qK3la9mmhW+reu/plNB7q5a/AInsEX/FR
	 hkrb/jUrldZyV7XDi+6LzHSmcctqC1fk2lIbX9DaOwd2SgFMBkmVVfRlFPlJTKMpQvI96
	 L8lscbPB5jXpjrokBLCZEei34apsPQ5nJ+Uwc5fmxZVCUb4Ammbwqq4qXrYxkK6BFlIh5
	 A0kf5SC+gkP6taSVfzEYY77ZZMATemj9G/7TzJkNF3wNOd6WrALfWBUxLpfMn9pKk8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=+au4NSAQlywMAWAnW8gI9v9WGhRbYIokFF+zwZ5t/v0=;
	b=gk5W+n9pi1tVO0jybcGj4bzZ44FCDGRUCQuATQ+Pefr3WqCkny/xCgxJB506jwoVaJz9
	 /j9mhsh5IezA1YOI1lpDzgR4PvHTvoN6v6vBeGOACWxsSBIvCnruKL9E1teyWWjl/taJt
	 WWOfKn4FzEEokcbky0dHRAQV5CAlAXIBU7IWWZu8FRYOSLvjEJvinVpl6g+BRXR3WKsoA
	 BaNmAaVAHC+VgnePvW+pTrUHXwjJCplAyPnN9Cr0K2Vt/Le8eptP7ovMlBR3LDZstw6Pk
	 MxCJKJj6TQZdxkYcIHCO5y4j/Aq5Qdzh8m8Ip6aZfFp0/I4gqAPBovyCUqmYvZOIDmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oSLT48Xv;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5DD606A334
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D5DD606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oSLT48Xv
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4cdc606b47so297976366b.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 11:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596862; x=1795201662; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+au4NSAQlywMAWAnW8gI9v9WGhRbYIokFF+zwZ5t/v0=;
        b=oSLT48XvEteheX6VpqJzbrrn6VfEudoajN4Z+DlXI0aT1DjUA67jiBZsifrslf5ked
         +QbQNVA1Y3c5aKKPNCe1Z7H+e1CsoJE0vdbAkf8Qqyacogk9YYB5MXF8y9Xvk888yOqp
         eExPG7q68igBfSXDuO7jo+zJeJwtqo0wdmfrsOeENTWTzTCr25dcjjMxYZjuSF3nGiaU
         lEc7vvXCP5+MVC0Vc9CSzFbN3l8obRPLqOCUvn1r7GCYE8oSOmSNmfxuq6LXBplZIMzx
         ol1ch6J54ohRdboVes3cegcwE+kTRGGvWoSJIXAY57vkApGtfLBN4tAGZ5QQNKJE682d
         ptTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596862; x=1795201662;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+au4NSAQlywMAWAnW8gI9v9WGhRbYIokFF+zwZ5t/v0=;
        b=VkLf/XA3Bi7O72Ln77jiAuSyFaYUtQYHkoStDYOWesTZkiLUk8LbreF2wUQEqYQ7i0
         3lnG2QE3erWSRxH3YeAzKP0H7kMX8rxVDbXczFVw9EnaNvUXFsmRavkFhdm9Ux1zlkuT
         f2Bz3WmolNb6oNbhRv+YiS7Ou9mMHKbu8yAFEvft6R0rGh/wCQ/aWJoguIPWMgbapY+Q
         NaA3qJd5lud8pYz9IdvOhFsxjE/hBu5rghtDIaPPiGbd7X+BGoEmUdS/dw2Q6CLxqHhY
         VCA7F/AtfWFzay5p8UbpWwNBe1uaUw7zDidheY6VnsWMKuMhcGyRcdPF2jTS9eWHtJUS
         tImw==
X-Forwarded-Encrypted: i=1; AL+hErHZMI1xx2PWw9y+yEO6rEgVjNCiQ3J3dz5opT51MgWGBP8D/NkKm4qpqrWVA5NgLo3mZlvLu8FvbB6ibZI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iilVGCAooA3pWghOtZby5kflfMkr4ehtLuB2Pb2ttN3rzNjMS
	ClswHGHztqP4Ocb6IvHEgPa44fEJ4mJYvoOxP/9c7jKP5HqFDIlBW2LE
X-Gm-Gg: AYBFou2PTk7E4Mzf+kLbSO2XI2wMdPs/HjL5l4qB4aEMmfkqLx4MNYtJJNDTtgzHdMd
	IhAyNPZmGdwRmTrWCvakpdUr8ba9W0brV5c8Irza3UnjB7uyxt1kvVRxA9QGffkOMhuPJW+Jnag
	Ex40Y2TYQ18+blQ0vJOfd3KxyiUI2giKmuQLuFmLZE7U7+6zsxVwSgUnr2N3VjrJdvWT447jcry
	67wJgiV/YPsTrA56Tt+OHby7+jDIPbZFVKvENhrsZ3tqDwwGSZ+F0JlVUPgy2DN/ufPpwdMYKCN
	3esGKnAFkKte4lGhCfPVyhayMGazrAyBXyztB/y5xZt7jWwCsKt9VOKIZEf1tfbTiptUtn8rAvO
	WuQ11hCFDwNtxp/oWpZNEM6jhPT6nFZnQKb6vLgvMLpJ7ckpUoJmop51uGw8UA/20vf1dsFzVEN
	S2Z2XXqp2+HizcdnCQdK7nby/xtzRUq9HQwCSJ35LvMsh6YvXTXiipwnmc8usLigStdnbCXqLsi
	+JNQBnS/WYAcDauO1FrbLan2Ev36g992/BhrWD9UU4fIzz5LOjwRhfqJ6JmtMzuIbWmIsFpwaQT
	8aIdDHaq4GZZ2XYUz+l6tAXTA91m2pSkiAKZfiUvPTNdtDYpsyXScjDov9s9VklV
X-Received: by 2002:a17:906:7c49:b0:c4d:167d:dcee with SMTP id a640c23a62f3a-c509641047amr235459366b.40.1794596861569;
        Fri, 13 Nov 2026 11:07:41 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:40 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Subject: [PATCH v2 0/9] arm64: mediatek: Add initial MT6895 and Xiaomi Poco
 X4 GT support
Date: Fri, 13 Nov 2026 22:04:56 +0300
Message-Id: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WOzW7DIBAGX8XiXCwWg7Gtqup7VDksZEmo/JMCs
 VpFefdiJ2qPI+3ONzeWKAZKbKhuLNIaUljmAvKlYu6M84l4OBZmUsgWAAQPc8gBRz7ltus1h5Y
 8WEDyWrPydInkw/cu/Dg8OF3tJ7m8WbaLc0h5iT/74grb3VMutATRSllr2RhlOHBMOB6pHgneT
 xOGsXbLxA73hzbS17Xk5scWmygl3HOH6vUp7PglzC7Hv9oVuODeCOWUamwD+O9929osJuIFppC
 HqlNoba+1BQFaGYMIgH1L0jfowPZNZ43xqitF919F2EzfSAEAAA==
X-Change-ID: 20261110-initial-mt6895-16ef1b1aef55
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2

This series adds initial support for the MediaTek MT6895 (Dimensity
8000/8100) SoC and the Xiaomi xaga board, sold as Xiaomi Poco X4 GT, Redmi
Note 11T Pro/Pro+ and Redmi K50i. It is enough to boot to an initramfs
with a serial console, CPU idle, the CPU and DSU PMUs and the volume down
key.

Dependencies
------------
The SoC DT describes the pin controller and the board DT uses its pinmux
macros, so this series depends on the MT6895 pinctrl series:
https://lore.kernel.org/r/20261108-pinctrl-mt6895-v1-0-f704c443b31a@gmail.com

Bootloader dependency
---------------------
This was tested with a modified LK bootloader that is not public.
The stock LK cannot boot this DT, as its Android fixups expect nodes
that are not present here.

The DT relies on the bootloader to:

 - update the /memory node
 - add all firmware carveouts to /reserved-memory
 - pass the command line from the boot image

The carveout addresses are therefore not listed in the DT, as the
bootloader allocates some of them dynamically. I can describe the
fixed ones in the DT if that is preferred.

Firmware behaviour
------------------
Two things in the stock TF-A affect what the DT describes, but not the
DT itself:

 - TF-A rejects CPU_SUSPEND for about the first 40 seconds after boot.
   The vendor kernel lifts this earlier with a SiP call, so with this
   series the idle states only start to be used after that time.
 - The DSU PMU registers are lost when the cluster powers down. TF-A
   can preserve them (PRESERVE_DSU_PMU_REGS), but the MediaTek firmware
   does not, so DSU PMU counts are only reliable while the cluster stays
   powered up.

Testing
-------
Tested on a Poco X4 GT with 8 GiB of RAM, using a minimal config and a
script in the initramfs. The results were:

 - All 8 CPUs come up and match the DT (A55 on 0-3, A78 on 4-7), and
   CPUs 1-7 can be taken offline and brought back through PSCI.
 - The cache sizes and geometry in sysfs match the CCSIDR registers on
   every CPU.
 - The redistributor is found for each CPU, and timer interrupts reach
   every CPU.
 - Once TF-A accepts CPU_SUSPEND, every CPU enters the CPU and cluster
   power down states, and the system timer wakes them up as the
   broadcast timer.
 - Each core PMU counts only on its own CPUs, and its overflow interrupt
   arrives on the right CPU through its PPI partition.
 - The DSU PMU counts, and its overflow interrupt arrives on SPI 18.
 - The pin configuration of the UART0 and keypad pins matches the DT.
 - The volume down key reports presses and releases, with no bounce
   through the 32 ms debounce.
 - UART0 output works at 921600 baud, and its TX interrupt fires on the
   expected line.
 - About 7 GiB of RAM was written and verified with no errors, with the
   carveouts added by the bootloader.
 - The watchdog resets the board once it is no longer pinged, and the
   ramoops console log survives that reset.

UART1 is disabled and was not tested. Only a minimal config was tested
on the device, not defconfig.

Tool use
--------
The commit messages, this cover letter and the test script were
drafted with Claude Code (Claude Opus 5.5). I reviewed them
and tested the result on the device.

Based on next-20261113.

---
Changes in v2:
- Describe MT6895 as Dimensity 8000/8100 in the commit messages.
- watchdog binding: drop the mediatek,mt6589-wdt fallback, as the
  MT6895 reset layout is not known, and drop Conor's Acked-by.
- New patch: add the MT6895 compatible to the mtk_wdt driver.
- New patches: system timer and keypad bindings, pinmux header.
- SoC DT: add the cache nodes, CPU capacities and idle states, the CPU
  PMUs with PPI partitions, the DSU PMU, the system timer with a 13 MHz
  clock, the pin controller and the keypad.
- SoC DT: use IRQ_TYPE_LEVEL_HIGH for the architected timer PPIs.
- SoC DT: order the nodes as required by dt-check-style.
- Board DT: add the UART0 pins and the volume down key.
- The series now depends on the MT6895 pinctrl series.
- Link to v1: https://patch.msgid.link/20261105210622.523747-1-asalde.le1@gmail.com

---
Alexander Letuchiy (9):
      dt-bindings: arm: mediatek: Add MT6895 and Xiaomi Poco X4 GT
      dt-bindings: serial: mediatek,uart: Add compatible for MT6895
      dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT6895
      watchdog: mediatek: Add support for MT6895
      dt-bindings: timer: mediatek,timer: Add compatible for MT6895
      dt-bindings: input: mediatek,mt6779-keypad: Add compatible for MT6895
      arm64: dts: mediatek: Add MT6895 pinmux macro header file
      arm64: dts: mediatek: Add MT6895 SoC
      arm64: dts: mediatek: Add Xiaomi Poco X4 GT

 .../devicetree/bindings/arm/mediatek.yaml          |    4 +
 .../bindings/input/mediatek,mt6779-keypad.yaml     |    1 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |    1 +
 .../devicetree/bindings/timer/mediatek,timer.yaml  |    1 +
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |    1 +
 arch/arm64/boot/dts/mediatek/Makefile              |    1 +
 arch/arm64/boot/dts/mediatek/mt6895-pinfunc.h      | 1524 ++++++++++++++++++++
 .../arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts |   87 ++
 arch/arm64/boot/dts/mediatek/mt6895.dtsi           |  461 ++++++
 drivers/watchdog/mtk_wdt.c                         |    1 +
 10 files changed, 2082 insertions(+)
---
base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
change-id: 20261110-initial-mt6895-16ef1b1aef55
prerequisite-message-id: <20261108-pinctrl-mt6895-v1-0-f704c443b31a@gmail.com>
prerequisite-patch-id: 68c077b6ff907e42d02115ed9b95bb5349eae7ef
prerequisite-patch-id: 09c2602edc0cdb6ca34ecbae12f608ab530da477

Best regards,
--  
Alexander Letuchiy <asalde.le1@gmail.com>

