Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012042.outbound.protection.outlook.com [52.101.71.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005381EE008;
	Fri, 21 Mar 2025 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542779; cv=fail; b=h3XI0V+qcGIV1drxmoDfnDPOBKkjWuK1iXFRTIBvAsn2bD+D56Jfwxc+dk4qU9R/dHktltx/UJzhc8jYAPOhpUU11eW/d4j6nyZmFhqtCuFS3OhVesiYi3wwMFFtPpmGP9M3RvdBUp8XzffVbZztqxujOUOcIlhQB1y+EOYTuDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542779; c=relaxed/simple;
	bh=7C64f9iIkbWkM+oCf3yllggksv7UZ5D/ccUu59e5ruw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V7U1ahNfBuMdIunUBBOFyOpNY2CUbZERcxPZ6o2pKe41Ib47RB/Ip3SUxhmQ+xxfBYVY4OvielE2jYECeT1XFWNgOvHnMjTIwAjMaFIzDW7VRaQJfqqnjc8Zi+v2GJ+yU6sVXz608wvY2h8n7XpiXMr42/9dQ+hzwAulsh3r/Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P/discfH; arc=fail smtp.client-ip=52.101.71.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P/discfH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFD2GeVaii5dzOTA4wdViUDAgoMVKVYN0YNiHsxjd1hFsqWb1VmcpX3ojUH0yqrOcUsjN6WUtSmOg6ONN6hm4zHLygUlmJ+yaJdAllGf8xSCsM3chK6D3mYyVuUlIuYqw0N/F3yxq7EWTy6Dj1gDcyU4+yN7e5aKSroD42Y1Gat257vF7z+7Cm725dbFF8s/KTaY4aU0dQxj1SS/YYgcmVL0kDlZuZe5/OUfPtL3dsylH7/3rap+m7GHm2fIBnQwY8j6PDjl9HDWEh5X3GCrdqkNYzLI3dv8uOIuQobRPnuBvBATJG9r0vDy8WeHdU+P8YcyXO4mthWfdXZebn8GXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvJdaliV4gt8NgMaCsuB0PQJ4MDccTAfbr1oBTQc1rQ=;
 b=jkTAqKzfYA9Y20c52g9peObBG7s4klcB2GrY/osghzEYAhEX5KUHIGbqaj1dyAPRIhg+3f2EmCrgxJrs5Jsvwrw5h1ojA2a3uB8sSwLVs86prFs+EmGNNiL7NzHmBq/JZW8c8ew8QO6RQMd/CqpBq9/TBr596T5yldCpy2Slf6yuwr4lPH0jc7jkykO2k1rwQfDAVnXjd9HKZjOObYSj3wmaRjY86ao21j/ZdzylDFb898RvHxMP6ORC8aKph2x0cwTCTO8of9fKSwc6BzqAEoKoJQnRgZXEUWt/B4Rkkgdv2FyzsdZ4YTIOCX5gagnZOrt+nXptC0zruoCIJDxDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvJdaliV4gt8NgMaCsuB0PQJ4MDccTAfbr1oBTQc1rQ=;
 b=P/discfHYDJ1aDBDH5jhPUuS4MGCfLJflsnsPuKnegreauFnkb7M6YuFgAeTmdLGaFQB1oLpDNX5g7XWuZ5VB4UhiCf0NNGAXf//kPZGju8xiBTkd01/J6873pFTbFbCUwMxY40j0oFO/oPcCCzBu3ApXZQP0MvmNxAKw5DO75S9g6LYY6MAlx8Ej1rSk5agEwuMG44AgKsKm8ltZyDmGODWIXoBuImRTLfxlNvcGcMdmG7ZS+M86DZu4e5b+5CMPP5l2D3+MpqePWlB+iXGy0ezqhY07AsJaaG2AfXNpS74W2dqwYmNw6bLCmcZACIpbXcAum99va5m1Yu55Merlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by GV1PR04MB9102.eurprd04.prod.outlook.com (2603:10a6:150:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 07:39:35 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:39:34 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V4 0/3] tty: serial: fsl_lpuart: cleanup lpuart driver
Date: Fri, 21 Mar 2025 15:39:47 +0800
Message-Id: <20250321073950.108820-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19)
 To DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|GV1PR04MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 800e0c48-1335-4e0b-760c-08dd684b866b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6mcNiWApHKeh3eHRKg4X7ScBZBH4qGPT/t72DHMLYSXDagxQuC9SNvojaCn9?=
 =?us-ascii?Q?PiEiTj5BnVBoZWl1E+5FW73C/nDNV0+VYyvh+EO/vfMjlIPcHAqby68VdTJb?=
 =?us-ascii?Q?3PeVl/Vd9lYuQSkmy4hI4arow2MhNwsVfbRm5STZOU5llqEiUTPbcoKDA/Je?=
 =?us-ascii?Q?nRN6zkjSFMD0dJ2p38zj4JdOovC2eWR6CkC9XdKbnkvoWrZch/1TIb6w6/rD?=
 =?us-ascii?Q?xgyuHjzVC2ug338RUNGQkxvVZEfAUMVzBppXx8P7ASysYae5aFdgPc5XvGqC?=
 =?us-ascii?Q?6chZ5yZIgDP4uaRlnr7UrP6CXGI/1g/AM9H3fGlLWmhnuu/zs0o53nzcfxRt?=
 =?us-ascii?Q?3/n8pCYnW+gepmaE9i18IgiBb2FgWDmtVb/R8fSLsROGF4+jFPET1NHz4o2l?=
 =?us-ascii?Q?2CIdgOspVEsCPumGQyiYv8seeI0x/pvOikh6dApmaDOcoM9Q2acsjXmdBBJV?=
 =?us-ascii?Q?4vicIDF9f7Y0B1wHJplEyCUc8RhdbVxm/WSbHCjC58fsCMnC4hS8blo4SINz?=
 =?us-ascii?Q?whJMWOFNSr5xRSXdOE/EAeUIXOEHI441tDNqX0tW8HyxmGKM8fE99Ge7f75q?=
 =?us-ascii?Q?vu4j2AcPe+i/oeNS/019S7iHKp3VR8nVBjkL81Qys2v2dYnfTn8U19DDA1Mt?=
 =?us-ascii?Q?FRvsYXUQXQrtzcTOzg4jvzYEPUbWhkUIJ6jU2ShQ3IzwV2OAhwgw8mjpJEth?=
 =?us-ascii?Q?UMmZNs4+yyyTasZ+VrF1tsmIm5XxIDvUATlzzPHn/eeNSx1dBeRO7LliSTO9?=
 =?us-ascii?Q?wZRuwhTaW5zlj5cvkVJp0QpZy+bz4On/VsW+nZdhB4b177gu0Zhmrg9J1OEY?=
 =?us-ascii?Q?zY36mVdAXF+cQCU1TYaXNvGd8iskHnSLNX4+q9qHqrW0zaydELw08rakvc5S?=
 =?us-ascii?Q?N3cVfjkUPeWu8N/be5OfymF+RGWRDpsSJy7lI+hDq++Kmpfc6PvjAylA1YK3?=
 =?us-ascii?Q?hlaQbPeNpsHwor2irkZO/AUk1kmw9TTAasYtBphLz8vBfbqv8QeYjFcKpiu9?=
 =?us-ascii?Q?O6v1RprUABlpxXV4O3kP6fP9Uqvs4FkuArYTqP3QIVteTEheh/Cp4ypF7fbE?=
 =?us-ascii?Q?r4UN1X/lpvYJAx+jEKZw5POXjTIh0WKmBb98jL+aq+H3v7zr2+lJFdGGw0UW?=
 =?us-ascii?Q?I5nNwkPzdbW0NLBwoRj7AIrcA8FBE3PnE2Lro3YafIVbIDcX6T1b606wVOFE?=
 =?us-ascii?Q?+5NLMD3y+rke9yqxTKIKKkL5sy7tDVD585srAyXriqH8kr17IxFh/w9scKXL?=
 =?us-ascii?Q?jMAiiK6ftgOpnhVVG2GuwkLMfl4Gpc5ULJ9rqcwOTEsL0sDPL450KmPopuAm?=
 =?us-ascii?Q?QUfOIRqR4/juT0yh85bf7Mu6Uac+6iR8jOrDolDdn/TOhBBNB4ZOxZg5MNfF?=
 =?us-ascii?Q?2ouGP9ZtYdFeP5VmJDlauE5PJ8MQoQ825DwteOX1auZVpH5Tl7j/oqHXZ3ZF?=
 =?us-ascii?Q?lRKWZ7OJ6cl1A43R0scBcOoNwr/Sqop4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hLmCAHJaLcImEz4Z0EnmKxhYGV4mo0lNZ4267WRIoHdduAxb1XQLMGW1TkLh?=
 =?us-ascii?Q?I5XDJNb3h4RTzdSSG3ZFBzP2yPckHvk78nnBtnhHb1SsdJOQjGUXUEbh629z?=
 =?us-ascii?Q?9Yutqfg5puoaZsDBZ69p/gmxtTeQcvAUh2QRtT9P5MMnBusHfi20G5jJuLvn?=
 =?us-ascii?Q?FmaNP2VoniN3C1rf1tLPPM2YG/0RBBELY7lvNX2beZYVolBWCMIARxZOUsGo?=
 =?us-ascii?Q?f/973FCAwzogZMqh7XomuFRCNNit/HZkPsvFGAsCabspgzd2cZ+MN+hHvD7z?=
 =?us-ascii?Q?bxU0Scyj4RnRXn4IpoUHB031CP5gv91TOWK9UCLuskElrZ4leJy4JgoXHUqM?=
 =?us-ascii?Q?jfI2PD8c0VAlBBUPf/zytfZ9TaSRCTixmzIJgMbARNbe13Fr1xTq57vC1Tkt?=
 =?us-ascii?Q?ik8iCeZ2tFS7BqM6GChnniehNSGbC3T3nd4wiyYL17DDCwOzGwjw6Xisn/II?=
 =?us-ascii?Q?UPnizsrxkzmDffkvZnLw0hVbfWpw6vYjHaKoPrPYcf/EsRsVS9bsmCpqWk1T?=
 =?us-ascii?Q?KlOn7Y59xn+UHz5Bm1w2PhhviyCvbMtq+MRQEZZXWkIbDbuFl7uQRSOFj6Gt?=
 =?us-ascii?Q?EECGdmPsyON1On2wkRhluENjAFEM0iTl3KPXyoPIqEkpWt+G0on8B0rHI3w/?=
 =?us-ascii?Q?RquGHlwJ8MU+YeYGuCALxRqrSqA8PqIOKv8P+TR5HFzb2niRjWqE29vlBI4I?=
 =?us-ascii?Q?kiEpc/S7utEmoEvv1zZ4H8ui/Gh6SrpCupJRQjNDmyxcSdxxkP4sGCOenvI7?=
 =?us-ascii?Q?yftV8lBM7h6H2nJAlMq5JTZCn3xrcmdZvHjDyG5jCO9T+gO7h3kyy4sxIrYz?=
 =?us-ascii?Q?ygMMXnc3yfJV/AGgerR8GTecWEcwhM7bJTMh8f+qGcpf7wemtSgnkfsNi2jr?=
 =?us-ascii?Q?RsIkb/uGuSbv5mq1+t5oGnWW3f5MhAlYFbPEvzBZs5+Q9R/1dxVTmlKJgkNa?=
 =?us-ascii?Q?cczMCmWN5o2pG6bNM+liLCsDky6k1JqoHQy7VeZ1RDqXZpAq9bqU9xcLdFeM?=
 =?us-ascii?Q?3/e6ZM10m+PRZBYeQsvQvs1VPNz24BEYOGecTgcWh7c40QoKPlAJ6T//AFVy?=
 =?us-ascii?Q?mQjAavF6K9XYmsHti0ij436e4wqFzmqH1xAIKRVkhnO7dB0nj4H9D8RFAUea?=
 =?us-ascii?Q?t4jBv7Pc3UFFz8RBP0RvY70FSPDfGlJ3Nm8ER5WwXcCMTdhmH1WjW3uUNgq/?=
 =?us-ascii?Q?5iP9vcsygt959AIaBqP5puBFkKpIn3bLQjIpK90YG4p0lQtdcMaxuZ7r3z/k?=
 =?us-ascii?Q?H4ndTKsWqFSifSFQ6Ch6BqTlL0yzay/bDGz8jjWqx07VHdRXIHmFoiJ++1xw?=
 =?us-ascii?Q?/rAruUbC9sblkQSj2viR56KzWU0SWMlxxcyYOs4fqGWv/jnwmmLA5+7xQI5e?=
 =?us-ascii?Q?vLUn9ZVglwimj1dOz5TuOdWHIaiPP9tR4p2cN0cuWsDxGBnqhhCJGryZXwSM?=
 =?us-ascii?Q?tZww4EfyDUZemWX4ii35JfKtlcoqL0VeCAeZOxMWZkIV4uhBtHAQiNwJm+GM?=
 =?us-ascii?Q?AUwKjb/059z9iTfcnOL43WETMW69RJf1458/UOCazVDn221DOStdM67bDioW?=
 =?us-ascii?Q?d5SOmzlH0w8oz30bZx9EZrd3J7uZ/DLWGTY5GGpl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800e0c48-1335-4e0b-760c-08dd684b866b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:39:34.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRfUIuJLf1bgrMSAowwL6IOVgooC7IFa9vadHE0wCktgjJnod9OC//KRGE0Nfbmrt6b438VrhdCWz57T8wZGUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9102

Do some cleanup for lpuart driver, no functionality change.

Changes in V4:
1. Fix unused variable 'sport' warning in patch#2 reported by kernel test robot.

Changes in V3:
1. Add the change to covert unsigned char to u8 in the first patch as Jiri suggested.

Changes in V2:
1. Add the third patch to rename the register variables as Jiri suggested.

Sherry Sun (3):
  tty: serial: fsl_lpuart: Use u32 and u8 for register variables
  tty: serial: fsl_lpuart: use port struct directly to simply code
  tty: serial: fsl_lpuart: rename register variables more specifically

 drivers/tty/serial/fsl_lpuart.c | 472 ++++++++++++++++----------------
 1 file changed, 231 insertions(+), 241 deletions(-)

-- 
2.34.1

