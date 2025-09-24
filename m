Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011025.outbound.protection.outlook.com [52.101.70.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A021B9F1;
	Wed, 24 Sep 2025 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683846; cv=fail; b=uA5v10DH/4AczDHRxghF/EkkOI97b6RfKPL1x6STSwUayGutom/MaRL/2wRAB+BUXa+ewaq8dXMFcnALGlw2sWNPA2qxN5FiR7EvQ3Yzh6tZUSwCrhhmbtWU9P+kbotpVKaDY8o0QKl3OBda0Tfr3h3g36nI6Fa/zECULKBEHTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683846; c=relaxed/simple;
	bh=aaNfRshtAoZYfMnKbkU8eLetad85XI0LWQmD/YqEnQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=em6R11CRTlXbMzj7XyTHLAqDLjF4H25D19WoQXeqNyF9A2yTnspjPyMsji1dHaKLzZTyj1Jv/KMS0FXT6PorH4Ru8Sl8c5v5u2kGKRsAfcMBvyHTkhUB2QZmQaK3tS7RsXdlop+b8BNPLTDcMQMgU5QhkNFfGYCjWOxTAKOex2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HENGYdqx; arc=fail smtp.client-ip=52.101.70.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HENGYdqx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJNREY72UeDXc5pDpeUsXp8gtXzgSVpfQnxe3nD+h4hccmZSl2kQ55N36VupYDMVy6rhoTRMrdhF5k/RcQA89Iu2XTWsWu+JIm/8jvrrMsw42jyCR9UzN2o8b66oI+Ldt8t1Fz/FNcc9jCSF+wHOVhlHFkGfaGGlRAsFhx5A5OcG7xkZsXIpUZb3cwpcSdHy/5ttLJRjmoT9l1WlTe4/Be9osy2BGQ7pJuUrTxFsvVXRLmc0r4oVSBheqKqcSkEd29O8LcNzmOxC4b9ycjuZvy3ZdxSw3e1UZJIH3w0h47zgcxtf2kDctYz21ZlwLctobB5mX8d+IxGWq7APujRlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0qZhyTRSd7HSvDfSQbv0bkSI6xtHispmINuNvosV/8=;
 b=AgGQbR0eLQpq4y23nO+I1e5/h5cEcQ3ZTkKs9ngkhnlmc7zLMoyMW+Xi8GSEZmHbjnm132CToaUAexNYpKvpcD8iEBw61+kNqjsUzvP0iAIZoMvIwc6bUfy8unKjTejIn95deOkmPbkM38hzvMlhVC+PjIf/KFpy5SG4PwFGKQxGxoH3mB/bSm24x/ZFZox7koZ71jSLID9BmLZ+7NwrsU28IJNoMbkfC3CxvFsrgcrC1TnT1hwtFvdW6O5hjbTv/zWImL0RNGmdRa1K29anfx+R2DvKxBurJ/FkuDQb4O9fZNgi3xscAEkG8aMvm1RdD8iSs1CX6fUtcRQUjP9LhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0qZhyTRSd7HSvDfSQbv0bkSI6xtHispmINuNvosV/8=;
 b=HENGYdqxhoV3Nd4l7QwWuM1pMlk/y9u8foWu3XltjTPf+wd7wFbXiNQFTQajNpKiOj5xbJKL7vWnCni8DNPoXa02QXBCKI39FJwD5joQux9eEvEZ5XdfNxNWbb7KBvQvsGxn0NIYETa1f9b1Jkz1jLUMu6pU3t/05RwJ65uliwsOqDuWmJnDRYIs9nDAOI3a45YWtm6vNzkCmdb0iQaxumOfuGhKim3f214Y2QaI0gumsWfXa0Y5ZfbV/Imq1QkIe0Y0Mei5jFvHCWLq3DmkKlPWJ4FdrwAX0/ZIuc7mZUjThN0GEm82mMog2Gdfdwx2dmak/OXBEYx/cWVeDhCNtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 03:17:22 +0000
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f]) by AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 03:17:22 +0000
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
Subject: [PATCH V2 2/2] tty: serial: imx: Add missing wakeup event reporting
Date: Wed, 24 Sep 2025 11:15:50 +0800
Message-Id: <20250924031550.2516704-3-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 84ff1767-a4d8-43e6-9b12-08ddfb18e046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GJ2orZF5B346MP0s0OXwdhUmuY0QJHBR96QXqRPiY4i2dVyBU33zEe/ZJcWm?=
 =?us-ascii?Q?NY2KNLIodoioIWiu4m031TNwltB4Ucxbc9OWLoOB6vtXYtbQmYMRhGyKY6lB?=
 =?us-ascii?Q?Kgm/MwXrgiWkJmElNE+jaQr77cho9/vvqj36hm+GzcabOw3Hl4p7NkytPbtA?=
 =?us-ascii?Q?x7KslquM4kvKyzAk0ghHOqVxlEtBMi8OMYyuE9hMhm0mp1Pi4zOd45kEYIoP?=
 =?us-ascii?Q?M6zncFgdWDg2g14Byu9ZEghGKyK/2UPOQzG+D0EQkpLQ5hn7sS+Azt7hcQeV?=
 =?us-ascii?Q?hTkO44y6EZTndfqDEWBi3EWQGPCzCR6q9qoG0DtrvYbBw/Kgn7ACA4f1eIH0?=
 =?us-ascii?Q?dz9uRp3LIYRfH+enPqGDCNQEuqZ3txeY94ey410QY2nYxkHXX6hMGRcvGy34?=
 =?us-ascii?Q?CgyL4A7bLh4q7J293xx7pgN6e+OmsU7mDPqiR1s/vBECSi9P1T47sl3y6+ay?=
 =?us-ascii?Q?VDrx9LYJvQGFNx0/E31Uz8uGfxS6LPSPju6ySPwTEnMLMXc9o2LCalpZddXR?=
 =?us-ascii?Q?8boettXm7sM5uEB28/oDW8khJqnYhICrE7k3RUSFIO6yHVI8yNk4BV0P5q0k?=
 =?us-ascii?Q?sj2pnuifXxjlEQqFAfb+raxNyFUB2ix7fwwDMssjkYA+tIV6dS55ElLLKGkU?=
 =?us-ascii?Q?gJzmZUBQ0HqyyCq1jiWcCXWCHLxiFEakJPrdkR9rXTYbNEg5oFtJN3WD6zKo?=
 =?us-ascii?Q?E41t72pV0i19qkS6URhF8KHgsc5wA5AAYoY9gaFl+CURpI315ivP4nR1aRT4?=
 =?us-ascii?Q?vlzGUp2yHlnZ7Hm+qi+9DuNVpmsp1uHePFSQCH7YQMEwFYNkRYSoxXVhb/wF?=
 =?us-ascii?Q?ZrFgCOAjdUrgycDmewkMqza6IvNENIJ91uGh/fR1z55STRy5uhanqZYHFEGH?=
 =?us-ascii?Q?evEZ3erzNM8qQSwoYBs6KeT9/XE5uMhJ3b6VTJXzEK6DSebk4o72xg54qo6S?=
 =?us-ascii?Q?wB3G24bRXik9KKtTDiGecjNDzZRAui0Hamfb4MUutiAzFjCjpp/lW+xRQdww?=
 =?us-ascii?Q?R2eJauIeSxg4uAcFk6NNrAJiAIm8o/MIJVJQRhkIcz861lf9wGYW2dBZy7je?=
 =?us-ascii?Q?PxiDGDTG01xb3PZB7gJwK8vU0GmRJn1Zff3NHkZTxeIxc4BwBr2mVrddkDUi?=
 =?us-ascii?Q?HC6CDFZGW9QXObQdIAV2gEIBkUlkpJapRWIqjpqtGkTzS4p03wSHdPBijDlK?=
 =?us-ascii?Q?uJ4DFYDosoF1SFC3NTj3cjqR9xcGEXFedr9pXvg3aJ78nhzuEASxk30gF7ZL?=
 =?us-ascii?Q?cnHVqXxlZSPfbnRQOMk6KLYfOGdFb7V0rWTTOfVIU9efACon8LUnVI3/tjK4?=
 =?us-ascii?Q?284MdLZkzeSILFXg7M8Lir8HBQ2PDMX+456lZdyyTTynEg0NSKWH+7RwAU/Q?=
 =?us-ascii?Q?0mSiZZbICT3d2+D/n6785jebyhlKs6CnpVvE225W4pdlty3O1oDymQL7pK2m?=
 =?us-ascii?Q?dHXDjN5rsleNV6kZYv+LYi+bhaYpz6SnfrLxPsf7D12R0CVau3lQvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8418.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DnlIEiab4Y2lOWZHmHotrKuStKMg2BPIwZRX2DCAD2dm7s343jAWUiQ8x/x6?=
 =?us-ascii?Q?UpIR6qqAJUI1SMHw5+si2T7Y5dO9XovTlZQP+jxviMQmA7Y0skzs0CblKHiK?=
 =?us-ascii?Q?zIEWB1FpsVdClCmyHWKqXSPnVNpVltY9HwQ+6E7EbQ2csltIYfeNW4Y/5sM8?=
 =?us-ascii?Q?YYi/pDM796+aHwFpmIgk4UnmN5i4lKtcfwfAHMVJyYL57cpSjWaC8OIpvVgf?=
 =?us-ascii?Q?0PN3ptCBIPCJcGV+1Cmtke+FkGPUsLk10v3/oEKl/QW1Q7x8yUFDMnokMCv5?=
 =?us-ascii?Q?IPVGhw2b80rWeuj8O6NQaKse8iawH1E/VSUavAGRRs3BTiX5SReK8hEtyrur?=
 =?us-ascii?Q?3M61sWnSU58KfySv78RMeoHzJqCOdzxGg8KMxbObw4d0ASc5LobBDwzcLrg6?=
 =?us-ascii?Q?VLCdaiTBxKXF5REYMCvYcB7ccHPs0Lq0t5yGmV1Od4JbdkkfNliQwycadv8D?=
 =?us-ascii?Q?IH+s+EX9ctsp/Izi05Al4VXeR77qL/3mxbzy1NqVFQuRU60LqGn3pLM3+nfr?=
 =?us-ascii?Q?GsdpukWgiZ/55v08e2rdL4svUGU0bLLpHrloNIXEctLftWgda3X7X48s4YW9?=
 =?us-ascii?Q?aVTcmQdbZo0AWIReyMkJ8VwWyHkmw31wLTAeNYV+MihpJ3XL8N6VdTpNBhw7?=
 =?us-ascii?Q?mVVVbSZw8nP6c1PlKatROfeQSWjnL7JKjgF9T3E6hN1XZyA9L0pSwXT9Nhot?=
 =?us-ascii?Q?N4PLdePGJu5i+dFSAxWEIvZvimLRj8fBzd8xfXRszOV5u6TUJ/8LIgxswT0i?=
 =?us-ascii?Q?WirxoZQJJZQSx8572EUZtwoEQFopBKXBLcZHm0TxGFWWO6t8XQFmZzE1MeYS?=
 =?us-ascii?Q?TOCKN6vShw8JK8nd65e4trZna5OBDM9jx5KP6RHQRerp5B90cttT2J8vUd2F?=
 =?us-ascii?Q?/qE9TXxJa9GjdqOVCQNgc7RMJ2wMuFABuKp2wv0vCNViYXT+GO+Z8/Ce9s7y?=
 =?us-ascii?Q?l6mEWulEbFUL6NDqfGtSfKkDT62sXbcB6a3GH73FRB+iVniVzFa2nNhm6WKU?=
 =?us-ascii?Q?b2QC9DnAiEaUNnFwwwgDlNk+V6v9q6/FtoQESvVzsy6Ncl9QSuWAjFD8+UXq?=
 =?us-ascii?Q?knYTfowvhCW3UC4T6oIZTVCjjBxvLyg++B1SeslowUEpZ9LW3rmiLXzTo5X1?=
 =?us-ascii?Q?ueFs0d2OREk3s8tDEZF94F4aAx9LPcbkrhdwDwFSFpoa1UUP/U1hHRbbTAc5?=
 =?us-ascii?Q?lNagw9+if/OsDsNsA8973B20QLmZEXcsab8e5wqhXiASvNdmBDEs+7fxOsOa?=
 =?us-ascii?Q?ErIrHG679QutTFY/SI8gIxhKhmViYB8O6VsLh8ZnGPmPe8iTPWQ6Tvab/XrQ?=
 =?us-ascii?Q?faptoDBbEaVr1IB5gBoiNID8R/o2XF+vNztCrHYxlqJB0JyG9Gy6f8ZUq7AC?=
 =?us-ascii?Q?QzpnMTI2PX5p4fsyDKavth82J6OvBkoIVmv0chzyH5fO9A5Ypn4u000TRXjN?=
 =?us-ascii?Q?SNyFbwRuAs2OLuuQOjVLcFG6AtMsLaqPTclVLoWDZ/akzzCQ8EwXSLPOqF/k?=
 =?us-ascii?Q?fqU+5/YgOBd6ALYrzB5hL+nGa3vvl33Cn/Yfa8cM9VpQdC+erICtMPMqXHSi?=
 =?us-ascii?Q?ynY3TMqNfpUDacxeJ5TZYpJz/OzuNLkeIZQzh8ln?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ff1767-a4d8-43e6-9b12-08ddfb18e046
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8418.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 03:17:22.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvhCLBvhGK643EpbvC7GdvXDlUlMiKdYuA3MViEUkP4rL2XIY/uHLHjnbehwb5xn341TcRSLFR3LnxI/UQio6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767

Current imx uart wakeup event would not report itself as wakeup source
through sysfs. Add pm_wakeup_event() to support it.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/imx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 87d841c0b22f..b83f5c9c722c 100644
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
+			wake_active |= usr1 & USR1_RTSD;
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

