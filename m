Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022100.outbound.protection.outlook.com [52.101.126.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D0295DAC;
	Sun, 30 Nov 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499542; cv=fail; b=jqAX52gXWzI89fSvonFbZFNzSn4MtnMPv4LmOk3Nd1Xiot7AkM7qLUc/L3mNgO/TaXOrk0mj4afLSPfcWW9eHdtOnT+SnzdoObO1eHhYH5b9RkvdBXnwvMZs0YeOOJs/BC73aOJJbVJEFh5xhbrhErlov6JNpztAEkxXdDntsKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499542; c=relaxed/simple;
	bh=rE2CNB80WytoZSbJhb7JWpCoLTvfpy2zbK+W09I2VSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CAfFOlDvdreSGQg3gGryiEsjfwhe6flKyqrekzVME6eeH8ovsHtwwcVEsxqnwONjtFVqwg1O9OlnjNR1SwTaCJ31AL6QRo7e1I0Tv0he5yNtDLmyXQcZIYK7E3YCouGNiWWWKpeYL6pu39C5CkG7eBOweXsfdtqeCGV9luC6vBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=VJOywNTx; arc=fail smtp.client-ip=52.101.126.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="VJOywNTx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbolpsuKmxiDwkn40SkaexGD6Of+83FOBIsE4f2bAobAGYf74N2iiyJGpVIGeEoBaaFvxlWgrv1ktNApalyiQDGUCGmyKQn1GUef89cqGzs2EkJJPN8tlGcoBW6ADuVUdbehyD1hh0OeKadG7YXcJDSYfhOsfDHFFxsXVBDNO1nYKe750k4QJB7zgEhk9Fbyp0kcqYgnTslA1fn3gYQK/4C2QTtrG1VfoOO7C6nyL7/yjZk4YT5w8UuiycFdOwVlUenMTQ1axCEkpAqpAHbtuRMxc4tll0yiCEgmisqaoVikrJA05La36sltf8wTrbcI++F0+ZKIHtfdwith6JtCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzKeiWkVbzQ6hu5X0/zBABRkUgNwUVxShQb3Zg/w//8=;
 b=LjGCZrRvY5gFjxMsHdEz3Qnox6yLSM317Ex7odWf/mNxIjuUWOKdtfRDX80WqK94RN0aV63Ej22q7paDn9pmt6b2CRsT/nqE1bxTUz4o5oODZJIkE5Qv/nBEnEk2IymydRS2plLJdUBilWI397WwyyfBUHNAxkVOPfLh16P+7XBIyv8JDb9XG7U8Sdht1ChrFCyYTDRqqOi4hoCd2ti0aSbrTvVYBMiCjOfv5M5Ov2a9yKl81ecqgYvGi85fM7QNzsCHGK4XaoxZPaPImoPVYrQMpbAws1V2+1DE+EWxLxXA44mxE21nX0J9tzflRsheV7lD8UNARFhXUsocAmrMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzKeiWkVbzQ6hu5X0/zBABRkUgNwUVxShQb3Zg/w//8=;
 b=VJOywNTxRheIVFKqbpjZHilYUTEafKo7E2vNA44seBFcOIu61f9a1Ap+iWzN0zYv3LqvCvQbJJfhPyRYxrZf+r0aDBekQIatNpeWg135vBeYrC7HZpAnOoN+wEirnYTliFtpVDNiRjD+NpfcI8I8srJNOBZAePdNXphTEGGa6fM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:45:34 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:45:34 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 25/31] serial: 8250_mxpcie: add basic GPIO helper functions
Date: Sun, 30 Nov 2025 18:42:16 +0800
Message-ID: <20251130104222.63077-26-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: ab69bbb3-9cb2-4fc2-cef5-08de2ffd9746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y+SsC/I5BiVvYGwcx4gTr6KA77vR40bUvbzOYlKp92t1PBNMpO2KwMM9dxD+?=
 =?us-ascii?Q?9MhvVawn/4q3uxeGlxg2OtDnC1WC6XQXvG3/ouRnUUtx7eeLbqGUsFW5dcCj?=
 =?us-ascii?Q?fszOehhy3OjyYxJtk67p6RW2sLxl/Hzy3gguyOFJzEPM93WN37robvzytGHj?=
 =?us-ascii?Q?uBpedb5eQs4Vz5whCpE+4cAG9EuQdRFa7AoXAerCSjgP0Q8maw3KvoNjLqh5?=
 =?us-ascii?Q?6keliCBlmfBitglTYY7IsI7vbc1rc6txbuOkehMXkAryq3/FnKfi2NyjOo1Q?=
 =?us-ascii?Q?mtIwMzLyNHijf9j2jgbGvlYptq+eu1D5uVtORScLPp7lz392DFWijmER/Zuk?=
 =?us-ascii?Q?D3o5hNqpVDlkbpc9sQTpeDA7FzfaYWPp3IQ9D4jwxU8VnxNYsTlcSowNKvNX?=
 =?us-ascii?Q?tmSZEWhAFFRqtCQHUviSCTy/Ian1G7+sGk+wK+gz8G0woRJtPQDOOJ2hXMKD?=
 =?us-ascii?Q?Bk3JFo3SZxDML5RQdlbz3soJSOURShEaHP+PtNR5y8pxmMQc6SO2s8PjkOWH?=
 =?us-ascii?Q?TSmXdwYbJ2f9TNxIgoRvYs7TGs/mdJj0RXlmcUiZK4Ipq5F+3Dysc1P1uS1u?=
 =?us-ascii?Q?WtoVJ89Le7V+0QglNxts3M8bNUflbNXvH+F2vg6LVQagmF+XjtsIgC0uGqLM?=
 =?us-ascii?Q?vkD0Mg1JmSWETQtURd409Es/pR7X3jJHcv29h7kNXyBr+BZFMRa7V5hkSMDO?=
 =?us-ascii?Q?RA0X7Y7270NCrmYnKOPxf8QOTMgBbvnGhaEpRVLxjjVrUjaiq1xr9ODeUVO0?=
 =?us-ascii?Q?d4yAmXNbpT/bC3PEfQGieDDa9qUvIOjY7s6UfyrTefGRdkmdPF4+HkmAZdH1?=
 =?us-ascii?Q?qlst+dhQPmKvdP0E7QYxrnAr+zWB8AEcc5/EcmFQdUrTuC6ZLqVCV9ZmoM+y?=
 =?us-ascii?Q?jM0DMFPrhSngBZJptmgL6zeHvyKjMcn9kd7OU2RnDcFqO8IEyjyJ8crBJaUn?=
 =?us-ascii?Q?+Abbf9sF5lclVC8lPgh8JHHM7TTMwJlQGApIf58VQTx8zHqprL5fH6XQ/oAC?=
 =?us-ascii?Q?u/tlqc7i/dP4IyUlo6oHzF2u95aPB+hMQwSjNZJWy6RZy3S+t2L2oQ7svmXl?=
 =?us-ascii?Q?ldMYmckxxu4UO3iuZm4bkWFVWm74K4UmRm50bw0+x+DuoJdUDpU8tQFzR5VU?=
 =?us-ascii?Q?KhFkgkYK0Qr5SeLun+9UnS/uvcybvUPRRkIXo+83sSKMRypxLKpTbWE+u5Tm?=
 =?us-ascii?Q?Wm6AlNrkvyfDKuRiQXD5B8kZzaoMz4/Fk67O54Sx6sOGd58F8H1kPfsGGdem?=
 =?us-ascii?Q?eql1ouwmginxf6se5N2iQZcj9LyV/k2ku3WRzR8/vwG648/6UbCwRZUpinmt?=
 =?us-ascii?Q?j+cVT2mj5I90aC0HA9zhJm8TuhUlP1T3/LJVIwTjxe6TPXuGpbMPiM/zaN74?=
 =?us-ascii?Q?lpWERQl7bgdnPyLz0vHvTHiWi7PxDvBOypAmLjySJk2Ck96e3B8ReRaOkml7?=
 =?us-ascii?Q?OkBtK2UlAP6TKpdg76MfLFp1oQ5p23YJWSmsDD7ROjHVEsSmVzg4OzqGRrib?=
 =?us-ascii?Q?YA8p1FI6rFp+fGaOkAVRAO/YU9wD6tAgWd0b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BOghNugwK217A7ZXHxOegH2sU7SPyf/2DIJ337Bu/WM8pGUWBbUpblXH+v6I?=
 =?us-ascii?Q?WgubiEM2rQvFsl/F7a+FCgA41p5QRAXR+FaJ+SMQKC+6fo0lA6L0ajxWVjqJ?=
 =?us-ascii?Q?8BN8+Y43YLdBpteo9/WJcJwssnYG2itWB2tj4ptPgOBTAY4VoLehBmtqZo2X?=
 =?us-ascii?Q?1X6Tx/tyMARrjiSx2QmWyCkXzOtHYCHi18FZZnmu4Fga4xw+c7J2W89GqnRd?=
 =?us-ascii?Q?UC3mO6LT+WScfQaF51GrNoBzOUTl3qyFwHKu1hzmqONzaVKEBLLTJWXBDEIy?=
 =?us-ascii?Q?+1Hq40Yryr3nY7K9CckmdJy2ooCvvEJoARwNf8fisX7stNiQObzfqqLgOewM?=
 =?us-ascii?Q?gIgrRUJ/NF2n39CG5C5zSlMZ9AhhA8YqwYLTX6ZC1IwO09UbpG7COV0E4wMR?=
 =?us-ascii?Q?HyZtWBIIZH4e6eAa2n1AkmeksEpSvB9+cEws4haCpdYdKJ3e2SE/HXHbhsWW?=
 =?us-ascii?Q?nklam7fXz82RON0z6S7mrWfZB4hQgJ7Kg0F6CvKjCquaTmPtZa7VOCxNEdsT?=
 =?us-ascii?Q?ik5TKspi5Q6IdM0mH2s2EJQfUnjZyfZ3/X1X8u8bj1YKdyBINxS2t3MiUGjr?=
 =?us-ascii?Q?k7R42aZ6YoqpYBCUKrcgeZHln6mFO8H64UizKjvzyPZ7yq0ivsmZmE4huM56?=
 =?us-ascii?Q?dGosygacYTslIjOYR31VPYeWrtjKddrei8a9XLbOhhnfDChKmk2piwMxVEjj?=
 =?us-ascii?Q?bRTJ8HuZigCBjb7dvWivsyKuQWzrkFHWpfuCLT37mtfcYrfTfly5ItjQVl7V?=
 =?us-ascii?Q?zYg5ww7DWtIxXJ64F5s8dMB1F2kGF3FLkMC2iha1ZJV5n53MkCKUNQp43rDA?=
 =?us-ascii?Q?ys7rWGBl3q5SRu1abYDdxvsQU9scXNimv39bnUQmZ2STT84GZIPFvuAIcsl/?=
 =?us-ascii?Q?1eLCluAS576Tfyi526dH2NdCFENoAPSXucYUa2y+RJU95lNGfJY+i4bnZHVz?=
 =?us-ascii?Q?4F58PRqbptwmAX7MpLXG6Ve53kKPhbWGk0z4yc3OaNuvfeZZhV7Nf0OeXM6n?=
 =?us-ascii?Q?tc4N6e0sar5fzDSD38vv3a6BamVzqS72qhEFRUIeM8OI3QfR/qT36vfb43PA?=
 =?us-ascii?Q?QE3gR4UWT+yuNfHSV6H5gjmImpD+teRqI/YIK/vzM0q3VpccIshktXqG6ovR?=
 =?us-ascii?Q?U1TCagFDbcJ1Lz6K/VhGRQ3VFbgiQjRjVs1jGPxJO2aJAqmgIoXJZXKpUd/R?=
 =?us-ascii?Q?s1rLb1AsioPKIxi08KmVVtGKO6dm6ju7oT6JChbpihpRFHKl7Pb7CjiLCNFQ?=
 =?us-ascii?Q?khX92jAQcfbpicCjXF2vjDbqccx3YTnODwpE9c1MDiadHxhns/PfRgmbFtKq?=
 =?us-ascii?Q?tB5YICpe2YNEGhSLT+wEyYnNW4vqPtUz+jcLmwVFcLkOHpziZUyx+4acflVa?=
 =?us-ascii?Q?XDM9BYuGjQkYroM9EPaHlr5cAMe8aUgAWS6rlEqZEapAfArJAjAUJv9ueLLy?=
 =?us-ascii?Q?YMlRQKU6N3NpuSZZXUBgKjDwmyAZYpgAPTB7eAkb2LJ/z4imzgdAVRRu/e7S?=
 =?us-ascii?Q?dW8rpLW1Vdqh16SVhBX9jFFC1+HuEtMvhhh9t5lFV4V7Ni/Wcaa6s7qMdswg?=
 =?us-ascii?Q?tlDLnzk8jufVVML4ZA8UWQPAEyxcuKsr/TqwWXB+SHDGyfbtIqx3c59ADkYS?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab69bbb3-9cb2-4fc2-cef5-08de2ffd9746
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:45:34.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YunWVI5ovbrBHJx9J3aUyD3tb+8nNePjDVAOdJzhpNEyvY7m9sN4XQDxHFQrLnk8tX+tQtnLWEHgEecBiCjuhNKL2424m4wLwQEvOP84h0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Introduce a set of helper functions for accessing the on-board GPIO
registers on Moxa PCIe serial devices. These cover:

- Initializing all pins as outputs
- Setting the direction of individual pins
- Setting or clearing an output pin
- Bulk set/get operations on OUTPUT and DIRECTION registers

These functions do not change any existing behavior yet. They are added
as a preparation step for follow-up patches that will make use of the
GPIOs to control board-specific signals.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 91 +++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index a0deb464a318..6e727b77c105 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -79,11 +79,18 @@
 #define MOXA_PUART_RX_FIFO_MEM	0x100	/* Memory Space to Rx FIFO Data Register */
 #define MOXA_PUART_TX_FIFO_MEM	0x100	/* Memory Space to Tx FIFO Data Register */
 
+/* GPIO */
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
 
 #define MOXA_GPIO_PIN2	BIT(2)
 
+#define MOXA_GPIO_STATE_INPUT	0
+#define MOXA_GPIO_STATE_OUTPUT	1
+
+#define MOXA_GPIO_LOW	0
+#define MOXA_GPIO_HIGH	1
+
 #define MOXA_UIR_OFFSET		0x04
 #define MOXA_UIR_RS232		0x00
 #define MOXA_UIR_RS422		0x01
@@ -120,6 +127,90 @@ static const struct serial_rs485 mxpcie8250_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX | SER_RS485_MODE_RS422,
 };
 
+/**
+ * mxpcie8250_gpio_init() - GPIO initialization routine
+ * @iobar_addr:	The base address of the GPIO I/O region
+ *
+ * Initializes the GPIO direction. After calling this function, all GPIO
+ * pins will be set to output.
+ */
+static void mxpcie8250_gpio_init(resource_size_t iobar_addr)
+{
+	/* Initialize all the GPIO pins into output state */
+	outb(0xff, iobar_addr + MOXA_GPIO_DIRECTION);
+}
+
+/**
+ * mxpcie8250_gpio_set_direction() - Set GPIO pin direction
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @pin:	The target GPIO pin (MOXA_GPIO_PIN0 to MOXA_GPIO_PIN7)
+ * @direction:	Desired direction (MOXA_GPIO_STATE_INPUT or MOXA_GPIO_STATE_OUTPUT)
+ *
+ * Sets the direction of the specified GPIO pin. This function should be called
+ * before performing GPIO set or get operations.
+ */
+static void mxpcie8250_gpio_set_direction(resource_size_t iobar_addr, int pin, int direction)
+{
+	u8 cval;
+
+	cval = inb(iobar_addr + MOXA_GPIO_DIRECTION);
+
+	if (direction == MOXA_GPIO_STATE_INPUT)
+		cval &= ~pin;
+	else
+		cval |= pin;
+
+	outb(cval, iobar_addr + MOXA_GPIO_DIRECTION);
+}
+
+/**
+ * mxpcie8250_gpio_set() - Set GPIO output state
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @pin:	The target GPIO pin (MOXA_GPIO_PIN0 to MOXA_GPIO_PIN7)
+ * @state:	Desired output state (MOXA_GPIO_HIGH or MOXA_GPIO_LOW)
+ *
+ * Sets the output state of the specified GPIO pin.
+ */
+static void mxpcie8250_gpio_set(resource_size_t iobar_addr, int pin, int state)
+{
+	u8 cval;
+
+	cval = inb(iobar_addr + MOXA_GPIO_OUTPUT);
+
+	if (state == MOXA_GPIO_HIGH)
+		cval |= pin;
+	else
+		cval &= ~pin;
+
+	outb(cval, iobar_addr + MOXA_GPIO_OUTPUT);
+}
+
+/**
+ * mxpcie8250_gpio_set_all() - Set all GPIO output/direction pins at once
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @data:	The data to set for all pins
+ * @offset:	Offset of the GPIO register (MOXA_GPIO_OUTPUT or MOXA_GPIO_DIRECTION)
+ *
+ * Sets the output state or direction of all GPIO pins at once.
+ */
+static void mxpcie8250_gpio_set_all(resource_size_t iobar_addr, u8 data, u8 offset)
+{
+	outb(data, iobar_addr + offset);
+}
+
+/**
+ * mxpcie8250_gpio_get_all() - Get all GPIO input/output pins state at once
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @data:	The buffer to store the states of all pins
+ * @offset:	Offset of the GPIO register (MOXA_GPIO_INPUT or MOXA_GPIO_OUTPUT)
+ *
+ * Gets the input or output state of all GPIO pins at once.
+ */
+static void mxpcie8250_gpio_get_all(resource_size_t iobar_addr, u8 *data, u8 offset)
+{
+	*data = inb(iobar_addr + offset);
+}
+
 static bool mxpcie8250_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
-- 
2.45.2

