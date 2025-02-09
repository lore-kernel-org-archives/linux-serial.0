Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2125.outbound.protection.outlook.com [40.107.21.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660823ED51;
	Sun,  9 Feb 2025 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739134981; cv=fail; b=YwnKMw4NN+sJQsbsefzhkOlB/TNK3LC9kVYCk4LfSAH8Y5TCa1/NhmsP3NqItb6w6OA2epgd+HRElmhSVGsMnL8+b1DqLWGhrfyzoEDDbMNQPbD7d5iFEwpHLI4Ibsmb+FDOQQPZr9DGFw4WqKlwKevi05/Z1prpRRvjJuXua54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739134981; c=relaxed/simple;
	bh=f6Xo6gmcU61IWCAJpeIQ2VrACKwkDKsUEnrlQOEUsk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qmT6fl7O/vVK+knoh6P1VfHbcbrorfty9WIb6BbbmJH6xRDjJ2iNN8Kw+fLLc6xox5aW8gjjqEwqc2Z4CRsbJJ1M6vZpjui9kSqwJk65lubAtyEocsbrBlvM2i1KZ+z8yCbOi8uUxYDqeUYBpFe4Yur2uzKcNGPIdMp+DActbh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=jGZRSnAf; arc=fail smtp.client-ip=40.107.21.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="jGZRSnAf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2BnuQroRSyfUAF0vPvsNTgU5+AIVmEXG4bY8FvXT9T2YtivPouCEnKVh6tIwNlQ1bMu3m8q54NgtoSdofEJwqJySHhBTu1Cd328WfPOlgoj+rULplIBGYz2I4eWxybBGVkX/KGYPifTwo92ImhKBDm3ZMb9G2PgI+geJraagkeNLwqgZDNtq3HLwHARAYc1Z1NbviDcEeYMopLdQ6xSEQh1WHuO9DPDnwajGxj9tisZXZeTctCb4DSpj48VItwn6AFUFVwWAe//PlRUgdS2BprVf5rw93SwvUdF3adDlL4Fw1N7IsOkzjeHh9YVDEweLsvdmw/HOR7+qLpouI+NZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JM4s9zMT10NGAtxjkO5k68CmQifkDi4ExS7GXIXLb4=;
 b=euHst/vjxV3NAnv0/vXzv0QnCVFahi4XjACKMTMp+0ChiGlf0D+JaoZZs20NFuvmbcshYEsHSkkVqiVfwojNK/0lZrJb+7FyzuW2SDZKjRC7CR3ynUiHyd8SBv0oKAPg2Wf+eS98AyjqTV86w9RIYvw7UYhy04LjbF49BVCOHzvXh5+dv0Gydu/jR2F3vUJGG7E6k/l7Op5o48iNu9/aY+e6WgH/QY1+9QA1bSZ0yi6Ha9DD1lLY0LR6zSblAzvY/LOMvnv65LPIbfvffPErjY86rk3M6mLv9IxeOQPOGXSyYQi01kkQXEnpHs2KFqUhic3Ljc6+97sOV9b8WqrYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JM4s9zMT10NGAtxjkO5k68CmQifkDi4ExS7GXIXLb4=;
 b=jGZRSnAf4q+CWMJyFQLf/lKIhq0AjxqLSrEuQqRjxeaRWqSHLrMOWLzkkHUw0zfv9cw1ZHwLeGvVMNaZZlEzgw0hSyYPTwzQSo39UwB3QdpvTSvjpbV4hvzfYxbG6aP4CDng9iPt0a8/W83pH/k1fT95A7jv4o0tF73twsW6dA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by DBBPR08MB5962.eurprd08.prod.outlook.com (2603:10a6:10:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Sun, 9 Feb
 2025 21:02:54 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%4]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 21:02:54 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	gregkh@linuxfoundation.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
Date: Sun,  9 Feb 2025 22:02:41 +0100
Message-Id: <20250209210241.2622309-3-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
References: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BB9.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:13) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|DBBPR08MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 48592e8d-c6dc-4e56-8d60-08dd494d1f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2fbeJ9BPiYOcjSPRTJRtzQR5mQ748gNPjteVpM7fzx9MvbYInF59jAwvt1yj?=
 =?us-ascii?Q?G5WOU3H22bVcH+99nMJ7WWenWHyccjX5GnMeePvSgEeImBpj369ulCid/pqf?=
 =?us-ascii?Q?jccm2HWS6IZ9arX0kdflgxQU0fLPCf455+290edyGq8x3VufDj9nJ41Je1D0?=
 =?us-ascii?Q?0J/JmpJ9DH8FxjYc1aKlRPYJ4RQbtHTZAmHXOKOz4NLlDJ0G/oKG4DY+w3Nv?=
 =?us-ascii?Q?hMu9YFvfoVZEbHFYxH22xKbstKGIJAiJ1rbJar5Hms9ySRZ9FSq6KPlrz4YE?=
 =?us-ascii?Q?I+beg6+MJ/Csyc2TGLcvNO+4g2iV4UabGSGs9REOyclggyt6v+gkacMxWZqx?=
 =?us-ascii?Q?nto8sSND3SV8m/ZcMcCA8sACmZvb7buUCUiPl+TXjE8p4SXRyNt0tTobhVXK?=
 =?us-ascii?Q?/0bNHMzeJyU33vdEptIjH78J7pVG7vr/parfK5fE5ugzCKr8ebXE7poy+PD8?=
 =?us-ascii?Q?mZnjl9wtUymshT1KVW0oIFV7K7yPdoWMYtKYkPVlO+PtchePJ5NHc88eWS0a?=
 =?us-ascii?Q?q968fc8hPbIsTCNId3KUoAPrEJe7zgGpFURLdGi+nhfzgkagcRLYaOvc0uCy?=
 =?us-ascii?Q?ObZE9J4ZHbl8jakjkBUymy7LidcLwe43vPrEaltHIUnkU0Q/C0qHXavIcXG/?=
 =?us-ascii?Q?cvXJoybwbCh3QyYvfl9m9VDTpNRQZ9znyCD8e8D/D0dJ1WVa+RnQjodYPeKl?=
 =?us-ascii?Q?Jmj1VargrBmDyb0MPtHCnYUOyghpSjf3jUmnjqpFQ+uGrgB9r7bqw5j45TF2?=
 =?us-ascii?Q?WZTkdywaChWQ4g2L8kFPdTgfZtQ01ys3mdxDeiix7Y7vLJ6rQSLFb90t7vxb?=
 =?us-ascii?Q?P/NXuzfgNQHVE19Dc/tRqi6hsIwlJTnHAZAit2YZuEjpgAgp9tlAh/pezTmH?=
 =?us-ascii?Q?UpVpJRnXVAayGshTboPJ7dIjQ4iw/NVczhg3uK6PiPObbbB445zyyAsTWKuW?=
 =?us-ascii?Q?1hY4N7jlcfvyZ/hJw/l5xd74dJEZAGdnSnB+eI+AWK08voAq6K6kFdwtibLu?=
 =?us-ascii?Q?M4JTetzhswiscVVimNYdQpAul4eCiEolnxJuGPbcnNVPQlF+ctjLJ7noFTGb?=
 =?us-ascii?Q?YND1CgRe3OoWGAfWljNK4hmqKoHGh4w3/0XD59gnFsRn+DDSlEQo2s5hMGDL?=
 =?us-ascii?Q?bdvhPN3zcWhiGb9hThO8aSdZ+z4JxxvLnKZAVZZjEIOd26bzGM78lu3gJsX7?=
 =?us-ascii?Q?6QgzBryX9YdXf1zL2JzIpUwxU2MtUnVNHYhfBojyArfc70QIvXE8WIx+LEbi?=
 =?us-ascii?Q?YWMZZO3XeanC5tBqdnjZwkXQyksZXS2huS5UxyXG/7I7ZqyzGAqP6/pQ7Jhk?=
 =?us-ascii?Q?ALrxaUIBT4PwDbN00sT/dWAPfn+tDuoXj/6HhOjaKkG6ughcwa8/UhautdUY?=
 =?us-ascii?Q?YqXBrccJABBAmiuYdHYJdHMzDafQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAXXKpPRT7oYfEwbntP5rkGDnkMFMqb2/jP43S79jCJh0Ata8ABXvJB+D93w?=
 =?us-ascii?Q?zg2Jw9YGUqwPTocHA2eP7dCt58NWL3lX8E0sM2kQg5W+aRyDYUrQ1sD20bkw?=
 =?us-ascii?Q?yK/hq8dQS7ve8rbpO2w1v3Cm8Iq7oIWVM/UuI3uCWuBwk1FpVeMEVhCZlC+u?=
 =?us-ascii?Q?xVUrBGqmn7QT7lC02uWKbhkD33/DhxvLZ5nyxecnrJFRF5KqOf4rSI+JGGhu?=
 =?us-ascii?Q?RRxic52sj3BauqWSsmd1KNjuNif4ifR7LDHwKp8yhK2g+ngveCQaOn14GpTC?=
 =?us-ascii?Q?YD+e7At7TiPfQSGdtU9vx6ESfvgH1exMT1NoInDXZqvrKl1cUu5q05HVX2dN?=
 =?us-ascii?Q?bbZdJoNRM3rfr773ZDjRcC00HSO9lLLfT6Aoh49f7MbViUMXeKTcoe4Mxuj+?=
 =?us-ascii?Q?G7ji0vz0Pqnd2y6iZz14PKhOunTBUW77BpCdr227Qv78dJxtGirwIp8NZuxq?=
 =?us-ascii?Q?QJhe2C2tFWbFXMw6/QmfwXhg0G+WnfB4zA4QQQhOnVfAZyqTJwOTOj5eJI0d?=
 =?us-ascii?Q?Q5FgTzos0wUpUFIdjVp1iFlThytk9OAa8O/6Kc2kpPItDOlts3tVHHe+cFrY?=
 =?us-ascii?Q?xWts/DiG3nxWC+I0Yewvp9cnNuSZIRqL8ZxL/pTDaNV108uxIscnDoOQKCui?=
 =?us-ascii?Q?LBrL3/mW74TC88j4ZnsCl/FyYw+pPZtsaqOqM7xDqM6YM2j94cxQpLeVh+Lo?=
 =?us-ascii?Q?PEHoDweKWqpgnO8sENEfl62PbUVEZIt4mqmodjDAViWqDELdgecMtw/4Rw0P?=
 =?us-ascii?Q?Yxxp8rQHvYNmnOmV1ytLj99/hl29DHFI8Q0hDniAYsHqlBbDjAFcElff8Te9?=
 =?us-ascii?Q?pEcUkopZKiSeO+8u20IFu5s5GtFAYuuPIQVdhs66HXLqN+uLBZk60o+glUF5?=
 =?us-ascii?Q?51umxbPmZ2ZenWa+exk8D2z/E61+Zjf9kp6qOihcCDBRshCdqB1XNANbZCqR?=
 =?us-ascii?Q?DzvLpMngomQSrjozX6arB1225VqNQtGgA9jPXwWi8VPFoT8WNfMXr30/vmHy?=
 =?us-ascii?Q?IPktz+SKDBJNAow1HT2uVWgAE/PMGFNdKsgA/NNoa5ORPgRrbae9S/jd9aWG?=
 =?us-ascii?Q?IIAi50AOpPMvRgdu6hRi+zdoTTEe3YG7dEaqTOua8giD86FhS7mtgzvnDkjc?=
 =?us-ascii?Q?c/KiOry5oSfaJ+PpRFpKk46h9AjJREnZqItG7xuwZwLHf+zcub/jA/ergYmq?=
 =?us-ascii?Q?dCYogofG9N5JGDUl7r5yFIaoGxEwDW1V+jpCy+y5EC+GuPpSiD7rhdfbsYeT?=
 =?us-ascii?Q?iQgiE8nbXEr6mkbbY3LVlkcfonk1PPHWs0NiJ5DFfK+H1XklolLQX5cZsiFJ?=
 =?us-ascii?Q?g6LJi9/a3+3rDLrvKk7sPgKIIHhU+a9bO+RhXqMRtPTzawl3sUSQpZTmoX+N?=
 =?us-ascii?Q?7rYbvcLxZRHoxsFk4BiH/CJFA/QJZ5uGArumA+4JpAm5YjZom9xGvXhVeoDp?=
 =?us-ascii?Q?yASHiv6ufg6otmoERXpTjkLlX7D7BJSKBYHMj5QM9ovlcEkrqVuRKnNNdoTP?=
 =?us-ascii?Q?v+f/XzoVUV3n1AevIKDk3ogusD45iEaii+u1hyVw0J52rty5IW8Vprb7PSIO?=
 =?us-ascii?Q?Uo5fsCD7jxJ1QHfCOEA7DPDswDQkwf5cELV0bYHl0WAkI6CU8Xbr1PEtiBgR?=
 =?us-ascii?Q?RDiFyPqkHnni2r/vz+U5ciqr167JNUMGopu7zzdDkYAsiEbTL66swS5XB9km?=
 =?us-ascii?Q?GTM3Ag=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 48592e8d-c6dc-4e56-8d60-08dd494d1f46
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 21:02:54.5035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sW2tgDvFFoYpGsWZQLhIi82P3CpoTjg/YFWc9TBg0sKNGz5aBwRdGd6vRzgvQtkNyH7l8CNTOf27j2PgMNA/rdUeowdyDUZCMw70zbDkHRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5962

Support for Airoha AN7581 SoC UART and HSUART baud rate
calculation routine.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
---
 drivers/tty/serial/8250/8250.h        | 15 +++++
 drivers/tty/serial/8250/8250_airoha.c | 81 +++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_of.c     |  2 +
 drivers/tty/serial/8250/8250_port.c   | 26 +++++++++
 drivers/tty/serial/8250/Kconfig       | 10 ++++
 drivers/tty/serial/8250/Makefile      |  1 +
 6 files changed, 135 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index e5310c65cf52..dd762289fa25 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -314,6 +314,21 @@ static inline int serial8250_in_MCR(struct uart_8250_port *up)
 	return mctrl;
 }
 
+/* uart_config[] table port type defines */
+/* Airoha UART */
+#define PORT_AIROHA	124
+
+/* Airoha HSUART */
+#define PORT_AIROHA_HS	125
+
+#ifdef CONFIG_SERIAL_8250_AIROHA
+void airoha8250_set_baud_rate(struct uart_port *port,
+			     unsigned int baud, unsigned int hs);
+#else
+static inline void airoha8250_set_baud_rate(struct uart_port *port,
+			     unsigned int baud, unsigned int hs) { }
+#endif
+
 #ifdef CONFIG_SERIAL_8250_PNP
 int serial8250_pnp_init(void);
 void serial8250_pnp_exit(void);
diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
new file mode 100644
index 000000000000..51e675605741
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_airoha.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Airoha UART baud rate calculation function
+ *
+ * Copyright (c) 2025 Genexis Sweden AB
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ */
+
+#include "8250.h"
+
+/* The Airoha UART is 16550-compatible except for the baud rate calculation. */
+
+/* Airoha UART registers */
+#define UART_AIROHA_BRDL	0
+#define UART_AIROHA_BRDH	1
+#define UART_AIROHA_XINCLKDR	10
+#define UART_AIROHA_XYD		11
+
+#define XYD_Y 65000
+#define XINDIV_CLOCK 20000000
+#define UART_BRDL_20M 0x01
+#define UART_BRDH_20M 0x00
+
+static const int clock_div_tab[] = { 10, 4, 2};
+static const int clock_div_reg[] = {  4, 2, 1};
+
+/**
+ * airoha8250_set_baud_rate() - baud rate calculation routine
+ * @port: uart port
+ * @baud: requested uart baud rate
+ * @hs: uart type selector, 0 for regular uart and 1 for high-speed uart
+ *
+ * crystal_clock = 20 MHz (fixed frequency)
+ * xindiv_clock = crystal_clock / clock_div
+ * (x/y) = XYD, 32 bit register with 16 bits of x and then 16 bits of y
+ * clock_div = XINCLK_DIVCNT (default set to 10 (0x4)),
+ *           - 3 bit register [ 1, 2, 4, 8, 10, 12, 16, 20 ]
+ *
+ * baud_rate = ((xindiv_clock) * (x/y)) / ([BRDH,BRDL] * 16)
+ *
+ * Selecting divider needs to fulfill
+ * 1.8432 MHz <= xindiv_clk <= APB clock / 2
+ * The clocks are unknown but a divider of value 1 did not result in a valid
+ * waveform.
+ *
+ * XYD_y seems to need to be larger then XYD_x for proper waveform generation.
+ * Setting [BRDH,BRDL] to [0,1] and XYD_y to 65000 gives even values
+ * for usual baud rates.
+ */
+
+void airoha8250_set_baud_rate(struct uart_port *port,
+			     unsigned int baud, unsigned int hs)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int xyd_x, nom, denom;
+	int i;
+
+	/* set DLAB to access the baud rate divider registers (BRDH, BRDL) */
+	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
+	/* set baud rate calculation defaults */
+	/* set BRDIV ([BRDH,BRDL]) to 1 */
+	serial_port_out(port, UART_AIROHA_BRDL, UART_BRDL_20M);
+	serial_port_out(port, UART_AIROHA_BRDH, UART_BRDH_20M);
+	/* calculate XYD_x and XINCLKDR register by searching
+	 * through a table of crystal_clock divisors
+	 *
+	 * for the HSUART xyd_x needs to be scaled by a factor of 2
+	 */
+	for (i = 0 ; i < ARRAY_SIZE(clock_div_tab) ; i++) {
+		denom = (XINDIV_CLOCK/40) / clock_div_tab[i];
+		nom = baud * (XYD_Y/40);
+		xyd_x = ((nom/denom) << 4) >> hs;
+		if (xyd_x < XYD_Y)
+			break;
+	}
+	serial_port_out(port, UART_AIROHA_XINCLKDR, clock_div_reg[i]);
+	serial_port_out(port, UART_AIROHA_XYD, (xyd_x<<16) | XYD_Y);
+	/* unset DLAB */
+	serial_port_out(port, UART_LCR, up->lcr);
+}
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 64aed7efc569..5315bc1bc06d 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -341,6 +341,8 @@ static const struct of_device_id of_platform_serial_table[] = {
 	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
 	{ .compatible = "nuvoton,wpcm450-uart", .data = (void *)PORT_NPCM, },
 	{ .compatible = "nuvoton,npcm750-uart", .data = (void *)PORT_NPCM, },
+	{ .compatible = "airoha,airoha-uart", .data = (void *)PORT_AIROHA, },
+	{ .compatible = "airoha,airoha-hsuart", .data = (void *)PORT_AIROHA_HS, },
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, of_platform_serial_table);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1ea52fce9bf1..040659de35a2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -319,6 +319,24 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 8, 16, 30},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	/* From here on after additional uart config port defines are placed in 8250.h
+	 */
+	[PORT_AIROHA] = {
+		.name		= "Airoha UART",
+		.fifo_size	= 8,
+		.tx_loadsz	= 1,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
+		.rxtrig_bytes	= {1, 4},
+		.flags		= UART_CAP_FIFO,
+	},
+	[PORT_AIROHA_HS] = {
+		.name		= "Airoha HSUART",
+		.fifo_size	= 128,
+		.tx_loadsz	= 128,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
+		.rxtrig_bytes	= {1, 4},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
@@ -2847,6 +2865,14 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial8250_set_divisor(port, baud, quot, frac);
 
+	/*
+	 * Airoha SoCs have custom registers for baud rate settings
+	 */
+	if (port->type == PORT_AIROHA)
+		airoha8250_set_baud_rate(port, baud, 0);
+	if (port->type == PORT_AIROHA_HS)
+		airoha8250_set_baud_rate(port, baud, 1);
+
 	/*
 	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
 	 * is written without DLAB set, this mode will be disabled.
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 55d26d16df9b..9cf16d392aca 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -356,6 +356,16 @@ config SERIAL_8250_ACORN
 	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
 	  cards.  If unsure, say N.
 
+config SERIAL_8250_AIROHA
+	bool "Airoha UART support"
+	depends on ARCH_AIROHA && OF && SERIAL_8250
+	help
+	  Selecting this option enables an Airoha SoC specific baud rate
+	  calculation routine on an otherwise 16550 compatible UART hardware.
+
+	  If you have an Airoha based board and want to use the serial port,
+	  say Y to this option. If unsure, say N.
+
 config SERIAL_8250_BCM2835AUX
 	tristate "BCM2835 auxiliar mini UART support"
 	depends on ARCH_BCM2835 || COMPILE_TEST
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 1516de629b61..b7f07d5c4cca 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
 
 obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_ACORN)		+= 8250_acorn.o
+obj-$(CONFIG_SERIAL_8250_AIROHA)	+= 8250_airoha.o
 obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)	+= 8250_aspeed_vuart.o
 obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
 obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
-- 
2.34.1

