Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB2236A70;
	Tue, 23 Sep 2025 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597460; cv=fail; b=AD7VCIQJxiKJeABu17SN685uz8DYr1xVH0QoNtXmF1Mti5S7Olqtp3Xx78bS9HwctQ8GhQShV6qmP8gQ5MGfBY4dxU9BWQvCDl0z2f/P9jsoQqFqHaOsq+2m5dDrWDbx7l7GNssYMYIcL56E7BVcEY5fzEc3buvQMMVe1vDx1Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597460; c=relaxed/simple;
	bh=Bytcqw6ilybzJE0J6PlO+uu9nXoyy0ZN7RX8moU3044=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U727rYTH24slFafYtvcXSOdgLh8xR+k/O9gk/hm4+YBNlPT8enL3EFnncTnUzoo1HJpYzVng9EeQ8leqbMN7X/MZFC0BVKQF5siZz3f+7imM32D4hlF9sB1niGpNzQ4vJx8zldOGvq6m2aNLtyxT9a0GtvtvB5lBYVlNyqqYqd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mIiaehC3; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mIiaehC3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8uVb4+HqciYJfodvXZV336Vd3g8HLyQNApMoQEkZyI5ZyMQvJ1+hEdvUf/WtJIyRq7F6dr6Tp67kVzcN1vYcEkB3N+6/KmrRsyiekODi38GYSHik6zrk57ynY6j7kGDNetkdG5TMkAS8Q9R5GlT0ww1zqPRub3QV6oplmuOcXElr/wWrq8PjLECzzpBbJtd6cirfK8Z3xchi7RA6BX14azq3k0t2bkmJCmP7xExPQaXLIxsIkAO7dF7K7bz1QHmjONnG+8QoDW5HC+ls3LIrcHQiT5DWevOfu67FW6b7NdSR2l58yIeQvgY7pmw83O1NA05hHl6asiBR7yEYNfNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+N4CYJd2x3Ee1X1+EqfKnyXpho0el3tOskLjvG3/Xg=;
 b=EhaNjcUjFUXUGkyCB7XuStG70kAqwmecA7S8fAbT+0i2ntcU7zoS/X0tShf3RYkQBCHJWYIjZxphQXQwsUsh+bM9u+iWnjFIyz4TlwW3RmgRQfX/Yd+PCFKVyW8M4mO5E6ghpft/GL1vync6OmKFFBoIlmc0bUWHMQTYMzDlS2WoULzSYyKyRP9Lxz88eu2n2kHPupjHCyCO0CMAyS6Z7KeLmh1ckuQ3v11RteO6hJN6ATQ6ZVq36joSPvdDKTmgRVUxNrUjOE8fi7Rt3ue38kN2xeOO4zTRD3stZXsS2Vzpt84f5QLSGQXTC3lxFs3mKH+u3zOsdmt6ciAYxyZetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+N4CYJd2x3Ee1X1+EqfKnyXpho0el3tOskLjvG3/Xg=;
 b=mIiaehC3FvD3pFrTX1eFQeRKqx5HsEb8o33PNfpp88B4hnHbr+NNMf9+r9ntDSLXH+mx/6PgOoI/cw7bSExgBkzQ9q/+J7S39WJIntTNTUtmWks9ItONgfx/YplFYgI56xswcLrSAkJsJgvcB/fB792MPh/Qbj1NhwbqGHNqYX9qBprNArlHjhNLxKUfrBBwlwY3z+g/zJVlGTCmo/XS6nleMtFoqi+67dsjoomjqrgLgabNaiMgJfb5G0DQ+ECYm6jvSnfZ070nnjdMpCe87uRI8ITwmRWgmCoSqAIVmqhlJwIy0JQOo7CK9ESceA27Lz4OaoxpvJjgqsgLP5KuNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DU7PR04MB11137.eurprd04.prod.outlook.com (2603:10a6:10:5b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 03:17:35 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 03:17:35 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shenwei.wang@nxp.com
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/2] tty: serial: imx: Only configure the wake register when device is set as wakeup source
Date: Tue, 23 Sep 2025 11:16:12 +0800
Message-Id: <20250923031613.2448073-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923031613.2448073-1-sherry.sun@nxp.com>
References: <20250923031613.2448073-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::7) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|DU7PR04MB11137:EE_
X-MS-Office365-Filtering-Correlation-Id: 22495863-31fe-483e-025e-08ddfa4fbe01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m0koVz5Dry+5vyxuUMeK9LjP7YvD3k3GT98ixdc6oMsVKRX6K2OtB/oAq/75?=
 =?us-ascii?Q?pUMEPAw7ntWd102pW7xqn3J0KCELtE2LuvdmAbjX+s0L2rhiQkQ/loHFJwEW?=
 =?us-ascii?Q?Hc1JDgShAkM58UlmNUNfnB2gVJiAp1B14voNSqlKLAc8z/WQcRmfUOQIKesU?=
 =?us-ascii?Q?oOqwOxdSuTBEMT+DFWSPJk4933sehFtoNUzWLDEM+Y8jQYStwzll9218C65G?=
 =?us-ascii?Q?xSgro6kAn9EeyqyMB/Fz0GNNfHZsA/Ovmkfuh/YxQBq8LkzsABY6LrpRJju7?=
 =?us-ascii?Q?8VVa0MmgLPS6Le70f0dGBVob1RwyIiqvU3CwcMMYgs3GlZFVaEnHQU4tfhka?=
 =?us-ascii?Q?hS0X+BZ4/bKaw6Z6vzxPpip3aO1qQ4Mn8ix7XuH/aOLiDISTMp0odLbR2u1g?=
 =?us-ascii?Q?NdSUreV+2UbIgwMFeZQgciJz8Gzaeh6/+YWB8ALFnIxMIBeP7641UUAOQ+2s?=
 =?us-ascii?Q?KacWvdHaCOz+dwCjHKBifIQyxJ1WLYGwRBqx5TB9ttxvAI+8XyLAoZNfiFDW?=
 =?us-ascii?Q?PhQ4ZQJLF/7G77AZlchql4rEaNVhN3fcefBLPvUMT59A0XihVOX1zlo1oEkk?=
 =?us-ascii?Q?gBDKshiHu1m6ylGdy3SoBH1tnI9Ea1mjhqFW4MQbmDNKScHda9OBBzST1/G1?=
 =?us-ascii?Q?xSalfUjbLYg2r6XFeTBSc3ZnNhqCNfwPiansYOxTNdnm2W0cIXqUlGNV0zOM?=
 =?us-ascii?Q?8CfEWbji7K2n4vRXKL8XD44lF0p7S7k/cPxrJqTNRo7A/YlSEUa/85TUICgM?=
 =?us-ascii?Q?vbx3L14rkaNh4xVyvI9qtVdWBT6Wt6UZmZEgTe0kddP4Mw/v4vj7NoMqorDB?=
 =?us-ascii?Q?ADK6C9kKr8vpANW8pBbR7pHEJOF2IHsYqpgHc37rDBbMwwommxlz4k6LKJRU?=
 =?us-ascii?Q?uj8Nz334IUDS/Enkgr9xxgfOzdGjAxXfqtW7KZUFlAIHlLIqnghcxtASsMVf?=
 =?us-ascii?Q?lCht4drYn1vdrCqP1sEzRYhWlnZ0CVHe5kU4kKi/+bbm0SjCDbRrm+FvY2rW?=
 =?us-ascii?Q?urPg8enmmPoMjaObYN1uXONHFXBgFJrKtLM+vfRn8WpsHwi4v0+4Kb1UbhCP?=
 =?us-ascii?Q?Foz7OBiLaQkjIU939CSK6saoEigfKPlWQURU+RfL68NbXKYoCdYM7QSj2PqS?=
 =?us-ascii?Q?WgDREm2Gj/eFOF1gNx9CcVtauGZO18EvOVpiw4sdOkOeppp0VsovgaOD683i?=
 =?us-ascii?Q?u43rADlDIlBcZDKNCFQ3UxudwGFlnhHys2xu0cd3R7gQx7BJ9/tmkVIWTC7S?=
 =?us-ascii?Q?TfpmzSLCLEz31YD6zn88fD5DOARX+qqAGuUgKoO1cyj+vqDi6m5B3zs2H7o+?=
 =?us-ascii?Q?qLsIMIHc6Ib3rmzzV9DPmRUWLF9FoK1wxrtBIhl9bqUMcyqlsu3ySf1RkA3u?=
 =?us-ascii?Q?WpJa4mpvLGf99mdGPkxTMlpnM4wNBE4QnIqXIMihg3j55pfzJSwBM5Tu1QDF?=
 =?us-ascii?Q?gPqGZJ9T20N/Iwx29rSJGdEY1cld4IvdFlJiwFy7BQYSYwiFUYbZaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ShGpy5p7ApRlIdhkXdn2wDkDZ/a+ZPVcblk9NfGZr3nezT1FyA9NfvqnwQBJ?=
 =?us-ascii?Q?xSUN3HUnwfknzCYqZF7a6edomEyw5oFqIfL6Eer/QRdzRVgLL21dPuyEaGa/?=
 =?us-ascii?Q?Ww+S5VJSKg6gtH39sH0j5cqzXtn796umSblKvxU6QZIPbTvC/rni4GG7lM+o?=
 =?us-ascii?Q?Iao+gB+HH+qWYYnvATt6WRg37PJCI7CyzkJJEkwHJ3jIc96lTawlLZcX2E/A?=
 =?us-ascii?Q?d0JH/LZPScwAM8mfdUNHR7gsSJBIuEbZsXINYvTBGvTar/pUKZeQKms+E5Of?=
 =?us-ascii?Q?LIN+cpDCtP+8PZGP3WMgifGWE/p4hTbvBw/Lbb19tZDpucxQgPfwzw/r2FDB?=
 =?us-ascii?Q?lVrWt5uPDUHLR1h+ilmIqQ0p/Q9jzoc+/aTprfodfJTAYimROovxeUOY5xlx?=
 =?us-ascii?Q?0VIxdPBbbAqpToDwp4wNcEqL6W1GnawUU8JUMx8lmfSMMzMPGBEpsGUdcvXE?=
 =?us-ascii?Q?4fgcPZodIOAVukFw1ZTv7bmZT2jj+Fb3gnDnEGMTEBGxVgPXtQNuxYt+a/vQ?=
 =?us-ascii?Q?TxGXYjzopzHHXs6VQaLI10UsbVYRg+zA7EPxDqYnVNf5czWK0L7u1ANLAwXk?=
 =?us-ascii?Q?W+av9VcBYQC4FLmhm3HgBM5XJOO3AE4xQ8cQOWL8wET/95s71PPY9xD960dS?=
 =?us-ascii?Q?SbVM6ZEpdzrjRSSajYmivxc62JHPbgr7d5erimUXCFdQdAUhaN4RiKu74joR?=
 =?us-ascii?Q?l4ncUygvulbZWOiUhK/bzcnkMRVfC0if7mI7hnU20m0pKgDXvirAALxwkEUE?=
 =?us-ascii?Q?+c1Tnxr09sY+G6ZQFDzjduxo4Lr5lPXolx+++0EVvwkMAs/MlF36pl3Sepej?=
 =?us-ascii?Q?9cfp4h2d2C1KeI9WQcY+TbE7mPI/dktMdikBDE8GPMRdymo23yw+Eplu5qKG?=
 =?us-ascii?Q?vkO8x6TZGV3yremzIweeW/T/j87aJMQ5R4NHIj3dqHQp4qPU1YxWIJNpkVi0?=
 =?us-ascii?Q?y6C5O4fxPv+WQW9te06wsXz0K3lFpya0w9uNnnOcMnrvo7k3UH/T74rZpQ0j?=
 =?us-ascii?Q?fW9w9/yQ1BPu36ZXfNpuniZI++C2Ci7TN4sGSSSoznoxFCMYX70KWG0kdrQg?=
 =?us-ascii?Q?RIiimt/EPgO7Mcjh71E1FhRZJVir/aM0Y6regAFdaM11zLvf7Mc1PTIpUjyC?=
 =?us-ascii?Q?SEeqnyMY1VvJMs7MDTrdHOhGIaQm3f04lTPNPRbJGctZmTcjPLch4i8qndXD?=
 =?us-ascii?Q?YB96wbCdqr8V2fqcOdH7FoCBa09txRZ+CW98IbyvAkuEew3unHxOYpoesEjF?=
 =?us-ascii?Q?s4j+raiejKoczKld7KVgeUb2hgASiD1coA3dTfRwBbsTmQO1MPiM7n8TcHjX?=
 =?us-ascii?Q?EcPR4wXTQ6uT0LQ+aDBC36Zl5X8gqAW+txS7UmSPWfQpFIJ9BsGpBw/X6c/Q?=
 =?us-ascii?Q?wEfTtjXNK3dCAHZLH+1oWk5d0xdcGAKuBN2X2pzvGF9pfvBaP7YH/KZ3qLCG?=
 =?us-ascii?Q?tSD05wmlWsyA8lH/d/lSG4RjqOAjk53mdscu0LGhi7ftKyCFHBfzBbJQ6FqF?=
 =?us-ascii?Q?nnwfEtCY59shAAdSEkENqGVd1coWPJgvDoIuWwBgimEaoGxZlOmwUYX69hAH?=
 =?us-ascii?Q?GbS4gds0F/uXkJIt1yZH0OW5ehE6Rwz/9jD5fOd6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22495863-31fe-483e-025e-08ddfa4fbe01
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 03:17:35.7043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCWy2UkPCkJ3snschCr9d9uDCg2UdQMq7OxN6i6SCQ2QdVHTVux6pTvXVNkOSc80oTsyxnWk3jxPS+Qku8SRgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11137

Currently, imx uart defaults to enabling the wake related registers for
all uart devices. However, it is unnecessary for those devices not
configured as wakeup source, so add device_may_wakeup() check before
configuring the uart wake related registers.

Fixes: db1a9b55004c ("tty: serial: imx: Allow UART to be a source for wakeup")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/imx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 500dfc009d03..4ddfc89816bf 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2697,7 +2697,22 @@ static void imx_uart_save_context(struct imx_port *sport)
 /* called with irq off */
 static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 {
+	struct tty_port *port = &sport->port.state->port;
+	struct tty_struct *tty;
+	struct device *tty_dev;
 	u32 ucr3;
+	bool may_wake;
+
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
 
 	uart_port_lock_irq(&sport->port);
 
-- 
2.34.1

