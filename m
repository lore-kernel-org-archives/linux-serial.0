Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA632D0EE;
	Thu, 24 Sep 2026 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239188; cv=none; b=cDv4XUXZd5IECu5pwj2gkKfhqpqEE0y3AWtQyLcsqqdQ8kdtGX2pjKxPNTg1Lb7e313MdBOVMLt+b77jUJBXpt+S52WC6Cgk9cASabv60Fd5TOfqhmr0pu6DdfoVYjG4uxfA2QzDWX0I99hX8+ukTTP+YK/sQcNFKJzcU/DKkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239188; c=relaxed/simple;
	bh=Tt2bpkdEluqHRxtBY7MKoCj5UmzG/Kly1kN0FydimLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LHsverfgXYciHbxiWCui66ebM9aq20h2INmwzZxNH2CHkFUo//FEdiMF3JNnd93QdAwVmpr3xVUlEUevI1FDLNij34L+DUPjt98ELv/QSr/BJNQddWWhfdF691PcLKQGFWHylgO0n15J1qL/3nlEZU8xbOKjm9xBcjALUTeb2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aITOphml; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aITOphml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790239184;
	bh=Tt2bpkdEluqHRxtBY7MKoCj5UmzG/Kly1kN0FydimLs=;
	h=From:Subject:Date:To:Cc:From;
	b=aITOphmlBj1JyNO9dlUxxs5d8Gy6xRNvT6CbtZePVIktUEOBpDnA2KQ6AVCF6013B
	 8vawMh5EqH4O2eql5x/ZF5n2rYQzGtxKU38qbpJSr9cYDPgK3oc2/mx1TphIqqTnaw
	 JwlVtq9bLoyKOtGoCSTkaZUPnuEUiZMVEIZghJkrOlQkUex5jd6tiL4Ibm/JfDP5km
	 Zc3DtPyGWRY05n6JD2hqswDqgU/MPd3mxkwzUBsJ71kqFeejePXDBVeAmZC+2ltl0N
	 hAiF1hdWoj+pA1mcyCBSjvWnbnnhTtDL93FF8q9dTX8P3wvj57koOC3pL+N+nFK0eU
	 ldIUzPvNZMuJQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4652A17E0371;
	Thu, 24 Sep 2026 10:39:44 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH v3 0/4] Add support for the Mediatek Genio 520-EVK and
 720-EVK boards
Date: Thu, 24 Sep 2026 10:38:09 +0200
Message-Id: <20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WR3U7DMAyFX6XqNa7yn2ZCaO+BEMoad4u2NtBkZ
 WPau5N2mxAItAtfOJG/43N8KiMOHmO5KE7lgKOPPvS54Q9F2Wxsv0bwLvclI0xSymqwzkGHztu
 EW1hj7wNIRkDnwnELRFHFuNZGC1dmyNuArT/MAs8vl37A933WSZfHcmUjQhO6zqdF0eMhQdZSx
 DA+zXcYo523WBSPlw8ioEs1rQ00u9BsI8RjTNjBDBoVEJCuZUK3UhleL5uw29lVGGyVRZ7+Ykr
 KiCRKcKkryqWhQCGk18amzbE67Jc3u/8DSJ2Lc8pVpTWRef4zhzdVtcb785NbAe6js813tlePI
 8uGBCcrlxOV2JrfhqZUNz6mMBznK450jvXqi9872Egz37XaiBWznFj8yZ/xI7shFdGE3kVOK1P
 jpLMiL1yL38jz+fwFbQlrJ3kCAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790239184; l=8930;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=Tt2bpkdEluqHRxtBY7MKoCj5UmzG/Kly1kN0FydimLs=;
 b=jG9bJhK/EMs08/u6J1gBtXCHK6ge5cjOQ9YT+Elf8tk75bCePneBfXTVO+347Blikprca6J+6
 qn/sa6sWHKPC/eluVQbb3daXsNbcUwOjFN2J65TfW/TseUCspVq2nb6
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
  - Ethernet controller

The series is based on linux-next next-20260923 tag, and the
following patch series are currently required:
- MT8189: Add support for system and base clock controllers [1]
- mt8189: Add pinmux macro header file [2]
- dt-bindings: timer: mediatek,timer: Add compatible for MT8189 [3]
- net/stmmac: Add Mediatek MT8189 support [4]

[1] https://lore.kernel.org/linux-mediatek/20260904-mt8189-clocks-system-base-v6-0-5df247f56938@collabora.com/
[2] https://lore.kernel.org/linux-mediatek/20251205064357.13591-1-ot_cathy.xu@mediatek.com/
[3] https://lore.kernel.org/linux-mediatek/20250825033136.7705-1-zhanzhan.ge@mediatek.com/
[4] https://lore.kernel.org/linux-mediatek/20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9@collabora.com/

---
Changes in v3:
- Rebased on next-20260923 tag
- Updated series prerequisites with most recent versions and add MT8189
  Ethernet GMAC driver series as new one.
- Added Reviewed-by trailers in patchs 1 and 2
- Patch 3:
  - Reordered device nodes by base address in mt8189.dtsi (C. Tsai)
  - Fixed spmi address range in mt8189.dtsi (Sashiko)
  - Add Ethernet nodes in mt8391-genio-common.dtsi and in mt8189.dtsi
- Link to v2: https://lore.kernel.org/r/20260701-add-mediatek-genio-520-720-evk-v2-0-19d5da4ef984@collabora.com

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

 .../devicetree/bindings/arm/mediatek.yaml          |   10 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |    1 +
 arch/arm64/boot/dts/mediatek/Makefile              |    2 +
 arch/arm64/boot/dts/mediatek/mt8189.dtsi           | 1009 ++++++++++++++++++++
 .../boot/dts/mediatek/mt8371-genio-520-evk.dts     |   32 +
 .../boot/dts/mediatek/mt8391-genio-720-evk.dts     |   27 +
 .../boot/dts/mediatek/mt8391-genio-common.dtsi     |  798 ++++++++++++++++
 7 files changed, 1879 insertions(+)
---
base-commit: 4d7e75152b01862a4ec598435d79a81c4b254dd6
change-id: 20251128-add-mediatek-genio-520-720-evk-06162377974d
prerequisite-message-id: <20260904-mt8189-clocks-system-base-v6-0-5df247f56938@collabora.com>
prerequisite-patch-id: f383e7157010179243963badff8c663d0ca21592
prerequisite-patch-id: 742dfe3c56d88bad5dbdae49b34ecf8639db1bdb
prerequisite-patch-id: 9c9c64b8b3879f230ba18a0d11cbeb584ce2977c
prerequisite-patch-id: 7b1af194800ee6075aeb7933e2b55ac57e1dc5e2
prerequisite-patch-id: 8c8e59354c22f2fa141599efaddc1d28da97c910
prerequisite-patch-id: 560ea66d94464ee05a72499d1bd8adb3830fe9d0
prerequisite-patch-id: def65116008ad75bae741bacc67552227446449d
prerequisite-patch-id: 226e61bec983c3cdd39a64d0b5aa64994c6873c4
prerequisite-patch-id: 988df54e8bb41d0cc56104398da9c8f669eef878
prerequisite-patch-id: 9a3f954e6efaed40f57a23e721505f5e2abf538e
prerequisite-patch-id: ac2ae94b727d7e4f2576601e09ed481248e6c099
prerequisite-patch-id: 5cf430a386ebd823b14ad79aa05e8b723510f2e8
prerequisite-patch-id: 49a0b4ca405cfbc9854dea09df664f60c7467fb9
prerequisite-patch-id: 998d0587e6bb0ee244afeb5344cd3e9438d933ca
prerequisite-patch-id: c23a23ce86063191e84218c496151104c270bead
prerequisite-patch-id: 9c596a2b6b48b1c646e2aa6fdb12c2fc853f44f2
prerequisite-patch-id: f0978bcc3be8c1986a00e41aab540c911508ae07
prerequisite-patch-id: 8ce69ea826d8ebdb9103dab20941b018a10ef230
prerequisite-patch-id: 7f544c1d5400bb2f6e964f53eeaacb52878bfce9
prerequisite-patch-id: e2027aa2ac9d98bc9bc577dc0ef5bcb664380c51
prerequisite-patch-id: 29b5901b08e6c967da57d83d90fdcac50657e4ad
prerequisite-patch-id: 4442d5bd4b04a393301f974a3aaeabef7a693aac
prerequisite-patch-id: c6be163e56e8187c47e4ee6adbab4c7877b5b5e9
prerequisite-patch-id: 12f43414850b4a72ba37967ff7f765e426abd9e5
prerequisite-patch-id: 9b00d856ced9bea88911a5af4d5e5dd003e66b15
prerequisite-patch-id: 967e506aa16b20c211cb74080f83e38a7dffecd1
prerequisite-patch-id: 2943831ea7bc0c4075580adf69e033f9057f4b19
prerequisite-message-id: <20251205064357.13591-1-ot_cathy.xu@mediatek.com>
prerequisite-patch-id: 7f2d960cde2f0e0a307721150e83b7b05b9a60d7
prerequisite-message-id: <20250825033136.7705-1-zhanzhan.ge@mediatek.com>
prerequisite-patch-id: 7aeee7d452186b3bc1c11722b7ddb7dfbae7d396
prerequisite-message-id: <20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9@collabora.com>
prerequisite-patch-id: cedfd27a6d86ef771ea29570d7aeaa1de6700d76
prerequisite-patch-id: d71281b728b70a0c3e6628fcf667df5fce81f2de
prerequisite-patch-id: f08f0f9abf6ddb4856e6f83f09afbd9a6bd58c69
prerequisite-patch-id: 547ff4e2a908f87e94fff37f8e0a5cd7b6a06deb
prerequisite-patch-id: 3b288113483ca2c4181fcc1141f03c4dfc05c43e
prerequisite-patch-id: a7497035d432d4454a9e9ddf09b4dbef89a060ed
prerequisite-patch-id: 26b2574fc9d0ead6e8ab193fca387cf6e816dce4

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

