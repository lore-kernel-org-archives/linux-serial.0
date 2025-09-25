Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F902EC0AF;
	Thu, 25 Sep 2025 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791586; cv=fail; b=Lr70m/JyYhVsQGoe2m/Pl9w03rq7HZhP3r5u/2N3EmGj+BybNQUga1XF227ouMtfypONK4cRbXz+agKfC7MmgJlXvT1c0+KIrTz5/0V/7HhS2QvIgIm94ArYs94r6VePUeXE9bVze/SRv18CXgRFBG/o+EVVBGOPyc3CJYRcK+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791586; c=relaxed/simple;
	bh=XBM3CUY1qJXBCleCNR6UhrOudMBQ6hKCSVJfr9vWshU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nLx3LQB+ooKaVGDRD5jzRvOeui5wvfqmKVjKqdmroXdOEQSEPO0OnVBmte0okMk3G7pbK2CH68OH4NxQ82kA9kssKzULgn2QWVLWRaM4z5vrZlRNToax7+ZzmXZHNtI4k5QSXxNnIXOj9sN0rqj4oFokZeb0wAQKIBU2BrEAl3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bl/6cksx; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bl/6cksx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ut4r3FBQyExmkI+1nRrwlEXmQNCyJRgcVuZqk88xs29ZLK0H6LTIGAznHWpDExbmlNgz5HzrS5APmbsLgyxmv4HViEdu6C3GB00dlJ4qb05jcQCyajPzcND22t51/fDxBasaT480PYC0TzV5RpyCWcC9Q9Wi5iCmVJ65lIzkWfwD/BgsE8oAylMpg804V/Kzfo8gFf7VLbmgMyS/2rEFXY1aO/r/OHUIXfgyug/kma81AXN46/Q+OP6J5ME9DpvYgzMHDgSIr4ghflTMXMg/D2T7v67l8HaPp8iYyxWtUnlsb5lSQG1YxBhqdTackn2ZjdGgbKw2xUEwr0Kf75Lzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXuDmkPkt9wnCtKeGivpwD5KKcBU3SPAJeCbsr21qlU=;
 b=ULoP3C23sKtrEyJsqDNzdaO2n6qaILx9WtFRNuC88ZEr1h+06jSRonRauV9inQj1NXO7IZAQoM47ZuijypYyj25wENhmqfDcUjkLEMhwqOMmled4zwxsjO7XXjLMMnnImojCzCAFaG5veJnKLJI6zTOOAAkQUbwfRMys/DY/KnPPhN2stpJ7VbBKFNnAyLohyG4G8IjOBO+RjjuyKQ9RtQlXI1V+iLKPpBLlCXJ8kioe3gem6C0Ck1aRLYWEnCSmIVEltTfli7ZQsMXM64y8+QyPUk3xwXHViq+7YlGIYbkFv6AhJuzENRbhYM/U1Ut5coZHLSom+4v8aos1jkf+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXuDmkPkt9wnCtKeGivpwD5KKcBU3SPAJeCbsr21qlU=;
 b=Bl/6cksxxllEgkbVjBUQy9XgDCKMZ0zxNFCXW8Zcsuo7KMQ5jfWo00bJmYX6245lU1r3h37bMGp4Ow5a/KNJd1N3KmJqgC9IZz6VpYXqgeFuvsHStDIumxKc/l7TCVs7Wqs4orfKemRJN8HFrYfBN4x9Y6ISoMNUj38xbmX7LFEqhbTxfmcfVCFrefYKt4DjR2r9zaL923e9Rw41nu/nC1FgWGMt5TtM2Lk+1QQIMZJJn0W2vaSVOMLRB7ygd++ly9qce8rXjIMXEeSCNRF+GPh0oH7DRiQi3gYF/nSXqzoXqqSorXFiV8zr0MyqOOBujPN/tJg8VEMju67VFnyo9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB8610.eurprd04.prod.outlook.com (2603:10a6:20b:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 09:13:01 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 09:13:01 +0000
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
Subject: [PATCH V3 2/2] tty: serial: imx: Add missing wakeup event reporting
Date: Thu, 25 Sep 2025 17:11:32 +0800
Message-Id: <20250925091132.2537430-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925091132.2537430-1-sherry.sun@nxp.com>
References: <20250925091132.2537430-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|AS8PR04MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b6377e-bfdf-40be-bca0-08ddfc13ba48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gFcMJXb2d7FxgE7KDRJoTmmkKmfAMh3HCjN3lXkXcprCSTJTKsA1gT34glD7?=
 =?us-ascii?Q?aYyyomOMw/B0yta6Xe6XOB/XEqJydYVUkY+PRLCSxuZyEgHlnDEZwlgkn3up?=
 =?us-ascii?Q?Eosd4TTXG154jZLBohH7VhUklSplorgNiJq534ptBSV/qDI+MKGgShUCLboZ?=
 =?us-ascii?Q?UgLw6yoOFjdY2JAhEiwRaDkw7RbyTJY4Uc9/kWHGEKCotSSWb19l4ijfoI2i?=
 =?us-ascii?Q?6lUOt4gKn1ApBWGuRsL1gQMLAfd3Y9l/t/Uv3BpJ2nOpO2PhP02t1sJdAxzl?=
 =?us-ascii?Q?MaLI4nf+z/f8sjLtof5aQhBHD60kgA9mt8NoQkwvhsRDFOLg/4zpDj6dTDgO?=
 =?us-ascii?Q?zv19KdyKHm6vgXfWDjoz7cxDWGYAhGmSdq+K0pAiKa5fIoXSIAeo+WTNeSYQ?=
 =?us-ascii?Q?IGopMA+XtKlslaqN3LHZTkQLpryhNGyWNkX48ypT047r2ZsQg/oRrKt+7pgp?=
 =?us-ascii?Q?5iZf1DHtLMV22ZLJsMadg5ampYcs/i1n4dTSOWwusgKcsS+qaMzV/O2ONwx1?=
 =?us-ascii?Q?7b3yJsMTP9kUN0p7nhXrXmxAOue4jQSyB587EsHqmZAcO81o8pDeAmVwZwQ2?=
 =?us-ascii?Q?tf/vnX6tQaHHrGlHILqcqo9Cu0Ewsezga5DMcPp9rKP5MLyaSdLMeaE0fnxM?=
 =?us-ascii?Q?cZJfzOZvEbZ3HzNzp/7RDHsS4XKvVGe6J7BSbol2qwcZwJOvB6AGgJCxYfrf?=
 =?us-ascii?Q?U4aNRsbmIW6pDQxi/CY43KdZKIyR7tyL+wjeR0NOLHMtPUvU/UgMrPaXHtj8?=
 =?us-ascii?Q?E0bmEKXNE5j0Pq0aD7fJVvP6CGL9kYRmDcJIkeAuYSU8sH3SrzjDqqpcUaqZ?=
 =?us-ascii?Q?q/bkjG/jA+9Jjbaz4Xc7eJaNduNCHK8khyGBisv4ettIkFKbU5DX5zywT4DM?=
 =?us-ascii?Q?jtvrC1OM77Ec93En2O4mjMAnuOy3Ws5FelIJlMd3VKUanE7jChN//7w9VArC?=
 =?us-ascii?Q?DKat8f7YQouRtrO78aguZlsJt5w44ppllVfRr9TZsD0OCCSC3Qwz19VVoQzU?=
 =?us-ascii?Q?g1NI7Phv87/fCJ02a+fhp5HKWw4eWfiXjIZhN99VmK/yphipxJ81l8w/ztfa?=
 =?us-ascii?Q?d09/3Pk38bIyYthJMs1w5hZ/VijGfRmxqU0TL1o6vO45xRPz9TTItKPnHa0q?=
 =?us-ascii?Q?n6fEss6HZLHUPya8yBflg9eREqSxx3A4TCXJVBP/N1LaNM+76+OLVfXshAV/?=
 =?us-ascii?Q?MeJJywSiQHI/MtaylRagBp824r8YrhLFFhHQDjNKUeN4QwMK4WxjJaAMG9tD?=
 =?us-ascii?Q?DPSx0aCx92QR79kM3eCJ19nHMYTwKAK4X4t26RM0qcVwD6arS7LTBz2i5A9c?=
 =?us-ascii?Q?VhUeM/cvC+8V8EFm9Oo+STrHz0dtVySr31IPeLL8Ftoi1Xw+Hro2MxSQhsfx?=
 =?us-ascii?Q?BeO6N1+uq++LJ7iXCFTJVJ+ND2ojh3D5VzTdqIZ0Mr+66H9dYCuGNMlDeKgB?=
 =?us-ascii?Q?D6ClYLwukr/l4WWIBcq6LrG0jRnqFZJZHKP7MEdlPTZwnQ6UIdVrAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?94Azy/I7eCtUfxhiFqg2n20v45vkujDClr/h40kaYGYtQbwEOF0kfW6pCx1j?=
 =?us-ascii?Q?hKSQs3dqRRiUeHMJKwPmyNqVyvq84i3dBlUsajpZcJXGQU9kFugK7CGwTsN4?=
 =?us-ascii?Q?o6ToMs3q1+Rzp9mU8UrLjCoOUVhSi59AvkSfChpM74k255wcrxiDrCN9qA1e?=
 =?us-ascii?Q?lhGd4ouRCvacTAsjtBL0D3Nm3BuG9AvbUvGYyKpMiyhRK0ydQ2MHf/gkzSPG?=
 =?us-ascii?Q?u/IZadNdwYSxhoLkVLlVV1PLLKI83EZfqnIOH4lgCPqu3cFow/JBFpaPuvlN?=
 =?us-ascii?Q?f0douVPoyoPzGgyYvs+l2D2G9Oze6q6QViPZHEjsPP/Y/QYKRPMA22+WlJg1?=
 =?us-ascii?Q?Dpp9L5dKWLCqdvgb6Pej5hvMqm3zEERCe4XNggu3hAIxGUulCdy7U9IJR8eg?=
 =?us-ascii?Q?v6E0IPWkBMJ2t+lUuVOe7If2g9dwbzgvfgVJo2JmqmR+nYnEfnB6hk/nXFIi?=
 =?us-ascii?Q?MngxIA7ZdcxIoKNVDCDBAlf0I8gGaDFOz4t+YYL/KuqggKdKOowROE3z2luh?=
 =?us-ascii?Q?xtWJ7iXjmTj2InhGxZ4FKZbkkIaFvJ7xP+PZ48pNm0/jtjhVKtWQ/NjqLtvE?=
 =?us-ascii?Q?MZypsJbgQWvwIHshSNf+hmfm71rfbKrv1lAg8/NTMLD40nONJQBN4Cv3V2yQ?=
 =?us-ascii?Q?iy51BtYO9Sr6WsB45YbDoC4f3yBKSmhiAhVKp5SsC016yQt8norIGA7dDncg?=
 =?us-ascii?Q?yQH+B/lk/resMexmsxDzEaDWwdol2KIhiGUw1WB7K7atEzFO3NTMWVlRz1Hr?=
 =?us-ascii?Q?8IGM8EOrz0vcSXWL/Q8pV8/sBuEhuro3E+V1PpVB17WZ2dZA38rAMl5ZVLHf?=
 =?us-ascii?Q?yxw7StW+7Ro4jRhuaFnIxByuexguIDwv1cKTlD3H2Ykcx9U1k3b0nv4WVWQ9?=
 =?us-ascii?Q?WeZxh0tMDH0+BWtyePfcyhhGFkLHXBQyL191lLXnI2HXewjYLailDCfeLIPU?=
 =?us-ascii?Q?J7rrvLKnqKKHUaXN7mrpOrHOlYdqX1OywSB883HTTnGQqwQeJ+H9xT4YhrdI?=
 =?us-ascii?Q?ZXP8hjhDmbEkdvRuCPag750cv6gboU+AMIbjYoRCoNhPWZ/rLOc+rLmIGTLT?=
 =?us-ascii?Q?2LT2PLLqnyS31AP2kBCtJkcqNSRT8N6affQ8N5bZYPJ5mi5jOKr+HEtOtXdl?=
 =?us-ascii?Q?9oLT/FxPXG1RTD9IdHjkyJy7ISVQKcst2niDiKilSRvJD9qRtdllnNmPmyQW?=
 =?us-ascii?Q?UbZ7SkXB1xqXuxBadxCWyc3uXJsNNgjwgDgRc2Uh1laqmENu+lBBk5bahvwl?=
 =?us-ascii?Q?PwQ3HQCjoJHVIzDwLX6bN9wX70fk912cG4pYNq8PkcyLJDgVtw8esFvr4v17?=
 =?us-ascii?Q?04t8qoUY//DZzWAJ1aeg27S/pBn/fJNBfa6IuJ5zR7rLgZ9SzUrfcIuTmWLC?=
 =?us-ascii?Q?Nk8BdfmylVbWufaOKbiDh/1La1f9pGP58/iJ+xrPeaKfJYzEREWb1ADFHj3k?=
 =?us-ascii?Q?IVBl7fcFfRX08swu9gm18mO5Tc1JgDsrebW0vNQyqZ/JBHzh70We3VSk0HRI?=
 =?us-ascii?Q?sObF9pFklkHeVr/BuqmQphJRTncNfO5MgzUP6gaIVAnZBqJbLnW+KJOQdT+7?=
 =?us-ascii?Q?YG8sg4Pappf8RyK2xTrdde+u/zjxkpKqSflBeebY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b6377e-bfdf-40be-bca0-08ddfc13ba48
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:13:01.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaDBYpST9HSbyuP8TBkcs1yV8kxlifVxKgY0FtfmgzH5cGr1ptHSMm5oSHnmaVxhuN7piZve7n6WlW+v0S5mJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8610

Current imx uart wakeup event would not report itself as wakeup source
through sysfs. Add pm_wakeup_event() to support it.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/imx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 87d841c0b22f..0eb3f5b8f820 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -30,7 +30,7 @@
 #include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 
-#include <asm/irq.h>
+#include <linux/irq.h>
 #include <linux/dma/imx-dma.h>
 
 #include "serial_mctrl_gpio.h"
@@ -2700,8 +2700,8 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 	struct tty_port *port = &sport->port.state->port;
 	struct tty_struct *tty;
 	struct device *tty_dev;
-	bool may_wake = false;
-	u32 ucr3;
+	bool may_wake = false, wake_active = false;
+	u32 ucr3, usr1;
 
 	tty = tty_port_tty_get(port);
 	if (tty) {
@@ -2716,12 +2716,14 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 
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
 
@@ -2732,10 +2734,14 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 			ucr1 |= UCR1_RTSDEN;
 		} else {
 			ucr1 &= ~UCR1_RTSDEN;
+			wake_active |= !!(usr1 & USR1_RTSD);
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

