Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022106.outbound.protection.outlook.com [40.107.75.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F01283FE2;
	Sun, 30 Nov 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499460; cv=fail; b=P91L1R1BYlbuBIfCK2RNaj8PFQt21X002JiX55N5wUiRmd9QVtgZOBZabo8ZcGOZVoTneP4EEPlvBKMghS6PQly4t9CS1fwRjRfyR9DQkDUCZtVeUCJUOWXsnOi5OqsXbXjaafVGWeAqNe/7fTznDRZESAv2zjPH8jXtL+6t0cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499460; c=relaxed/simple;
	bh=BZ4lRLiyuoRDX/hmLUroUsCJF73f9wIGMKwviklG3RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjRFVOwESUEAfUvHJVK1PpZlZh2b5/qgKtvFfFqL2TUIGfLftPziyc7vl+YygfV2YG+bH9O4iBHBVp3/NhiWk/pDWL96qHWiOotBdLz5N+/fBd5jIL2OaJcZb9WjjEiEryTx6gL9d/7Mj8q8MsayjqG4hJdeP6f2A6BfZeqqSHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=POAb4xsm; arc=fail smtp.client-ip=40.107.75.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="POAb4xsm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIj/w/xMHlSRdl+k3dJ4EXniQJj1Y2oJNdG9NXCVeUHOt8GYli+bqSxCSVyYGVT+gAcf4qZWdjF2EKUnGxcaaM6QmxR7fEfICbH/VEn8bezBVKdksKb4wCZNVugc4uv6TpiD1tKDObXY8o0NKKpFGrG5NidgczghAn+mieojqIIH8lW9YaN+8jOnrm/bcWTRBoILCTKJ8s6xt5aRUXha01XDsMhn6OoG/3l4VqRH11A8juH6iXZx5VqF9IEz2bmCMqInjLzwxjQF2QEb10qSXNY6ZO3QzK8TY4W6cAewCr+S+46zAQ9I+69a8V3peJ+kgQWhDRnUH2D2Hgnf9BPaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxKcuJw1rdZhlJNXpborI08SbZLvyT0qV0oziLHoUng=;
 b=ZSKEkH1BnC36YKF2sDZ8nhPVyehPBsX6hM6d59SeNMSLbEihFuZGXY52+lG1frDMztxERc1n1pR4fN5XT9QmID3zpKl38GVA2hd/AIyjf7CiDdfOXOyyw+Hdx44ajL4coM8BavgrdQig/NhRJEis6/HvuqMeRxHhyTELBzYYZ3TBp/XyBLvJ6rcZMsmWqDliRBIyETU88Z2ACxT2PuxH9IhaQf8nNM6VTNc/T4unAeMwHRI1cc6F20SBevGxjk/xxNgvGezDfcvXmr3FZjgVmWhXX09s/8G58JsqlxM738zK/R3zwbw2ivKQ/UvE9Q5jYXn5KgQEJshkskJYb2sbbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxKcuJw1rdZhlJNXpborI08SbZLvyT0qV0oziLHoUng=;
 b=POAb4xsm8gU7pCiNRVvX1vzzCOmoGnvUGbpJ5kUgzly7xTXeyL5MBNoDCnf4nzhT9lwvjqhVrjjEbtGD3O0NYEOCSWh6vTBRWwl6myqyjHhnARZHCdVwbBsV4/CF6MUvI8TJ9so6CxhA08fuFurDy/llivpg+KxdwWw19AO4QCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:44:16 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:44:16 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 11/31] serial: 8250_mxpcie: enable enhanced mode and custom FIFO trigger levels
Date: Sun, 30 Nov 2025 18:42:02 +0800
Message-ID: <20251130104222.63077-12-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: d7dabe8b-7d4b-4815-6588-08de2ffd68ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lWesbXp00T7h2srEDS6Wx6Ez+K++srnigFsSvMAnGG9TUwEMoDCgWntMuuLE?=
 =?us-ascii?Q?NIO5Lg8G0VMiaXTrntAv74w4PL6s/TSsBMEN5Vws1S0ua2LugwjLymV2dAOg?=
 =?us-ascii?Q?TC2h3yWmJHoH8IEXHaXxnsEnzjeDM06OuUsWPKGojMuXQsTeLRaQKX39JV2W?=
 =?us-ascii?Q?8yj7h9X3WpnWCl3Xw41vkp0+2u6gASogb9OVCHRqkzOD495BV7wWJDWIYSBl?=
 =?us-ascii?Q?/IDpnqKHcMIMOzWQhbNVgFSgU5fLMb8MviBkcDGM/wKYDUhjJvFT2YHWyE6D?=
 =?us-ascii?Q?bIwYNshVnaSd7SQ0YWJXSrLxXicK7OAoRUxB+6fPQzPxNC9JO1TBUlESGvUC?=
 =?us-ascii?Q?45IEXHEBfXrUd9e19fGzla47IDZBhfDsdE8/FzfhVNqx+XkUThetA3N1jeRf?=
 =?us-ascii?Q?5d4Nf6sTaag8khgjlqMV3DsMx65WH5rE+rBOFkMsTKd391Zyjzg159ea5zdv?=
 =?us-ascii?Q?U5zLNfODC4Fghkh+oZKFQTIC/u4gKFjH7zM34G6og7pIFdHAwJJ3VQt4jcdV?=
 =?us-ascii?Q?Mwgm37WXWiKdTuA4+yi9Trt9o09RksdjUw0QoblqP44rb/V9+eWG0JJzD8IO?=
 =?us-ascii?Q?3PVIt9epD2HyOx3k/W1xYgqOn0l9fqPPNqCwgVFCKw3g7F9yBhq8tggCo6J4?=
 =?us-ascii?Q?qLM7YZFtfueBy4FeI9DJiYQJss1qkcC1d7QpOcEErwNjl+RrhdGXTxGrSVSi?=
 =?us-ascii?Q?AaPuYNwd+9hsC20KB2pk37JkiiLX4gqrseza4Wnt+BcySiGHMUN8q8LVy0MS?=
 =?us-ascii?Q?Bdh9An+Xu7qrYIqCioY4c/zGZDU+MhMUJod1/PpaXR9VllSCs6GzDzOxjGqM?=
 =?us-ascii?Q?Fxm2XLQl4OwUSAU6CNblUcJwx/AVSp5PJOv8zA/0ZtxyblokDnuLEVFHqV7p?=
 =?us-ascii?Q?ci3YGMkrC3tMVVN8hHS161b2D9Nhes91yl48BskyduwNupj64fEiTtgEU+YS?=
 =?us-ascii?Q?y31ZhrdDvyAnLuMXDOtdDvf7RgwH/WSs2JpAqAfbgMCFwOcEXw1ZVwKpKo03?=
 =?us-ascii?Q?YUvNqJRPjH10/SJQIgYy5Sym8I2TWpGZPQ387tYMF9ckesutHYyuy20OQGDm?=
 =?us-ascii?Q?TEdBI+czthQLDZ7296J8uvZpc5KD12BNEWPI90EkJyDQAT/3jtfLHPygL78n?=
 =?us-ascii?Q?eLnSS9r/CoO46OXdJmhKc6zguxiDgh+NRaM0uBPGzJOSGP2mPrqICL6ZLz8e?=
 =?us-ascii?Q?NxLVD9akae92fCzzuqeI1Gxt55KryCwfOIC1DU8QTYC4zW9CAu94Vg9IHGm/?=
 =?us-ascii?Q?q482ZgrCFjW0L0g436XVc9EtG+5UDmFAWVqjdSEwT08ClQ44yIxJiME2ixh+?=
 =?us-ascii?Q?TO8JTJYAQQk6qS+ECJOIP2VQ6/IKaGqcnp0PDxVoTaq5wP+z3BQTHo8Q2Y1x?=
 =?us-ascii?Q?B14loBQ5N8NcDdDLYSe5tKcOKu7ScL6Ay6F6jiL2jRPpIJo1neGpSqQDPEIt?=
 =?us-ascii?Q?LhbAyk3U2S1p2OkUXN7C/SbmAgfGqq36kvWRrRBHAOzyMJVkbhe1mg37PHHw?=
 =?us-ascii?Q?56yT2yiItBOrZxvCZRDuEAf6X6KEhDBGgwpw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YwhmkjjFvnE9omrz0pphc+RFGdfRujPKUj3bHoYCC/fhbXT4m6vz1mqfyMPI?=
 =?us-ascii?Q?5yrDZntblT34w2gcDLFPwFtOCftz4y263OLckBbuyVGm3q59TaiV4vbigTUQ?=
 =?us-ascii?Q?4X9xtkpI/qk81FL7Hsj56OnEwIJji6ug6QM/CJXXMP0tcZ76HHiuwJaenUF+?=
 =?us-ascii?Q?vIjysXJ+2GfambcOl6OJXjP5YLo1Pac2EEeBp6iFsopnWc51IRPCG4BENr51?=
 =?us-ascii?Q?/s9vMMTza2YE8vZAGyHoTzNFjtWj39K4wFA0BupaPKU6BKZ0fGEnUL9794BI?=
 =?us-ascii?Q?QpihWaCXzZAKxiM1OX9v1VFzcSliZM+2eII0lIOxfH3eFCvJyAdpSk8UY9EE?=
 =?us-ascii?Q?AYc48r3rcbgS74MOqB0V+y7zRzmRd/ixmDdfKGCS7clh5oNCAB19MZG3BemG?=
 =?us-ascii?Q?YrC3EtGS4Hzz/CHrM40hK7v7RAA/oCrhx8NeBIoPQLCmLZu9KBazGzlgzVH3?=
 =?us-ascii?Q?JMBDcmtc3TydryrgOPBLPTB22W/+BpJUhxX36rdBY8Cfwrsw5gINIznX+esm?=
 =?us-ascii?Q?mzQWYN0fqIxMhMwKxZSw4nCyj1WAe4oH5PZ2Tv7kHkVoLgMjWwUIzCQye+PW?=
 =?us-ascii?Q?RzK+NZpqH+Ab7itqC/R9cW4yFYSMQFhdECBaYXEUeg+6rKBVu3ia+fLHcDue?=
 =?us-ascii?Q?XMTflmPIpKLtsUVgf27nCkFukp3nCyFA7mW9Z0+B/MODxeCFSuKeoVo5ZaOK?=
 =?us-ascii?Q?2dxZyIrARtI/b1RjyGtya7sMhJKXF8/1588qG4SXl7kcFM/izOPFA1c7EwWz?=
 =?us-ascii?Q?g3z7PU24696L9MC+0024n5NZ041Ce3R5dhJCwMIj+V0sSbT3VRovwnVmgEf0?=
 =?us-ascii?Q?tC9CLZAFLJZ76KpsIfOM9x0ENOPy7XzfPcksI0WGth2BXlmhBykdeed2aaYW?=
 =?us-ascii?Q?uV53+EtRucjDLoXGJ7kCZS/cHx1xZ2Yu3z8Pa5nU6E/bfUVXsYA20x0hg4T9?=
 =?us-ascii?Q?dn8I6Unfhu8NgGPK3KuikRz85vNRh4yJI2OFJ+Xhr1s6t3NpUSCcUVZx+jMe?=
 =?us-ascii?Q?5XGA84T7kxelrjzoksxpUs4nfXC0qNUEJfDG+rzLRWzkjy0mk9qnI/vX0Tks?=
 =?us-ascii?Q?/sGpgyRQl4HyUj3btG8vc7rTjRVBW1OH2fEKAOtGemEXaPCfsU2O5XDd1FWx?=
 =?us-ascii?Q?d7PLHzH85Xw4jmfaNmSONHHGK59p+Q179oRkFMbPEKNZhs2V27C51BlhXKj4?=
 =?us-ascii?Q?khrCzUSXCI3pd8OhOKNE8IF/L1Ja1KBUJAK19c1HHAWaSnP26yZhuLQHujr/?=
 =?us-ascii?Q?f/Y1McXnltbTPIZ3cCcnnC7aRDq9lHqTcOOaCjmqCxCNG67A5t30UuipzZXx?=
 =?us-ascii?Q?dNGDejpXoqUXvDscPXsIqeHJf5GhrB4QOq/DHyRZktnCNAy9ZdIZKL77TEvt?=
 =?us-ascii?Q?B6v2RYxf6UoyIK9RmmFxQXg3VYzIcoK4lprftSxkGOkL72RWYsIl6jb8p9Ir?=
 =?us-ascii?Q?1GF3cwvfLZKnrMn5dH57qSfafx+0wz0f3OheEILAHwj8s5P0nXP/gKMVhRqz?=
 =?us-ascii?Q?dbRtliBUC2KTDhWawdJ7lXaASfPnBUFA7XpVAzXsjzNQiqeXVS+FdZPDcSYt?=
 =?us-ascii?Q?XwgXl17QwA8hOO1CmdcHdR9R2vDTi0+SJXchoEv160T+ykl8e/jP336ENHUP?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dabe8b-7d4b-4815-6588-08de2ffd68ae
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:44:16.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlQxRODKuFzWwTknKzE5/wO4RY2Pyr92cYLBXCzrMLVnW2d5wFJFUc0muPEQABO0yfjsJe4vXTuZVtjKAXwYW86NOHVg/R7iQm8Oo7buMsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

Add support for enabling enhanced mode and configuring custom FIFO
trigger levels on Moxa PCIe serial boards.

Enhanced mode is activated via EFR[4] and SFR[5], which is required to
access special function registers used for advanced features. Once
enhanced mode is enabled, custom TX/RX FIFO trigger levels and flow
control thresholds are configured through specific registers.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index f38684d11a90..39a178dc0519 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -36,6 +36,19 @@
 #define MOXA_PUART_BASE_BAUD	921600
 #define MOXA_PUART_OFFSET	0x200
 
+/* Special Function Register (SFR) */
+#define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_950	BIT(5)
+
+/* Enhanced Function Register (EFR) */
+#define MOXA_PUART_EFR			0x0A
+#define MOXA_PUART_EFR_ENHANCED		BIT(4)
+
+#define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
+#define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
+#define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
+#define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
+
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
 
@@ -124,6 +137,37 @@ static int mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	return 0;
 }
 
+static int mxpcie8250_startup(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	int i, ret;
+
+	ret = serial8250_do_startup(port);
+
+	for (i = 0; i < 5; ++i)
+		serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+
+	serial_out(up, MOXA_PUART_EFR, MOXA_PUART_EFR_ENHANCED);
+	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
+
+	serial_out(up, MOXA_PUART_TTL, 0);
+	serial_out(up, MOXA_PUART_RTL, 96);
+	serial_out(up, MOXA_PUART_FCL, 16);
+	serial_out(up, MOXA_PUART_FCH, 110);
+
+	return ret;
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
 static int mxpcie8250_init(struct pci_dev *pdev)
 {
 	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
@@ -210,6 +254,9 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
 	up.port.type = PORT_MUEX50;
 
+	up.port.startup = mxpcie8250_startup;
+	up.port.shutdown = mxpcie8250_shutdown;
+
 	for (i = 0; i < num_ports; i++) {
 		if (mxpcie8250_setup(pdev, priv, &up, i))
 			break;
-- 
2.45.2

