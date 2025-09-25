Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1D2E9ECC;
	Thu, 25 Sep 2025 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791574; cv=fail; b=nL7oHYKorgJz50wg5fg+SsAKA+79oONEkDEZzwV9TeDG+4wfq1dVXjqojk0TefZ/Y8FEOQ/p7qw2hsVtw+zWguVnT7oq0UcmSzQhFYvv3vtiFEEVStJ78pKzcGAocZHZ71n/OjvxI52dQfXhzoYeeZ4ifLMo1Gw2W32neRxeEgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791574; c=relaxed/simple;
	bh=QgaWMB6YNKw78L1S6iOU2HxSCO5EKS8SzHYyeFoT8Nc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IdjL+tXp707XRRaHV963L+SrkSDVFhlMEaSVOhUOtk0mGjHpfOuRq+u3wOOlgLak9kwKGu3K4VHUlQHVUaL1lxSOeON+4VOI1KcMkKWPsQGR1LE+7El5SeWUDWEgN7LwusOeQYav4BiSYSwxSyym3lhxLMRV4pBl9vaNtje1n9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ViakBkWA; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ViakBkWA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAVhE6NMKC8uGFQIp7sVCr+hddwzcsBuRfDgbRGSJvioQjqY3D2OG/SPxX/HfB0Ly8iLaSQKEAaLIsy5GnP1y436WuTOPia+kHsW0qyZTeP28eL15DaC7JK27YIxhwlNcr+v6AXktU4K7nUdV2dADS98b/w0IeoBmr0wrgBjrFp+VfzUPE3YDqxkQ5WpjNSue1f7/W34FMKydqAunh0lVxSXHbAE7JcX1DGpV8mr3IQlXhNvmgFopFCD4uWXIQpAbfKzU0GxkuljfpO2hu6iCZ3eueshpdlj67pTC7KIuIZoy4xY0XdexpQv6qwnooRrgRuQmfQ+YLaf+F1VFHJRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERKncUYZQOMOlmGIA/PGNx8JAVoBl2kQ/VjvPBIFl2A=;
 b=J7rZHXWEs8IsWK/mkmqr3FUcIiEMmDL5xsFyaTWEcm2Wz/iEIy+6pKSElIUENOUS2JMmery+95vElfe9ReAETirbd4G8DcGMLxhKViWl1ykFm38YtCuEqO32PurRECuocvi1dwxMgQWtGABZl4XHTjY/o4DXrhFybK+UcCYjH9A2N8IRYwk4O5FvsBfGs6Jhm33o9AnKto6XypZUZ0YOgB3MefzEEQDyEZN6wsGU/MKH68mTvE1DVdFUtrgXQUovAn/4aRNw8bmUTsN3fZx09/Z+f6IvM6rbN0c66jNk0GhQYMReFrMM+no3iUUVvpGY0TrpDvdz2M6ZxiufN7uMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERKncUYZQOMOlmGIA/PGNx8JAVoBl2kQ/VjvPBIFl2A=;
 b=ViakBkWAJKVrgH6G5uXSnWcekCerc8ypOS1gIx5mewUy4d0hBbSmcW94EJJGT3AgfsNU6+2w3MNoRkMLbvdbloIgyjXRPtiMGVxIBFmMuZFXZyzysZkFNP7G0hwXZQpMNenfSnAhmdn7hShJl14/nqBTf9hlrG7GiuAD8gVxxM37T9mHsLpFW89feru6Oc0GHpRlCB+RzVNFzygUcCjZVhRVOU5oXM0AFqf0EVUDHyF8eMUjWunIRBGIn9PpsDDmE6eFjf5UwbpZO4p6ISvn7RzrS1KqByoIxe35dMDzqdXEYZCodRRZJ03IZsedHdaO4VzUPC2lyZ8JYnTblgh1cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PAXPR04MB8591.eurprd04.prod.outlook.com (2603:10a6:102:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 09:12:50 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 09:12:50 +0000
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
Subject: [PATCH V3 0/2] tty: serial: imx: improve the imx uart wakeup function
Date: Thu, 25 Sep 2025 17:11:30 +0800
Message-Id: <20250925091132.2537430-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|PAXPR04MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 351e898d-5cd2-4d1f-3835-08ddfc13b320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KSNSnvPW8G0jE9GF+edI4ZkFN4spL02VrSIuv8+TmcCkc6TayRtWV6m8A8XI?=
 =?us-ascii?Q?ioPcMnwMBKT2VgcQ/jCHGIP8jBjtFMVwxN4ZI+c5obhQA51+vR/p9Dew4nup?=
 =?us-ascii?Q?p2h28GQfGdaS45QZFymFAsK1vjWE8SXvykW/8Zze2dqhlYCkCj7rxRNmUMJy?=
 =?us-ascii?Q?fgcGAqeJ0f1f49hP7U0MY/t0/CYIrvYi7x9cHHGBwTdWHWj7DCuyfKLRiVbP?=
 =?us-ascii?Q?067GdQcbYIOrVNbCXCKzEJ3h66j8/MO7X6TFKANUf1O6K2Nrqus0RXAZkeZZ?=
 =?us-ascii?Q?0SVDIzrt7IhBGIbC5fR1LIpVb/7DMX272tPjFi3R2MspVvzh3vXuyqxtR0d5?=
 =?us-ascii?Q?EiAr0Ctc0oPoa6+ZNisQ2WwLVT9g/Pt/84FhC51hBppPGX9LY72EtPEW64yL?=
 =?us-ascii?Q?qUSXQ/RhS8S9qMHwIIvEG9r7ROPTkCX0spWrLjVvwsO4KNkJ7oCzEXF13heq?=
 =?us-ascii?Q?IkxVGSPZHhaKR4LuiPFc8YvT8Dax8szGB94uhOvpDop/WcJDO3S9mMG3ihRm?=
 =?us-ascii?Q?ZY8VebBHGO0RZFB1cHggH3wl4f/apuCkwxPyyIIdaeGYP+7SOfxGaIrAa5E/?=
 =?us-ascii?Q?/X+lVWiX5QC9YUXcD437Gms/q5rckRZBALqrlgsrSo5O5xVum9p87F8jTvfW?=
 =?us-ascii?Q?oWJ7QDDS1AIKX1S5v7XAW77ic9O31zXRKGl0Wvo3dPbKZixWv/Px7Qa0R1yA?=
 =?us-ascii?Q?tZBRx6s/Gx8ZiLpX476eeqjghdTQ/0/M1oPunuwr/iOQVqyFTDjisF+OXyqz?=
 =?us-ascii?Q?LxA1BFEw8kUFjJ6sA11KNxPVC/7mxcgDSVQTY10vrAM+WYIqn5uLIgCVnd5Q?=
 =?us-ascii?Q?w8aFAIVFT0f/2SGIZxEOEY/JFUlC9iWLgO9oF6uL5btref6MF1lMR9L7kx6r?=
 =?us-ascii?Q?5b1MvOllPtQEaS53/uuF7d5wqtnV5zhfT6FSyfyvAR0DQ+gxX7jHMILarD6/?=
 =?us-ascii?Q?7vB52oMl108t1/QFuCrhD67W7YvVeNjCjNmapC2HVyT6isko+QcDEEtRpB66?=
 =?us-ascii?Q?KRa1kE345/Qv2rlz8i6z5sJzA09Zuq8lUr4Rdx/9Em1oKj7w9HddxYiMeV2V?=
 =?us-ascii?Q?krkbEAsEeQDneMmB0rkQhPX5+mN7KOhDnI5AiTdvUkGi/Tp3+MDLvWFnfdvg?=
 =?us-ascii?Q?qD+OY16IwK8J7MO3a5zSk5hTZ6v2vfwINABAyZ60RAGjFfB7VUKy6wzLTJwO?=
 =?us-ascii?Q?Cqz9AcKamfGnDFvLBVUKzD8Rtt2i+6BlubP6Aa6CnoW5Zq1pFE4lr9MUqVlW?=
 =?us-ascii?Q?11su/vncwo864znQ9Px538sxJ6SbC1wWoEJLzRcpw8LwNOyK9aCcOv0oR6V7?=
 =?us-ascii?Q?A+slnWHmAXGA1BgZCWwmFvkCPTvvarAzPX9PsdAnXJX6c3d4HuUkh1cN6fSZ?=
 =?us-ascii?Q?i5LSEX7wdJJYgxwK4EZu1UIpiR2DC4lP1aHeY9b4+6wVFvZ3tq+HkJP4vLO8?=
 =?us-ascii?Q?Qh9ASNkG1CSuRSp+JgygAFEBmfdliEHS+d5BDHO080qdz6s9kCAgkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UQkwYXXMoc2cKJjGVamq2Zu7H6aJ4uEW6aoqWKwDftEts2EW2xu4X/AU7R+d?=
 =?us-ascii?Q?bvBZy2ZFWia3mfsnCIF582slsysFz5Xp7qhYLZ3EX6kKEbiPfyQfnpHEKFiS?=
 =?us-ascii?Q?YJw3um4cP9P81RXBDr8+2slep01i6irFOU66o5uSlXNGonpVx+DTYa2IevsE?=
 =?us-ascii?Q?RlMasVEfDV5qIagb0Kybo66oWosluaS88Zl7Lp9wVXzYY1u3fqWQxyoEF/CF?=
 =?us-ascii?Q?TTjqzYQdLU0CtjcQ1Zr3W1SdkcLFLPZ0gHRbgEkXZvpeTzKdM//QmtImN9tj?=
 =?us-ascii?Q?Iq7Nvfo2H0aLzy3ENxZsY3wE4oEd4DmamTZUkzIbVKmf541eS2mcYSBKdnJw?=
 =?us-ascii?Q?TDCk7avCel8r7fsLPzS9a4pYg+a/xiw5ActTVY6WsjI81SVWp5DtelKGanvk?=
 =?us-ascii?Q?t0OvaYdqxlv4jPvUhjPnd5rNEL5Z5qR1BGw2LA4CoBtpDtzAVTS+vtyZJiOu?=
 =?us-ascii?Q?pG3bj8APkoBRZCoHEd6rni7Sh+S981X3K/HbpqEMDsoY0X1DdU9vVlIotZtV?=
 =?us-ascii?Q?gXFDWd7t9CITLAOvTQzgIYwMZz8YlCmvEVr6WeX3twfiPiyNVLpwNq5Y3cWd?=
 =?us-ascii?Q?jgL4Zm+/HY9eXzJnlBN1lcTMaS4tKPdiHZr0luL6/tZ09afXJBFzXKKw38XD?=
 =?us-ascii?Q?EL2sxbPX1nG3e9LCW+ZGPqfM5RE8Lpr5FeGu0+xnaAtgZFCYXsICfHwaaQda?=
 =?us-ascii?Q?P18Dgr5hfnX/lnzgLZAg+VMhydEam7b2efmJIiC1rNygCXVjQ204xpq4uqft?=
 =?us-ascii?Q?EPXf3JATpmKJdZ+uxx5tfyZKpAf1PprqmA5j91ZoYQNznVwz1JZ9uJbKHfXA?=
 =?us-ascii?Q?ci3MVT1q0g38zoHU67iQzbcWKXT7OAWpKmvEmOAHHUyk4CMs70bvXrg6APUj?=
 =?us-ascii?Q?xLEDpw/8xK3S2swGAgi9VoSgiaGzvF3sEz2UBoqZWVaAQ7vVqudgEeFjlA12?=
 =?us-ascii?Q?nep0PqLV7Cc/RUaJ9nq1KeEc9Yf7SOq9HOaNZIcDCYZF9OWXtLtGyQdwS+gI?=
 =?us-ascii?Q?1nxLPG7uuDQD8mlnRJ20OqJI1ZuFxZQRzPho7sMBXlWKLVTXWNZLCyTGrTdm?=
 =?us-ascii?Q?OUdbtxoB76Y9c6Gxed0OWLPAdJe23cQXyJcmPPHL3hnG5vgJyqLMzn3uWzOr?=
 =?us-ascii?Q?RaqjATgoGbeSXmyRhmizygoQ1yLhkDcSnsHIAjiVOalsFr5emzXH3jDpNk67?=
 =?us-ascii?Q?GV5scQcCNvZDysFLZq+t46WCq7xaPDMzruSglK3knrEi/7Kzyws8MGc2FFg7?=
 =?us-ascii?Q?wD3mkSApDkPK2a2+RkPyVT3Y6+VNAgK1cedjlLzWluZXCqXLSRvdalCCMAk4?=
 =?us-ascii?Q?jyqW7Uw2UD8tuAvni1f+0N3KwmIO8ZcTQ3ui8O08xbEKE4wwJtwADLJtm+jH?=
 =?us-ascii?Q?ha59KXcO6pwKQcqjb5OxXRHO1uw6R7lnQnSR1ZSMEJJkjL2e4NvfD3T3MZBp?=
 =?us-ascii?Q?MtzD3f/xSFOsFMc3stLyesJ/sF8gv7gcRhUJy0HGOGf31up/wSShBxxxX+wU?=
 =?us-ascii?Q?UQnRkFn1/IeoMhLHqfuIghC6YYcM3noC5fOk6mZDp9gNqYV8QIhFemuCoNbG?=
 =?us-ascii?Q?I+jNP16tOGelEU9ydPLh442fl9Wifo6BUrGIKRcj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351e898d-5cd2-4d1f-3835-08ddfc13b320
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:12:50.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xt2xGKIszZc205UvExTAdsWJMSiBYXMsqtHHox0iQ5jb59IubMhEk59z+qxF878jk69ECFJD6ppfnB6wM0mXyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8591

Make some improvements for imx uart wakeup function. The first patch adds
device_may_wakeup() check before configuring the wake related registers.
The second patch adds the wakeup event reporting support for imx uart.

Changes in V3:
1. Add !!() to make bool type wake_active clearer.
2. Add Reviewed-by tag for patch #1.

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

