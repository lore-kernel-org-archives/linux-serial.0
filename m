Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021119.outbound.protection.outlook.com [40.93.194.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038034FF62;
	Fri, 17 Jul 2026 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260312; cv=fail; b=Azv1TkqOmQCRodyP/LZi27AWcMuDkJ0GoAmbdmhsN42WbnseOvb0M+q5bh9TvSBhNlTRs9UaZXWPp9N2AkQa4z03ddssaZgupJxUpJR6JgIZakQI36cpkxgevwDJHndQOZA4nTdIYWsAQCK411JaIpB3d0vt8l3wQf3KVOI22fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260312; c=relaxed/simple;
	bh=D3wfVIQBmOCCdycboINU/1K0/cGb/9q9hl+fgLBXasc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLHMPMM8ybNRwTPx3OJuol4W1BwpymmJ96CCzMPdmNhj17g3oghBh51gCych+zXR9PMoNQbDa3zXm3+au0wIt50IQRDjjAlYZsEAnxYvTtgxKxS6SiXtA7dq45XM1g0pKHV8+T/OBhTnW0D5mJJPVsGINTyd4jHbFbKKAS6sey8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=l2nsWWcf; arc=fail smtp.client-ip=40.93.194.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="l2nsWWcf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXocVKzZhkzJRHDXm0z2KEolcr/SRcMqvJw2UB2RihVzHqbVBrIdmw+voSA5C9lqDLkq+l3P9DjjKeh/HombG5kt1AkD90zxXzYTj64sKDI9m8LtQOJ9x3BRw7X96mQrdW9QnllyK/Bg7paZOeTvZQiGjAT7WfVYiqyDvhqFhJ3M6PTB1ZE1Pmb9ftaMwRnlmw5JIXC53sr4d9obKAIggEfO7W8X6/LJu4lFzVMyKhbNaslC2orGHKMMBf26d7W+igkQHwmkQfWDSCvahy6italDI2wSzO/HQVzatvxz6wfSlvD/Mzx1smQiTqKbFaWIIpmdaBYg2T7gDfR791Xwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pt87qYAGEO7+IGQIb8vRJS7jwKfXtTaVVhFlhRWoPqw=;
 b=M93Hn+nbLSWvWig/J9Ru3LjQCBvFuXmnb4cVKBekZ77yYzpEGVoQ30bWWc2zNzPw9mQUbPFNsJOwv7p0nJtNSM8QG+rSlzqMYjiB7UR8wH7qUCkONNKvHvBA2MYv/hhd/yj8idBMpw3aflh1O1hg965+pf/LQ87d1sK8oAzjpRxT0Rska6dXH4kdsbfiJ38ds/LciqqVQU6ejvhVhqPAyoCG6ct1TRX2QmeIm5RKMTrN+q1QRQHUno/rbVOYbcUhzqegA+3Ky/ktRuEZIP6srltd1wypirYtnBo4zv229AmOZc+UvCpi2yg2fsz+zoLOMlynOlDyicdUrVov+NzxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt87qYAGEO7+IGQIb8vRJS7jwKfXtTaVVhFlhRWoPqw=;
 b=l2nsWWcfLx6HvbywmB1dzwN32H4RFVZE4DLN0KMz10VHGIWrgEVfXt8VTECDEqW9T4dRv1rHmluKsO7tcPLDZYxzMAY1o+slZ4Gcd0ZcjMSMet6IWt58DIIMjJQYGQENC+HUaD4vM2/BLIga5j4kpyZz8Y8zUwIv4Fy0+PqX9l+AfB5Drh2c5C3T+6h8hbUDnIdx5gxF+eanp2z0R1xDdADiqi/M3QFExnPdCjoA9Mp8rbY4k+Sjy6tfPojOhqkAQn0Y8lUKZu7N0DAkaa6Rksl7iv6l37a749XHMjiIbsL4uBE+hgubXdGfGQwDE5TA3zTZn1gY1rMsDuU0wWHY/w==
Received: from CH0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:610:32::28)
 by MW4PR18MB5107.namprd18.prod.outlook.com (2603:10b6:303:1b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:51:28 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::1) by CH0PR07CA0023.outlook.office365.com
 (2603:10b6:610:32::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 03:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 17 Jul 2026 03:51:27 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id 56BFA40BFE12;
	Thu, 16 Jul 2026 20:51:26 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Thu, 16 Jul 2026 20:51:15 -0700
Subject: [PATCH v3 8/8] arm64: dts: axiado: Add initial support for AX3005
 SoC and eval board
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-upstream-axiado-ax3005-upstream-v3-8-c429095143ec@axiado.com>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Jan Kotas <jank@cadence.com>, Michal Simek <michal.simek@amd.com>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Mathias Nyman <mathias.nyman@intel.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, Swark Yang <syang@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=30133; i=syang@axiado.com;
 h=from:subject:message-id; bh=D3wfVIQBmOCCdycboINU/1K0/cGb/9q9hl+fgLBXasc=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhqzIZXvX8cSdiZu8K8pmh+cW80UP67evFXF+K1/Prdb7O
 dhyl8y2jlIWBjEOBlkxRZavOt/yT+Zq3+vcu7IUZg4rE8gQBi5OAZjIh4eMDJdVwhXKYx9H1y9e
 MpNF9+OatyZq/rfn3/IwVspsjCq/IszwT8VFzejil4U/VgtlFnVqlav93Md1fd9sNpniuwc+/Vq
 7gQcA
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MW4PR18MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: c6254e13-accf-45bb-cf61-08dee3b6ae4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|10067099003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GSXcNAALdxRaj9HlY5fRbeJRdn6/Pd4rXuso47hL4hNqWN2ng6lKhfhU0QUaHOcAer85CDRy7dxkFyflb/8tSncOIsTRbTusQmaXaOetKx1GSQ0ZEEf8IQAUN1d8OlSIxHQNZMdcvWM1R1d9kA8UKe7xLZh56z9XIePbRgih1QrwDJ2i6K/Sd5XEQLA80/8/MuwZh6Wmy9uQi/w6wPDMp/VdTo/Fd2j6ucXxGLcvqSk07Mqmxw7Z8/cUJyQ1tIAG5QO+hq63IlFNq7jQ0/dQI9lYjAUYw3M/N2mzzf3Vlx9E/wrEXTMYPYNNf/97HWQOq111m7Wwx+gJkLJOAZEPYJPxHo+T7artym0e+j53Y+NyY6gVrmAc/KYJSRDuNyS3rk2iGL7oErj68GcihCPDbCXOtWupmr1vLXxFLZ9lzE2O19LMVc8sunu2WoRgd+wCxONMSIRHIvaBI1LrGMHPC+mDmeCIKzajRmi00I23F7Bv64nm/+tcJvxpKyHFMgUZ2T3YBaxNhTYVuumP6Fw5F3VyGfzcZernYyD0vtc+rxr5vjeuZFxq7LsCCSL3Ctpa/BrkWy2LB4+zFQvckpan3r279WdgT2HZQhg37FqAfsiBd1sB+9qirr3A0FGXSEEhgxD3M5n4qTHyRFDvLnVbfvRC2xfUYVHAPigSTuKmoET8lSfmsGP5haKnGCSTF9lKurCQgL+I8hXHuHJ1CfAtWViraPuHa8M0kEW/ntf9A9/oxG+we282HuJU9nLHFWXF
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OyMufbsA9KN7OTBbzzm901saJqGckstfJaL/CJ+8ea6lIXGQcZ3raFp1Attw32pq4vwNKcndbYe3q9SqYo4iylrJ0DQny5RGwmv37rFMPbAfI6kG7Vke1rWd/s791/szQ7n2g/Ys/cYpZSWzY3ajOa6oOXUr9NJE+1A1y0QE7h549gzpUKHvMkq0iHWpoNCND35LLlKeNmPHZp5nP4ynx4SdpdeZjilfN8/QPrSaYsj4bLYBDRBeyA+kari0ABWCEbS2Wb2GcQE3njPQixDNuz+XK4ROn6RpWZYfkVICt/pfoVwwLQLFbOBtd+gujJCLSRU/EAO0U7YtPAuc8lkRrH2GjbI7tfGv0MiSDZy+zyru3E1es4J+hXsST7hs6ZdoSlazqOt8FFXaritErBSMnG3pDqMUVZ6MA0DKgQyKYhyBFGWNYpcW3yxZGjIGx8jo
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:51:27.9692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6254e13-accf-45bb-cf61-08dee3b6ae4b
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5107

Add initial device tree support for the AX3005 SoC and its evaluation
board. The AX3005 is a multi-core SoC featuring 4 Cortex-A53 cores, and
this adds the CPUs, timer, GPIO, UART, I2C, I3C, SPI and USB
controllers.

Note that all secondary CPUs share a single cpu-release-addr for SMP
bring-up per the AX3005 platform specification.

The AX3005 groups its low-speed controllers into four Slow Peripheral
(SP) blocks (SP0-SP3), each exposing its own I2C/I3C, SPI and UART
instances. The controllers are numbered by their per-SP hardware
instance ID, so the i2cN/spiN/uartN labels and their aliases are
intentionally non-contiguous and do not increase monotonically with
the register address.

Signed-off-by: Swark Yang <syang@axiado.com>
---
 arch/arm64/boot/dts/axiado/Makefile       |   1 +
 arch/arm64/boot/dts/axiado/ax3005-evk.dts | 327 ++++++++++++
 arch/arm64/boot/dts/axiado/ax3005.dtsi    | 842 ++++++++++++++++++++++++++++++
 3 files changed, 1170 insertions(+)

diff --git a/arch/arm64/boot/dts/axiado/Makefile b/arch/arm64/boot/dts/axiado/Makefile
index 6676ad07db61..e71a0850a451 100644
--- a/arch/arm64/boot/dts/axiado/Makefile
+++ b/arch/arm64/boot/dts/axiado/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_AXIADO) += ax3000-evk.dtb
+dtb-$(CONFIG_ARCH_AXIADO) += ax3005-evk.dtb
diff --git a/arch/arm64/boot/dts/axiado/ax3005-evk.dts b/arch/arm64/boot/dts/axiado/ax3005-evk.dts
new file mode 100644
index 000000000000..f6705504679e
--- /dev/null
+++ b/arch/arm64/boot/dts/axiado/ax3005-evk.dts
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DTS file for Axiado AX3005 SoC based EVK
+ * Copyright (c) 2026 Axiado Corporation.
+ */
+
+/dts-v1/;
+
+#include "ax3005.dtsi"
+
+/ {
+	model = "Axiado AX3005 EVK";
+	compatible = "axiado,ax3005-evk", "axiado,ax3005";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c8 = &i2c8;
+		i2c9 = &i2c9;
+		i2c10 = &i2c10;
+		i2c11 = &i2c11;
+		i2c12 = &i3c12;
+		i2c13 = &i3c13;
+		i2c14 = &i2c14;
+		i2c15 = &i2c15;
+		i2c16 = &i2c16;
+		i2c17 = &i2c17;
+		i2c18 = &i2c18;
+		i2c19 = &i2c19;
+		i2c20 = &i2c20;
+		i2c21 = &i2c21;
+		i2c22 = &i2c22;
+		i2c23 = &i2c23;
+		i2c24 = &i2c24;
+		i2c25 = &i2c25;
+		i2c26 = &i2c26;
+		i2c27 = &i2c27;
+		i2c28 = &i2c28;
+		i2c29 = &i2c29;
+		i2c30 = &i2c30;
+		i2c31 = &i2c31;
+		i2c32 = &i2c32;
+		i2c33 = &i2c33;
+		i2c34 = &i2c34;
+		i2c35 = &i2c35;
+		i2c36 = &i2c36;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		spi3 = &spi3;
+		spi5 = &spi5;
+		spi6 = &spi6;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200";
+	};
+
+	memory@81000000 {
+		device_type = "memory";
+		/* Cortex-A53 will use following memory map */
+		reg = <0x0 0x81000000 0x0 0x7f000000>;
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
+&gpio3 {
+	status = "okay";
+};
+
+&gpio4 {
+	status = "okay";
+};
+
+&gpio5 {
+	status = "okay";
+};
+
+&gpio6 {
+	status = "okay";
+};
+
+&gpio7 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i3c12 {
+	status = "okay";
+};
+
+&i3c13 {
+	status = "okay";
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&i2c16 {
+	status = "okay";
+};
+
+&i2c17 {
+	status = "okay";
+};
+
+&i2c18 {
+	status = "okay";
+};
+
+&i2c19 {
+	status = "okay";
+};
+
+&i2c20 {
+	status = "okay";
+};
+
+&i2c21 {
+	status = "okay";
+};
+
+&i2c22 {
+	status = "okay";
+};
+
+&i2c23 {
+	status = "okay";
+};
+
+&i2c24 {
+	status = "okay";
+};
+
+&i2c25 {
+	status = "okay";
+};
+
+&i2c26 {
+	status = "okay";
+};
+
+&i2c27 {
+	status = "okay";
+};
+
+&i2c28 {
+	status = "okay";
+};
+
+&i2c29 {
+	status = "okay";
+};
+
+&i2c30 {
+	status = "okay";
+};
+
+&i2c31 {
+	status = "okay";
+};
+
+&i2c32 {
+	status = "okay";
+};
+
+&i2c33 {
+	status = "okay";
+};
+
+&i2c34 {
+	status = "okay";
+};
+
+&i2c35 {
+	status = "okay";
+};
+
+&i2c36 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&spi2 {
+	status = "okay";
+};
+
+&spi3 {
+	status = "okay";
+};
+
+&spi5 {
+	status = "okay";
+};
+
+&spi6 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart6 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&uart8 {
+	status = "okay";
+};
+
+&usb2_0 {
+	status = "okay";
+};
+
+&usb2_1 {
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/axiado/ax3005.dtsi b/arch/arm64/boot/dts/axiado/ax3005.dtsi
new file mode 100644
index 000000000000..f9ec68efc613
--- /dev/null
+++ b/arch/arm64/boot/dts/axiado/ax3005.dtsi
@@ -0,0 +1,842 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2026 Axiado Corporation.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+/memreserve/ 0x80002fa0 0x00000008;
+/ {
+	model = "Axiado AX3005";
+	interrupt-parent = <&gic500>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clocks {
+		refclk: clock-125000000 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+		};
+
+		pclk: clock-100000000 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+		};
+
+		sysclk: clock-200000000 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
+
+		spiclk: clock-400000000 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <400000000>;
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x80002fa0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x80002fa0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x80002fa0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a53";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x80002fa0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+			cache-unified;
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		interrupt-parent = <&gic500>;
+		ranges;
+
+		gic500: interrupt-controller@40400000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x40400000 0x0 0x10000>,
+			      <0x0 0x40500000 0x0 0xc0000>;
+			ranges;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+			#redistributor-regions = <1>;
+		};
+
+		/* GPIO Controller banks 0 - 7 */
+		gpio0: gpio-controller@33000000 {
+			compatible = "axiado,ax3005-gpio", "axiado,ax3000-gpio", "cdns,gpio-r1p02";
+			reg = <0x0 0x33000000 0x0 0x100>;
+			clocks = <&pclk>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio1: gpio-controller@33080000 {
+			compatible = "axiado,ax3005-gpio", "axiado,ax3000-gpio", "cdns,gpio-r1p02";
+			reg = <0x0 0x33080000 0x0 0x100>;
+			clocks = <&pclk>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio2: gpio-controller@33100000 {
+			compatible = "axiado,ax3005-gpio", "axiado,ax3000-gpio", "cdns,gpio-r1p02";
+			reg = <0x0 0x33100000 0x0 0x100>;
+			clocks = <&pclk>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio3: gpio-controller@33180000 {
+			compatible = "axiado,ax3005-gpio", "axiado,ax3000-gpio", "cdns,gpio-r1p02";
+			reg = <0x0 0x33180000 0x0 0x100>;
+			clocks = <&pclk>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio4: gpio-controller@33200000 {
+			compatible = "axiado,ax3005-gpio", "axiado,ax3000-gpio", "cdns,gpio-r1p02";
+			reg = <0x0 0x33200000 0x0 0x100>;
+			clocks = <&pclk>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio5: gpio-controller@33280000 {
+			compatible = "axiado,ax3005-gpio", "axiado,ax3000-gpio", "cdns,gpio-r1p02";
+			reg = <0x0 0x33280000 0x0 0x100>;
+			clocks = <&pclk>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio6: gpio-controller@33300000 {
+			compatible = "axiado,ax3005-gpio", "axiado,ax3000-gpio", "cdns,gpio-r1p02";
+			reg = <0x0 0x33300000 0x0 0x100>;
+			clocks = <&pclk>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		gpio7: gpio-controller@33380000 {
+			compatible = "axiado,ax3005-gpio", "axiado,ax3000-gpio", "cdns,gpio-r1p02";
+			reg = <0x0 0x33380000 0x0 0x100>;
+			clocks = <&pclk>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@33000400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33000400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@33000800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33000800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@33080400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33080400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@33080800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33080800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@33100400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33100400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@33100800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33100800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c8: i2c@33200400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33200400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c9: i2c@33200800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33200800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c10: i2c@33280400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33280400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c11: i2c@33280800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33280800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i3c12: i3c@33300400 {
+			compatible = "axiado,ax3005-i3c", "cdns,i3c-master";
+			reg = <0x0 0x33300400 0x0 0x400>;
+			clock-names = "pclk", "sysclk";
+			clocks = <&pclk &sysclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			i2c-scl-hz = <100000>;
+			i3c-scl-hz = <400000>;
+			#address-cells = <3>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i3c13: i3c@33300800 {
+			compatible = "axiado,ax3005-i3c", "cdns,i3c-master";
+			reg = <0x0 0x33300800 0x0 0x400>;
+			clock-names = "pclk", "sysclk";
+			clocks = <&pclk &sysclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			i2c-scl-hz = <100000>;
+			i3c-scl-hz = <400000>;
+			#address-cells = <3>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c14: i2c@33380400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33380400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c15: i2c@33380800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33380800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c16: i2c@33120400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33120400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c17: i2c@33021400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33021400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c18: i2c@33021800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33021800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c19: i2c@330c0400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x330c0400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c20: i2c@330c0800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x330c0800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c21: i2c@330c0c00 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x330c0c00 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c22: i2c@331a0800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x331a0800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c23: i2c@33302800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33302800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c24: i2c@33302c00 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33302c00 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c25: i2c@33303000 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33303000 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c26: i2c@33382000 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33382000 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c27: i2c@33382400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33382400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c28: i2c@33382800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33382800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c29: i2c@33382c00 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33382c00 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c30: i2c@33383000 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33383000 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c31: i2c@33383400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33383400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c32: i2c@33383800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33383800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c33: i2c@33282400 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33282400 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c34: i2c@33282800 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33282800 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c35: i2c@33282c00 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33282c00 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c36: i2c@33283000 {
+			compatible = "axiado,ax3005-i2c", "cdns,i2c-r1p14";
+			reg = <0x0 0x33283000 0x0 0x400>;
+			clocks = <&pclk>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi0: spi@33010000 {
+			compatible = "axiado,ax3005-spi", "snps,dwc-ssi-1.01a";
+			reg = <0x0 0x33010000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&spiclk>;
+			num-cs = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		spi1: spi@33090000 {
+			compatible = "axiado,ax3005-spi", "snps,dwc-ssi-1.01a";
+			reg = <0x0 0x33090000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&spiclk>;
+			num-cs = <1>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		spi2: spi@333c0000 {
+			compatible = "axiado,ax3005-spi", "snps,dwc-ssi-1.01a";
+			reg = <0x0 0x333c0000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&spiclk>;
+			num-cs = <1>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		spi3: spi@330e0000 {
+			compatible = "axiado,ax3005-spi", "snps,dwc-ssi-1.01a";
+			reg = <0x0 0x330e0000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&spiclk>;
+			num-cs = <1>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		spi5: spi@33390000 {
+			compatible = "axiado,ax3005-spi", "snps,dwc-ssi-1.01a";
+			reg = <0x0 0x33390000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&spiclk>;
+			num-cs = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		spi6: spi@333a0000 {
+			compatible = "axiado,ax3005-spi", "snps,dwc-ssi-1.01a";
+			reg = <0x0 0x333a0000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&spiclk>;
+			num-cs = <1>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart0: serial@33020000 {
+			compatible = "axiado,ax3005-uart", "cdns,uart-r1p12";
+			reg = <0x0 0x33020000 0x0 0x100>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&refclk &pclk>;
+			status = "disabled";
+		};
+
+		uart1: serial@330a0000 {
+			compatible = "axiado,ax3005-uart", "cdns,uart-r1p12";
+			reg = <0x0 0x330a0000 0x0 0x100>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&refclk &pclk>;
+			status = "disabled";
+		};
+
+		uart2: serial@33120000 {
+			compatible = "axiado,ax3005-uart", "cdns,uart-r1p12";
+			reg = <0x0 0x33120000 0x0 0x100>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&refclk &pclk>;
+			status = "disabled";
+		};
+
+		uart3: serial@33020800 {
+			compatible = "axiado,ax3005-uart", "cdns,uart-r1p12";
+			reg = <0x0 0x33020800 0x0 0x100>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&refclk &pclk>;
+			status = "disabled";
+		};
+
+		uart4: serial@331a0400 {
+			compatible = "axiado,ax3005-uart", "cdns,uart-r1p12";
+			reg = <0x0 0x331a0400 0x0 0x100>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&refclk &pclk>;
+			status = "disabled";
+		};
+
+		uart5: serial@33381d00 {
+			compatible = "axiado,ax3005-uart", "cdns,uart-r1p12";
+			reg = <0x0 0x33381d00 0x0 0x100>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&refclk &pclk>;
+			status = "disabled";
+		};
+
+		uart6: serial@33381e00 {
+			compatible = "axiado,ax3005-uart", "cdns,uart-r1p12";
+			reg = <0x0 0x33381e00 0x0 0x100>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&refclk &pclk>;
+			status = "disabled";
+		};
+
+		uart7: serial@33381f00 {
+			compatible = "axiado,ax3005-uart", "cdns,uart-r1p12";
+			reg = <0x0 0x33381f00 0x0 0x100>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&refclk &pclk>;
+			status = "disabled";
+		};
+
+		uart8: serial@330c0000 {
+			compatible = "axiado,ax3005-uart", "cdns,uart-r1p12";
+			reg = <0x0 0x330c0000 0x0 0x100>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "uart_clk", "pclk";
+			clocks = <&refclk &pclk>;
+			status = "disabled";
+		};
+
+		usb2_0: usb@41000000 {
+			compatible = "axiado,ax3005-xhci", "generic-xhci";
+			reg = <0x0 0x41000000 0x0 0x100000>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		usb2_1: usb@41100000 {
+			compatible = "axiado,ax3005-xhci", "generic-xhci";
+			reg = <0x0 0x41100000 0x0 0x100000>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		usb3_0: usb@41400000 {
+			compatible = "axiado,ax3005-xhci", "generic-xhci";
+			reg = <0x0 0x41400000 0x0 0x100000>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		usb3_1: usb@41500000 {
+			compatible = "axiado,ax3005-xhci", "generic-xhci";
+			reg = <0x0 0x41500000 0x0 0x100000>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+};

-- 
2.34.1

