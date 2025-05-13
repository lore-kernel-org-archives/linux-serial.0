Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC520C461;
	Tue, 13 May 2025 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173600; cv=none; b=B0DFT2DsH5CxsRdLi1yarmvVZEBKjBNC7tD5VDJ7jsmPze1YcFBap7vHvhWCM8zaxfoPNlLa+rTjIMl5DCBIliRMQk1PfbpJrSWP6kgQZGFMLl2ZHntHr8SlRNLIVEuZ+fuShVk8x2pcNIriCLb1woL0ZhXl17aiRnwUj/oCc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173600; c=relaxed/simple;
	bh=JwDW09i6Wb/dXp2iXbgQlj6eYiXj8mnV0MZVigxCgz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nh8JKLUVf9oOHjoSmBdSECzwEU8/4quTj5x2klx7scQRO9sNl7NLQ+CX9+SJR0xE5J7J5uZKBCyxjbVWFJRuHWPz8O7K73AvREUEMw8DS8yRwWcHX6cR0XFnvvlk4hD9L1PtlGd5Q1VC18DQW0IsDzqdfZpw1pGjMbS59SeQY4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kUvyx8lh; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kUvyx8lh"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxaJ62965929;
	Tue, 13 May 2025 16:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747173576;
	bh=swB1Y7Qu5nV3v4fJ5qKmzudD8LkKar6pzlkj0R1vLvc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kUvyx8lh75X4oNKi0KM087tLc9Xn33YPUwac4zbXsuRzRyW+ob8G+n/MjuK/7Ea53
	 T+lRBwIUJFs5gt1Lj44sgx4PJq1d8sDpJgh74WIBFn4GL8SD+ellRpxMg1M4DGikvV
	 RkuHNw5BBa9ER1pO7eD/3C3nNx7N+pzgqMaPzR9k=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54DLxZ031005887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 13 May 2025 16:59:36 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 May 2025 16:59:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 May 2025 16:59:35 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxYdG111031;
	Tue, 13 May 2025 16:59:35 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Bin Liu <b-liu@ti.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Andrew Davis <afd@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 5/7] DONOTMERGE: arm64: dts: ti: k3-am642-sk: Enable PRU UART
Date: Tue, 13 May 2025 16:59:32 -0500
Message-ID: <20250513215934.933807-6-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513215934.933807-1-jm@ti.com>
References: <20250513215934.933807-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

There is one PRU UART module in each ICSSG for am64 SoC.

UART RX/TX signals for PRU UART in ICSSG0 can be routed from/to the
PRU Connector J10 (pins 45/44) on am64x SK, so enable icssg0_uart by
default and add pinmux node.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 1deaa0be0085..9065fc8a7569 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -25,6 +25,7 @@ aliases {
 		serial0 = &mcu_uart0;
 		serial1 = &main_uart1;
 		serial2 = &main_uart0;
+		serial3 = &icssg0_uart;
 		i2c0 = &main_i2c0;
 		i2c1 = &main_i2c1;
 		mmc0 = &sdhci0;
@@ -284,6 +285,15 @@ AM64X_IOPAD(0x0244, PIN_OUTPUT, 0) /* (E14) UART1_TXD */
 		>;
 	};
 
+	icssg0_uart_pins_default: icssg0-uart-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0184, PIN_INPUT, 2) /* (W6) PRG0_PRU0_GPO9.PRG0_UART0_CTSn */
+			AM64X_IOPAD(0x0188, PIN_OUTPUT, 2) /* (AA5) PRG0_PRU0_GPO10.PRG0_UART0_RTSn */
+			AM64X_IOPAD(0x01d4, PIN_INPUT, 2) /* (Y5) PRG0_PRU1_GPO9.PRG0_UART0_RXD */
+			AM64X_IOPAD(0x01d8, PIN_OUTPUT, 2) /* (V6) PRG0_PRU1_GPO10.PRG0_UART0_TXD */
+		>;
+	};
+
 	main_usb0_pins_default: main-usb0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -413,6 +423,12 @@ &main_uart1 {
 	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
+&icssg0_uart {
+	pinctrl-names = "default";
+	pinctrl-0 = <&icssg0_uart_pins_default>;
+	status = "okay";
+};
+
 &main_i2c0 {
 	bootph-all;
 	status = "okay";
-- 
2.49.0

