Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97679EA;
	Wed, 24 Sep 2025 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683839; cv=fail; b=nqocYU1AVvK+LatIXXzhYBhv6bYo4OaxMXuCW4GndiXs3/ayLkKdt1DILKRQ+YbfwO8IDJGFYPCQZ+GJ7XZhrik5IwxXVAAuFFhx9aC5K8XGLiHE3naLDi1n5r8z1pq1r5ZF0k0vjECsj6gDJmzrvnyyiBAYtSrWJUpgFBe+aA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683839; c=relaxed/simple;
	bh=Pa0NKRbR6MtddEuYE3PZLxk9XlfReqUlfRgKUqOnC/4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Nza4MNYzSzPoRydZKq13dFO9+AKDje7pEzvhbcXo75wshU0lWxhXDWarkYxKC31P91HaTHgw9fGepiraWhN+tXFmpaoGQIPZP1aw9Mual+ilD4YPseUIrG539t8vAqdXdSBniY1Nt1vu7jkEr7U1h81VA4WGbGZFLhbnzYm+ens=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KZ7cFYp9; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KZ7cFYp9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJB5b9aiOo/Mf7/dcLZmFqpW92bL6p8QDdlSJgccXiuIZU4T+fVG5hklsiAjfik3ru5jtGB3Y1FAnQcM6LEEV1Gl4usfxYZCuSWcSUD3QLk/rkeRxgGn+p8WC2FuFSFOw6R+3i1W28+xHz1MCWkJR5NbI/ExoyOqOYSMtFtwM8aC+1by4efyUUfHM9EcmAFcUB17La1VjLNwgFnC0Jw7F80cv5S2Y791NZ1vXULI1lMBpso7DqXtpQIOHG2s4oqoMk7BuzzzNtbup7oMtbJeU+X5ZYFWpbTm0fydcKCKxL3ubpal2SIMyWTt31CY7Ap6Buozml7wbJbr4D7kOYlrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikCFmqZ1yQNtywVcLHW3Er9hFJtdeAdMbywy823Ng5I=;
 b=cZo9nKCwlWVrIt9hcWryUlo94Fle3UN8UROovEqzCvZgAQF+WtxMnswZ+o+CsCGIGU4QNNSl5W4wh4jsEPvKFrIuQwGS4PSI5iIUaJiDtZ+1CBaR4VqlSV+XsZNHaQjdF30Mi6Jv1FcdF/CZFZb/ZAuaHAzmh3dbDosM1ln9hSmYZQ6aJN17VoaBkzryqCCR24yIhBpe5F+freyViPfY+JxgwbSEzHyFoDodJdNn1VVS4RIOH4GQR0sRxi9eIDGc1VXz1+SErxu/0lkmwPwiHpn/ZoO227TaYuToOPhTCZbYqfUe/2ImyZjtC9lBYhjYeHTlIyP2hqo4VN+lSm6icQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikCFmqZ1yQNtywVcLHW3Er9hFJtdeAdMbywy823Ng5I=;
 b=KZ7cFYp9Aecpj4mHFVl6MaQHmLcXM5k6a23BHpb7/rjIf9Zrgmn2YBwm7lB21wiovBWuwzAH5M3lMAUx0oddQB8D+T9KiLmIVXMqTg3cr3Omn6c+OO4vuuVr5PVbZ6r6L/vFMWzC5y7WtvxRLf4qWH4F4b3PxOMdb6pD50RsmAwxm5jzttPaJJL88j+DNypTMcmFoiDhx4gJhDr+X+/JK2OYdbt6v9+jwGnK5DEnJnSbINFyHWrIgqj/UQn4gRgLEbgQ5iak5KbKVgD+HuBc8YSrn5CGuhzXsfm/nD3szkTYd5iKXNNftAUiWt/SoLi5MnJiLJVNRWOopW0lZYd07A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 03:17:11 +0000
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f]) by AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 03:17:11 +0000
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
Subject: [PATCH V2 0/2] tty: serial: imx: improve the imx uart wakeup function
Date: Wed, 24 Sep 2025 11:15:48 +0800
Message-Id: <20250924031550.2516704-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 6a5be32f-6678-41ca-74c0-08ddfb18d9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l5r99DfuTRWFnWQdEqgp6rkkWruqFifXhFWVeOKThB97TIU0Moe25ol54Bva?=
 =?us-ascii?Q?QvWZBDbY/thUV5ZDy5WTqFfA4GVBxanTEjR0hU2WxpCviWY/zd4unIdSnEwh?=
 =?us-ascii?Q?RmP8ueQX6Hg+QUYHbsqI2T2ETS+PMgxWtNR9QJ+5Tt0c7O1CMyiru9j3lpLK?=
 =?us-ascii?Q?6eZFUSYyTx1iglrxV5ghH78kHb+Tv5n6odKGnx15mk3Hq0OflB2FZHgBppUX?=
 =?us-ascii?Q?DtjUHKuOTwAiyBsk9nLKvYQqRGZja5cVzjMyNwzz2V+0NIENSXJpE/9s98m5?=
 =?us-ascii?Q?CfetyE4Ye/3t7+zEg/rIBUC8xWwFpOV1BL22Y55iaNwKW603ZX3xMN0462MW?=
 =?us-ascii?Q?cPGqZ98lb49peCam8LpqRxe2tr++OCKNe5PTFrehqjVe1nIk3QJ+jmzQFDk2?=
 =?us-ascii?Q?t91NJjn6QUjFjtKR6fZFAX8HG519J06mSoujpH6WOyFOdi3vDz5ID30/E0PS?=
 =?us-ascii?Q?V0YC4h3zzkVN5zKqb3cXvTQiKSpxrETodfhNKQlhbQY93kWH7iPSLykklPUY?=
 =?us-ascii?Q?1F+oSaO4r6aucNIVTwiZ8XuO9MbmQUe3F1qLNypp5llsFDn0ikl8GVTNb2U6?=
 =?us-ascii?Q?ZRMa0dvlTNdfCk9mxBfI9wD4rSQAm1xldBQzFBOCccOkQP9DiGa9rL8HW2C0?=
 =?us-ascii?Q?fIumJaSbiN3BaNUYCseqxNxOOpHI75ByA6jDtJVyOX7CLcQ9XD9yIiLimpq0?=
 =?us-ascii?Q?jD5lh0OJPMh3dLt42StJUY0Kj/bkPFHslKP5iuGIq4Yhk7jQ6kuZN5Bz8vnA?=
 =?us-ascii?Q?5CqCkyqRt/yw0W2p9YHZaasu0R4exHof1+Tdc7FC8Qru28URZ/bXviIbqAqb?=
 =?us-ascii?Q?U6xGANEO9792XKMSiUu9QK+G17q2i4gzihA/k7dYxHzsH+98NkGiqo2hhKi6?=
 =?us-ascii?Q?S4v0Lz9oHzzZ0baJ3DqYz9Atc11lgIsCx3joAEMDXrMM7ZbpStMg5vmrhvMu?=
 =?us-ascii?Q?xTH4PUo6TPCwuyExn0kfR7w9eRfcK9+BqG8bSWIPXmcy/l/jWOdxh0rBnWpN?=
 =?us-ascii?Q?7XC9hiFeq1OotxKzFGw5gpzCRZPBe6xBuJJADVs4G7we71OBEZx4zTrSxt5T?=
 =?us-ascii?Q?D1zkLaumbqdBobPccfFn3h9FUfeseENiQnJVpXz1UX6UjhN3R0KIhcSq7OwR?=
 =?us-ascii?Q?Iv32EbF3NYt+sO2FK641ILKK+ETbc1yZOTYQDshLJ1e7XMtItsZXw8Z8cQqt?=
 =?us-ascii?Q?emhmjnl8yPE+CA1e+c8nAFi5a9qzHoKYLS5ws7i6bI7yXBofB/+aWIJ7/NXf?=
 =?us-ascii?Q?b0gjJ4Y1sA1nS7eJ4aK2qMGhQgms6DYj6Ipty5Kgprf7DMIlCxXc12ofS8Gb?=
 =?us-ascii?Q?IHry1kH2r6qYWHKnIKgAeF56vaSBpq6U2fHYji+0Qrg6O/wTUtKRj+aZfJ03?=
 =?us-ascii?Q?1aBHFEp1ji7+j/2fLuxmEMrNHTjbyYgyK7HOpG32l1O3n9ILlQgfUBOCOyJG?=
 =?us-ascii?Q?3vjGtISaVzhBDjAEd6tjtg8o8VWS6o1Okz3fYUymIgEjOUmC64odDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8418.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KX7tyKR47Fw/jkPa9KOjJtKGLwYbCSNIFJkTYiimBeh+PRIaoz90ja8zD0D5?=
 =?us-ascii?Q?DJV14CjVp/fR6v3DXFiUMWWzhTurWJhDGMZ3zOSayStu9zYuhR8YvpyZbX4k?=
 =?us-ascii?Q?OmxoFO1iX0xtpbKhj6X4QV6Agw6mpl+Z9nSXzs73r1hc1DTUJojR8jVYqU7w?=
 =?us-ascii?Q?KsbKM4F94qEnVrcX+lix/8VzrZZ3lbrn5Ru7OodHWWY4ZJkGTVkIJBhkq8Kz?=
 =?us-ascii?Q?dKkmmHQrDEcSr7I3y24MLwZAmiVuG+6FSpLMwnxbyln1O5NkHTDKQYoHApTK?=
 =?us-ascii?Q?cN0aCbsaZj6vn6vtxdQdGRxIxPFuq02eHiaUO7HeWEhFEDH0icNO5SdSe4Ag?=
 =?us-ascii?Q?nLKYBd98IYPt0IImhlSAEr95ED9HWeKLiiRTRzTEehsdPsGRDr/CQeBACkHc?=
 =?us-ascii?Q?LSL49mvpZ+fnJbjCoFEJp6jU+EgjtRnbvcdaVDrAXbJ2Fxu9qF2PXzVthgMR?=
 =?us-ascii?Q?PJfELxEdUcPvHsLi/xcG5ENHZXuc4m0YJ7PlSieUmkiv9mX8sHCh5p+v0xGR?=
 =?us-ascii?Q?xRhdbDBab22+fT9Wfd+hsDLCzCe2uSHGgaJfRNHr+KP3XJKXXkN5rXN/UWRs?=
 =?us-ascii?Q?MKERKBwJudWK/7eugAg3opDrwvc9CZMX7uEFZZN/8gqOwYEhP0Jbwus1z+G/?=
 =?us-ascii?Q?bTqKe4AUucFI34jrDoNhY0EpyxxWOuw3/GmjVO+xJhUH6rGx2EOimARFRjcw?=
 =?us-ascii?Q?CZoM6sW6Vrtj+qFGyOJ/61RAODRifWFDgtWcKSQDcxFnb2x39+NhntsnyIat?=
 =?us-ascii?Q?8NM9nvNO496eG052oj3IJABRcqUWT6EgV6G4j8gWpzltEwmcO4EEcuTFySFf?=
 =?us-ascii?Q?qSpc7WDD+0vtOOdYmTenZceX5Yks6Mj37/R5Jk9GWWQRFhjpRmaZkDrs92aJ?=
 =?us-ascii?Q?7l2bccBMCEHNC0WFQ3F3sAcUjQ7vnDji8lcnN6I8WzClHI83PPDCS0FOgOSQ?=
 =?us-ascii?Q?sMbt/gxNAibKndND8vuBMJUE7qNSZ1VphAXhZYKMNc/a6AtDKcnUle8yzfam?=
 =?us-ascii?Q?qPt1BFC4fDlv0lzuLIxo+dSNEQZRwcx3sjvJVmepLA/lZOcMsx1RARkwAkWE?=
 =?us-ascii?Q?zh5ZenvKyQEKRJgq7v39BrMJOt20o+E2L9DrMlrlHMEc0METhk2ynXJslP90?=
 =?us-ascii?Q?Q9YcW8bfYo6r080OTkUpP9jstXylC210IKAptjeRN8Fz6RKK9zSY+P+YeNyk?=
 =?us-ascii?Q?fBmfuaan+CAsVpLSk1GwcpxtxnZf8ZG7eCEtGwhURQe+5ahnkP//hHYDefs5?=
 =?us-ascii?Q?UyL1Tq0qgTk1TBGfddi1TgR2TeJdX3oCynGY/vR5WTNp832f1Zi/kbig6Jme?=
 =?us-ascii?Q?nWSt1/5BxNhonB/0pcvr6cRBhnnID5hcSSv/4jtyEwRY+3X5sELHrLit/euZ?=
 =?us-ascii?Q?Jzlm/SId8Ordk98ZSlPLPW4xs7py8V4P3TrErbZBuplKmwEiaAaSfN9q3Q2/?=
 =?us-ascii?Q?0Rkk0QlR2ioBrDlssOIbGDBbKvdtG6LG70XC6uC2WP+qYM3sQhvoYXjwi4ns?=
 =?us-ascii?Q?Jfyt3dqwyM32fTkRqboTMi4KHa2MXZGN59y314nin6zewJvF8O4jNG7cKzin?=
 =?us-ascii?Q?3SvPnybb4zjoYPOw/X303iGKp/sK3dIx/SNE8Axy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5be32f-6678-41ca-74c0-08ddfb18d9d3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8418.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 03:17:11.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuKcU+VrvCDmh9gxOoSQVdi29LHKPASrLOiuj6Fgu4cwZ7mVYVUXJS2kCVk7LrRINgxfgfthCOHzgtltvI61iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767

Make some improvements for imx uart wakeup function. The first patch adds
device_may_wakeup() check before configuring the wake related registers.
The second patch adds the wakeup event reporting support for imx uart.

Changes in V2:
1. Improve the commit message as Peng suggested.
2. Initialize the may_wake and wake_active variables to avoid build
   warnings. 
3. Move may_wake and wake_active above u32 ucr3.
4. Use linux/irq.h instead of asm/irq.h to avoid build errors.

Sherry Sun (2):
  tty: serial: imx: Only configure the wake register when device is set
    as wakeup source
  tty: serial: imx: Add missing wakeup event reporting

 drivers/tty/serial/imx.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

-- 
2.34.1

