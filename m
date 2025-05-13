Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FEB217659;
	Tue, 13 May 2025 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173602; cv=none; b=tZiSIM1U9QLXMojF0XwX+vDSJ8E/lCY7bBk8JSPestBJPcHCNT0x+gVJNXPlcuMzWBzQsft9tZj4AcxOPpFpjELpHyiiJjUgTQme9bClVjkv87hHnu7n6PsDpuJ8hK5AWFRw53e7dEBNwTpK6eI6etwPNsj7HiBPfyB7HX28J8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173602; c=relaxed/simple;
	bh=5EjVsjxBlzfUERFXjaKmvuV82xLSUkfyC7+UBqTb/04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwGZL0mPn6JxSeD86bcdx+S86EIFHHXLqIKwPa6ccbd7a3O5ghT35Y6U6bXjMSk35qT3awDmaJkcTctQxpy4/zfEXJ0Xl5sl9FtYdGokeW8QPV16e0ZsBcFJb7s2nhB2YrAaDS25Wi0L/2vPslLtfLmYXefWSe3OvZAs1esB8vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xtoa2PHH; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xtoa2PHH"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxaCl2431444;
	Tue, 13 May 2025 16:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747173576;
	bh=PaXp3+Nc4om8rc2bk8qplk5oP4MocCsaSbkZb3DsCtw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xtoa2PHH8NNnlNIvxtJ0iTBfsGyJcMXfl8yIJK0einXWti5e0cubP7ZTzilM75ENp
	 g2WwLiyouRLtfK6UkaueaGGSk1b3AZHHBwQM7Y+rMuzNGRq96l+5K/YBaqE/6HsIIO
	 LVIxl45889/QWNR6mwFp38foUMwOC5bTRXUmKrHA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54DLxZON1005889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 13 May 2025 16:59:35 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 May 2025 16:59:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 May 2025 16:59:35 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxYdI111031;
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
Subject: [PATCH 7/7] DONOTMERGE: arm64: dts: ti: k3-am62x-sk: Enable PRU UART
Date: Tue, 13 May 2025 16:59:34 -0500
Message-ID: <20250513215934.933807-8-jm@ti.com>
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

There is one PRU UART module in the PRU subsystem for am62 SoC.

UART RX/TX signals for PRU UART in PRU subsystem can be routed from/to
the user expansion header J3 (pins 10/8) on am62x SK, so enable
pruss_uart by default and add pinmux node.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index ee8337bfbbfd..c474e1d1a74d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -15,6 +15,7 @@ aliases {
 		serial0 = &wkup_uart0;
 		serial1 = &mcu_uart0;
 		serial2 = &main_uart0;
+		serial3 = &pruss_uart;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 		mmc2 = &sdhci2;
@@ -181,6 +182,13 @@ AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20/D16) MCASP0_ACLKR.UART1_TXD */
 		>;
 	};
 
+	pruss_uart_pins: pruss-uart-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01d8, PIN_INPUT, 6) /* (C15) MCAN0_TX.PR0_UART0_RXD */
+			AM62X_IOPAD(0x01dc, PIN_OUTPUT, 6) /* (E15) MCAN0_RX.PR0_UART0_TXD */
+		>;
+	};
+
 	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (B16/E12) I2C0_SCL */
@@ -370,6 +378,12 @@ &main_uart1 {
 	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
+&pruss_uart {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pruss_uart_pins>;
+	status = "okay";
+};
+
 &main_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.49.0

