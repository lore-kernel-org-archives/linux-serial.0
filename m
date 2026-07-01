Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CCB374198;
	Wed,  1 Jul 2026 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923794; cv=none; b=Z2oPb3ngdzNk4TNr6/QWcwhcfdECIvoznIr2PGzFqCPFnEqTc7vlvo0bKVuQNa2IOge0MJksMDuDoEkh2bTW31NhGFq2dNrzYxBTQx1Q2kQvyN+/hsh9nkpBuOT/TgDBcm1q4ajUGkYUoCRfMy2bb4DaqRFiekX/XMB25VykADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923794; c=relaxed/simple;
	bh=bH6bKnImCnQPwBBMAabeb7brD+kg4v06+tOq42mnU+w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M20yNPSKv/ONm2kLpJIB/rbgnsq99/2sq0yzGEke6GYd2tIqv1oFx0gzl2rC8V+s96cK1RzfQlz9F9yZv19di5wZgmYwWzorZea+fQFv7fyI/9Xm+5q//zIcdaed2LDYjgJJmDNgkzPwO4QLtBEFZW/27U4PNzoZRU6X0RKcsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m5ptSGcj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m5ptSGcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782923788;
	bh=bH6bKnImCnQPwBBMAabeb7brD+kg4v06+tOq42mnU+w=;
	h=From:Subject:Date:To:Cc:From;
	b=m5ptSGcjQHlo5M/Tj8pnQ69SOed+j4B2gTCrR3YwMqSXaeBcjaMArgsEK+Zc4mbgU
	 lDviyOfpgvkTDpIYhalFpLS6XaBBnnWHUSmtPjnyw0ZAh91WJyQ2roAv+5a/KTzI1i
	 dQyYqkZi0k4U84iDCmXGe666/S1UoWgHhkCFMZX2JufkyZY7hXcJmRhL8/v9HNM/GZ
	 MM5UU1mUQIT09wL3H3GxI/3Hh/cOPapRS7O/uRESIopE4Fhn7fHqOj4lnfNyRq7GoZ
	 tGJC20EZV3LFCWXoeS5k90Yakj2Y3nSFK/sBHN4NJj7eZVW4odzNNPzsAL2j4lc7m9
	 MBOdq2217xLqw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 54A1517E0521;
	Wed,  1 Jul 2026 18:36:27 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH v2 0/4] Add support for the Mediatek Genio 520-EVK and
 720-EVK boards
Date: Wed, 01 Jul 2026 18:35:18 +0200
Message-Id: <20260701-add-mediatek-genio-520-720-evk-v2-0-19d5da4ef984@collabora.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6WT0YrbMBBFfyX4uWNGkiU5YSn7H2UpY2mciER2a
 ikh6ZJ/r2K30JSWLeRhHkZiztUdrt6rxFPgVG1W79XE55DCOJRGflpVbkfDliH40lcSpRZCtkD
 eQ2QfKPMetjyEEbREsKX4vAc0wkhl7do2viqQ48R9uMwCX96WfuJvp6KTl8Oqo8TgxhhD3qwGv
 mQoWgaNwvt85JRofsVm9TJfWBQQcyvaNbjD6PYJ0jVljjCDzgIQZIdN2zOTRnp14+FA3ThRXUQ
 +/42phUSNplHa1kLptQABY/7qKO+u9eX0+svuvwHYllJKKFNbi7rMfy/Lu1e95Y/nH0zF6MBn6
 MLgw7BNUNZ3dyWAre5lI0ha3f2Hqwfo78DkjmVjC1M6bHrsPYnOPsM8usAL0TpLpizEGt08Q8z
 H3XUh6rZpSXbcKlTPEE80ZfCRFqqzAo0Uhhr0f1LvQd2FlMfpOn+Ms5iT+jMq6qM/MGfQ93bdd
 JIUEj/yq7fb7fYDjumAUXkDAAA=
X-Change-ID: 20251128-add-mediatek-genio-520-720-evk-06162377974d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782923787; l=8588;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=bH6bKnImCnQPwBBMAabeb7brD+kg4v06+tOq42mnU+w=;
 b=CM3ARkAB7EhzizSnZED97Xmpe6FzooHchBeDeFU7suXqAC17+clbRB9veVQ8oUXUqe9TVhOg4
 YM9pscbbJVpAG2jEo7TzZwLhsWl8+BGS8UVl1fz0T6OLed3jI9RLXkf
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

This patch series adds the support for the Mediatek Genio 520-EVK (based
on MT8371 SoC) and Mediatek Genio 720-EVK (based on MT8391 SoC).

MT8371 and MT8391 SoC are less powerful variants of MT8189 SoC
with the following differences:
  - Arm Cortex-A78 CPU core maximum frequency (2.2 Ghz for MT8371, 2.6
    Ghz for MT8391, 3 Ghz for MT8189).
  - Arm Mali G57 MC2 GPU core maximum frequency (880 Mhz for MT8371,
    1.1 Ghz for MT8189 and MT8391)
  - ISP engine number (1 for MT8371, 2 for MT8189 and MT8391)
MT8371 and MT8391 SoC hardware register maps are identical to MT8189.

The Genio 520/720-EVK boards have following features:
  - MT8371 (or MT8391) SoC
  - MT6365 PMIC
  - MT6319 Buck IC
  - MT6375 Charger IC
  - 8GB LPDDR5 RAM
  - 64GB eMMC 5.1
  - 128GB UFS
  - 20V DC Jack
  - USB Type-C Power Adapter
  - Micro SD card slot
  - Push Button x 4 (Power, Reset, Download and Home Key)
  - LED x 3 (System Power, Reset, DC-IN Power)
  - USB Type-C Connector (USB 3.2) x 2
  - USB Type-C Connector (USB 2.0) x 1
  - 3.5mm Earphone Jack x 1 (with Microphone Input)
  - 3.5mm Line Out Audio Jack x 1
  - Analog Microphone x 1
  - Digital Microphone x 2
  - Gigabit Ethernet with RJ45 connector
  - DP x 1 (Mode over USB Type-C)
  - LVDS port x 1
  - eDP port x 1
  - UART x2 with serial-to-usb converters and USB Type-C connectors
  - UART Port x 2 on Pin Header
  - M.2 Slot x 2
  - I2C Capacitive Touch Pad
  - 4-Lane DSI x 1
  - 4-Data Lane CSI x 2
  - I2S Pin header
  - 40-Pin 2.54mm Pin Header x 1
  - CAN Bus x 1 (RS232 Connector)

The series adds two include files for mt8189 (mt8189.dtsi) and common
board definitions (mt8391-genio-common.dtsi) and a devicetree file for
each board.
In regard to the current MT8189 SoC upstream support and this series
provides the following basic hardware enablement for:
  - CPU
  - system and base clocks (including fhctl support) 
  - spmi and regulators
  - power domain controller and all domains (excluding multimedia and
    graphics related ones)
  - UART 0/1/2/3 with DMA support
  - eMMC and SD card
  - watchdog
  - timer
  - efuse and socinfo
  - auxadc
  - PCIe controller and Wifi PCIe M.2 module

The series is based on linux-next next-20260630 tag, and the
following patch series are currently required:
- MT8189: Add support for system and base clock controllers [1]
- mt8189: Add pinmux macro header file [2]
- dt-bindings: timer: mediatek,timer: Add compatible for MT8189 [3]
- dt-bindings: mmc: mtk-sd: Document extra clocks for MT8189 [4]
- dt-bindings: mfd: mediatek,mt8195-scpsys: Add support for MT8189 SoC [5]
- dt-bindings: PCI: mediatek-gen3: Add support for MT8189 SoC [6]
- dt-bindings: phy: mediatek,tphy: Add support for MT8189 SoC [7]
- dt-bindings: dma: mediatek,uart-dma: add support for MT8189 SoC [8]

[1] https://lore.kernel.org/linux-mediatek/20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com/
[2] https://lore.kernel.org/linux-mediatek/20251205064357.13591-1-ot_cathy.xu@mediatek.com/
[3] https://lore.kernel.org/linux-mediatek/20250825033136.7705-1-zhanzhan.ge@mediatek.com/
[4] https://lore.kernel.org/linux-mediatek/20260701-mt8189-mmc-dt-bindings-fix-v1-1-e75f241a275b@collabora.com/
[5] https://lore.kernel.org/linux-mediatek/20260701-mt8189-dt-bindings-scpsys-v1-1-2c04f0fda1b7@collabora.com/
[6] https://lore.kernel.org/linux-mediatek/20260701-mt8189-dt-bindings-pcie-v1-1-7c7a65087654@collabora.com/
[7] https://lore.kernel.org/linux-mediatek/20260701-mt8189-dt-bindings-tphy-v1-1-5848a2be8303@collabora.com/
[8] https://lore.kernel.org/linux-mediatek/20260701-mt8189-dt-bindings-uart-dma-v1-1-c7106216a40d@collabora.com/

---
Changes in v2:
- Added Acked-by trailers in patchs 1 and 2
- Reworded patchs 2, 3 and 4 subjects to remove redundant parts
- Patch 3:
  - Moved aliases from mt8189.dtsi to mt8391-genio-common.dtsi
  - Renamed fixed-clock names in mt8189.dtsi
  - Removed the multimedia and graphics related clock controller nodes
    and aligned remaining clock-controller compatibles to match the
    latest mt8189 clock series revision ([1])
  - Added missing aud_adc_ext fixed clock (used as parent in
    clk-mt8189-vlpckgen.c)
  - Removed _clk suffix from all clock controller aliases
  - Added UART DMA controller node and use
  - Added PCIE host controller node and use
  - Added MT8189 powerdomain controller node and SoC power domain
    definitions (excluding the multimedia and graphics related ones)
  - Added ARM DSU PMU support with fail status to handle its optional
    support in firmware/bootloaders.
  - Added extra clocks in MMC0 and MMC1 nodes, that are now required
    with latest mt8189 clock series revisions ([1] and [4])
  - Replaced mt6359.dtsi include by mt6365.dtsi and added the supply
    definitions and compatible related to this PMIC
  - Added the MT6319 PMIC supply definitions
  - Added the MT6319 PMIC definitions and aliases with two different
    USID and enabled the expected one in Genio 720-EVK devicetree to
    fix this PMIC not being properly detected on Genio 520-EVK in v1.
  - Added the needed definitions, pinctrl and regulator to enable wifi
    module support
- Enabled the MT6319 PMIC with correct USID in Genio 520-EVK devicetree
  in patch 4.
- Link to v1: https://lore.kernel.org/r/20251203-add-mediatek-genio-520-720-evk-v1-0-df794b2a30ae@collabora.com

---
Louis-Alexis Eyraud (4):
      dt-bindings: serial: mediatek,uart: Add compatible for MT8189 SoC
      dt-bindings: arm: mediatek: add Mediatek Genio 520/720-EVK boards
      arm64: dts: mediatek: add Genio 720-EVK board
      arm64: dts: mediatek: add Genio 520-EVK board

 .../devicetree/bindings/arm/mediatek.yaml          |  10 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   2 +
 arch/arm64/boot/dts/mediatek/mt8189.dtsi           | 920 +++++++++++++++++++++
 .../boot/dts/mediatek/mt8371-genio-520-evk.dts     |  32 +
 .../boot/dts/mediatek/mt8391-genio-720-evk.dts     |  27 +
 .../boot/dts/mediatek/mt8391-genio-common.dtsi     | 673 +++++++++++++++
 7 files changed, 1665 insertions(+)
---
base-commit: ba7c57499e5999aeae8dd4f954eb2600589d80aa
change-id: 20251128-add-mediatek-genio-520-720-evk-06162377974d
prerequisite-message-id: <20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com>
prerequisite-patch-id: 7b1af194800ee6075aeb7933e2b55ac57e1dc5e2
prerequisite-patch-id: 875e450fd11593714ac2f5de93240c058d4b0a42
prerequisite-patch-id: b38381973e1d32c5ae8e04aba4673b7221dad2b1
prerequisite-patch-id: ed4aab90f897ed26c4cbf6f0a5be965c9e9cedd7
prerequisite-patch-id: 41ea05f49926cab03759da60e03b2d58fd524846
prerequisite-patch-id: c193828b36c6195aa6c21e8926e61bba4032ed9b
prerequisite-patch-id: 2c9894cd211e5676f43ebac4a722704c0e127190
prerequisite-patch-id: a29fd1f809b1ddc581847ba26638882e5ff127e7
prerequisite-patch-id: 6dffca2ee6a8762d22aece8a319499500ee271cc
prerequisite-patch-id: 587d2d91b66dcaa59488eece20931b76d8fbd655
prerequisite-patch-id: 28acddfadf1d24eb54ca107e2b4573a57113ded7
prerequisite-patch-id: 75658fbbf84ba98c996571253f4cdc0508552d5c
prerequisite-patch-id: 96cbb979a4b52485e5078472827a165d1d65b418
prerequisite-patch-id: e924638bcd10aabd9ef6c3c3a2eed6984f9dbac7
prerequisite-patch-id: 6bb480bbd14445cc515a890db212d5570f0824d4
prerequisite-message-id: <20251205064357.13591-1-ot_cathy.xu@mediatek.com>
prerequisite-patch-id: 7f2d960cde2f0e0a307721150e83b7b05b9a60d7
prerequisite-message-id: <20250825033136.7705-1-zhanzhan.ge@mediatek.com>
prerequisite-patch-id: 7aeee7d452186b3bc1c11722b7ddb7dfbae7d396
prerequisite-message-id: <20260701-mt8189-mmc-dt-bindings-fix-v1-1-e75f241a275b@collabora.com>
prerequisite-patch-id: 3f6f8e5a3005e7ee4a9f082da6842efaae560d4d
prerequisite-message-id: <20260701-mt8189-dt-bindings-scpsys-v1-1-2c04f0fda1b7@collabora.com>
prerequisite-patch-id: 8982f7b2776e6cae070c41a48076b5a02c97ef2a
prerequisite-message-id: <20260701-mt8189-dt-bindings-pcie-v1-1-7c7a65087654@collabora.com>
prerequisite-patch-id: 8b5cc41be174d3e0768fd43bff843208c0ec200b
prerequisite-message-id: <20260701-mt8189-dt-bindings-tphy-v1-1-5848a2be8303@collabora.com>
prerequisite-patch-id: da74129ef4f3ed94555df4f540f44bee2f5f05f9
prerequisite-message-id: <20260701-mt8189-dt-bindings-uart-dma-v1-1-c7106216a40d@collabora.com>
prerequisite-patch-id: c5894d7c4c71327f7855869cbd8686d0ea610f3e

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

