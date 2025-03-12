Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C11BC09A;
	Wed, 12 Mar 2025 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741747171; cv=fail; b=qSzjgnYRTBV3nWIG4x4dKiHM0pEcouGOjpSjgt3qCvHzUL8xNXgqrs03yi8sE0Ar0uviIlsQ61X+xWEdKyR4NV0o6gTjgbY975kdOicAV2xv/IaDNmVxBSH/bd1i5IpCpkYYnYaVtBdL65fze9WUewdmKzx8Sn0LvfVe6qappVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741747171; c=relaxed/simple;
	bh=RX5luVQX7PioQBP9NgmHL0s0qwmxYwdeQAwJtSpYPak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cb53scs7NvhAIUDqm295V2ecGpmfXNfFhf2p+enLUwmEKPXE0HHC/f7GwCTgEojCSe84hAY1X5nsH4K3GiaHgIcFnwjZafR8ylgqNeurxQa/jaBHLsy0CL/89HE6MXe7f2iEX91eCkIvSoZQhGxWNQ3RgzP+g+tk2OncgqTKyLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WFbvsZDb; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WFbvsZDb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZTU0fbWWKCKANx0YPU34yRvoUiaB5xZD3PJRoNYBS/C4LImu4tqBhsvsQYtArVfFm+zW4MwRnjY8ONwtk98wSU77GlqeKY4B7DSGdu8Be+gtCRgvMa/WiQn0pQZ470ivuhumAs83+GkFKSNG64y3GmnogX1DpF+1f7K0J2SUxAJXTLRXFJMuQkYLD8Xb7rWKmLwDoHgVEu5MZJV7N/IqFClV1AhcKFH6hMH/XByytswXbCOX0Tvf+y6HtguIV46S8rQ4hEdPB4heoeclHO55kozks39PgsSUpst6zlB3scFh5MSt+W55fNP15kkpLprweQS0jtDlncmDhTRSp0UMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP93JZ2ZYF6QC1CS8utO383oqlJXbtpQ4vB8lrJ1Hig=;
 b=ldmSC3mSWwNikLTKCOuesqYc5h/ihdQE7nvg/NCZavModHW5+gd2bEMeHxvK0moHVKnvJch4Qo7NHa31jj+DsTPwVRoJJbwpYEX2C+RnGpbCoNSx8mehLZUOz8+NRbxPfRiySe5Ldrj/8HKxYIYjJutKwYh933HSqyRrHe5id4/y2sx2lIVcebZyXu4aS1sdcEZ+N1QKEigtWJd9eFQcV3FJvwVFalgeCfHG62YnNHdlionpPgpXWJ+Yu84B/mTLAew7J4twjglZg1t46fjTMrMBJYp3EFHqVXHEvi69f05an4p1lElAO/PF42U8wPCVg0VgfXEZyslYO1RteDzmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP93JZ2ZYF6QC1CS8utO383oqlJXbtpQ4vB8lrJ1Hig=;
 b=WFbvsZDbWuUAlxpWr1b/8fjbSxjAfjwf+ZxI7Z0g527dcY5rDnpDB+TlMQrdTY5nYA3jjvfDNXpBJVO0ujxNeqxYOruKMhD/g37k3ZR7tpwukWdfcyDewkHfcYQYsVEN37eWD4VqoyTRIK4XnCRPvXyEADbejlrtrBY3m4bTeOHHXFYhGINYOGCPvB0Sbpp9kji0jbnTYkrY3WfdQVchtdqz/3v7vf2HyW4g4joZjl9LToHzrQECYaOmhDUv8eEHk5kDAnz7UuYdfDQL2PwQCBxiawiKjr0UeceAuDE5s42I92QxiLcP6mjHZo8N2mSazTKOB9hVXvrdVKwU36DlpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DUZPR04MB9794.eurprd04.prod.outlook.com (2603:10a6:10:4e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:39:26 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:39:26 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V3 3/3] tty: serial: fsl_lpuart: rename register variables more specifically
Date: Wed, 12 Mar 2025 10:39:04 +0800
Message-Id: <20250312023904.1343351-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312023904.1343351-1-sherry.sun@nxp.com>
References: <20250312023904.1343351-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|DUZPR04MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfa2e3c-50f9-44f8-0fd0-08dd610f1aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BLKWW5cJ42AmDz8FRY5z9uukH0jqeidMN7+HlxncQw5BSfqqwYtRLYsWTETM?=
 =?us-ascii?Q?BwgY1X0qWOe5MmOg8/x9praaYL76oFxEbtGg5k8xhrNEVa0DVzVT6ApKlurh?=
 =?us-ascii?Q?zpjrV//Xxl1omY6UDuHQJquSHPuoey0TSJiaKeKo69yxkGb9HRTdZ+1nKUJ8?=
 =?us-ascii?Q?zu8DV41UwGVY2J6a9BjRAE7VwydDFnlegi6wX7u/5xosZ01WpPP24knG25iE?=
 =?us-ascii?Q?ky5ASVONWPAKWkVolMvcZO83xfcpLwbo+JwLt2PCBjzBGQGMWzRRI1FzeYNg?=
 =?us-ascii?Q?/9Ij7pYeH6yYINUml5FbyUXnyV3aDpa5E3fcms+CTXIqmo+cBLIT7P2WySVh?=
 =?us-ascii?Q?liug07jREaqroNIea4pUnQEOl0b+IDWtwKzlfmVe+ChAAQdELsvIzZ1WYvO/?=
 =?us-ascii?Q?XGv62eIeUrPA4+OAXXOoe6zh2Dh4BUk4VLYGrtYgUx93LqE/ZtQsG+UuxLsD?=
 =?us-ascii?Q?iPxuPgiDjNV8TYq5c1/5HQVKfjjf9drbfpMm5tJNmoyokFM9/VFUa93vKEKh?=
 =?us-ascii?Q?3xZPbE5WqKibDMurzeoPWMnDtNBYlx6z4PBMn7y8lomO1YET8OEKw6v0EXzY?=
 =?us-ascii?Q?7j4emLPgJQt9o6hHYdPlOm5/pnHT0j5v6Xwm3hPiWDEyhiNkJcgiXuHeKnvB?=
 =?us-ascii?Q?cCiMiDduJi2mCbUKWeRAp3Jxc9ziO2Ut98H1JtgFB4+/+Pk5aNpcw6pNo3RF?=
 =?us-ascii?Q?t3IpLPRYo8ZHyEWbGxvd/YQd8h3/PKD6EJR7MUpHWkKySfCSD9v1N/n5fPk7?=
 =?us-ascii?Q?OQHar+gl6i62dxV5N2stxGe82Jhmoy7WJSlezsFrwHLkx0Kf6jZ6tNhXTmm8?=
 =?us-ascii?Q?je5XdWicikDoyefrr+51sIiwP9Jq3Na+OtL2kdo6j79OWriUnQka/FSwRPLy?=
 =?us-ascii?Q?cQLo/Xr7olGvXToHQA/UvMUzhsch3hyE7d8LC8/CG8BdI7jgx0QHdJ+RlMVa?=
 =?us-ascii?Q?YJm1Y4bCzobD7IDs9TDochMsmLIYINfgm2jSfpseYctkLXlW9cMYjGRY24Sa?=
 =?us-ascii?Q?q5q0mge4e5e/iFk/iuJGKvz6aFF/UkESeSagLfn37fxYqsiUW7QCLeFDaV46?=
 =?us-ascii?Q?SlcCY05y35FVbNLoSVY6v+wxEJQjxAeQQvahXIuzwhMpX/Osa9KAxHhvGfX9?=
 =?us-ascii?Q?EqFuqf0AVwLDViJTKy2tpAeZIUsajB8Wq95DFgRNKre6DtRzgolxTriQeBgx?=
 =?us-ascii?Q?8TKqC64HFrlHgY1Lk5XxJqm91sdTySEB1J+FiBDsduYp04rJFwqEiBNeGK/J?=
 =?us-ascii?Q?kfSlWATcbE6FtBk5WvTqm7xmD9gug4StcWzqBxJiCNeSs912PxWcfOqqEgYb?=
 =?us-ascii?Q?MUNY9sRZZ1twlJrj4aWDKgOVaW66yZSISm7vhbj08ty49pRFuXIac5f1GB7H?=
 =?us-ascii?Q?j6pQ+Yg6/cxw4yy6UblkvDVA39C5F7fQglE+wA0F3j6OR37PLd5OBUGRa+fp?=
 =?us-ascii?Q?2RMamTDbQqEdo16xP070aMJAIR4nENSN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5TL5+FUDul0TMyWze7kvUSlg5npvsNI6i6rHfppUk0pkand11N2n7tPqhloA?=
 =?us-ascii?Q?zDmUscdzi5o6FHYVzvi8/I2r3nDyFDx9IKpa07tIzSACBIBCWHbNnp5p++Q1?=
 =?us-ascii?Q?z+W97WojLmsP160jLHzJFnjGkjej85szfyXxqS4GiKCpk4KIVDAXEvBWKyNO?=
 =?us-ascii?Q?VQ7JmrFNM2fcFgjzYWmbo9nowwhADzzj93kd+sJeqimSlYWDZmGeeauUQFho?=
 =?us-ascii?Q?JGtq4cN2oR548szRW3jM8lyRwAAjDbTWQC19HrmizBPsXIUVRr810NJKCtX2?=
 =?us-ascii?Q?WJgfwkBLli8YB1acxPf6k4dTEXcRytYd7T1lkZVAA8q+a1GfpUEQ2iQ1qSEB?=
 =?us-ascii?Q?FpoboKwLgP/akwmwRFnGHNWXyl4ygCYsP8/AU0Mo+8Lj1KDivGIrU+IGk3gc?=
 =?us-ascii?Q?hHWtqccrzxlBgg+HAW34/05sbKYltmv6LavpW3onC0rfJ+0wLRH9uNNb1Ym5?=
 =?us-ascii?Q?NmGXmDMbW0ZgDzLW7q3DE/uWRq+33n636+Lky+/5VkH/BPjTPCbXU6jee0CZ?=
 =?us-ascii?Q?9ZT1PKsdJfZISy4CICVdEiuVmtVt5clJaZLUtanrI+LIK7AcUekyJndGGJzZ?=
 =?us-ascii?Q?QzzSXchresovXZhX2x5k9ZASvKWdYOkd9QfQ8jJGLfPQ/29PpgjaVw3N/4uG?=
 =?us-ascii?Q?6Yh97Nd2YpOhOtrxllpDzAvw3FrtId03UhkMbNaCsLYOvi7lejjbloQFxoq1?=
 =?us-ascii?Q?OrY1z8Ag9HPVZeplML3lITSeo6GVl4R+u/sjv1lT2VQlKenpV+hzFwkulW/8?=
 =?us-ascii?Q?bW4sVc9/5TyRPAotiHA0ye/F2MROo55wM1chV3Bzzlj+za/cCDzG1sc9m9Js?=
 =?us-ascii?Q?DeXWOITiaeBbtWSR4Y8Rf41MtWImSYuQjX5BOTTK+cnM8gjWDlKvtPGFJjtG?=
 =?us-ascii?Q?AysEyGoUBWb1ksjmJJvtzJ+FVRP9WuToRYXPiGLAnwmqU7PHvRo1Zhe7ledY?=
 =?us-ascii?Q?iKIzFMAz9zds/8ERUqs5nB9c7vcdWhEHvPWL8xKTV/QmhaTYlIjJsJzjl8fX?=
 =?us-ascii?Q?qjIfM2Sh3EBEtqtHXV2WYESH+Og18VuLW4tKBdhrWEJQrseEta345ovLuLWU?=
 =?us-ascii?Q?WiSz5adEuBPGx530bjuCB0ApHhHkpMro7GoP6kHIEX44mMDsk+h3PaivOAx8?=
 =?us-ascii?Q?3WcKo5DKL2TWjY7qUUFTJxnMV3AYprK4D2h4SkDLoyFwd8gX7CDjgbcHeaCc?=
 =?us-ascii?Q?td83kzHTYXFZet/NypyMxddcsfNiqF3+yW5kY01Fr+hM0SbJdITHcwAeLdu7?=
 =?us-ascii?Q?SzStArZszsQCgu5wiJMbCdoQrDwATVmgr/EXh3jBzhlUzWtiC0NM4M3GEpep?=
 =?us-ascii?Q?NYVXGqpXKYhs2HtsWbUwfCPCtqyKAnbMV3rFE3WjUJ2NjiNnC5FG+cEHIHi9?=
 =?us-ascii?Q?wU5ZxhPYwdsZ++A9OT1fdzDgVcYjAFb17JQNySf1sIzocZrpP/xeyvvNKIr/?=
 =?us-ascii?Q?ABIOi8v492AJglDlyvAfwJSyWrQxhYXg97C5FVQK1v3+W4GYDxxRzIJxPiEd?=
 =?us-ascii?Q?sofqMydrVUPtaFZG9vI8krmFmbsuVGY44KdMkvw8xo7rNe6djupJr479FYhD?=
 =?us-ascii?Q?OB1WeXPXrjrlDn1LAvSj1eGLY34O3D4/rCw4sdMf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfa2e3c-50f9-44f8-0fd0-08dd610f1aed
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 02:39:26.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwHtViqGUyCgmkvwkKW5MibOrJPvOAnugXWyaWuXorQATjSr4dUAvbkukZKbx9H134/ryXgGZ9SVydk7rPHCSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9794

There are many fuzzy register variables in the lpuart driver, such as
temp, tmp, val, reg. Let's give these register variables more specific
names.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 220 ++++++++++++++++----------------
 1 file changed, 110 insertions(+), 110 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3b48e320e7f4..c8cc0a241fba 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -441,36 +441,36 @@ static unsigned int lpuart_get_baud_clk_rate(struct lpuart_port *sport)
 
 static void lpuart_stop_tx(struct uart_port *port)
 {
-	u8 temp;
+	u8 cr2;
 
-	temp = readb(port->membase + UARTCR2);
-	temp &= ~(UARTCR2_TIE | UARTCR2_TCIE);
-	writeb(temp, port->membase + UARTCR2);
+	cr2 = readb(port->membase + UARTCR2);
+	cr2 &= ~(UARTCR2_TIE | UARTCR2_TCIE);
+	writeb(cr2, port->membase + UARTCR2);
 }
 
 static void lpuart32_stop_tx(struct uart_port *port)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(port, UARTCTRL);
-	temp &= ~(UARTCTRL_TIE | UARTCTRL_TCIE);
-	lpuart32_write(port, temp, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
+	ctrl &= ~(UARTCTRL_TIE | UARTCTRL_TCIE);
+	lpuart32_write(port, ctrl, UARTCTRL);
 }
 
 static void lpuart_stop_rx(struct uart_port *port)
 {
-	u8 temp;
+	u8 cr2;
 
-	temp = readb(port->membase + UARTCR2);
-	writeb(temp & ~UARTCR2_RE, port->membase + UARTCR2);
+	cr2 = readb(port->membase + UARTCR2);
+	writeb(cr2 & ~UARTCR2_RE, port->membase + UARTCR2);
 }
 
 static void lpuart32_stop_rx(struct uart_port *port)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(port, UARTCTRL);
-	lpuart32_write(port, temp & ~UARTCTRL_RE, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
+	lpuart32_write(port, ctrl & ~UARTCTRL_RE, UARTCTRL);
 }
 
 static void lpuart_dma_tx(struct lpuart_port *sport)
@@ -599,7 +599,7 @@ static void lpuart_flush_buffer(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	struct dma_chan *chan = sport->dma_tx_chan;
-	u32 val;
+	u32 fifo;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (sport->dma_tx_in_progress) {
@@ -611,13 +611,13 @@ static void lpuart_flush_buffer(struct uart_port *port)
 	}
 
 	if (lpuart_is_32(sport)) {
-		val = lpuart32_read(port, UARTFIFO);
-		val |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
-		lpuart32_write(port, val, UARTFIFO);
+		fifo = lpuart32_read(port, UARTFIFO);
+		fifo |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
+		lpuart32_write(port, fifo, UARTFIFO);
 	} else {
-		val = readb(port->membase + UARTCFIFO);
-		val |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
-		writeb(val, port->membase + UARTCFIFO);
+		fifo = readb(port->membase + UARTCFIFO);
+		fifo |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
+		writeb(fifo, port->membase + UARTCFIFO);
 	}
 }
 
@@ -642,7 +642,7 @@ static int lpuart_poll_init(struct uart_port *port)
 	struct lpuart_port *sport = container_of(port,
 					struct lpuart_port, port);
 	unsigned long flags;
-	u8 temp;
+	u8 fifo;
 
 	port->fifosize = 0;
 
@@ -650,9 +650,9 @@ static int lpuart_poll_init(struct uart_port *port)
 	/* Disable Rx & Tx */
 	writeb(0, port->membase + UARTCR2);
 
-	temp = readb(port->membase + UARTPFIFO);
+	fifo = readb(port->membase + UARTPFIFO);
 	/* Enable Rx and Tx FIFO */
-	writeb(temp | UARTPFIFO_RXFE | UARTPFIFO_TXFE,
+	writeb(fifo | UARTPFIFO_RXFE | UARTPFIFO_TXFE,
 			port->membase + UARTPFIFO);
 
 	/* flush Tx and Rx FIFO */
@@ -694,7 +694,7 @@ static int lpuart32_poll_init(struct uart_port *port)
 {
 	unsigned long flags;
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u32 temp;
+	u32 fifo;
 
 	port->fifosize = 0;
 
@@ -703,10 +703,10 @@ static int lpuart32_poll_init(struct uart_port *port)
 	/* Disable Rx & Tx */
 	lpuart32_write(port, 0, UARTCTRL);
 
-	temp = lpuart32_read(port, UARTFIFO);
+	fifo = lpuart32_read(port, UARTFIFO);
 
 	/* Enable Rx and Tx FIFO */
-	lpuart32_write(port, temp | UARTFIFO_RXFE | UARTFIFO_TXFE, UARTFIFO);
+	lpuart32_write(port, fifo | UARTFIFO_RXFE | UARTFIFO_TXFE, UARTFIFO);
 
 	/* flush Tx and Rx FIFO */
 	lpuart32_write(port, UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH, UARTFIFO);
@@ -789,10 +789,10 @@ static void lpuart_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	u8 temp;
+	u8 cr2;
 
-	temp = readb(port->membase + UARTCR2);
-	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
+	cr2 = readb(port->membase + UARTCR2);
+	writeb(cr2 | UARTCR2_TIE, port->membase + UARTCR2);
 
 	if (sport->lpuart_dma_tx_use) {
 		if (!lpuart_stopped_or_empty(port))
@@ -806,14 +806,14 @@ static void lpuart_start_tx(struct uart_port *port)
 static void lpuart32_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u32 temp;
+	u32 ctrl;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (!lpuart_stopped_or_empty(port))
 			lpuart_dma_tx(sport);
 	} else {
-		temp = lpuart32_read(port, UARTCTRL);
-		lpuart32_write(port, temp | UARTCTRL_TIE, UARTCTRL);
+		ctrl = lpuart32_read(port, UARTCTRL);
+		lpuart32_write(port, ctrl | UARTCTRL_TIE, UARTCTRL);
 
 		if (lpuart32_read(port, UARTSTAT) & UARTSTAT_TDRE)
 			lpuart32_transmit_buffer(sport);
@@ -1411,9 +1411,9 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	dma_async_issue_pending(chan);
 
 	if (lpuart_is_32(sport)) {
-		u32 temp = lpuart32_read(&sport->port, UARTBAUD);
+		u32 baud = lpuart32_read(&sport->port, UARTBAUD);
 
-		lpuart32_write(&sport->port, temp | UARTBAUD_RDMAE, UARTBAUD);
+		lpuart32_write(&sport->port, baud | UARTBAUD_RDMAE, UARTBAUD);
 
 		if (sport->dma_idle_int) {
 			u32 ctrl = lpuart32_read(&sport->port, UARTCTRL);
@@ -1520,10 +1520,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 static unsigned int lpuart_get_mctrl(struct uart_port *port)
 {
 	unsigned int mctrl = 0;
-	u8 reg;
+	u8 cr1;
 
-	reg = readb(port->membase + UARTCR1);
-	if (reg & UARTCR1_LOOPS)
+	cr1 = readb(port->membase + UARTCR1);
+	if (cr1 & UARTCR1_LOOPS)
 		mctrl |= TIOCM_LOOP;
 
 	return mctrl;
@@ -1532,10 +1532,10 @@ static unsigned int lpuart_get_mctrl(struct uart_port *port)
 static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 {
 	unsigned int mctrl = TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
-	u32 reg;
+	u32 ctrl;
 
-	reg = lpuart32_read(port, UARTCTRL);
-	if (reg & UARTCTRL_LOOPS)
+	ctrl = lpuart32_read(port, UARTCTRL);
+	if (ctrl & UARTCTRL_LOOPS)
 		mctrl |= TIOCM_LOOP;
 
 	return mctrl;
@@ -1543,49 +1543,49 @@ static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 
 static void lpuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	u8 reg;
+	u8 cr1;
 
-	reg = readb(port->membase + UARTCR1);
+	cr1 = readb(port->membase + UARTCR1);
 
 	/* for internal loopback we need LOOPS=1 and RSRC=0 */
-	reg &= ~(UARTCR1_LOOPS | UARTCR1_RSRC);
+	cr1 &= ~(UARTCR1_LOOPS | UARTCR1_RSRC);
 	if (mctrl & TIOCM_LOOP)
-		reg |= UARTCR1_LOOPS;
+		cr1 |= UARTCR1_LOOPS;
 
-	writeb(reg, port->membase + UARTCR1);
+	writeb(cr1, port->membase + UARTCR1);
 }
 
 static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	u32 reg;
+	u32 ctrl;
 
-	reg = lpuart32_read(port, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
 
 	/* for internal loopback we need LOOPS=1 and RSRC=0 */
-	reg &= ~(UARTCTRL_LOOPS | UARTCTRL_RSRC);
+	ctrl &= ~(UARTCTRL_LOOPS | UARTCTRL_RSRC);
 	if (mctrl & TIOCM_LOOP)
-		reg |= UARTCTRL_LOOPS;
+		ctrl |= UARTCTRL_LOOPS;
 
-	lpuart32_write(port, reg, UARTCTRL);
+	lpuart32_write(port, ctrl, UARTCTRL);
 }
 
 static void lpuart_break_ctl(struct uart_port *port, int break_state)
 {
-	u8 temp;
+	u8 cr2;
 
-	temp = readb(port->membase + UARTCR2) & ~UARTCR2_SBK;
+	cr2 = readb(port->membase + UARTCR2) & ~UARTCR2_SBK;
 
 	if (break_state != 0)
-		temp |= UARTCR2_SBK;
+		cr2 |= UARTCR2_SBK;
 
-	writeb(temp, port->membase + UARTCR2);
+	writeb(cr2, port->membase + UARTCR2);
 }
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(port, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
 
 	/*
 	 * LPUART IP now has two known bugs, one is CTS has higher priority than the
@@ -1602,22 +1602,22 @@ static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 		 * Disable the transmitter to prevent any data from being sent out
 		 * during break, then invert the TX line to send break.
 		 */
-		temp &= ~UARTCTRL_TE;
-		lpuart32_write(port, temp, UARTCTRL);
-		temp |= UARTCTRL_TXINV;
-		lpuart32_write(port, temp, UARTCTRL);
+		ctrl &= ~UARTCTRL_TE;
+		lpuart32_write(port, ctrl, UARTCTRL);
+		ctrl |= UARTCTRL_TXINV;
+		lpuart32_write(port, ctrl, UARTCTRL);
 	} else {
 		/* Disable the TXINV to turn off break and re-enable transmitter. */
-		temp &= ~UARTCTRL_TXINV;
-		lpuart32_write(port, temp, UARTCTRL);
-		temp |= UARTCTRL_TE;
-		lpuart32_write(port, temp, UARTCTRL);
+		ctrl &= ~UARTCTRL_TXINV;
+		lpuart32_write(port, ctrl, UARTCTRL);
+		ctrl |= UARTCTRL_TE;
+		lpuart32_write(port, ctrl, UARTCTRL);
 	}
 }
 
 static void lpuart_setup_watermark(struct lpuart_port *sport)
 {
-	u8 val, cr2, cr2_saved;
+	u8 fifo, cr2, cr2_saved;
 
 	cr2 = readb(sport->port.membase + UARTCR2);
 	cr2_saved = cr2;
@@ -1625,8 +1625,8 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 			UARTCR2_RIE | UARTCR2_RE);
 	writeb(cr2, sport->port.membase + UARTCR2);
 
-	val = readb(sport->port.membase + UARTPFIFO);
-	writeb(val | UARTPFIFO_TXFE | UARTPFIFO_RXFE,
+	fifo = readb(sport->port.membase + UARTPFIFO);
+	writeb(fifo | UARTPFIFO_TXFE | UARTPFIFO_RXFE,
 			sport->port.membase + UARTPFIFO);
 
 	/* flush Tx and Rx FIFO */
@@ -1696,14 +1696,14 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 
 static void lpuart32_setup_watermark_enable(struct lpuart_port *sport)
 {
-	u32 temp;
+	u32 ctrl;
 
 	lpuart32_setup_watermark(sport);
 
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp |= UARTCTRL_RE | UARTCTRL_TE;
-	temp |= FIELD_PREP(UARTCTRL_IDLECFG, 0x7);
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	ctrl |= UARTCTRL_RE | UARTCTRL_TE;
+	ctrl |= FIELD_PREP(UARTCTRL_IDLECFG, 0x7);
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 }
 
 static void rx_dma_timer_init(struct lpuart_port *sport)
@@ -1820,16 +1820,16 @@ static void lpuart_hw_setup(struct lpuart_port *sport)
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u8 temp;
+	u8 fifo;
 
 	/* determine FIFO size and enable FIFO mode */
-	temp = readb(port->membase + UARTPFIFO);
+	fifo = readb(port->membase + UARTPFIFO);
 
-	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_TXSIZE_OFF) &
+	sport->txfifo_size = UARTFIFO_DEPTH((fifo >> UARTPFIFO_TXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
 	port->fifosize = sport->txfifo_size;
 
-	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_RXSIZE_OFF) &
+	sport->rxfifo_size = UARTFIFO_DEPTH((fifo >> UARTPFIFO_RXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
 
 	lpuart_request_dma(sport);
@@ -1840,24 +1840,24 @@ static int lpuart_startup(struct uart_port *port)
 
 static void lpuart32_hw_disable(struct lpuart_port *sport)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	ctrl &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
 		  UARTCTRL_TIE | UARTCTRL_TE);
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 }
 
 static void lpuart32_configure(struct lpuart_port *sport)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(&sport->port, UARTCTRL);
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
-		temp |= UARTCTRL_RIE | UARTCTRL_ILIE;
+		ctrl |= UARTCTRL_RIE | UARTCTRL_ILIE;
 	if (!sport->lpuart_dma_tx_use)
-		temp |= UARTCTRL_TIE;
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+		ctrl |= UARTCTRL_TIE;
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 }
 
 static void lpuart32_hw_setup(struct lpuart_port *sport)
@@ -1880,16 +1880,16 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u32 temp;
+	u32 fifo;
 
 	/* determine FIFO size */
-	temp = lpuart32_read(port, UARTFIFO);
+	fifo = lpuart32_read(port, UARTFIFO);
 
-	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_TXSIZE_OFF) &
+	sport->txfifo_size = UARTFIFO_DEPTH((fifo >> UARTFIFO_TXSIZE_OFF) &
 					    UARTFIFO_FIFOSIZE_MASK);
 	port->fifosize = sport->txfifo_size;
 
-	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_RXSIZE_OFF) &
+	sport->rxfifo_size = UARTFIFO_DEPTH((fifo >> UARTFIFO_RXSIZE_OFF) &
 					    UARTFIFO_FIFOSIZE_MASK);
 
 	/*
@@ -1934,16 +1934,16 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 static void lpuart_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u8 temp;
+	u8 cr2;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(port, &flags);
 
 	/* disable Rx/Tx and interrupts */
-	temp = readb(port->membase + UARTCR2);
-	temp &= ~(UARTCR2_TE | UARTCR2_RE |
+	cr2 = readb(port->membase + UARTCR2);
+	cr2 &= ~(UARTCR2_TE | UARTCR2_RE |
 			UARTCR2_TIE | UARTCR2_TCIE | UARTCR2_RIE);
-	writeb(temp, port->membase + UARTCR2);
+	writeb(cr2, port->membase + UARTCR2);
 
 	uart_port_unlock_irqrestore(port, flags);
 
@@ -2141,7 +2141,7 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
 				     unsigned int baudrate, bool use_rx_dma,
 				     bool use_tx_dma)
 {
-	u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
+	u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, baud;
 	u32 clk = port->uartclk;
 
 	/*
@@ -2170,9 +2170,9 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
 		tmp_diff = clk / (tmp_osr * tmp_sbr) - baudrate;
 
 		/* select best values between sbr and sbr+1 */
-		tmp = clk / (tmp_osr * (tmp_sbr + 1));
-		if (tmp_diff > (baudrate - tmp)) {
-			tmp_diff = baudrate - tmp;
+		baud = clk / (tmp_osr * (tmp_sbr + 1));
+		if (tmp_diff > (baudrate - baud)) {
+			tmp_diff = baudrate - baud;
 			tmp_sbr++;
 		}
 
@@ -2194,23 +2194,23 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
 		dev_warn(port->dev,
 			 "unacceptable baud rate difference of more than 3%%\n");
 
-	tmp = lpuart32_read(port, UARTBAUD);
+	baud = lpuart32_read(port, UARTBAUD);
 
 	if ((osr > 3) && (osr < 8))
-		tmp |= UARTBAUD_BOTHEDGE;
+		baud |= UARTBAUD_BOTHEDGE;
 
-	tmp &= ~(UARTBAUD_OSR_MASK << UARTBAUD_OSR_SHIFT);
-	tmp |= ((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT;
+	baud &= ~(UARTBAUD_OSR_MASK << UARTBAUD_OSR_SHIFT);
+	baud |= ((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT;
 
-	tmp &= ~UARTBAUD_SBR_MASK;
-	tmp |= sbr & UARTBAUD_SBR_MASK;
+	baud &= ~UARTBAUD_SBR_MASK;
+	baud |= sbr & UARTBAUD_SBR_MASK;
 
 	if (!use_rx_dma)
-		tmp &= ~UARTBAUD_RDMAE;
+		baud &= ~UARTBAUD_RDMAE;
 	if (!use_tx_dma)
-		tmp &= ~UARTBAUD_TDMAE;
+		baud &= ~UARTBAUD_TDMAE;
 
-	lpuart32_write(port, tmp, UARTBAUD);
+	lpuart32_write(port, baud, UARTBAUD);
 }
 
 static void lpuart32_serial_setbrg(struct lpuart_port *sport,
@@ -3085,7 +3085,7 @@ static int lpuart_suspend_noirq(struct device *dev)
 static int lpuart_resume_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	u32 val;
+	u32 stat;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -3094,8 +3094,8 @@ static int lpuart_resume_noirq(struct device *dev)
 
 		/* clear the wakeup flags */
 		if (lpuart_is_32(sport)) {
-			val = lpuart32_read(&sport->port, UARTSTAT);
-			lpuart32_write(&sport->port, val, UARTSTAT);
+			stat = lpuart32_read(&sport->port, UARTSTAT);
+			lpuart32_write(&sport->port, stat, UARTSTAT);
 		}
 	}
 
-- 
2.34.1

