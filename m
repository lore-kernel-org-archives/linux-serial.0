Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625012550D8;
	Tue, 23 Sep 2025 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597465; cv=fail; b=RS8AtE9lldevPxqYEiSMZrqCEUPMFzkm49Rm1Chgwa+rR5Bbe+YP1Xt5Mmn78tqo0I4BPJq2I6hWHo7ZeyVcYA8qjYF63Zgr4CG0roZleRL29kdJfSJFty0M7QuA3fgwPQDsXmkkqsIEziNZkAfA1sc0KcJU3abNixI+UizKEC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597465; c=relaxed/simple;
	bh=XMsFVlTt0qmcMMcSAavdr9N/EPr0J/tXVON6yESG9Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=npwf7njuaHXRvV3Jr0MjazB1YhLuBnh+0F9TMHrq175YO90PDkw0VCgzXY0d8sNKaewd0OY8tFbvrTPz2UbkgkrU2Rs4TSjAoECQBsVONrjTJ8hFnpM8NrERmkUOzgefelbz4IA0eS3okDxnpxjqsOLt0sCPZqXN1xwTC1M2a3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jlEQqKn5; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jlEQqKn5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYlaFWz/SsIIVdX/MXNK2df8mvhfTG7k17iGBuknFg8fhvorz5YdFuE7nMJAXuF9D2LimNCMN1dLOlzQ173L4ezovyfy89xi4SKHaS2Jw3HSxbYCf1qBvm9KLwj6fodlorVX59MaAQfXCGmlSzBWbKKG0mIS6/w2w8shQ/9rWBiFsk8ryu2Wicnd9N8z0u30rAAyPRyB8JXgDyi1Bfl5pn2OF79K2/Mt/Ta9HumbYXaPAUee3B+uIQiOWx0mrF8VkOY5jI7eW5TzW2rmth13opQ/6Tnzex4D0TuLFmoPYaxU3zwOtIjI1wr0+WiZqc+402v91uyrcsfCZ5cm2gLwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53Q/8/uT9qQH9doTsAFB83j45E3iuuTFr5tGwsUwVeU=;
 b=HGEUfHOZkuOSoZdKUpRfK6IVyU+9qyMN3AQT1MYgE0gf4QPGW7HSsSH9ULOcahQEU5Mu1kh9Cim0OGB2T0YcMY0Yt6JIssktsrMC0G2gkePiphO6PJ98yqnn/SyBglJzjgZeOnDdzavfz00pZxhOInFm/YAwZEWdpmQ3pkf8vNzvH+sY0G+ghntEeYs2VSM+0si8IdkswO3SaLmXe1sP8UcVyuV1JaJOXhKTvf6v9MH/uWDJQ31JnMnz+0VmQCukMCMDca9528EpypwDDBm/BXqd4QtrO/fWMvjxjJAMxmRqiWWrUnWTPneKHQFTcoO5FnBoKM3E/JGTW+kkA1jn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53Q/8/uT9qQH9doTsAFB83j45E3iuuTFr5tGwsUwVeU=;
 b=jlEQqKn54EY1P9XSNnXQ8w3isbiyk9E2goJr0sT08AzNR0o7rVqiW0gApzNIhsWsYv0VwVUJcRp/Rzgqx6iV/RD/lV7cgFhxJc4WyoRJ/vj1/fVOM03Jos6Ekaa/glMEqqrOFH1hs9IjPKOCfOp3krc8tgKKR6a9H7rH/5je+4GXB5V9z/kQiaxGEIKKXIWNe/N7X6UlUt/mAFW3c+n31iJ4xvcewxnk5KKL6mVGROVVAdH5DP6LGJoXKEY1TdgTLCmV6A/BzU5na/0vg0waLyIpWYRNT6FHDbjfa6X25qodTHoED8/hZ+BcsYjxUrIyGKeLFH7WjYZQQwfPjKHWrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DU7PR04MB11137.eurprd04.prod.outlook.com (2603:10a6:10:5b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 03:17:41 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 03:17:41 +0000
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
Subject: [PATCH 2/2] tty: serial: imx: Add missing wakeup event reporting
Date: Tue, 23 Sep 2025 11:16:13 +0800
Message-Id: <20250923031613.2448073-3-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32796aa3-e0f4-4023-56aa-08ddfa4fc136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+6ueNPrq2kSNzR0TCbXCWMaNLl/l4H47JYn4bJskjWEQLYVpsWdbPfd04y2y?=
 =?us-ascii?Q?oFeQpvEjmutXv6t8vyRvqE9IGrgMNQHBiuTgSOmfe+OpKD6XG/u9nX/rDWzB?=
 =?us-ascii?Q?gckQmdnAQlDQE+0v131FdbahPIhEN+6J+kisQOOKFbLxxwBT05vCxG0N78KV?=
 =?us-ascii?Q?iiY304DTSlgVte51qhQQn9Ezp5iWlTd6dEYYr5Rt8jYbJcBwCRPwMDys/non?=
 =?us-ascii?Q?nYV+Km6AK8gwMkEogfVW9XKmS+7FOHOpXNHaI0w+lZAzWc4x36HnXalXBarU?=
 =?us-ascii?Q?Jxj4thcjQ8JbNs7shsDnMbs6VrkJTMl68l0ByTxkBzMvIs4X9opoU/2lY2vq?=
 =?us-ascii?Q?Muh1sylUV+M3RYC0I/ga2A1VRuVqRwQ6dKZYyDQLpOLZs41jXfhtG4giZsDa?=
 =?us-ascii?Q?Kj/n4xAu2ugcojzvjoKSPUKOIsgSYFC1SVtf14+ix0b03mCSO1mw2xkqUu9g?=
 =?us-ascii?Q?C/yuK63UgXbWDg8fCyS4TIaqNRx6k/ajxu6hV/0pwKgoDxJX1vkZZ6fahFsx?=
 =?us-ascii?Q?Efdp2nZcWtfqnPAhQMSlU6XACSptaXS/xc3h77YqUUfHwMDXoE2KKHLnNg2E?=
 =?us-ascii?Q?+KI+WEMVjQYPS2+EjkRhfrVYNxrPFQLN5n1e/9rOAfEiHCp8irUi3e6Gs4xZ?=
 =?us-ascii?Q?dkHJEIC3SyTmG/mJeI3NrApKcgypcJuMKuh8ejE+mPbThODp94cc80inlMD+?=
 =?us-ascii?Q?EwMqhcC+6uvGJeH5ibSCTGIoqnwp49k7qRjnhvXQuTQhivQadcYoapI9cwyG?=
 =?us-ascii?Q?2L7p+wqM+FxZ/iiuLgNMtT2QFY+TRwjesFuhR/PekA3gbyVh2zp9UeDqWNBX?=
 =?us-ascii?Q?RZ/oHMofNMF2RKOu5FclnITNXypta0WBQE0khsQtUgSZw1gELsb46r/qogIT?=
 =?us-ascii?Q?70n+w35AfJhuAl4GAcnnJujjSIFZ5WMeSiLxwlXBznB1t9znCHGrub5O+2zn?=
 =?us-ascii?Q?nakFfS02Vmp4+PD3/mVMb5YJed2lPlJThvhVQPf397qIPzEKOseYvRl5fgrv?=
 =?us-ascii?Q?fSmDRajH2otknYf+iWWVJxm/WvQK8Q43M/rlpebeQoj+0O99U7L4AHqeZcvh?=
 =?us-ascii?Q?LrEY+cToxrHPPDMDf2YuFSo3CNJfXMeUxe5UUhqEwPxox7GJDvQGQ+tjBDI8?=
 =?us-ascii?Q?iOpaoC3A1LQj3O9LAHPx3zOxLrjHC+Hlajy2QrCiHRxT/mn3Fe25TijA7e+W?=
 =?us-ascii?Q?kTynCQPryabaO5GJuUdBMdzn3VJ/EZFvBFlRtoNBwNvar2wDYDUo/0Sp2AtM?=
 =?us-ascii?Q?uP1zhF+tGDzX20YgRPK2Jt74bD0xZO3SUFGAKeazjZC+3E57F1jv4QVWGS8Y?=
 =?us-ascii?Q?FTxoGkQVbMmgmSoU9AadqhGjw4vN/ptJUBa2biMLEH8SBQvV06DlLd09pSQD?=
 =?us-ascii?Q?Isfi/hG8FZqBGoR+0VSIOzi0N7/aG33m/O1/MBlzGbirpVmuS1jfPRBHpHye?=
 =?us-ascii?Q?E0mV4UfHJ8qRQfMeAzABz7TCy5oR8reL2lVc5KOT5RO7SfgMyxOjEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MQ3+3gJXD4T0341wgwpxJX0E2u/LckkoNrjER+STcGWhgiDFraAAi5SS5DZp?=
 =?us-ascii?Q?dKZ7wfcTfcecyhZXRLgOjNZdH6azFFc83+Fsd7vrvs6NcpoDvsjW0IZfqbpP?=
 =?us-ascii?Q?HMROU8HoIkL0kXFoV8hbWL+G76RPSjNWQtrbewDryZ/SphFsgXY0IwF5P3ho?=
 =?us-ascii?Q?YhAeFyIJqkdeEa5CW2uzq4cP6o7PplLTuQh+QFn7RmTepFZWRTgIcqA6zMp8?=
 =?us-ascii?Q?Gx07TRNfmUt6qwjryWID6eI2a0rR4LwLyHMUKkgBGMmOR564VQzVvdmXqZPe?=
 =?us-ascii?Q?M9I15cJnElwDTOa2+SZ6PbF+ncG+vEumx/lxu86REDDDpvJedf40RIdDTztT?=
 =?us-ascii?Q?DmfuGCnta36/XEIfPg40A7/hG3bYvjAq1Nl6uJUC8ty8p5IlciS8mu0xRzGA?=
 =?us-ascii?Q?Itpa0bEzO/eBHJ45M9iJo/FPbIFT4OheblUVGeAO5Mg6joObyg930alQBSQ4?=
 =?us-ascii?Q?YL7vvpHaO52zxCyc0T4DcyNOWxUajC8w6X48kKMxCG7WPmEJolhUWccpTHwh?=
 =?us-ascii?Q?NcKRTEWCpbLvQaMmVC8bdJ4oOcgu6MkX1tGGebkEbL+33HSTwok+DOu3mU7r?=
 =?us-ascii?Q?yKossgEvp+8NivzFVRPlUKfhKdgVFRm/N6dEcDEAZlvZf4CUmzImFC9YKNI1?=
 =?us-ascii?Q?naNYTh/0nbmyg6iA1jxonpXljEcA2OjcyHjTGUWmmavSdBy+cZGTYjoMIDLJ?=
 =?us-ascii?Q?n7k9XZ5h4w3gUDUU8FiU/Ux68tt4JfyAXMMzWqGydarPTmKRvd2Hh2qk2HQ0?=
 =?us-ascii?Q?klT9wHilRBykhfgH++FgkL2/3nWrMtjt3kyRQF9Y68FhZ+oi3GcDwFh8bMD0?=
 =?us-ascii?Q?LVpWb1VbgyFxhF8OJn6bJlxvsD4dMVIghMZ7LWzCv2Zmr3kcANnFk1fxVwnM?=
 =?us-ascii?Q?4q2NLeY9hzmlb+/cbEbPJp3LpI6xxTJzdnO0BkC7jmcbM121Ax1VxskuidkU?=
 =?us-ascii?Q?kqgyxR70mezlV/HGi8Quh9ygfLfKN5R9opn4U2dMMZeIVnQImViZPGS4pR4n?=
 =?us-ascii?Q?9uOhds5YRcCe1JYCUifw5Pq6EnmNpam2/RWsZtPQ6eDgiBJ8aZmexHP3KE4m?=
 =?us-ascii?Q?q1+7Insy0yQ63y1l52a0JO5J8PX14GBiftalXmLlcYKrGGriKvYiEfGP8kJm?=
 =?us-ascii?Q?8MC1Eho6O24LjkgRADN6dF3Gs8H2bwzMXIt0u0KdBqjpu1Cb593Q0xbp1Na1?=
 =?us-ascii?Q?rc/CQuZdn9TFJ3YByTiznNMSFOGClA5xmDWJMITJV50UN5UL6BCxquWwYYY8?=
 =?us-ascii?Q?ZQXTPyaUJwhpYkXp8vuckxpY0t5ayWuZfnjVvZlYjbY2o+CVkVKONcdU+R9H?=
 =?us-ascii?Q?qtKktotWssVOH9wkpdSkURJechhCWoV7md2gwj3rcD7Wo4v8FoHMC1PLh070?=
 =?us-ascii?Q?VZA5AVt49cF1I1GOz8sK1aY0aYjOCJpfsdz1e6uRgQ4ObERqku6NJMMdXYbO?=
 =?us-ascii?Q?N42S3stmPXY8hT8HB8RkkkM9CtetqBvax7IlIWh72nqyDisb7vn25A6V9qkv?=
 =?us-ascii?Q?WmqhNZlFJWfITS3ViYkZL1SBRES1/UOOw/W0mL4sMlsIElsPCOvYJ8xIDlpN?=
 =?us-ascii?Q?a2K06fFwv6BVQ1yR42cUwZZmcOKg0d5DCraX9EjI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32796aa3-e0f4-4023-56aa-08ddfa4fc136
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 03:17:40.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c369O7zjerEX1/JkZlapnp8T7uuF2sTAGIOnR7zDbXiQ7AS7Bkx4zISe4YSDOIrgIIXwEZDH6gVhB8WLQgjsZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11137

Current imx uart wakeup event would not report itself through sysfs as
being the source of wakeup, add pm_wakeup_event() to support this.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/imx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4ddfc89816bf..647123da04f5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2700,8 +2700,8 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 	struct tty_port *port = &sport->port.state->port;
 	struct tty_struct *tty;
 	struct device *tty_dev;
-	u32 ucr3;
-	bool may_wake;
+	u32 ucr3, usr1;
+	bool may_wake, wake_active;
 
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

