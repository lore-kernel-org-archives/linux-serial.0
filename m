Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E519CC20;
	Wed, 12 Mar 2025 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741747164; cv=fail; b=TLGYYyc3M/f1WQm/UydscL3tOSdjLxbqhpcRxeuz+/16i2mxtnD9LxT+iN4pSkwXp7Yi9JO/kuG/JeIwqh+tPXuzxhFt17LE3SjVyyVoxLdSfBO2ROCnqS7OXxMIVPt6Z6gkI/v+lV3rci7wE+FuCLpH++faXybzmVl2xEMw2HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741747164; c=relaxed/simple;
	bh=CAbyxAwy7pNqmsBLGzog/W3ys+kBaQExYNJb1qAKe7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZDIIrkHopMCKMxIiPYHxj/W3JMB4FDkQ7MLoyiFvlN0U57RN/4Q6OzfuXIlzluCLAGAKyBDeOzmDtXhyqMPigcmBxsgUMfyZk5k03Dj/zQ5HfQj7CEnjqGAYrhEawoJvIidezRKyZmh2BAVJ/gs6T/pV93t9uVl464mX1AgdBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QI/aWnQt; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QI/aWnQt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcxCrBF7FrXnU7bGmxcjE6Sl4rIgsyLzPqCmCdBmCg0poOX/r+v/xH60MwmVj/V66P4YOHarP3qLNcAzW+32xAoIJBvC2MHqRQHAG7ui/3xOT0n4HmBk3tZbLOfsirUWA+uJGfgUwaBySJyonp95PobeuPXWuZacmeO7K29lp5mG7SY2vzrxzlH/Zf6jRpX6nt+V9xo1E7WFwSa+IcGVi7aKMvSWnBWKzgTtTxwjgj+I5OrIXx6SjDY5RSVONb6oPEHatUJxQLaB+tj6ceFocS9GKXe3AAvHl14hhiaEWsN/p9qqURcIOBoa+df7NZ4EcxsUzH+oegkLsnIONRPnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUJJNiSJpy1qR3QrD1kEpxJP4nwf7uG0IXtZYaMZHbc=;
 b=blJfb/djVK5Z0aK2KbUNWWH6SjTO3YRpJEX5cOuUPArlFWhnHWpe3Wf2qoQf6mRmdQrrzLY5ecMJKAThe5Z4xROfkaWZTu0PIpbgeKnZ0ZUAXdImBnaWWYImbfVm1K4c8/LEN5WePAwACiRjTsSwttUryGPUE8P6aiF1/96jQvejgcag4Vi4B5V5zgAuUJhJMZ7OCgryHlR+t1VL3JYb444clNER+kxonfSC5XAnOP8MMka+rqIPV0TWYW22OiKiRzNaxHkdCK8CPkYzQ41ZWCTY7RzmzWvljI50H1qdoOiuZOPPCffFM2Nb4t94NMpqYbfSzhWHqjI7VQoxC7f+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUJJNiSJpy1qR3QrD1kEpxJP4nwf7uG0IXtZYaMZHbc=;
 b=QI/aWnQtd67LUCqrEI5qgmYCrAMYCaDVjlRiGjliJl44SMgnU1LdPvjl4RVRSeUn1yclgK29PdTu/KAsr7r/FntXq7wZVSao8pqwYJdw8VRvaR9PH0rff3eRUH4pHRoh6DpddhtwdsyD1RC/l4QE3kGxV6Rhn4XVhZ273nchvC0hTq5+qEOo1JzXVQELHWt6Ym6HfbE6TRNQ0e3sZhDe+2QXi1iOtP7MOTBfYlgDbyntTCt73+5gGgwwk3TY1eYy7QoSZA7eAixYEuNO+GCRtdEQeKVuZiXsKA39PMwxvTN+TBbTUunjgUbKwbGZZIWT7YqWl28Ja6V40FNIDRy8Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DUZPR04MB9794.eurprd04.prod.outlook.com (2603:10a6:10:4e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:39:19 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:39:19 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V3 1/3] tty: serial: fsl_lpuart: Use u32 and u8 for register variables
Date: Wed, 12 Mar 2025 10:39:02 +0800
Message-Id: <20250312023904.1343351-2-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: de7d2d23-f2ec-4915-b672-08dd610f16ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWFyBW4fRzRZvT7GSe9kNgRgt2m2TWFzgCubaypeHzTq6TX6ZPnSrlI/YRkL?=
 =?us-ascii?Q?msUkqoTuoolD4CBpcrwbKJUdFZWpCassYTdLAeYrl96Xx4UfWqzraNv9NhdD?=
 =?us-ascii?Q?Le+QqoTT5RCmnPUr5M3+msLaNUOKGUVqpIjXuySSMHxvtuXFpO4KxHnUOCO0?=
 =?us-ascii?Q?FY5TaiCJn0YazdDY29XZtOo/WRNANNu7ksf2YcwtoRglSQjalxRuvm7ASIg6?=
 =?us-ascii?Q?CuLPhOyEAVYvSloVoW7aij+LjpAWtQlrTOk0GZDfevJUrv3lMtTuWIq9CXBk?=
 =?us-ascii?Q?dQCcSTrJK01zeI+Ycpe0qqmaPjGfvu8CDiNTtdNIbBtmrh7zq+6uCwVrhQSE?=
 =?us-ascii?Q?QvCc2EaVdcrMOsGXCJeO4geRAfCP6JBheH+L31Q0oji8ktInZ0x89cBILuNH?=
 =?us-ascii?Q?ZyMi8atgj4JqMlHV3g6fDMQXAWdpgA3VPvdhr/rQh1FAN84m6WXH/g2nmzA0?=
 =?us-ascii?Q?VRo9A3ZCfzXZSYRS2puPRsVtnyXCg9g3NIEA0MuNCeAUa6hV1F5218qrdZKq?=
 =?us-ascii?Q?kxW0lR7/JU6wCrUfgIczj6+Yl5sNmf+4oEhqfcj4OJMRW8pzFWiSXHjpw/Nx?=
 =?us-ascii?Q?9g4oQvKHf04uIweU/wbvz1NW9uKc2DhK6O+NY0L7c7JiAiHIXj4UYn8snvnb?=
 =?us-ascii?Q?D4lh9qBLLu8ZSu9xmivA9w9ZR8FCnAeL+L1p7Iv36SaU4JLM27WbCS9HIbI/?=
 =?us-ascii?Q?SyUwWD+yEsQbR6PY7AsfKHcPzY+qj2ykujuSjwuM1h3lJ5YGYkH011r5IbMU?=
 =?us-ascii?Q?FGqkc2ygRcdM6ImFOBfgisgAsXzMCmCMslkDl0Gzjx/vJUk+wjHK3TlvvTLj?=
 =?us-ascii?Q?kkR4mqS6TsHH4+pFIGDfz7+DpfB2g4oZ6Z+NeI6rNxYMCudCOUn3/BcxHCGQ?=
 =?us-ascii?Q?xLxOecKTSw6jNsk3WV2MYr0I31HgyRwbah3LVo7gKDdBkUqxOwSqPZrG86+m?=
 =?us-ascii?Q?xsrljLBW3Ulx50O6kP/niJae3FBBnpi/YGHV5a90f+7aKUGoRMeie3UGA2L3?=
 =?us-ascii?Q?bB8TwbAD8Asrvz2VAXdb/b+GRRJeRy2/PtuqwsNaU4UyxMKYMYlbo+Kgy27J?=
 =?us-ascii?Q?zePOcb2q8x/CXDLb1eCSaWeEza/+2nGisnfZ2w+8vUFcArOTqH7eUfrU9BBp?=
 =?us-ascii?Q?IIQau3uDZh/98yO0a3qtO99RDUdi6WfEARVjWJuoO63wfX1LWhkkJAS26P5U?=
 =?us-ascii?Q?cwnLiilh1lmxF5yN+sOciZjHjgk2H81nujSGdzzha0LC7CLckbk5lbeLiPQW?=
 =?us-ascii?Q?rVUDwLwCqYXVeZTV+y/bzhCUG7wKuw27eZTC7Ar58rTFqNFp37NeEyzADfzR?=
 =?us-ascii?Q?YFxhSOv5ukdXt3HJ47f9RyBwH5jVMGDWC18u8pThLRwarBXdgMeeo2+eSgXl?=
 =?us-ascii?Q?6yZXWuH6hw9Kl4YxY9Nuv2GoE3D2lF+XPZ/8e0cLLK7n7S3ZwMN77n+VnxiA?=
 =?us-ascii?Q?TfaH6tt9wyZ+xmocipvc0FjoqRHkbVEG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YAfdroYPcIXiz6hfbQvIN4wM7qufBjvflAWFS/xbToDOplnljSjw+SvxPsnq?=
 =?us-ascii?Q?ehGnaFuAJeCNK20cN5od4vtApM78hGwZZzDaAUiEAborNxGuxMIlXGFAB+Wh?=
 =?us-ascii?Q?zmWr04wV0y6j1htZE6rrr1Ho8l+fjtv/cs2uyIKKYA0xMpA3n4WxV30XXmj+?=
 =?us-ascii?Q?nyEKPyzHLhrFnxgugI37T8aP6Ckgj3PycG3Xq00qf7d2EgTviOA9DoxzB/V6?=
 =?us-ascii?Q?ulaRmHB6dmLmLV1CgZNPA1WJemVjOYSypMj1kZmqJoETcC+B/+2yHBRm7Nfq?=
 =?us-ascii?Q?sceptLPgNyBAoWXAQeAapW03SArTXiu9FZibtCiTv9+FFpYQENLY9NVpZsKY?=
 =?us-ascii?Q?YU60pIaV378QAD9+BWz9nJatgty5rrYaAkpH296QILYsUWkEl9JcPMklNUvC?=
 =?us-ascii?Q?ZXt5wArt71sA+XLbf0+HpsYRisuA0f33z5aYZ0TL5vtg3sKZHYr1yhtsRyFq?=
 =?us-ascii?Q?JIpoaln6IT7wcp9SDRD7hDq/r0/KK4NUXvftSjTlgGgttADZBTV/igGFeSu/?=
 =?us-ascii?Q?JxJF9DLCRB5LQGGMmU2AIHrvOxBnJsO3ei5jK0u07U1WNY6ycJq7QsRyB0OO?=
 =?us-ascii?Q?zXONGX2Wh2jidSLHOie0Vdk20v5X5RArPk27PYpZNlWpJFxtGwdvqQwGZcxZ?=
 =?us-ascii?Q?IYvpVTS5DDRDZ6YQ/+6CogxIuCkk5tvqIVPrQ6kEKCG9rzQaVfgQ960NwPqR?=
 =?us-ascii?Q?LfvYMJJuHU+sv5zN80/v5WCpbv92igPSlUtZRCfXuLUlfvVgOQPZ77PTyCgR?=
 =?us-ascii?Q?VTw38ovrtCdXuhKTkqdG86qOui+xvdLiBG5GU9TBjVnuJ23RsmmLTqDfGGEX?=
 =?us-ascii?Q?ebJR55wAFxDsHDPfMRH/ypipWmf4fByTf6Wdczc/IqwQS+0FJFP9UtsQApLT?=
 =?us-ascii?Q?WyacKOoVC3dRrtQdnemuBrwtAloqUqXl325erTfxMG5+Xlw8k9rt/aVoRyRU?=
 =?us-ascii?Q?gu64FhUEVelmM27exBYFpcrAAu9K6zvmIvcZiQvgGBASuL6UOonIV+gdj0Tn?=
 =?us-ascii?Q?Opa6+g4shw6b9WN2BvHnwVXzxokvxhOBhFJGECDJdhAF4+/TwgUZpbxHPH5Q?=
 =?us-ascii?Q?lbFTD7lXCV4GTF9QdJtR0nxmg+9FKRApdIVDcuaV4IgDGYYL8uiyr1yTTdBf?=
 =?us-ascii?Q?1sI+l4xA+SfKyh0Twapk30GF/7yEteTIR6GdHHH2gztqjj57rDZ8pvhUo9cZ?=
 =?us-ascii?Q?9E51Y+wwJgvZtDU52C726QqND08nzHd/4t+XgT70SsCyxYVPpAI3IIew53od?=
 =?us-ascii?Q?2FKyUbGkPzGb9TCsEyaq8JFi8ZOQF+kG2JubF6P6b93pNKaIX38NqU9xFPr/?=
 =?us-ascii?Q?t0/yexHkVB/Q+zyNVFaZGFseLJ/81/F2mFLDmDX+jn7BHRfWMBOAcTgw8q0q?=
 =?us-ascii?Q?JBZwG5X9FHsqBKPAsJz07b8UeoUjS75B2Ho0CG4mUkQv92zOYZGZfkCxvTGl?=
 =?us-ascii?Q?LLXvwpSg0hTVFeXxhA/ki1+HoM9Quh9sek12CMZYz84ykmoQkdT6f543WF+G?=
 =?us-ascii?Q?77pi3PXGbIQCXy6QAzLLtoMkBvV6+5Sa/6FcZY2QhF6iJO4vBK71NYoY0x+f?=
 =?us-ascii?Q?+asVNG9IcyojZyXe8iIX7VWoK6qgC3Ds/459Zx6E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7d2d23-f2ec-4915-b672-08dd610f16ec
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 02:39:19.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V97zOab5VHYzgf5+OCKILLBKXMoAqNm3bOazoC2Ihdm+uxTBgCi39eEhpmEzapOTL6TC8BQnFYXJ2SDhMcix9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9794

Use u32 and u8 rather than unsigned long or unsigned char for register
variables for clarity and consistency.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 93 ++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 203ec3b46304..6f64a3300a38 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -441,7 +441,7 @@ static unsigned int lpuart_get_baud_clk_rate(struct lpuart_port *sport)
 
 static void lpuart_stop_tx(struct uart_port *port)
 {
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2);
 	temp &= ~(UARTCR2_TIE | UARTCR2_TCIE);
@@ -450,7 +450,7 @@ static void lpuart_stop_tx(struct uart_port *port)
 
 static void lpuart32_stop_tx(struct uart_port *port)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 	temp &= ~(UARTCTRL_TIE | UARTCTRL_TCIE);
@@ -459,7 +459,7 @@ static void lpuart32_stop_tx(struct uart_port *port)
 
 static void lpuart_stop_rx(struct uart_port *port)
 {
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2);
 	writeb(temp & ~UARTCR2_RE, port->membase + UARTCR2);
@@ -467,7 +467,7 @@ static void lpuart_stop_rx(struct uart_port *port)
 
 static void lpuart32_stop_rx(struct uart_port *port)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 	lpuart32_write(port, temp & ~UARTCTRL_RE, UARTCTRL);
@@ -642,7 +642,7 @@ static int lpuart_poll_init(struct uart_port *port)
 	struct lpuart_port *sport = container_of(port,
 					struct lpuart_port, port);
 	unsigned long flags;
-	unsigned char temp;
+	u8 temp;
 
 	sport->port.fifosize = 0;
 
@@ -752,7 +752,7 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 {
 	struct tty_port *tport = &sport->port.state->port;
-	unsigned long txcnt;
+	u32 txcnt;
 	unsigned char c;
 
 	if (sport->port.x_char) {
@@ -789,7 +789,7 @@ static void lpuart_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2);
 	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
@@ -806,7 +806,7 @@ static void lpuart_start_tx(struct uart_port *port)
 static void lpuart32_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (!lpuart_stopped_or_empty(port))
@@ -839,8 +839,8 @@ static unsigned int lpuart_tx_empty(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	unsigned char sr1 = readb(port->membase + UARTSR1);
-	unsigned char sfifo = readb(port->membase + UARTSFIFO);
+	u8 sr1 = readb(port->membase + UARTSR1);
+	u8 sfifo = readb(port->membase + UARTSFIFO);
 
 	if (sport->dma_tx_in_progress)
 		return 0;
@@ -855,9 +855,9 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	unsigned long stat = lpuart32_read(port, UARTSTAT);
-	unsigned long sfifo = lpuart32_read(port, UARTFIFO);
-	unsigned long ctrl = lpuart32_read(port, UARTCTRL);
+	u32 stat = lpuart32_read(port, UARTSTAT);
+	u32 sfifo = lpuart32_read(port, UARTFIFO);
+	u32 ctrl = lpuart32_read(port, UARTCTRL);
 
 	if (sport->dma_tx_in_progress)
 		return 0;
@@ -884,7 +884,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
 {
 	unsigned int flg, ignored = 0, overrun = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned char rx, sr;
+	u8 rx, sr;
 
 	uart_port_lock(&sport->port);
 
@@ -961,7 +961,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 {
 	unsigned int flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned long rx, sr;
+	u32 rx, sr;
 	bool is_break;
 
 	uart_port_lock(&sport->port);
@@ -1039,7 +1039,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 static irqreturn_t lpuart_int(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned char sts;
+	u8 sts;
 
 	sts = readb(sport->port.membase + UARTSR1);
 
@@ -1113,7 +1113,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	int count, copied;
 
 	if (lpuart_is_32(sport)) {
-		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
+		u32 sr = lpuart32_read(&sport->port, UARTSTAT);
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
 			/* Clear the error flags */
@@ -1125,10 +1125,10 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 				sport->port.icount.frame++;
 		}
 	} else {
-		unsigned char sr = readb(sport->port.membase + UARTSR1);
+		u8 sr = readb(sport->port.membase + UARTSR1);
 
 		if (sr & (UARTSR1_PE | UARTSR1_FE)) {
-			unsigned char cr2;
+			u8 cr2;
 
 			/* Disable receiver during this operation... */
 			cr2 = readb(sport->port.membase + UARTCR2);
@@ -1279,7 +1279,7 @@ static void lpuart32_dma_idleint(struct lpuart_port *sport)
 static irqreturn_t lpuart32_int(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned long sts, rxcount;
+	u32 sts, rxcount;
 
 	sts = lpuart32_read(&sport->port, UARTSTAT);
 	rxcount = lpuart32_read(&sport->port, UARTWATER);
@@ -1411,12 +1411,12 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	dma_async_issue_pending(chan);
 
 	if (lpuart_is_32(sport)) {
-		unsigned long temp = lpuart32_read(&sport->port, UARTBAUD);
+		u32 temp = lpuart32_read(&sport->port, UARTBAUD);
 
 		lpuart32_write(&sport->port, temp | UARTBAUD_RDMAE, UARTBAUD);
 
 		if (sport->dma_idle_int) {
-			unsigned long ctrl = lpuart32_read(&sport->port, UARTCTRL);
+			u32 ctrl = lpuart32_read(&sport->port, UARTCTRL);
 
 			lpuart32_write(&sport->port, ctrl | UARTCTRL_ILIE, UARTCTRL);
 		}
@@ -1482,7 +1482,7 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
 
-	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
+	u32 modem = lpuart32_read(&sport->port, UARTMODIR)
 				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
 	u32 ctrl;
 
@@ -1577,7 +1577,7 @@ static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void lpuart_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2) & ~UARTCR2_SBK;
 
@@ -1589,7 +1589,7 @@ static void lpuart_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 
@@ -1623,8 +1623,7 @@ static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart_setup_watermark(struct lpuart_port *sport)
 {
-	unsigned char val, cr2;
-	unsigned char cr2_saved;
+	u8 val, cr2, cr2_saved;
 
 	cr2 = readb(sport->port.membase + UARTCR2);
 	cr2_saved = cr2;
@@ -1657,7 +1656,7 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 
 static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 {
-	unsigned char cr2;
+	u8 cr2;
 
 	lpuart_setup_watermark(sport);
 
@@ -1668,8 +1667,7 @@ static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 
 static void lpuart32_setup_watermark(struct lpuart_port *sport)
 {
-	unsigned long val, ctrl;
-	unsigned long ctrl_saved;
+	u32 val, ctrl, ctrl_saved;
 
 	ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	ctrl_saved = ctrl;
@@ -1778,7 +1776,7 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 {
 	int ret;
-	unsigned char cr3;
+	u8 cr3;
 
 	if (uart_console(&sport->port))
 		goto err;
@@ -1828,7 +1826,7 @@ static void lpuart_hw_setup(struct lpuart_port *sport)
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned char temp;
+	u8 temp;
 
 	/* determine FIFO size and enable FIFO mode */
 	temp = readb(sport->port.membase + UARTPFIFO);
@@ -1848,7 +1846,7 @@ static int lpuart_startup(struct uart_port *port)
 
 static void lpuart32_hw_disable(struct lpuart_port *sport)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	temp &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
@@ -1858,7 +1856,7 @@ static void lpuart32_hw_disable(struct lpuart_port *sport)
 
 static void lpuart32_configure(struct lpuart_port *sport)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
@@ -1888,7 +1886,7 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 
 	/* determine FIFO size */
 	temp = lpuart32_read(&sport->port, UARTFIFO);
@@ -1942,7 +1940,7 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 static void lpuart_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned char temp;
+	u8 temp;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(port, &flags);
@@ -1962,7 +1960,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport =
 		container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(port, &flags);
@@ -1998,7 +1996,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned long flags;
-	unsigned char cr1, old_cr1, old_cr2, cr3, cr4, bdh, modem;
+	u8 cr1, old_cr1, old_cr2, cr3, cr4, bdh, modem;
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 	unsigned int sbr, brfa;
@@ -2236,7 +2234,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned long flags;
-	unsigned long ctrl, old_ctrl, bd, modem;
+	u32 ctrl, old_ctrl, bd, modem;
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 
@@ -2503,7 +2501,7 @@ static void
 lpuart_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct lpuart_port *sport = lpuart_ports[co->index];
-	unsigned char  old_cr2, cr2;
+	u8  old_cr2, cr2;
 	unsigned long flags;
 	int locked = 1;
 
@@ -2533,7 +2531,7 @@ static void
 lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct lpuart_port *sport = lpuart_ports[co->index];
-	unsigned long  old_cr, cr;
+	u32 old_cr, cr;
 	unsigned long flags;
 	int locked = 1;
 
@@ -2567,7 +2565,7 @@ static void __init
 lpuart_console_get_options(struct lpuart_port *sport, int *baud,
 			   int *parity, int *bits)
 {
-	unsigned char cr, bdh, bdl, brfa;
+	u8 cr, bdh, bdl, brfa;
 	unsigned int sbr, uartclk, baud_raw;
 
 	cr = readb(sport->port.membase + UARTCR2);
@@ -2616,7 +2614,7 @@ static void __init
 lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
 			   int *parity, int *bits)
 {
-	unsigned long cr, bd;
+	u32 cr, bd;
 	unsigned int sbr, uartclk, baud_raw;
 
 	cr = lpuart32_read(&sport->port, UARTCTRL);
@@ -2822,7 +2820,7 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 {
 	struct uart_port *port = &sport->port;
 	void __iomem *global_addr;
-	unsigned long ctrl, bd;
+	u32 ctrl, bd;
 	unsigned int val = 0;
 	int ret;
 
@@ -3028,7 +3026,7 @@ static int lpuart_runtime_resume(struct device *dev)
 
 static void serial_lpuart_enable_wakeup(struct lpuart_port *sport, bool on)
 {
-	unsigned int val, baud;
+	u32 val, baud;
 
 	if (lpuart_is_32(sport)) {
 		val = lpuart32_read(&sport->port, UARTCTRL);
@@ -3093,7 +3091,7 @@ static int lpuart_suspend_noirq(struct device *dev)
 static int lpuart_resume_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	unsigned int val;
+	u32 val;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -3113,7 +3111,8 @@ static int lpuart_resume_noirq(struct device *dev)
 static int lpuart_suspend(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	unsigned long temp, flags;
+	u32 temp;
+	unsigned long flags;
 
 	uart_suspend_port(&lpuart_reg, &sport->port);
 
-- 
2.34.1

