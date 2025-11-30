Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023100.outbound.protection.outlook.com [40.107.44.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C427AC48;
	Sun, 30 Nov 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499414; cv=fail; b=KLiM+bP+1XEtx9QQU9r23g7ihYY4SCApmK/73ItyXaBIrvnxxZoJ3QpJtkuo9xjoithyJLRj4lPQmLsUFfxVU41ZIMQCwot8wUV9cympcSIKegj0HTGu05t7PtCen4T4iJF9J4bPt2Af4C+A+6PxZINhb9MYh+XB1MrF0q1HWuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499414; c=relaxed/simple;
	bh=UhkRGzadmaKGC+n5Bf568U3fOyjhTokm83SfIsCkC+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZ4zSTtFONQZr1F5W/dDYgYw7Fqn63xNMoDbUcai0q1Rtz2gBSm1idMLibLeh94KlnBXF6wevxrZjoIkQj0I8lNXCau+TujPrGz3HzHBWuGIDK2U2DOmB2IZsVn59txpYri1kkdTCZTJGN0iauUnFJTkNtYxs4Y+hP/Ql8d5SxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=evzp9pz6; arc=fail smtp.client-ip=40.107.44.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="evzp9pz6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zS8apaVXsy1KxR8VwgJfCab/0eA7P0Fp9T+ZSqXF4FvgoLD/bDcrysSZnN0sU/lRUVpHYWfz0jgnIjIAUIqaXwKl1jc0cpeSqW4nz3kKHNnTBXtSC7OXBppLH1n2yDll2HLlJdkgc26kzcfD/wSgtoyzCuB9WbgIeRI8KB6qtKsAvsIzXasQOk4gsTmpKML5VIqT5uRy0YpshKTnD8duW4iFIQF6OnONuO/93mDmJ27jTiy9jXdGqlq1nZ/Fkl1s6+aAMSR759t2R/jc/YqMJhcXe3x/F7bhkd9g/SjugXplumO1o8L/4UMTy02PMTPujrpfvLnmS9PEZFylcrnFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmY3pIp/xuValsoxf5x1qvgR9eIs5i8u1AanYHEZwQ0=;
 b=JdYPMwAphQxsWwKUjwVJE5IpGKbzbjVszBm5aXr/cF5//M6JgHj6DJ74Ia4PUU43+ncP3JOZ+ixJbV/NVxD1asXplByZ0u+FiU9nztSF58QgFXtXKrZsW1MoeqqY/HNA7BW7E5xj9Zg9SHQV/uvop2tBVT0MPAeQ4ljIk2jSuGCyNppEgQaZrY6WbfOb0PyCtZ6r9uH+3TdDcg9BD2KJo54lUv44xqa3rNcEXFbkCtqOMtJ+/DOf3H/PZSF+wJFCm0qkDuamiLc3zAqWvO+dCXATIP7hOyvbE+zZYKGgpJSQBu11KJTXxX5yg8VfIbyDesA+cUBlpx+ZwoOkB8GGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmY3pIp/xuValsoxf5x1qvgR9eIs5i8u1AanYHEZwQ0=;
 b=evzp9pz6h3RkDDwt///9d2//N5fyxaYPQ5meeh/Y68MwH1VR9PhUQu2qYJtuFpzj3Hs8OKkudsvbfcIh9QEs6eSRNqCDm3HJQ6AH19dVOXQNR6fnG6S4VUcFLtTBNkbIneogOlqbMvzJNgi24H1JUahoC44UeuKJ8rn/o1iSN1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:43:29 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:43:29 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 03/31] serial: 8250_mxupci: enable enhanced mode and custom FIFO trigger levels
Date: Sun, 30 Nov 2025 18:41:54 +0800
Message-ID: <20251130104222.63077-4-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1cc1d547-22aa-4814-8290-08de2ffd4c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fHGS5A9DagylaCkNPmHce79QmV2pREa+e7orFIMoUcgUh5ul8HuqPdKkmFac?=
 =?us-ascii?Q?Vj+rZ8LYhte7w9Y5qTrcJgu0jXVhalq8bLzlKBVOrriMzkcUOudlcYTlguTU?=
 =?us-ascii?Q?zXSMkIliHByO2mfFNAeaY6/e6mHFf2bW590ZM9vN7TUdl1BOk2oK4sYGYkRw?=
 =?us-ascii?Q?mQFwlHDDg+gpP0zSOsfafSqqktJXCdONsY/j8pmsS/Mhsx5oBYPA2S0sUiI2?=
 =?us-ascii?Q?zez6NwDJfMkuReH4+PIyRa+cdFQRxRtNGMng+kunGQOUCip49sEpMWBaan6R?=
 =?us-ascii?Q?nW2bnjZYxeEfcQFvFll4vfp7zY4LgbIdjYl4oSTeJNVSWXnuYxumVLb5kcbC?=
 =?us-ascii?Q?cfhnuXegeDceKhiMknqEXP8+4gUlSOC6Ar4GMkmBNnp/Q3u7kasnQ9t/DkLC?=
 =?us-ascii?Q?jahxAe5daOTdqsB6bQigujcvQB5tyYkzGrgBdchJ+nAwCYp7yQhlIcrdaiT0?=
 =?us-ascii?Q?y6QFD1SIljNubTXpXpyLVE4iOqHvgPbJIAU5osWHT8EZNFV2n8vNNvOO1vS7?=
 =?us-ascii?Q?HdAK2NeD7BztZbgeBotgI8Ym++vfcmB0FHOBQkTar3+kviRE9sbuxOiw1Wnp?=
 =?us-ascii?Q?edD6maGp6E7SbG4UAnO9N0Rqf1Jusi6zQauOAZPNa3+TayDHcGH7U9zSpYc7?=
 =?us-ascii?Q?7gclLHIF1X1hcp9oSfaj+vZkzsSDaY4hGY5VlrYOoFQ5FRAGQ0TEsM9ShkDq?=
 =?us-ascii?Q?yvK/jnbgHyksJXQkruKqK4h75yfP//tR9uSTiUrETSxY7SZUBGRX0A9SS1Bp?=
 =?us-ascii?Q?rLBP4W+vnlHiyK0kK6lgncxdNy47f2rtzfwkZkfGPv7HVKqRv6cOEXjvgmmt?=
 =?us-ascii?Q?MHXslB2csK+IKcZZZiY21WULRprHe6JR6BJvwgkRpfqJxqskCAWWMCqckhq3?=
 =?us-ascii?Q?RQKI4KiQ/ummJ+N+tGHSkcZqpSFEA8MTUnc7VGQyb51xlQZks2CzvAnLA+o3?=
 =?us-ascii?Q?4fBU9dy4WVGZXUsejSiX3fQSPBAXHUKycVElkKbUH2FtbHt/161JhsLplXrg?=
 =?us-ascii?Q?jWSEDeA8sPPxr9opFqWplDdiisVc5Q2jfZtHLen5x7pDznN4hFZj2eZ0pgu8?=
 =?us-ascii?Q?I/8QrCaRrLV6kqfUNuRwhzIYUboU1lOXnaMF0APMFkM28Yxegow259l7LSoI?=
 =?us-ascii?Q?dAd/QO9BkgIBOK6AfPFGppwLaMDesTMIzsZ0rDt6LRV1csPqhYbBxlzBnCnt?=
 =?us-ascii?Q?BCCfAcdExL3VZif9cFIXlqLmJ6lpKD3a1tQXr8od/i6Hi60znAjhqheW+KEh?=
 =?us-ascii?Q?nZk9Rr6cGXGfFRBH74OZ/ka5zivtK72TS2WzE8tXin/Hogz6jNRU96Y+yLiU?=
 =?us-ascii?Q?2wSFdChIK9ZxkBdhbNPMXY/DKaVBXrDDYN91ofQjj92auiQR68RBaCZLnSNg?=
 =?us-ascii?Q?18+qJeziiyOsUUq218y+FrZkz8YHOk/JLff1+8XN7mt1KMZsYM5xs/mCGt10?=
 =?us-ascii?Q?RzBdGMdNwvVorLOtNIqa0i9/W5vX6OKQwY8SvWl9V+fxuRlG0K5piK1oFz3X?=
 =?us-ascii?Q?/FcqYqwIq2l7AD4+Umt37W1ZvysiiT2uQAc5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2dlxgktDqjfcz49QzB2cDE6DgiyoG9GTNmgUo8JtuYc53mLLs1S5+aP/uHs?=
 =?us-ascii?Q?sVj3nqwHqfFIYAIQAJCsQ+9+oefQKJO7JkB/ShwvBNhsRTohjfk/Hed9LcBp?=
 =?us-ascii?Q?NfFONUXxQmFWDfNo+9rake6J3xOv2MuDFSTVEJu4aCRn+80KfJCWC4H88vXi?=
 =?us-ascii?Q?j5VHQAJ6OkbGKMQ7ZuH6MTik5JuCWCdKBDO+a1K/AdqWi3OErFGRAaoOWulP?=
 =?us-ascii?Q?YyD61MQLXvSKl+5IDlZctHgHKzi0yYGtNdULVo08zr0Mv0jgOTQZhIfAnLbK?=
 =?us-ascii?Q?Ynv81IN6VN+JQkNzoU15n4jn/G871v9E9kcqxvq2Jmw3r6cGYnuM9lHScUP0?=
 =?us-ascii?Q?8gxvakyHow6QYz9IFR2WRZJGRQ/VlfwM5aDUShjoHZZy7YTvZLXuoQYJjtvc?=
 =?us-ascii?Q?jcOD6tXcqTd7IXqwiOLhSsUYHe82ZArvRfqjvfwQVmcR2zw0K32Hx0xy2apP?=
 =?us-ascii?Q?tbSmW0pKvDfzDZ7pAM/bv3LF/m7xevQXDWE+FLnDb53vBM+wTCpWNtESdj7G?=
 =?us-ascii?Q?ej0ZSTrFtg3QuRpslX+S6fF47QNoh80b1WDxOmemC9rG2nGtekJ6PfwTw35M?=
 =?us-ascii?Q?4X9jkNPgH0D7Y/opp+xHzz2sH7d6bx3+iBlfzH35TWrFLQHuu1FEA8kFWH6w?=
 =?us-ascii?Q?AvPq4CIxPUVDdjs8GYuvEETlsCL6jVLf2YJPKEA1+dtiyQ4172pAWgjBShiZ?=
 =?us-ascii?Q?0v6DBiPLx1iRWUkcQcSukDshiD16LF3WhYbmsegqDKGXk02XRRLdU+V/j4k7?=
 =?us-ascii?Q?U9FrTc10eId7bQUF+0bHF9Xh7iwLpMu8/aDio4qQpwSEynsHLEj7RqFu9zNq?=
 =?us-ascii?Q?oNjkopPqGTmNzVIrh1NiT5W5OEVihffTdlnMmh7Z0VLFVDIAuYfQ+h5Xadf2?=
 =?us-ascii?Q?eN8DeOAeQ+eUwH1WJImBUfT6z95YcJO63n3GGc9QYuJc9Al6B3SzDh+mb74J?=
 =?us-ascii?Q?8NDkqszgqdAcvRfq3E2rq3K7Pl+GcTpzYMwiRRza7Kx/tVam8RorIj2YkZf6?=
 =?us-ascii?Q?LUaGpwuO6AZgq39uwVsr8zXP7LgVHhL2OYg8wjcv2imZhFEFnbQVphuxtSiE?=
 =?us-ascii?Q?6ZGnhCzjti4YoywBjjbxrto4FfuIgcyK2AH2GGXiHR8aAlUZsuamhaMROorp?=
 =?us-ascii?Q?xpQPJvHkZOmhoO+qdYUe5+E7zB5ly7mvjJR3Si/4OTRNAnJsrgJOlxVldsRS?=
 =?us-ascii?Q?eIjEb7Illl1vwyZVDEIiLwcHOzfGZjOCduC8YL5Wj9F+6NpWXHqhFaO0Y2ii?=
 =?us-ascii?Q?5Abl6eaVK32vMS33j6qqkchFDsWIi/NM05KHmRQ+hhCBFVMqNIX2/1t5e5e+?=
 =?us-ascii?Q?/v5xxx93uiJMMdhVXB0tBMA8avuFEMrKWG5PB6lZ7AQKXT64IXbYmLuu0ooR?=
 =?us-ascii?Q?ZtsxVwxSg75ORWHsqv6ajIR9HbsFuX18X2qlKwjlPpu8prpw+n1cyW1bW80E?=
 =?us-ascii?Q?7mqQUHq7nWdwe2/bvQRgBg57OZIcGIGQPAkVzrJWq0W0+hO2HcmHslNlbZAU?=
 =?us-ascii?Q?x9HzGSOMu95+tL8NhKPl1Gm7qf/Cai6+s/biDCSxxB8na37GLhTOneEMw32v?=
 =?us-ascii?Q?1SzA2iWMGex7lftbXAU15LB69OvFoVTkoKxcl3OH3yR6hBT7xzYZW5I4J4Nx?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc1d547-22aa-4814-8290-08de2ffd4c9c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:43:29.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Le8CPprx6azqQnpPQf5ffyj9CXNDNOZS2w/x5cZt3iF0+1CS/+A5ppIF5IdBKAWK4yEeMigiRO7bY5f/lNnnKrceF+1uA3MjnDtyxsL7IOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

Add support for enabling enhanced mode and configuring custom FIFO trigger
levels on Moxa UPCI serial boards.

Enhanced mode is activated via EFR, which also provides access to three
configuration pages selected through EFR[7:6].
These pages allow fine-tuning of advanced UART feature such as Rx/Tx
interrupt trigger levels and flow control thresholds.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxupci.c | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxupci.c b/drivers/tty/serial/8250/8250_mxupci.c
index d7a4b838ec1f..c4fa52de8962 100644
--- a/drivers/tty/serial/8250/8250_mxupci.c
+++ b/drivers/tty/serial/8250/8250_mxupci.c
@@ -43,6 +43,25 @@
 #define MOXA_UART_BASE_BAUD	921600
 #define MOXA_UART_OFFSET	8
 
+/* Enhanced Function Register (EFR) */
+/*
+ * EFR[7:6] - Enhanced Register Page Select:
+ *	00b (0x00) = Software flow control characters
+ *	01b (0x40) = FIFO trigger level
+ *	10b (0x80) = Clock, ID, reset
+ *	11b (0xC0) = Alias of Page 2 (same behavior as 10b)
+ */
+#define	MOXA_UART_EFR_PAGE_0		0x00	/* Software flow control characters */
+#define	MOXA_UART_EFR_PAGE_1		0x40	/* FIFO trigger level */
+#define	MOXA_UART_EFR_PAGE_2		0x80	/* Clock, ID, reset */
+#define MOXA_UART_EFR_PAGE_MASK		GENMASK(7, 6)
+
+/* Enhanced Registers Page 1 */
+#define MOXA_UART_RBRTL	0x04	/* Flow Control Low Trigger Level */
+#define MOXA_UART_RBRTH	0x05	/* Flow Control High Trigger Level */
+#define MOXA_UART_RBRTI	0x06	/* Rx Interrupt Trigger Level */
+#define MOXA_UART_THRTL	0x07	/* Tx Interrupt Trigger Level */
+
 struct mxupci8250 {
 	struct pci_dev *pdev;
 	unsigned int num_ports;
@@ -59,6 +78,49 @@ static unsigned short mxupci8250_get_nports(unsigned short device)
 	return FIELD_GET(0x00F0, device);
 }
 
+static int mxupci8250_startup(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	int ret;
+	u8 efr;
+
+	ret = serial8250_do_startup(port);
+
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	efr = serial_in(up, UART_EFR);
+	efr |= UART_EFR_ECB;
+	serial_out(up, UART_EFR, efr);
+
+	efr &= ~MOXA_UART_EFR_PAGE_MASK;
+	efr |= MOXA_UART_EFR_PAGE_1;
+	serial_out(up, UART_EFR, efr);
+
+	serial_out(up, MOXA_UART_THRTL, 0);
+	serial_out(up, MOXA_UART_RBRTI, 96);
+	serial_out(up, MOXA_UART_RBRTL, 32);
+	serial_out(up, MOXA_UART_RBRTH, 96);
+
+	serial_out(up, UART_LCR, up->lcr);
+
+	return ret;
+}
+
+static void mxupci8250_shutdown(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	u8 efr;
+
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	efr = serial_in(up, UART_EFR);
+	serial_out(up, UART_EFR, efr & ~UART_EFR_ECB);
+
+	serial_out(up, UART_LCR, up->lcr);
+
+	serial8250_do_shutdown(port);
+}
+
 static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uart_8250_port up;
@@ -90,6 +152,9 @@ static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
 	up.port.type = PORT_MU860;
 
+	up.port.startup = mxupci8250_startup;
+	up.port.shutdown = mxupci8250_shutdown;
+
 	for (i = 0; i < num_ports; i++) {
 		if (serial8250_pci_setup_port(pdev, &up, FL_GET_BASE(FL_BASE2), i * MOXA_UART_OFFSET, 0))
 			break;
-- 
2.45.2

