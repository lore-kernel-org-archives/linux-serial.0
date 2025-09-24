Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BB221FCB;
	Wed, 24 Sep 2025 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683841; cv=fail; b=sIiFt+If/ya0D7X9dSkTHH9eFEqDBd9sV+nvH3OAM4AnyMVFBEI14VOFluWL0vNAdQ2LerwgaZfTku8UMcDQmF5pO7NNuwshOGfgkEVKgLf8B8Yxq8dQGWNxKCgZe6pW37VVKid65ndL/KWcUn/+5APDm354NIvsGO4aI4L3zbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683841; c=relaxed/simple;
	bh=akl8VDCevXmQgmEE7qqJ44dNZcfk1JnVKXGNlBp9WtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JdEFJ8+J9xQTWskfpImjP7+xHoN/Rh5zCAAgWn787CgLN6rxe9+uXeqihRRL3bBBmXp7x073HmlLB78mDD5tG7oNHXpeTrZrK2RSk1kuYht1ORP6X99Q3LmfjLxlV5DBphLYFee8QaJXe6cpUuopf8oklcp9xLUzn7XmmHa66Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RVjnK07J; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RVjnK07J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXBfq1FHCXoAfji6XuxZuooHahMbQlM2gbZ+tdixXyk67vCL73sRG1rR0+PWrsSXaXWzAsTPyqHw/BYTFuVDF0LyjGxdcUHGC5wD+SiHsKFyJoKXcXUF+1Ddmd/twhl7UyvnVnIFnbAd0VAOQRCPx77dzqKVcAIbJUEUs686j4DAsftxilWwBLAOyUOtDcR6w39w6IKH4bMnjjblLMr8p2hBva2xFM6KrbabjjDPvzgeNgzzy8LxwCLIRUGIHoN/HmUgMi7Tz5hMufXIgrv0ULcPLOrl0IhHBX1MsWswBxhCfzgCjuxcGL47/fvJIZIrDZe1tuInv/HfT8+j+jshzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GpgmkKqZ7ITvp568vfgxcqqq6LqT/oarRnTwHyIBYI=;
 b=GYZCUg8nMbYGvrRhExPKoBlXtrd/BAWmToLN9niPwLed3RIsIRyyEv0/oydbHFYOhCSZnSbVmp88SyH/gW3lehYVVA3VHapCLLR1HS5Nu68X2iN5LiJQnsp78lZIdxnQSLSeZAT17I3BzufomLAY21YjDTVqgEACTBoOmOUt8L6qXrmS7MxuPwG8Hqqw48i9qryo8VpTDzYNn3uOUT1ckJSmeST/cOIdTTdhk5lZqzaMXwK5gn1EBhpE1feavECLjVrPQPTMCLULmH9JwW7wao9KmVSgKY89EyDHuiiRbaRdgrRuwY0UABvKgrpc8E22Zc0zkW1nKs8PUlafgYygEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GpgmkKqZ7ITvp568vfgxcqqq6LqT/oarRnTwHyIBYI=;
 b=RVjnK07JrVmxLQGzX3DRs+5Z/NlokCu97cQhjK8P0tvu2CASi17cN+U5b7CVWFIHXcLwvmJGlDbVkE5atma/d7pCt0MQQdTvfeUC6RU7aN8pRKInynNhT0ZLi2e6tSm7imbsxbSjW33iN1xKCdDcmkBvYLVdG5IISHlxTaRmi5mOu8MStUa6a5Ctdi4s7mRADmtpa35PliGXiF6uMsqGLRJVzZf4JVzL3W1W9FfSR8GYmwgReagA6jiA6j0EG8RwvpQWBvZMf5hdebB3lMOOjL1+0KzqhkvPM/WPFRzW3gz9N7NivWor/CsczzO1wvy/kR+H1sZAnPBWAzOh3eYAiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 03:17:17 +0000
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f]) by AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 03:17:17 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shenwei.wang@nxp.com,
	peng.fan@nxp.com,
	frank.li@nxp.com
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH V2 1/2] tty: serial: imx: Only configure the wake register when device is set as wakeup source
Date: Wed, 24 Sep 2025 11:15:49 +0800
Message-Id: <20250924031550.2516704-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924031550.2516704-1-sherry.sun@nxp.com>
References: <20250924031550.2516704-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AS8PR04MB8418.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fa::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8418:EE_|PAXPR04MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: ac928cce-8229-4b8a-6d07-08ddfb18dd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9Ozla7b8FCLFzhHZqP89a9bwX7+Rcmlwz1y4uG522EqXeJVgaxHZeelJCXq?=
 =?us-ascii?Q?bEDycLiTLXODHTSX2f9RDPNlTFbJGkv4wt914FrJl8qYggrDjI3fZRGmbx8c?=
 =?us-ascii?Q?GGe/G8Qjy5rTXDJRmtDLiQ3ounTYhATIjatQGuPhzOQbZDaLRxzzMoxUmF2l?=
 =?us-ascii?Q?sqstSoDns4Hc6195aNBfWpsIcr+RmBDIYkpp5RN38BNKSgZthaBh1h7DxQWZ?=
 =?us-ascii?Q?ITwpfMuWs/zwuWst2dvhpdpQGFG7hkIeul/Pc91RgjRXs6TTEdVfz04dRypz?=
 =?us-ascii?Q?wrkU+k4OPaF78RTEhb6lcG78j11Y5wznY8VTjSuu01nA2Y7t3i2pr4jtwHSa?=
 =?us-ascii?Q?ldpd6LlNxRAflYp0Ymv1Wn/tv5xXh72M9cplUkpCxwS19dQyJ+t1s3A2hA8f?=
 =?us-ascii?Q?ZDL5wrb2YapeI+pSl2AQXwYZJ6ckVWVUe0hSP+QU0yGwV7JSigb3ELw+ivS3?=
 =?us-ascii?Q?Khx6YX8bZEhT8tnev7cbzHqFN80PlTA9YhFmJGMmdFjoG12efL3SdPtWjou3?=
 =?us-ascii?Q?tdndLq9haMUqtK4ai1z/mPUq7Y7320YB+AOOYOf9mh4VC592BQF5LM0URNpD?=
 =?us-ascii?Q?KnVXia7JZP6Pk1Dj/wTPIZM4B6D09RBAIpqVHxDbO9/z2Sw7mhIp0CUA2DUM?=
 =?us-ascii?Q?BS6V+/+2IXCGnv3oRJeKIMthNe8oW2utMAe2MlqQmtdXTt/QRzqlLDerUvhe?=
 =?us-ascii?Q?dzrD/to3hoeQwcJTgLAIZrAs+vHs1SRd2VgMQN9QJ02iIkBSrhMdCaXUGPDk?=
 =?us-ascii?Q?DWOcAfrhuolF+0ccn8ZLqD/L1ENol3pQlVjzw9QoDNAfevV2k4s6rrWbEXLW?=
 =?us-ascii?Q?spIRYeCrZb20GL8JhuEFHPQaq7ITAy1S55r+EJ/0vIFFbiQDv+aBgbRLgIn+?=
 =?us-ascii?Q?aVCGydao7FHJ31L4NL6kslP9+ulRDlwRP2+U6c6HYgZbo9IxqU6sIpku9gHG?=
 =?us-ascii?Q?LAsDj8Bky82ItGAdLxFTBVaZ8nyHcgGqKmvu6uEt8ASneCiPVGqMrcL6TECT?=
 =?us-ascii?Q?4aPf1TZ/IC0GMSBwOlswYla63Ju8nzT36yjGk6CJ5oUJ1c25ZenfgNCMiLWY?=
 =?us-ascii?Q?D+sO3Eu3SLCPCu+XelSVqp5wGbvucwky32s7/MLjwo8tKzNpVUVCDuWEiTEZ?=
 =?us-ascii?Q?s4CSsWPqZOphNFopHSxBIwdB+hwPYrlSYTibIFalJr2WW4ZT2ehuz1WtL9pA?=
 =?us-ascii?Q?QJ9uxiyfglmFXbiAeZDpvp7yGAB4SmgFdITIYp4G2YMcNN6oGNLieRj2xh1U?=
 =?us-ascii?Q?xz4EykV6vY6NFjrirY24AsvuKXpPeGdvx2oHsxXkWN9mPdhMudXt+SpaeAMQ?=
 =?us-ascii?Q?I+8ERV7jBV076WKdwCH0BpVR5pAy1q11K05P7A3uRHWRDrtwYYETGzVza0/2?=
 =?us-ascii?Q?7ldLObHDlhpU/3dyxh7FL/C4EL1iJ1zb6ByjAQNyp7m9tHZzzRdn4f9Vj0IK?=
 =?us-ascii?Q?eEmXbe7XHiZeJ3KL08CIfoxNv0UgV7FkEk7jqrkCeWWCu18JmDjP2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8418.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k0BE38rwqBWjlAmoZdRD5LG0ZywXA1ZhUIsnjpIcmujC5pFgrWI9AVQo4A8t?=
 =?us-ascii?Q?4Yn48tpz+IA3qPzuOZQ2hmJcDQCKtm/Cjg2ymbcj8ANIcNdruZr8LT2NqKYK?=
 =?us-ascii?Q?qoCXN+AZ6a9xFiXM9XH4tWEcVWiQdwvWPm8cLUdeyq5m+6poITpp2pq6cNGG?=
 =?us-ascii?Q?g6BJ2LYBuI1VQDhI+I1IlDAnh88yBiJC9muiIyFpeFV3+W8wGgpgOKK3n3xk?=
 =?us-ascii?Q?g0wJ3ncUz0jM+xIXL9FMzcfrTQ2fol3YGLWCXi1NvAc4okpwfCsBUvaXtNMf?=
 =?us-ascii?Q?+20B31U8IBgaxm1nUf8isyjqah7QQzla/h68+pw8U25M6Fp3fGwzCVui2Max?=
 =?us-ascii?Q?V0PFmMTChXz/yL3NT4yogptRV+ogxSc3WG+AJh5WWflDw26X75L9tXwKeSrL?=
 =?us-ascii?Q?TafGneK2fWxKGMk6qinR8XMYSrcljsxq5nTEu+GmnVmyH2Rt41ngWFkk7jht?=
 =?us-ascii?Q?VQW+SagB2tsK1vRTNcT8NXpL1Ebj63C+qCzLSDv9gUR4EVoSufo3jugpfWxj?=
 =?us-ascii?Q?7wSLNE65vv7MYRHg2+EYcEX2jcjBnKQuwliOgn8JF7mREk6UUbiKcxrr1VkA?=
 =?us-ascii?Q?gDK/1dXbk1JzgRnhZiWd3qriYspoY6ioLBqE+a/wNsX0PLGtnrlIK3QtN29j?=
 =?us-ascii?Q?KrmbLS/c5XeGpSu+I8ci6f8dMbr2lou5hkneo2BDYfsmR+44Ej9C1gco6Xof?=
 =?us-ascii?Q?rqDEN0yU7hVq0Za/Xmyhkpphkj755STq92wgnQ0W4rJBwFRCbfB13E94sGih?=
 =?us-ascii?Q?9pQLo16ypgyaqdcfFT7yyGOweiZWI6Eh8T22mP57Hqf2I6QsTAEC+7Eom9Ej?=
 =?us-ascii?Q?CY6QFSCmXj4vzNnrwps0Y6AuR0WrZPK16fcyIcM7piaMCel5vyTUf7ahRd4n?=
 =?us-ascii?Q?3CWbTDrQvuFnRgeaujiFOCA7puBOZ3+Wu25DjXFlWJuaxOIeDjDG5752vp18?=
 =?us-ascii?Q?cx9p7DH/HK4ATdlN4kKEIbjtusamAH5OvSFjKpT9ud59BfvjzFNRsO2vMKaa?=
 =?us-ascii?Q?Ox8zQnR2fPYHY9lb8ajHx6No/AScuxTVvTY2hL576IWFOcIYksSxSByEB9uL?=
 =?us-ascii?Q?fpYdt8R2yUYIjVQ71F96xzQXWKttK/I7EBAETD/eAqn9A65/i5FPjrmsloZh?=
 =?us-ascii?Q?9kZlJBZl65JBykG7n7FGiTJeRiz9I5cXutjIg5xvJBjndXXZBxNdmU4uFlQf?=
 =?us-ascii?Q?1n2LqmNYSIhO2MnYOTXRHvfjoszs8qDyJZ7n0Vj3AFRE4Z/qfjfpfMn5vZqP?=
 =?us-ascii?Q?H/L5ewZH2ZYL8eJAn0Aa4F0SckTjuA0eYa1e8O3/ZLHknctuJXQGvYYdPgu/?=
 =?us-ascii?Q?3wQ0nsl2gdZxtsFlgotWPGAn9586E7VmC8Bm9i/xhNODuhA/3kBqFLXbZjJQ?=
 =?us-ascii?Q?bWRBaP4tkkkehoqOF03DjX56oruBjTe1xuMTD9LDvnvB0RyHE5J5SQkkUArI?=
 =?us-ascii?Q?obodCvfuK69v0OjKKBs42BYitck7UYZQkq3xNZ0ndvr0uuzL6Ey7vVlkCVLq?=
 =?us-ascii?Q?RcKQJ4UDm0KPTtu/ZVy4mjYC+ClUWEDkDbYYdDPJz3zPCyPHcxIUvgisDYp7?=
 =?us-ascii?Q?whwD+OInezTjzyjsciDKSM0FGwwR+J6qADZ4y0GA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac928cce-8229-4b8a-6d07-08ddfb18dd5f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8418.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 03:17:17.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4TPYGYcaCPd+qld6uJx2wacyVGdZG8vxCrKI7A9cuK9hu8+f6hC3ErN/+5QbwtNDEVoTKs10m2iRLPVLwAaqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767

Currently, the i.MX UART driver enables wake-related registers for all
UART devices by default. However, this is unnecessary for devices that
are not configured as wakeup sources. To address this, add a
device_may_wakeup() check before configuring the UART wake-related
registers.

Fixes: db1a9b55004c ("tty: serial: imx: Allow UART to be a source for wakeup")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/imx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 500dfc009d03..87d841c0b22f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2697,8 +2697,23 @@ static void imx_uart_save_context(struct imx_port *sport)
 /* called with irq off */
 static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 {
+	struct tty_port *port = &sport->port.state->port;
+	struct tty_struct *tty;
+	struct device *tty_dev;
+	bool may_wake = false;
 	u32 ucr3;
 
+	tty = tty_port_tty_get(port);
+	if (tty) {
+		tty_dev = tty->dev;
+		may_wake = tty_dev && device_may_wakeup(tty_dev);
+		tty_kref_put(tty);
+	}
+
+	/* only configure the wake register when device set as wakeup source */
+	if (!may_wake)
+		return;
+
 	uart_port_lock_irq(&sport->port);
 
 	ucr3 = imx_uart_readl(sport, UCR3);
-- 
2.34.1

