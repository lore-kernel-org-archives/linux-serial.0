Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E5DF6C;
	Wed,  3 Dec 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764770381; cv=none; b=ROTZZzJelEVqa1lrdJVRYFVPfVxpg6PXgag/JAgGIStXOy92HPOunloFLp9R4q8JgxNkd66c1QOeFmGzQ6rvRze14Cab2hos6KMeJmja9FSFvYonLJbt5k92l8cSSYrEb7m4fM83tebko2DZbk/ZyWiyNO7Wsaqy4UuAoPnntp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764770381; c=relaxed/simple;
	bh=7rdCs97YBrArOUGWG2Izgfsf1uq95fUzJXwZjjk8CAU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZIyaZ+iCmPsGF12EqloEpr5S0VLFAh9FkAs+yjA3YSynYItdmqsiUOSJBl8w4eFP3fOxcq7juGPjKWVmO2uo0XkiH6v9uOD8a9+OamNaJyENpNh9z5+ZSb2HRVZO0X8y/De1nbeloZxm9nUoNT3bZz9ORYrygENibXdAm3xuvfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lWatP1Ft; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lWatP1Ft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764770377;
	bh=7rdCs97YBrArOUGWG2Izgfsf1uq95fUzJXwZjjk8CAU=;
	h=From:Subject:Date:To:Cc:From;
	b=lWatP1FtrOynHRXcB8k9cdCtkJrYIlvRZhwtN3vRhz15auBx9FfHi9pWgmbb7Efkf
	 1KctHMwbhzJNauPI/RXdRWGuqpux28GRe6acMiAGw4qRaMa3sW0i/k8t5pl/DCDe8Q
	 J1lno8UzqnGJ+4+5gtzn3FIDn7f290Vvh+HKKiQ/+BaH2s4Ldy0OXITYoK5YDUavKi
	 cg4jcD07wsGzJQdEmH8Hs45hc9LWdA2VhwNXwUVOqFqaxkOEQrlUj1ZWIQrl88QxCO
	 bac5BTWglrW81mZj538/s+KVhsJyIUTBrJp24buDWjJufcLigXPUXpWB5oT7iTq637
	 GomKpELWEWh1w==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0EF0317E0117;
	Wed,  3 Dec 2025 14:59:37 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH 0/4] Add support for the Mediatek Genio 520-EVK and 720-EVK
 boards
Date: Wed, 03 Dec 2025 14:59:25 +0100
Message-Id: <20251203-add-mediatek-genio-520-720-evk-v1-0-df794b2a30ae@collabora.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42RyWrDMBCGX8X43DGjzbZCKXmPEoosjR2ReKmlm
 LQh717FoZfSlhzmMBL6/kWXPNDsKeSb7JLPtPjgxyEt7CnL7d4MHYF3ac85csUYr8E4Bz05byI
 doKPBj6A4QpWGlgNgyUouqkpX0uUJMs3U+vMq8Lq77zO9n5JOvB/mjQkEdux7HzfZQOcIqxZHc
 XvfUwhmdbHJntcLFAh9rFmtwUVo/OD80AXw3MLCgIFqStRM2lIqsbXj8WiacTZFUnj5A8j1b8A
 w9f5ObBsyjBtJTtEjRKzTCMFEWVQVqkT4TFXepuho+13eP45YapFLIbBgTKoSMSH8vCRbYPfF0
 Q+PQFKB37HWP+sthNM0jXO8pUJolSUpOOMt6YdSaaaRo+KqqDTKZGmMb9bE/UdxPv0wtLtevwA
 z+nfsWgIAAA==
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
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764770376; l=7049;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=7rdCs97YBrArOUGWG2Izgfsf1uq95fUzJXwZjjk8CAU=;
 b=7JHZiNf2mB0ojn1S4yGXzfOXq+DMc74QOfpKZVxN5Mgk2Pabloe373q+OTpu518rNZfXWXfTW
 NvQoT/eGDm2DTwKFzjVXC9XRrvpzWpAKR3GHzsG0B5GD5pIe70NaycJ
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
each board. In regard to the current MT8189 SoC upstream support and in
order to limit the number of prerequisite patches, this series provides
the following basic hardware enablement for:
  - cpu
  - clocks
  - spmi and regulators
  - UART 0/1/2/3
  - eMMC and SD card
  - watchdog
  - timer
  - efuse and socinfo
  - auxadc

The series is based on linux-next next-20251203 tag, and the
following patch series are currently required:
- I2C dt-bindings [1]
- SPMI dt-bindings [2]
- timer dt-bindings [3]
- Add support for MT8189 clock/power controller [4]
- Add SD/MMC Card driver support for Mediatek MT8189 SoC [5]
- mt8189: Add pinmux macro header file [6]

Note:
The v3 revision of [4] patch series is causing the following `make dtbs_check`
issue for both board devicetrees:
```
arch/arm64/boot/dts/mediatek/mt8391-genio-720-evk.dtb: /soc/clock-controller@1c000800: 
  failed to match any schema with compatible: ['mediatek,mt8189-vlp-ao', 'syscon']
```
The mismatch between compatible string in driver and dt-bindings has
already been reported during the series review ([7]) and hopefully will be
fixed in its future revision.

[1] https://lore.kernel.org/linux-mediatek/20251030-mt8189-dt-bindings-i2c-v1-1-5b60914c6453@collabora.com/
[2] https://lore.kernel.org/linux-mediatek/20251029-mt8189-dt-bindings-spmi-v1-1-fbea12a4ed5e@collabora.com/
[3] https://lore.kernel.org/linux-mediatek/20250825033136.7705-1-zhanzhan.ge@mediatek.com/
[4] https://lore.kernel.org/linux-mediatek/20251106124330.1145600-1-irving-ch.lin@mediatek.com/
[5] https://lore.kernel.org/linux-mediatek/20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com/
[6] https://lore.kernel.org/linux-mediatek/20250919020525.7904-1-ot_cathy.xu@mediatek.com/
[7] https://lore.kernel.org/linux-mediatek/a50e6d433afcf8b08a47694bc5a52acc28871ee5.camel@collabora.com/

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
Louis-Alexis Eyraud (4):
      dt-bindings: serial: mediatek,uart: Add compatible for MT8189 SoC
      dt-bindings: arm: mediatek: add compatibles for Mediatek Genio 520/720-EVK boards
      arm64: dts: mediatek: add device-tree for Genio 720-EVK board
      arm64: dts: mediatek: add device-tree for Genio 520-EVK board

 .../devicetree/bindings/arm/mediatek.yaml          |  10 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   2 +
 arch/arm64/boot/dts/mediatek/mt8189.dtsi           | 860 +++++++++++++++++++++
 .../boot/dts/mediatek/mt8371-genio-520-evk.dts     |  19 +
 .../boot/dts/mediatek/mt8391-genio-720-evk.dts     |  15 +
 .../boot/dts/mediatek/mt8391-genio-common.dtsi     | 555 +++++++++++++
 7 files changed, 1462 insertions(+)
---
base-commit: e47d97576181b31291cf58e77d737d21def0e160
change-id: 20251128-add-mediatek-genio-520-720-evk-06162377974d
prerequisite-message-id: <20251030-mt8189-dt-bindings-i2c-v1-1-5b60914c6453@collabora.com>
prerequisite-patch-id: af92e103b9f50af16560a11d4eabc644bd724b07
prerequisite-message-id: <20251029-mt8189-dt-bindings-spmi-v1-1-fbea12a4ed5e@collabora.com>
prerequisite-patch-id: c82ad0d3145322fea43aed2e1d830ebc8eae8180
prerequisite-message-id: <20250825033136.7705-1-zhanzhan.ge@mediatek.com>
prerequisite-patch-id: 7aeee7d452186b3bc1c11722b7ddb7dfbae7d396
prerequisite-message-id: <20251106124330.1145600-1-irving-ch.lin@mediatek.com>
prerequisite-patch-id: ea3e5cf891c9753a77f126ad1ddad455a0752883
prerequisite-patch-id: ae9a4cb1daadb56cc298b87142b29b749dc11835
prerequisite-patch-id: 3df47b0207d75102032975e6811f71a5e7909e43
prerequisite-patch-id: 1c25a1327d50152cef227f58c08076072d65cee3
prerequisite-patch-id: f2cd301aea79253adb85bd3f62c012dd3850e1a7
prerequisite-patch-id: 81dc09321182c48f6928582e8b9d22f35a757515
prerequisite-patch-id: e0a251231fd14fa582800db8f3bb77011f6836f9
prerequisite-patch-id: da7c54c83cb8566df39beac753c80615523479e5
prerequisite-patch-id: 2f3d41e32b230ddc016fd75ace5b286cd11b2127
prerequisite-patch-id: 309f350ed5c942b640b5c3434737fee28d6825b0
prerequisite-patch-id: 7579b6db7ec7a31e28db616c73b4c1b0eb4ee106
prerequisite-patch-id: 0cdea5380c8d35cfd89e01bf843ef7fdafbc7830
prerequisite-patch-id: 3dc3e377981d3c894fc39122200a0f0d46f5d71b
prerequisite-patch-id: b57bf39e50a5316d2f9264e1eb89071d3e8e8b0a
prerequisite-patch-id: 56fd80d33667839823794173064860c613f911cd
prerequisite-patch-id: 963a3ed54fb5fd9fd518f28254eaf93a70b2f603
prerequisite-patch-id: 3c9cbc33093f754d867ca324cc7e689fbbaae8af
prerequisite-patch-id: 336ba35d1924706d1d21c6e46718d973277f207a
prerequisite-patch-id: f3322d6494603585fc4728074484055d07484dd6
prerequisite-patch-id: f5a70e41fe9df7df0ab29538701bdfdb401a9d01
prerequisite-patch-id: b46a91afc38bea2ee6a8440f59e71e39728df6ad
prerequisite-message-id: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
prerequisite-patch-id: feab935ed7d0d7234dcc1980185300782c61620e
prerequisite-patch-id: efbd41a9926397f9b3ffd19235a04791b61f35c7
prerequisite-patch-id: 5b12a1056dfe87e4d39af584d8b16c31a1a00a04
prerequisite-message-id: <20250919020525.7904-1-ot_cathy.xu@mediatek.com>
prerequisite-patch-id: 7f2d960cde2f0e0a307721150e83b7b05b9a60d7

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

