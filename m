Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70172DC768;
	Thu,  2 Oct 2025 04:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759380899; cv=fail; b=VYM7qq76esUvm1ufYCx5/DSdfkvL5jEERCqV6DfVRof5lpRtKbsF4gMSun6QDTZW1AaWJiT6RvPmBX6wA8c+z+ltrrtzGJbJJ7kDa/m81OnB6+kXcsR2HfAfYYrp+1y6svKJmKtdaeOUPHWvCdlRPE4tPJdmUhcXHEyEZCnkRdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759380899; c=relaxed/simple;
	bh=B1Wtey0C+vfkLTdLpNfezmvesSle4Zqy1f1Akt//YRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiW2Wi4r9IGh06SvheMNGO4m8B+fJ+AHrxt4eq7U1XarAHl0RDvs+3ZOctRvDO3aFShHXO8L1CLti/i7GFZIHlVkQSV/oCqDRF7Rk86RiYVjF0rzL/WYrTHBIJIrdaKCJXSo4tf62bzs9g+Hv/WW5ScG2FLKir8GePd8bn100A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AUz6lEFS; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AUz6lEFS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsyvmiKu2ocHijqh0i7ogNEPQtAU63pMHexmNOu+plEzkNh7JL826SCh4T2+MewqkplunQZHCc0q3O9J/rt+8YcPv1go8j/dsqbLhs5YIrt3jcZY8L5nZH4apYHXOdYOdzqViUUKF3ugfJHmZ7CzxLLM1KhLzsFzZ5qYwENmFzt12MHNmxVFKSTfPGBMU4JFTCFnmJnWXsiw0QZnIYKG2gV7sWum1hwTbo+FinRKZh8rTnWKWHLMNhUunIEOllQ3YyZ9Q4B+ZqrKO2nRIMhYjfHhYg0lRkYy5iLYOCq33D8N6Ju6aNxC10us8WE2mwauxK6dx/wQrebeVxuVbIKZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JArqXFFFf4fnOLGyBVMVk6FPqOeiRUrSibarxMOUPIc=;
 b=FE1YTKPwl6scCPSD2WEGnzm9LxKxLg12iIHEmSeFHL2oNiERBEzKtmHWIF0qyrgibv3hIHbS4u6IfpA3sxL8CDmyd2a8iK2WzAyITkMvso2p/qM8Xqt9B7+84TS5Pbl1Buo6boP4jr1mPDgi1cX99AJRFl+AT0wJ97rJEih5HJ+w9MrDS8fH/APsTibLtjgVlP+6yqy4L+aiQ4XZIJhLQZsYw3vt2dKpBngrdg8c9OKup4Nu2y0jXhizzMuzEEdJzwFknhEtOEM+4mX1DxE7DVQcbZwQQbF87nIapPQ58YuBhZlq8Sn4F2XTwhV/YZKpFJHDb1SjPHzncXc5EfBSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JArqXFFFf4fnOLGyBVMVk6FPqOeiRUrSibarxMOUPIc=;
 b=AUz6lEFSc+TVRnSO1T8oOzTM1X1NABfox2QN4WGwnEzz5QiUlwLCBuQd5f+0nVE+WSDwaSe8wCImJhNjmIk0Rzy2yJlmbbxCxkkR9RalNa1zCAaUKV4veM2HeHkHFPgeGGwXJzaCDsNbgzWwHNZD+g24AtqyoCUjCak1+HPYMwxLf9jYOzholQu8kMKXr5X/bTPiPIsbEaERk34IFhtFw/XNZhn8iG0nYFfE3MYd7yxb0oHZEAmCPMmS5UYTZGTi3JCRnshq4FwPuBP4FmsDH3YwciKMqavJXoooa3OAAK5Icd/TEAZjWKXTjAstXDGlFZ+L5nY2CSeNyH/NBN28aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Thu, 2 Oct
 2025 04:54:53 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9182.015; Thu, 2 Oct 2025
 04:54:53 +0000
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
Subject: [PATCH V4 2/2] tty: serial: imx: Add missing wakeup event reporting
Date: Thu,  2 Oct 2025 12:52:59 +0800
Message-Id: <20251002045259.2725461-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002045259.2725461-1-sherry.sun@nxp.com>
References: <20251002045259.2725461-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|AS8PR04MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8fb37b-ee3a-4069-0685-08de016fd348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ulv3awX0KNA0VjJWsPmxxqey0EcIV+wjhAIefKruYv/KVs8RwKF+R1H0tp5?=
 =?us-ascii?Q?x7x7S62moEPAyVq7GtsPmE/EjqkG/grbCxl6E9+m4Ya+IV740vMr+sRRuR1r?=
 =?us-ascii?Q?Jx3TkOom646CQoRqZLdwFUth3CgKCS4D8DGWjVLeZ4J0hdBRgU7ZJiiaan7g?=
 =?us-ascii?Q?VnU2s2Lo3RyqCKoVR+yAg3qDXDiK4Wc2dR5eWpgt9HycI+LlRzBZBKa/VeNq?=
 =?us-ascii?Q?3wV+NNcP7ioNN2k5H88neJi9JggGbiGRNbvwgVYMpysrigF6DQ7tHWi68tSG?=
 =?us-ascii?Q?l1FGbzg8zrQ0CuNOTDsHijJR9Fs6OvJ/uRLA8ukmN3HR1oMXuK/+HrBJp4Ka?=
 =?us-ascii?Q?sHFINF0HlRqPf02o3VLIbUzFCjnRO0R/hO5xNNSxanMnQv1nh40Yxzs1Ws7s?=
 =?us-ascii?Q?kI++O/D2XHkBXJpaWca+tL9ru9NmcUZjAiHRZCy++rvZ1K8HLOZ/sWvD2tvg?=
 =?us-ascii?Q?zAW7i2a0uPmKCWpPdR6a1BnzOTwNmFKNUjqgU0xKbuCqYY0EsrqXvfSHZuJ8?=
 =?us-ascii?Q?4hzb36P9kyrlh9n9Ohx8bL4chGHoGggOaoIdk7GCMR+rjryHu1ConAUWyqif?=
 =?us-ascii?Q?XldjUBehdwiSAFzX4WzUUQPp8PL7gZ5O7A9ikx2oRC4/BR9kZxqXQSWph3BI?=
 =?us-ascii?Q?liDtwVPZ7ZWdMK/BbZVGEf6PwuQwAescWG2uFLfqXQtgg01JYdIo+nQuAqcq?=
 =?us-ascii?Q?9VaGNMiLchuNFDFknP87DHsOk9ldQENZ0fe2ApHXZ5RKHtjtJgMmfWhAn7yi?=
 =?us-ascii?Q?+JQySaxfC7nkk7c3fM/iB5XjvuCEbiRDow6E+VKPn2R6AvW+qibmnzjaXXUh?=
 =?us-ascii?Q?WP6DL3DyXT5w9OPS6wBpJbO+yRhIfxWYvd68qMVgQ7iTPpSF7QmYxaqSyXkJ?=
 =?us-ascii?Q?1ZJf1noX/4QJGyiJgRYPsMLnXbtpzmqkw3VnNYnJrFMvWpopqsEXRArqpldo?=
 =?us-ascii?Q?4Dg0jPERjmY5WwqkNBd58h2TDkRg3xTW9oK13x8/H/F2ygZrvXqQoM8qkjig?=
 =?us-ascii?Q?nOrBedVkI2ACpFGa2CG4PLuOFI8/CIf1yPQIUv7HzkIfnckpnILyD9oY4n3k?=
 =?us-ascii?Q?8Dp9PPOxGrBD4OxOfdb9I3oZEbWyQTAp7b2kQiKNF0ZYzRIfJsT8gORH5nOg?=
 =?us-ascii?Q?sDjFS56V0xyuYQ+pdJU9iuZFQ8NJe8NdboNZn5phjlSqPlvkvDsNOaMV8rOM?=
 =?us-ascii?Q?wdhZ+E8S+BU0EnhnjUKITXKmIC5W8FaGycYCAOD5Z87JR1bl+xY6wKs84IXq?=
 =?us-ascii?Q?3Hw2nYt949pGn0TFDa2L8Z2ZTQKFV1j/6spIexzHqnJKu8SkGZYpLBVLk6jR?=
 =?us-ascii?Q?O93AYx9I5HL5MQKl1SI9WtoozCUqWtEQwHEA3NTgyBfmA9gubbURc0fFbmGA?=
 =?us-ascii?Q?hfnMctTqKRWteudQ8gfDDtOjxDqgqY4jWh3CcGwnTH4e5zwpddDkp/JdUuqx?=
 =?us-ascii?Q?ohkDrwbu4WkpCu2bi+gDi5Kg3621D434ZVDHZU2SXfoBD9nWU3xp/JFuT9/o?=
 =?us-ascii?Q?WiXJXhWb2uozbJ9LeC8/z2MIcTA+oZhQjiQA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lAVX8CGK9j1/w7RVtDkJ69FBLb+FXnE1xuE86Mj+j770zMbHuRKLlwsteVAi?=
 =?us-ascii?Q?g+2PtolhNXs9N2f6qDUV87xtUGuNIXiVRz2BswZayYBSozl4m0nj6jUJaEh9?=
 =?us-ascii?Q?5wzGKHOZ8ViNtnozfPD6cTBVH9MjiR7HgbMoNLj0QpBayIDraX5WXbO/q3sI?=
 =?us-ascii?Q?e+rfzy1pq4P2CW8cG3vIeMQ1jSzDugcCPxlF0nfM3q3HMiM4KT5itMJIDGG+?=
 =?us-ascii?Q?RgqgOyXcYukSK8BWQ4NfONyz7zeWCy6v79KHEl9/nZLBc9NDuv9rqZH7Tbx9?=
 =?us-ascii?Q?NTPRXsrLbdHDwi3BZZCQyFMSXuFEYcSSIWkE8XpPheoz+JmqF6arUAleNEId?=
 =?us-ascii?Q?KHySE2ob8zl6Th0npw0AybC4WAE1CQDAlskEKGlqA/sg/PQ1NflFYo+Cnt3F?=
 =?us-ascii?Q?9Dbrm8kkJC9w/Aqqlz9uEhPnoph18bNED+/83xKFPBp+ht0c+qGmowf+PWsP?=
 =?us-ascii?Q?WYWL6slqjVWw+0LruOuYLlVR2Guzfugp+R+Mf5pF31I+kptUqfNMTAtLmRJs?=
 =?us-ascii?Q?ZBgG6emRMZ7lypcxdRjcoklpHkgvKlDoX4vuZrTIvQQUvjOt2FoGDwq9I0s1?=
 =?us-ascii?Q?5pCsgQQYJTRzUSkb/wf/QhjQRvxBvKQ3EleK1qqTnKUS4AmO7fLGEriqLF3E?=
 =?us-ascii?Q?SSV+fiFYuhuAhOl9CJYHDKnRyJzyK0xniBLWbvwj7br3ZleKNAHDQq/A01rA?=
 =?us-ascii?Q?cV+UF7+vOkz/566pMx1UHQUbuPsXK1k2xvjHnqsRED4/ydd/1E2F9qQm1t3t?=
 =?us-ascii?Q?jkwKnPrITTK3B+BTqYT2atVcCx2sPzVNqULfW8tiR+aEvHdAMT3QZf82FfkL?=
 =?us-ascii?Q?e2arnw/dAK4qRVSLmtxYItvEgQVgB7KaOqmVKLfp3t2/tIFg78DemtNhc3eH?=
 =?us-ascii?Q?2fHyjCqaXOg94W0ValfQLwb96v2j0deON1ghJ3qYg9WQTvrmRm2TpSh8wH+Q?=
 =?us-ascii?Q?mPjNa6Cz+z3XEO6gwZyttWhBbdeRvpDJNrB7rRy9M38GEJYGnmjUwvDzQecd?=
 =?us-ascii?Q?HbwFKKk8RKC+kx2vys3HdpKmagd6B3us/PeaDmnv7nxKU9eFsIeBbTj/tVNg?=
 =?us-ascii?Q?rDKgMQnAtI6AxDKuohu3MFjRqPg9ORit1lLBp/3ZzzZKJn2KZ/jbmT7NOwm5?=
 =?us-ascii?Q?+RlVNTJ4BLBFebnzjuHeTh/OoOgNRBig6tquVvfeRVVreNYJ7SVjIYdRXteH?=
 =?us-ascii?Q?AeELPJ/WKt6hZ4D+xZ4xo3JJNxt2D5kOJz5rqNRjTe/oxjKyMx8bgyCfZxO7?=
 =?us-ascii?Q?+ncLTUMw2Jd/Eay0Lxq0JnRlLamWqY/7ApesyUbsjxxq3s0TFabWW6k2Qshn?=
 =?us-ascii?Q?3+O4T27r/xIHGuFOlro1i5aEWYYDYtjyokQ71exrRMcpzflq3yu0s++Drt2Y?=
 =?us-ascii?Q?4OQHaEIWiB1yZCT6RJDU2GygF/TcB5fksTpCevs/aviSDUOV62+NMeQq/tIQ?=
 =?us-ascii?Q?4i0070FppdLNYLW7ls0P076gQtQzEx0Fg0Omm6tKnwYzpsZmOQsYxOo5rRBA?=
 =?us-ascii?Q?E797YjOiBJ2vFga2O7E4w1BVOuJpWFgPErqk71kPovgi369p1JjgNdPUg4Rf?=
 =?us-ascii?Q?L5bV02E+ctCeMEOOqPUUSr7OnYe4jY96GQz+KZA/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8fb37b-ee3a-4069-0685-08de016fd348
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 04:54:53.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ihxq0nROGA46vbiNV/t5sPkqE+S7xnDn8wiSIxAEv/6SdQ/2/Wf7qTHZCzZZpAri9+GC+a0ER+9W31Td3+T/ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818

Current imx uart wakeup event would not report itself as wakeup source
through sysfs. Add pm_wakeup_event() to support it.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/imx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 90e2ea1e8afe..c488e5d372ff 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -30,7 +30,7 @@
 #include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 
-#include <asm/irq.h>
+#include <linux/irq.h>
 #include <linux/dma/imx-dma.h>
 
 #include "serial_mctrl_gpio.h"
@@ -2699,8 +2699,8 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 {
 	struct tty_port *port = &sport->port.state->port;
 	struct device *tty_dev;
-	bool may_wake = false;
-	u32 ucr3;
+	bool may_wake = false, wake_active = false;
+	u32 ucr3, usr1;
 
 	scoped_guard(tty_port_tty, port) {
 		struct tty_struct *tty = scoped_tty();
@@ -2715,12 +2715,14 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 
 	uart_port_lock_irq(&sport->port);
 
+	usr1 = imx_uart_readl(sport, USR1);
 	ucr3 = imx_uart_readl(sport, UCR3);
 	if (on) {
 		imx_uart_writel(sport, USR1_AWAKE, USR1);
 		ucr3 |= UCR3_AWAKEN;
 	} else {
 		ucr3 &= ~UCR3_AWAKEN;
+		wake_active = usr1 & USR1_AWAKE;
 	}
 	imx_uart_writel(sport, ucr3, UCR3);
 
@@ -2731,10 +2733,14 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 			ucr1 |= UCR1_RTSDEN;
 		} else {
 			ucr1 &= ~UCR1_RTSDEN;
+			wake_active = wake_active || (usr1 & USR1_RTSD);
 		}
 		imx_uart_writel(sport, ucr1, UCR1);
 	}
 
+	if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
+		pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
+
 	uart_port_unlock_irq(&sport->port);
 }
 
-- 
2.34.1

