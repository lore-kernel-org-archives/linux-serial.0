Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0E1422AB;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195815; cv=none; b=pLYBbBD5uV7yEl5hlA5a+Og7l5F63UaSdV4A42eMy8VhSCcYUbFuCnrdu5rbptRdTuHrzgz96CcnsV1GSSPyiTXydoQhw7n+aqwIf8993aTp6reffLBTF6Exbzz/rb9c62mzEGccOp5higNjJL+UdLlAFlDFTem8xNs7ozrQWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195815; c=relaxed/simple;
	bh=wL9gUnrlsPQNAWa/Td3yrEb1Mzg5Mf+QmQXD9OzX72w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TEFSB659nEXKb/lbVwMQlGvx9BKVvcunlkLSKxpL/9h2P9/OUpC6OcTE6nXrsACvX/ORyUrNuQSjL7TWalfT6DpWdP3FNcB+9ds3f53IzKevpAWzNIlhiL9LH3PRYnjWklYhKW4Na0JbvpNb/E3YW6UvHtYAWHiOy2ATdv6zZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ef+oFqeg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ef+oFqeg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DBD8C4CEEC;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742195814;
	bh=wL9gUnrlsPQNAWa/Td3yrEb1Mzg5Mf+QmQXD9OzX72w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ef+oFqegpteYd+UM3MsMEVF+QkF5iBAu9RBV02JpdRABpsFtdrILxzUzFMNt58Skz
	 WHp3pq1KvvDwsnON6hggASuw6wYydh0iM9IlnaKrEMVolKCMLW7D+mlJI6QlTYA2bq
	 B4pODHMApmXaxIwZULvAXSHw+p7s0iAp+UvHaB7c2/PKoSLZNVxC/qCpK7t1E0kecp
	 l6zn0638rk9szP0o/lIL631lUGgVgG55pP6jsiHFFX/LXrrwOsExa5wIKwIpb4MSV+
	 CyBqy/xHnQmg5CLyLqE0xYanFJbe9kH4zY2LI8HKDTjKRoYW8arJQ5yK4eNBhUytyQ
	 EPERWtIQ3nxlQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327E4C282EC;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/7] Baisc devicetree support for Amlogic S6 S7 and S7D
Date: Mon, 17 Mar 2025 15:16:51 +0800
Message-Id: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGPM12cC/x3MMQqAMAxA0atIZgNpi1a8ijjUGjVLlQZEKN7d4
 viG/wsoZ2GFsSmQ+RaVM1WYtoF4hLQzyloNlmxH1hrUHtXjElQibo4oOhq85x5qcWXe5Plv0/y
 +Hxwrow1dAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742195812; l=2174;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=wL9gUnrlsPQNAWa/Td3yrEb1Mzg5Mf+QmQXD9OzX72w=;
 b=DudI+EZbNWKj/cExJWHpLtrhBZq5G0gH1aBEaWY7T5W6Q5fTXxZpYlb0lsmNgLYJ4ScXYKMYM
 63/vxuVARWeAv3IcZip6ckG3PmaVmkDFz9zOOBC3vVCunosibV9eRy9
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Amlogic S6 S7 and S7D are application processors designed for
hybrid OTT/IP Set Top Box and high-end media box applications.

Add the new S6 SoC/board device tree bindings.
Add the new S7 SoC/board device tree bindings.
Add the new S7D SoC/board device tree bindings.

Add basic support for the S6 based Amlogic BL209 board, which describes
the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
booting up into the serial console.

Add basic support for the S7 based Amlogic BP201 board, which describes
the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
booting up into the serial console.

Add basic support for the S7D based Amlogic BM202 board, which describes
the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
booting up into the serial console.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (7):
      dt-bindings: arm: amlogic: add S6 support
      dt-bindings: arm: amlogic: add S7 support
      dt-bindings: arm: amlogic: add S7D support
      dt-bindings: serial: amlogic,meson-uart: Add compatible string for S6/S7/S7D
      arm64: dts: add support for S6 based Amlogic BL209
      arm64: dts: add support for S7 based Amlogic BP201
      arm64: dts: add support for S7D based Amlogic BM202

 Documentation/devicetree/bindings/arm/amlogic.yaml | 18 ++++
 .../bindings/serial/amlogic,meson-uart.yaml        |  3 +
 arch/arm64/boot/dts/amlogic/Makefile               |  3 +
 .../boot/dts/amlogic/amlogic-s6-s905x5-bl209.dts   | 42 +++++++++
 arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        | 97 +++++++++++++++++++++
 .../boot/dts/amlogic/amlogic-s7-s805x3-bp201.dts   | 41 +++++++++
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        | 99 ++++++++++++++++++++++
 .../boot/dts/amlogic/amlogic-s7d-s905x5m-bm202.dts | 41 +++++++++
 arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       | 99 ++++++++++++++++++++++
 9 files changed, 443 insertions(+)
---
base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
change-id: 20250221-s6-s7-basic-f300c30877e6

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


