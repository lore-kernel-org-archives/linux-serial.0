Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794054125;
	b=VKqrrbWYtGsQPbbH0IA3zU2knIYoArdGoIovf/zNtbiZZXrrO6pAyN1SJ0di00AV2XPm
	 2Zif9I6bPzwZm/Q0SdU3wcy5Yi+FxxIzl2nN8N4WnVApTOcbga8E95Vo1pGQGeS+woKrS
	 04eQjnrjP9QBaIXRSRQ17YPZAJgsK5WsX3eOKQweZa3r2P4G7arY22H/7wKkHNEc5n1wH
	 z+YOZnRT8QWAO96q/N/kHFJ3RCFj9P/SeQ5Ul99Hx7a0ZJD2DrG7JHJ4sCVdtxx8UChxo
	 bS1sYManrlzqygtMyek7Kogwr67U84yDbfJAe+JRVY46kGUAVozJPXVCRQCxrP3fHWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054125;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=cYBh3ujkptEjOl4B6edamdMHGb3RmyR9bzsarLx/F/E=;
	b=j7LBANG2lG8ncHA7aPV1uWXkq8Vjvc0Cu5Nk1smoz6TlDy1DkmZUR93Jm8OUCAt0VAOk
	 Y+3FUoeSrpPlUWO/aSq5K3E4IHQ2TUyhpiR/aq+pVs/7apRvg8b4TWEjuFNzucU+iFfr6
	 Y2mzWDxLYK/O14822sNYEwRb5ZBcxf3td30OtgrD/RavBGpIt9f+kZtcU3CxV9fVqloTg
	 kMI+SL8AkOHw/sY3mve3d14Pg5aFzZNzsSnmYB+LXFyX8IQrNzyua/aBjKp3WJI7/FEDe
	 BQfhVlRwilPXhf50TWDPw8LsXxIKGvpodmXwHMiGH9jLYPN4ePB/7koQFmMzxrpB+Rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHGJabNi;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BF4606A32C;
	Sat,  7 Nov 2026 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHGJabNi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794054123;
	b=LzlWwNBXE2cVNdXZPJvQbRHuXFMhUwqbZb3D6j0P4s7EtroWAibj9TUS8TXY0otd+/IY
	 1ZHB7NFwapQJlSqeCEEGaoq+sgDq31BK2u7PeLq5al5wWOActGTjmBtjj2VFHAQD00kPj
	 VySbl1/P/ArfSar7qUyYzvDvcxRW/2XjRplaSP4xKfSOYaR0D8o1DcY3dNJ5n5qokJBX9
	 XhxX8pXhGpO0B0LSnt1WreUzjJ5Ns+Q6qaqOv6+kehAid3LP2GwcUSEANq8MwhNIa4Xez
	 PUeCsQDWOJe66vz4T8b4n0gb0E2gcdhwemcLLFo1xUEpw6f9Wm7mfwYj1zjRm2+ZDHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794054123;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=cYBh3ujkptEjOl4B6edamdMHGb3RmyR9bzsarLx/F/E=;
	b=XpTD26/JUUCWY+MaS64dlPwtGZPCUG+mZ/18JhytKhl6P0TkkGrF1m77mMVIdbbjkxKq
	 WV9berr64w71pzINGNslpaZ8Im6bVAIcetEHB+0Qz8HzzjCWVRDPUQEgJtivduA69OOuA
	 0TmkIX5PjIN6yagFSMEA8+zVzrmePajZtcp6zQ4FPhsWIye6PSYK53+XJ/YDfDboXt21H
	 Et3cI6MnxVLYQVb3FJhmF4aLMLcPG4hyQtIrdWIJ618letteXDUwO+w8HkvtL4q4/UnIF
	 SzHk20IG0YjseOUlqhkRYybjMHcL5m1wFfKAKyr5F53APutAIIOctfYcGS/RnOSf4aQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 43ACB1F0089F;
	Sat,  7 Nov 2026 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054123;
	bh=cYBh3ujkptEjOl4B6edamdMHGb3RmyR9bzsarLx/F/E=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=lHGJabNilyXfinOF3+9gUWeoQKvtCGHhOHq7SZ+5VmPrHcrhMOqq2IA5wbSbe6WL+
	 82O8kYFtn22a8+UM+TietTooaFO4VzjHYdBxl3ts4+Xn/VSHGUxplzu1j2DIjOov7G
	 cbHyWtmkkol9PGbXLPmio8/ZLKrItWxIoGHMXWHPDx8pPI81qy+zlwNyvIGPGR7SeD
	 EJGPnWNOA0DcokJh60r6d5Xsuy/oehlO/BB4yck7NYo7GgQrTj8K5ry+62wufdWdGS
	 S0eCCODroUjLnSnIt1rniXOPcpQAACqDi5F55RacVlTFnxF4yFRXIicWMJIwG5LSdd
	 nb9lrNdRnQTVQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B3E3047BDC;
	Sat,  7 Nov 2026 12:22:02 +0000 (UTC)
From: Rui Cao via B4 Relay <devnull+i.udp0.com@kernel.org>
Subject: [PATCH 0/4] arm64: dts: mediatek: Add MT6833 and the Xiaomi Redmi
 Note 13 5G
Date: Sat, 07 Nov 2026 20:21:57 +0800
Message-Id: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMSQ5AQBBA0atIrXWizVxFLIoulMSQLkQi7q6xf
 Iv/LxCyTAKld4Glg4WX2UH7HrQDzj0pNs4QBmGqdZCpaUvzKFINCqkEiyzGItFoDLhitdTx+d2
 q+rfszUjt9i7gvh/fuVIJbwAAAA==
X-Change-ID: 20261107-mt6833-base-5a974a951add
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org, 
 Rui Cao <i@udp0.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794054121; l=2117;
 i=i@udp0.com; s=20261107; h=from:subject:message-id;
 bh=aGS5pwVEaByvAXqt5RgayabtH/SOiH8kdtd7Klwjx3s=;
 b=1Ef+pPWL5tiXhC1xG3VTSFRe9IKi9UQRAXxxLvvz8FXj16P5KIn7VvQ1IzbZXh1U2N1dweMXI
 R6sOBKFv/MoAncwkaq7CB2MSNLwEMFZKAJCRoBeVYUeBvpKIBC37t/U
X-Developer-Key: i=i@udp0.com; a=ed25519;
 pk=XZJKcKgnUUjjyw8KuKy7u2QeIX0JLY/L1Fxzwwje41w=
X-Endpoint-Received: by B4 Relay for i@udp0.com/20261107 with auth_id=1443
X-Original-From: Rui Cao <i@udp0.com>
Reply-To: i@udp0.com

This series adds basic support for MediaTek's MT6833 (Dimensity 700) and
for the Xiaomi Redmi Note 13 5G (gold), which is built on it: the eight
cores with their caches and PMUs, PSCI, the architected timer, the GIC,
the watchdog and the first UART, and on the phone its memory, the
regions its bootloader reserves for firmware and the framebuffer the
bootloader leaves lit.

With it the phone boots to an initramfs on the framebuffer console, with
all eight cores online, both PMUs registered and the watchdog running;
UART0, which has no connector on gold, passes an internal loopback test.
The pin, clock and power domain controllers, the PMIC wrapper, UFS and
USB are to follow in later series.

On booting: gold's bootloader (LK) only starts a kernel with the stock
device tree and the dtbo it overlays on it, so I boot mainline through a
small shim in the boot image. Like a bootloader, the shim takes the
memory node and the reserved regions from the tree LK passes, which
depend on the RAM variant, and enters the kernel with this device tree
updated with them. The values written out in the board's device tree are
the ones LK reports on a 6 GB unit, the one this was tested on.

Signed-off-by: Rui Cao <i@udp0.com>
---
Rui Cao (4):
      dt-bindings: arm: mediatek: Add MT6833 and the Xiaomi Redmi Note 13 5G
      dt-bindings: watchdog: mediatek,mtk-wdt: Add MT6833
      dt-bindings: serial: mediatek,uart: Add MT6833
      arm64: dts: mediatek: Add MT6833 and the Xiaomi Redmi Note 13 5G

 .../devicetree/bindings/arm/mediatek.yaml          |   4 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 .../arm64/boot/dts/mediatek/mt6833-xiaomi-gold.dts | 205 +++++++++++++
 arch/arm64/boot/dts/mediatek/mt6833.dtsi           | 341 +++++++++++++++++++++
 6 files changed, 553 insertions(+)
---
base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
change-id: 20261107-mt6833-base-5a974a951add

Best regards,
--  
Rui Cao <i@udp0.com>


