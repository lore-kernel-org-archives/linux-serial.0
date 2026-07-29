Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012063.outbound.protection.outlook.com [52.101.126.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5E39A4A4;
	Wed, 29 Jul 2026 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305194; cv=fail; b=eTe3bsCF6vD9y1z6A2+CbeKaBYj7cWs9NMjBBX5Fts9s1MJvWTuSS7p3KuOGKq42IW/9KmZlKHMOfWka2nfGeXD3BZeSNMltE8Mn4dZR4G/6Mnr2ci2SwaN1Q2w3J5Sodw+3adPseVeaK1cit9IzQ5bVm31lTtk6SiZTT2VFWn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305194; c=relaxed/simple;
	bh=UQT6RJIUz95DArGjp5UkDptSV1P++4gxmpLbS5+/XLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6F9H5McgwhhtpXw7qQJGO4kADXrPX0lvwP/Fx+fk6Vu/AUJDYNdrDP8TUGaFeNtSs+JkQpFyXkzmznUoTTGYctyTp+Q85e/G1Sd0IgpwqUjlb44JVlnNO7hzP7+9olMrGk3DVGHTaiagGCeS7dLBgac0KZmHnbgWtX84PkzoOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=DPo3/65Z; arc=fail smtp.client-ip=52.101.126.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="DPo3/65Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg4ke1f7Ep5QcbHmBd0vQ0sNBaQqfc56Em4gw3HzsHCKwQIc6Ln8N0AgG4wX96UZ2CmAu/twVqHrmz9olXaxHxBmRcXYzFSsjP1PD1Umf7h0n6MV0ims/mn1I++17HJ3YaxisnEKY12NXkczWakDM56YIkTqOBOpzWYqt+uS3W86jRu5bR/njhQBtwc3tNs3OhJXTdOTlTmo0hdXWphiB/WT15GovsJpeqYPfIinhPew7iZ2ik5gmOYQxAb6Pa4/3SgHlAjmvuHoN7XrtfoiUt/d2YNEVpMDkHxLTYsEdsQz9UYQRVrCo3tWu0E2/sEOQgA5j6XDebXUxdUzZHJvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVJkcLCNiK/kLgYGKEdegkWilJIsKl2e3nGQ8tAtAl8=;
 b=bXOjeIhNuwIaJWqs/VtClPjI+2yzx/PtF9DochaHuBupYYNlrBYHYaE0m8Bz5a6EQvUweEsDtV4IZuqhAZr6dkI+XEUAAX3bWr31wUiRtwgnyNajIzc+IPlKAZzqvW0FMwjROE7fSigBFjt7uFoXoCEL4WwVSRsUxj1G6tot45jJhGpJRdQ/+f1pnxmHcq+nOH3/nuzxqMp6zwLIXVb41TtZnIR8oqLTpkwZua8xuOCGJWZd4YhtgOYxdoZQSLOhkMCCn2Qchrp0WCePBo98y0S0ecUxGBgXcm4ddmSSIhEtzPtbRMPBodUNrIkjs2QJYmCrB8fJY/8H3Fc0aExdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVJkcLCNiK/kLgYGKEdegkWilJIsKl2e3nGQ8tAtAl8=;
 b=DPo3/65ZV5G834dwrIJmlI9Cw0XAouZv0Ie2P3Sl33QQAnNMIFzQTl372J+FrFCQ97R0cMHpo7f6n5puWm1cUDjkO6S/rdl9MkoVqQdF3YDVwYsqCNgM74C32DungAQjm0UDlt9Ala8+vXxvvUWv6VKYQoQDhtmftZHzlDQ8nXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:26 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:26 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v4 03/14] serial: 8250_mxpcie: enable enhanced mode and program FIFO trigger levels
Date: Wed, 29 Jul 2026 14:05:51 +0800
Message-ID: <20260729060602.492430-4-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEL0PF4D55A38B9:EE_
X-MS-Office365-Filtering-Correlation-Id: 39727b6c-f140-4b73-0209-08deed3785e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|6133799003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	uYA7y6Ln7cKtoThY3e3DmN80ivTlk4p/jONcQggp64lAGZSVJIVU/wuR4/JPeOFF0WK1Aobxn7vMii34nYXnfnW2wcQcrLTKAJm4L68ikmesIbA0e6w4/J3HIcEZrwAceQ/GcLxP1WFgpfohg3x8mzuQgwGq3zBZ0wN2NzPAkwyJqAIFsCELUqipuusTH5EXrbQvtBfF4QcgnL0UmCSRCXUW7aNDiD69xr+BLjlEEOetkB+jpnZV06hmAxN4ZuBYyi4kmP6EHRuktICsdZolQq5H7pH7hIItXK6TGUEtoknR2E4/iT7sUt+Osbw5nA6i0KgwWsj50NhR08oqlxvLnk7DR0tmSQExxMwJjxVEZ+U5ZBqZfk0Qsga1ooB9uTFtxxC19jaQyFmereOm31tCpAuldneakpI6g5IWAC7q47bQbgkZ2Dr4OiSMdA+v6BEWx78D58KY5B1HipD+hB8BSetB8QfkkPsHmSCmMyJ3qB9e4vqUom2fdTs3N4+vbnoUpdGetp1P55Z1BY7DCLBtPl/iCqjq6Q51FrqWroM5zb2rOr+dTDBVlQFHypDVNh/BGquCavCCOFzMm2AyelrByZLoMAy3Pw3I4LlP2cBSe0NnIPMHZCKNHXNxPkgeJFk5LpNr8CzBPKe3Vk3yimflZ0tKSOE08oJI+njnriVloFreKT/nS5lkcxAuYHqPsmphhHSyx1oK4s74fdDJvwxYy1C6mAo2oFk4a2nMUkC3NEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qypa7AeWU3wZ6Lf2sbfqIQOamGMyHvR87n2StwbT13R2fHH/BxZiYoogdNZy?=
 =?us-ascii?Q?Zl4GoGGM6tp1Zlwvm3W75QsPQsGHAKDur9AvqfywW/eWfnuHiCkGFKnPFNpZ?=
 =?us-ascii?Q?azJZ3cAIPZsv2a+EOqO4IIK6Rby1RNqLYBJoeNh4ls0q24OOl5I0AdYeFDrp?=
 =?us-ascii?Q?p2kMup6tapnTn26vKPZjWq3KNSogwH3mrmOo9PoDqaqQ6/QFNqSaZzpvZGJM?=
 =?us-ascii?Q?TIGqHWNpl6ffnnd0rSUaxNuRWFa9mRaqfpjMQVQ57MD4SJNRy3brFSgbBaX5?=
 =?us-ascii?Q?HILP9vnCt9bIA/enPCuLQDMk9qxkAboj3N0mA+A9PgV8t1D/mno8ECOpvk50?=
 =?us-ascii?Q?d97J3yjrFTyiOedfjZGcWWaKzLodZXTnoRH2oApnVT755nrSk9wk5eKOYpZl?=
 =?us-ascii?Q?9G9tKsk7MdF3G1bs27KC1Uyf9EavMSTF9pYSaJwJ2sWb3Tb2MbvU/O9+nDZz?=
 =?us-ascii?Q?aLNCr0/8WuhWObyPF+n2vkMqWP3NReXKeO/RKi+o1dESy3AIsuAsh1Kcuz3C?=
 =?us-ascii?Q?MeEtRP2Fu4RcX69BytrecyFSnYvoVF9BK4wjBTmF0oGlFU8l6iqMN+OziHBC?=
 =?us-ascii?Q?OrO4MzHWmuUwPbWnvzsk5JqZMt8RoRoYilaZ52WH0b/i9ztsHCiG6s/YgotL?=
 =?us-ascii?Q?WwYsvzJ1RaWs1LBe63h1zbZK5Dm4fpHufBhW112mbNhVOJ6pfhjaKi37i02L?=
 =?us-ascii?Q?7G4GyRoia1W3qQWWtJR3IX6VjD95Hd8XIeMK8fP1gMHqAIjySSINim76Ruk9?=
 =?us-ascii?Q?9bmtiuKNdV+DJng+Jiplc2QPXn1xd2riA0cT14iVkBJ8vdIym4vlZfA4y+Gr?=
 =?us-ascii?Q?ENIJ+QlXfsanAWzWsXhkeX8LQab941sM2l/q8gSMLrpqi213+jg5e7vN656t?=
 =?us-ascii?Q?kIhSdvWN7pMpsNiire+s0UCoWHPVPtR4GacSqVKSEC1B5hjJecaaxPQkueof?=
 =?us-ascii?Q?BLD6WtfyWtRmz0xB8hOzKwviqi1ZtBh9UR/xdvwlXsnQIiTZ6jPVMCpyWKfN?=
 =?us-ascii?Q?JVb8n6rbvgYdZMwbCUpKcTfG2XEPmqwrkuuYCVDHQNR4p0H6i9XKiD379G+Q?=
 =?us-ascii?Q?WBwofIUjyHHRbIpVo4+UI/+K8bsv7HEldD4py28qkJ+ID7RLePHIEyExfwPX?=
 =?us-ascii?Q?tIUbrucdYyYB8rk096mVREZ7tZTuL7xNZY6ZEPC1E0oid8IaMGMFGFPFxKQu?=
 =?us-ascii?Q?DDHbKvxBPdKMPgYA5gnU8hTZnOwAmBry9TyK+jJUNXF0f0wklK0KC1wXJKlX?=
 =?us-ascii?Q?a5vSerUh+DTuKyPqtbihpr7bGS5s8mhtSxWeaHvQg5eM3Y+ZbRM1t58CEuEz?=
 =?us-ascii?Q?r8lF9QZEPqsMwxlJMwKa1v1ZIv6K+hYLBxHvkytaterA5O+g7qGngteJUWTu?=
 =?us-ascii?Q?G52LKzVsrJpoymNr0kAfegqC1+HdeJdB7avvGIl1AEmbwfonUdrDU1UAVCYO?=
 =?us-ascii?Q?kCQ7D3b6osHwKWiALhY7kWHHrxYQW2eBIcDjbGSJDIxsqX4QuzllAoELtXOS?=
 =?us-ascii?Q?wgW6VNrW8+yj5Bs3llpqB+ALU2ZK0ZTpvPosukr55A3/KbFkEk9YQZ2i84IN?=
 =?us-ascii?Q?QITSyXHBox+abE/EA9txFWOOtkg4vSf8Ec8Dzl/IJWskanLpC/POWR8Kbo/W?=
 =?us-ascii?Q?J+b8ayFHf3AeiPWwf0MepnS16JOiUDPIUA+onihX6PJo5oo6msVYV91oc9/o?=
 =?us-ascii?Q?UaWLuWZkrvAHX8RZKhplIW9QkzGSks8vCvExtWpEBLd8ks797q3NjP49Tb7f?=
 =?us-ascii?Q?hBZjcr2cuxlS3/+UriBXA0BRTmSuFBQ=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39727b6c-f140-4b73-0209-08deed3785e8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:26.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBW8II43hzMzHRTxWIdNq1tLSmROCWZIFFLyWNQ8DolLcN2vke7o0uOHnWVU++U58crXxEXNOhWTarACjdydxGB/2MW/1qKNtsC/WhDngtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

The MUEx50 UART provides an enhanced register set and programmable FIFO
trigger levels for RX, TX, and flow control.

Enable enhanced mode during port startup and program the MUEx50 FIFO
trigger registers according to the configured port settings. Clear the
programmed state again during shutdown to restore the default UART
configuration.

The TX FIFO write pointer and read pointer are driven by different
clocks. Clear the FIFOs repeatedly during startup so both pointers are
reset before programming the trigger levels.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 63 +++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 7234740a760a..a73cd44c55d3 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -46,6 +46,23 @@
 /* UART */
 #define MOXA_PUART_BASE_BAUD		921600
 #define MOXA_PUART_OFFSET		0x200
+#define MOXA_PUART_TX_TRIG_DEFAULT	0
+#define MOXA_PUART_RX_TRIG_DEFAULT	96
+#define MOXA_PUART_RX_FLOW_LOW_DEFAULT	16
+#define MOXA_PUART_RX_FLOW_HIGH_DEFAULT	110
+
+/* Special Function Register (SFR) */
+#define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_950	BIT(5)
+
+/* Enhanced Function Register (EFR) */
+#define MOXA_PUART_EFR				0x0A
+#define MOXA_PUART_EFR_ENHANCED			BIT(4)
+
+#define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
+#define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
+#define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
+#define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
 
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
@@ -131,6 +148,49 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	iowrite8(cval, uir_addr);
 }
 
+static int mxpcie8250_startup(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	int ret;
+
+	ret = serial8250_do_startup(port);
+	if (ret)
+		return ret;
+
+	/*
+	 * The TX FIFO write pointer (w_ptr) and read pointer (r_ptr)
+	 * are driven by different clocks: w_ptr uses the PCIe clock
+	 * and r_ptr uses the UART clock. When TX FIFO flush is requested,
+	 * w_ptr may be cleared before r_ptr, so the UART can still observe
+	 * pending TX data.
+	 *
+	 * It is recommended to clear the FIFOs at least 5 times to ensure
+	 * both pointers are reset.
+	 */
+	for (unsigned int i = 0; i < 5; ++i)
+		serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+
+	serial_out(up, MOXA_PUART_EFR, MOXA_PUART_EFR_ENHANCED);
+	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
+
+	serial_out(up, MOXA_PUART_TTL, MOXA_PUART_TX_TRIG_DEFAULT);
+	serial_out(up, MOXA_PUART_RTL, MOXA_PUART_RX_TRIG_DEFAULT);
+	serial_out(up, MOXA_PUART_FCL, MOXA_PUART_RX_FLOW_LOW_DEFAULT);
+	serial_out(up, MOXA_PUART_FCH, MOXA_PUART_RX_FLOW_HIGH_DEFAULT);
+
+	return 0;
+}
+
+static void mxpcie8250_shutdown(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	serial_out(up, MOXA_PUART_EFR, 0);
+	serial_out(up, MOXA_PUART_SFR, 0);
+
+	serial8250_do_shutdown(port);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -225,6 +285,9 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.iobase = 0;
 	up.port.regshift = 0;
 
+	up.port.startup = mxpcie8250_startup;
+	up.port.shutdown = mxpcie8250_shutdown;
+
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
 
-- 
2.45.2

